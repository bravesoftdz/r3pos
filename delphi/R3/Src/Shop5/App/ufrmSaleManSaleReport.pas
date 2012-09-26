unit ufrmSaleManSaleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeBaseReport, PrnDbgeh, DB, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset, ActnList, Menus, ComCtrls, ToolWin, RzLabel,
  jpeg, StdCtrls, RzLstBox, RzChkLst, ExtCtrls, Grids, DBGridEh, RzTabs,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, RzButton,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar,
  cxRadioGroup, ufrmDateControl;

type
  TfrmSaleManSaleReport = class(TframeBaseReport)
    RzLabel1: TRzLabel;
    RzLabel12: TRzLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label23: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    P1_D1: TcxDateEdit;
    P1_D2: TcxDateEdit;
    BtnDept: TRzBitBtn;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_TYPE: TcxComboBox;
    fndP1_SHOP_VALUE: TzrComboBoxList;
    fndP1_DEPT_ID: TzrComboBoxList;
    fndP1_GODS_ID: TzrComboBoxList;
    fndP1_SHOP_ID: TzrComboBoxList;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    Label30: TLabel;
    Label41: TLabel;
    P2_D1: TcxDateEdit;
    P2_D2: TcxDateEdit;
    fndP2_SHOP_VALUE: TzrComboBoxList;
    BtnSort: TRzBitBtn;
    fndP2_TYPE_ID: TcxComboBox;
    fndP2_UNIT_ID: TcxComboBox;
    fndP2_STAT_ID: TzrComboBoxList;
    fndP2_SORT_ID: TcxButtonEdit;
    fndP2_SHOP_TYPE: TcxComboBox;
    fndP2_DEPT_ID: TzrComboBoxList;
    fndP2_GODS_ID: TzrComboBoxList;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    Label9: TLabel;
    fndP2_SHOP_ID: TzrComboBoxList;
    adoReport2: TZQuery;
    dsadoReport2: TDataSource;
    dsadoReport3: TDataSource;
    adoReport3: TZQuery;
    dsadoReport4: TDataSource;
    adoReport4: TZQuery;
    dsadoReport5: TDataSource;
    adoReport5: TZQuery;
    RzPanel13: TRzPanel;
    Panel3: TPanel;
    RzPanel11: TRzPanel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    Label5: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    Label35: TLabel;
    Label42: TLabel;
    P3_D1: TcxDateEdit;
    P3_D2: TcxDateEdit;
    RzBitBtn2: TRzBitBtn;
    fndP3_SHOP_ID: TzrComboBoxList;
    fndP3_REPORT_FLAG: TcxComboBox;
    fndP3_UNIT_ID: TcxComboBox;
    fndP3_SHOP_VALUE: TzrComboBoxList;
    fndP3_SHOP_TYPE: TcxComboBox;
    fndP3_DEPT_ID: TzrComboBoxList;
    fndP3_GUIDE_USER: TzrComboBoxList;
    RzPanel12: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel14: TRzPanel;
    Panel6: TPanel;
    RzPanel15: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    Label21: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    Label36: TLabel;
    Label43: TLabel;
    P4_D1: TcxDateEdit;
    P4_D2: TcxDateEdit;
    BtnSaleSum: TRzBitBtn;
    fndP4_TYPE_ID: TcxComboBox;
    fndP4_UNIT_ID: TcxComboBox;
    fndP4_STAT_ID: TzrComboBoxList;
    fndP4_SORT_ID: TcxButtonEdit;
    fndP4_SHOP_VALUE: TzrComboBoxList;
    fndP4_SHOP_TYPE: TcxComboBox;
    fndP4_SHOP_ID: TzrComboBoxList;
    fndP4_DEPT_ID: TzrComboBoxList;
    fndP4_GUIDE_USER: TzrComboBoxList;
    RzPanel21: TRzPanel;
    DBGridEh4: TDBGridEh;
    TabSheet5: TRzTabSheet;
    RzPanel16: TRzPanel;
    Panel7: TPanel;
    RzPanel17: TRzPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    Label17: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label37: TLabel;
    Label44: TLabel;
    P5_D1: TcxDateEdit;
    BtnDetail: TRzBitBtn;
    P5_D2: TcxDateEdit;
    fndP5_TYPE_ID: TcxComboBox;
    fndP5_STAT_ID: TzrComboBoxList;
    fndP5_SORT_ID: TcxButtonEdit;
    fndP5_SHOP_VALUE: TzrComboBoxList;
    fndP5_SHOP_TYPE: TcxComboBox;
    fndP5_SHOP_ID: TzrComboBoxList;
    RzGB: TRzGroupBox;
    fndP5_ALL: TcxRadioButton;
    fndP5_SALEORDER: TcxRadioButton;
    fndP5_POSMAIN: TcxRadioButton;
    fndP5_SALRETU: TcxRadioButton;
    fndP5_DEPT_ID: TzrComboBoxList;
    fndP5_GUIDE_USER: TzrComboBoxList;
    RzPanel18: TRzPanel;
    DBGridEh5: TDBGridEh;
    fndP2_GUIDE_USER: TzrComboBoxList;
    fndP1_GUIDE_USER: TzrComboBoxList;
    Label6: TLabel;
    fndP4_RPTTYPE: TcxComboBox;
    Label7: TLabel;
    fndP4_SALES_TYPE: TcxComboBox;
    Label8: TLabel;
    fndP1_SALES_TYPE: TcxComboBox;
    Label31: TLabel;
    fndP2_SALES_TYPE: TcxComboBox;
    Label40: TLabel;
    fndP3_SALES_TYPE: TcxComboBox;
    Label45: TLabel;
    fndP5_SALES_TYPE: TcxComboBox;
    Label46: TLabel;
    RzGroupBox1: TRzGroupBox;
    RB_SYY: TcxRadioButton;
    RB_DGY: TcxRadioButton;
    P2_DateControl: TfrmDateControl;
    P1_DateControl: TfrmDateControl;
    P3_DateControl: TfrmDateControl;
    P4_DateControl: TfrmDateControl;
    P5_DateControl: TfrmDateControl;
    Label47: TLabel;
    fndP1_SALES_STYLE: TcxComboBox;
    Label48: TLabel;
    fndP2_SALES_STYLE: TcxComboBox;
    Label49: TLabel;
    fndP3_SALES_STYLE: TcxComboBox;
    Label50: TLabel;
    fndP4_SALES_STYLE: TcxComboBox;
    Label51: TLabel;
    fndP5_SALES_STYLE: TcxComboBox;
    Label3: TLabel;
    fndP3_GODS_ID: TzrComboBoxList;
    Label13: TLabel;
    fndP4_GODS_ID: TzrComboBoxList;
    Label18: TLabel;
    fndP5_GODS_ID: TzrComboBoxList;
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure fndP2_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP2_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure fndP3_REPORT_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure fndP4_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP4_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure DBGridEh4GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure fndP5_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndP5_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh5GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh4TitleClick(Column: TColumnEh);
    procedure RB_DGYClick(Sender: TObject);
  private
    { Private declarations }
    vBegDate,            //��ѯ��ʼ����
    vEndDate: integer;   //��ѯ��������
    RckMaxDate: integer; //̨���������

    GodsID: string;   //��Ʒ����ID;
    SortName: string; //��ʱ����
    sid1,sid2,sid3,sid4,sid5:string;
    srid1,srid2,srid3,srid4,srid5:string;

    procedure SetUnitIDList(DBGrid: TDBGridEh; ColName: string); //����ColList
    //���������ۻ��ܱ�
    function GetRegionSQL(chk:boolean=true): string;  //1111
    //���ͻ����ۻ��ܱ�
    function GetClientSQL(chk:boolean=true): string;   //2222
    //���������ۻ��ܱ�
    function GetSortSQL(chk:boolean=true): string;   //3333
    //����Ʒ���ۻ��ܱ�
    function GetGodsSQL(chk:boolean=true): string;   //4444
    //����Ʒ������ˮ��
    function GetGlideSQL(chk:boolean=true): string;  //5555
    function GetUnitIDIdx: integer;
    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
    //����Page��ҳ��ʾ:��IsGroupReport�Ƿ����[�����ŵ�]��
    procedure SetRzPageActivePage(IsGroupReport: Boolean=true); override;
    function etShopSQL(chk: boolean): string;
    function GetGodsSortIdx: string;
    function GetDataRight: string; //���ز鿴����Ȩ��
  public
    { Public declarations }
    procedure PrintBefore;override;
    function GetRowType:integer;override;
    property UnitIDIdx: integer read GetUnitIDIdx; //��ǰͳ�Ƽ�����ʽ
    property  GodsSortIdx: string read GetGodsSortIdx; //ͳ������
    property DataRight: string read GetDataRight; //���ز鿴����Ȩ��      
  end;

const
  ArySumField: Array[0..5] of string=('SALE_AMT','SALE_TTL','SALE_TAX','SALE_MNY','SALE_CST','SALE_ALLPRF');

implementation
uses  uShopGlobal,uFnUtil, uShopUtil, uGlobal, uCtrlUtil, ObjCommon;
{$R *.dfm}

procedure TfrmSaleManSaleReport.fndP1_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmSaleManSaleReport.fndP1_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

procedure TfrmSaleManSaleReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if adoReport1.IsEmpty then Exit;
  sid2:=sid1;
  srid2:=srid1;
  fndP2_SORT_ID.Text:=fndP1_SORT_ID.Text;   //����
  P2_D1.Date:=P1_D1.Date;
  P2_D2.Date:=P1_D2.Date;
  fndP2_DEPT_ID.KeyValue:=trim(adoReport1.FieldbyName('DEPT_ID').AsString);  //����ID
  fndP2_DEPT_ID.Text:=trim(adoReport1.FieldbyName('DEPT_NAME').AsString);    //��������
  Copy_ParamsValue('TYPE_ID',1,2);          //ָ��
  fndP2_UNIT_ID.ItemIndex:=fndP1_UNIT_ID.ItemIndex; //��ʾ��λ

  fndP2_SHOP_TYPE.ItemIndex:=0;  //����Ⱥ��
  fndP2_SHOP_VALUE.KeyValue:=fndP1_SHOP_VALUE.KeyValue;
  fndP2_SHOP_VALUE.Text:=fndP1_SHOP_VALUE.Text;

  fndP2_GUIDE_USER.KeyValue := fndP1_GUIDE_USER.KeyValue;
  fndP2_GUIDE_USER.Text := fndP1_GUIDE_USER.Text;

  fndP2_GODS_ID.KeyValue := fndP1_GODS_ID.KeyValue;
  fndP2_GODS_ID.Text := fndP1_GODS_ID.Text;

  fndP2_SHOP_ID.KeyValue := fndP1_SHOP_ID.KeyValue;
  fndP2_SHOP_ID.Text := fndP1_SHOP_ID.Text;
  fndP2_SALES_TYPE.ItemIndex:=fndP1_SALES_TYPE.ItemIndex;

  RzPage.ActivePageIndex:=1;
  actFindExecute(nil);
end;

procedure TfrmSaleManSaleReport.actFindExecute(Sender: TObject);
var strSql: string;
begin
  case rzPage.ActivePageIndex of
    0: begin //���������ܱ�
        if adoReport1.Active then adoReport1.Close;
        strSql := GetRegionSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text:= strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���ͻ����ܱ�
        if adoReport2.Active then adoReport2.Close;
        strSql := GetClientSQL;
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
        Factor.Open(adoReport4);
        dsadoReport4.DataSet:=nil;
        DoGodsGroupBySort(adoReport4,GodsSortIdx,'SORT_ID','GODS_NAME','ORDER_ID',
                          ['SALE_AMT','SALE_PRC','SALE_TTL','SALE_TAX','SALE_MNY','SALE_CST','SALE_ALLPRF','SALE_RATE','SALE_PRF'],
                          ['SALE_PRC=SALE_TTL/SALE_AMT','SALE_RATE=SALE_ALLPRF/SALE_MNY*100','SALE_PRF=SALE_ALLPRF/SALE_AMT']);
        dsadoReport4.DataSet:=adoReport4;
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

procedure TfrmSaleManSaleReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'DEPT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmSaleManSaleReport.fndP2_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid2 := '';
  srid2 := '';
  fndP2_SORT_ID.Text := '';
end;

procedure TfrmSaleManSaleReport.fndP2_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid2,srid2,SortName) then
    fndP2_SORT_ID.Text:=SortName;
end;

procedure TfrmSaleManSaleReport.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if adoReport2.IsEmpty then Exit;

  P3_D1.Date:=P2_D1.Date;
  P3_D2.Date:=P2_D2.Date;
  Copy_ParamsValue(fndP2_DEPT_ID,fndP3_DEPT_ID); //��������
  Copy_ParamsValue('SHOP_TYPE',2,3);   //����Ⱥ��
  fndP3_UNIT_ID.ItemIndex:=fndP2_UNIT_ID.ItemIndex; //��ʾ��λ
  fndP3_SHOP_ID.KeyValue:=fndP2_SHOP_ID.KeyValue;
  fndP3_SHOP_ID.Text:=fndP2_SHOP_ID.Text;
  //�ϼ�������Ա����:
  fndP3_GUIDE_USER.KeyValue:=trim(adoReport2.fieldByName('GUIDE_USER').AsString);
  fndP3_GUIDE_USER.Text :=trim(adoReport2.fieldByName('USER_NAME').AsString);
  fndP3_SALES_TYPE.ItemIndex:=fndP2_SALES_TYPE.ItemIndex;
  fndP3_GODS_ID.KeyValue := fndP2_GODS_ID.KeyValue;
  fndP3_GODS_ID.Text := fndP2_GODS_ID.Text;      

  RzPage.ActivePageIndex:=2;
  actFindExecute(nil);
end;

procedure TfrmSaleManSaleReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'USER_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmSaleManSaleReport.fndP3_REPORT_FLAGPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Do_REPORT_FLAGOnChange(Sender,DBGridEh4);
end;

procedure TfrmSaleManSaleReport.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
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

procedure TfrmSaleManSaleReport.DBGridEh3DblClick(Sender: TObject);
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

  P4_D1.Date:=P3_D1.Date;
  P4_D2.Date:=P3_D2.Date;
  Copy_ParamsValue('SHOP_TYPE',3,4);  //�ŵ�Ⱥ��
  Copy_ParamsValue(fndP3_SHOP_ID, fndP4_SHOP_ID);  //�ŵ�����
  Copy_ParamsValue(fndP3_DEPT_ID, fndP4_DEPT_ID);  //��������
  fndP4_UNIT_ID.ItemIndex:=fndP3_UNIT_ID.ItemIndex; //��ʾ��λ

  fndP4_SHOP_ID.KeyValue:=fndP3_SHOP_ID.KeyValue;
  fndP4_SHOP_ID.Text:=fndP3_SHOP_ID.Text;
  fndP4_SALES_TYPE.ItemIndex:=fndP3_SALES_TYPE.ItemIndex;

  fndP4_GUIDE_USER.KeyValue := fndP3_GUIDE_USER.KeyValue;
  fndP4_GUIDE_USER.Text := fndP3_GUIDE_USER.Text;
  fndP4_GODS_ID.KeyValue := fndP3_GODS_ID.KeyValue;
  fndP4_GODS_ID.Text := fndP3_GODS_ID.Text;


  RzPage.ActivePageIndex:=3;
  actFindExecute(nil);
end;

procedure TfrmSaleManSaleReport.fndP4_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid4 := '';
  srid4 := '';
  fndP4_SORT_ID.Text := '';
end;

procedure TfrmSaleManSaleReport.fndP4_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid4,srid4,SortName) then
    fndP4_SORT_ID.Text:=SortName;
end;

procedure TfrmSaleManSaleReport.DBGridEh4DblClick(Sender: TObject);
begin
  inherited;
  if adoReport4.FieldbyName('GODS_ID').AsString = '' then Raise Exception.Create('��ѡ���ѯ��ˮ�ʵ���Ʒ...');
  GodsID:=trim(adoReport4.FieldbyName('GODS_ID').AsString);
  SetGodsIDValue(fndP5_GODS_ID,GodsID);
  
  P5_D1.Date:=P4_D1.Date;
  P5_D2.Date:=P4_D2.Date;
  sid5:=sid4;
  srid5:=srid4;
  fndP5_SORT_ID.Text:=fndP4_SORT_ID.Text;
  fndP5_ALL.Checked:=true;
  Copy_ParamsValue(fndP4_DEPT_ID,fndP5_DEPT_ID);  //��������
  Copy_ParamsValue(fndP4_SHOP_ID,fndP5_SHOP_ID);  //�ŵ�����
  Copy_ParamsValue('SHOP_TYPE',4,5); //����Ⱥ��
  Copy_ParamsValue('TYPE_ID',4,5);   //��Ʒָ��

  fndP5_GUIDE_USER.KeyValue := fndP4_GUIDE_USER.KeyValue;
  fndP5_GUIDE_USER.Text := fndP4_GUIDE_USER.Text;
  fndP5_SALES_TYPE.ItemIndex:=fndP4_SALES_TYPE.ItemIndex;

  RzPage.ActivePageIndex:=4;
  actFindExecute(nil);
end;

procedure TfrmSaleManSaleReport.DBGridEh4GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
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
      if Copy(ColName,1,5)='SALE_' then
      begin
        Text:=FormatFloat(Column.DisplayFormat,AllRecord.FindField(ColName).AsFloat);
      end;
    end;
  end;
end;

procedure TfrmSaleManSaleReport.fndP5_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  sid5 := '';
  srid5 := '';
  fndP5_SORT_ID.Text := '';
end;

procedure TfrmSaleManSaleReport.fndP5_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if SelectGoodSortType(sid5,srid5,SortName) then
    fndP5_SORT_ID.Text:=SortName;
end;

procedure TfrmSaleManSaleReport.DBGridEh5GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmSaleManSaleReport.FormCreate(Sender: TObject);
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

  P3_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P3_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P3_DateControl.StartDateControl := P3_D1;
  P3_DateControl.EndDateControl := P3_D2;

  P4_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P4_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P4_DateControl.StartDateControl := P4_D1;
  P4_DateControl.EndDateControl := P4_D2;

  P5_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P5_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  P5_DateControl.StartDateControl := P5_D1;
  P5_DateControl.EndDateControl := P5_D2;

  fndP1_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndP2_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndP3_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndP4_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  fndP5_GUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  SetRzPageActivePage; //����PzPage.Activepage

  RefreshColumn;

  //2011.12.22 �ؿ���[�����ܵ�Ĭ�ϵ�ǰ�ŵ�]
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    fndP1_SHOP_ID.Properties.ReadOnly := False;
    fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP1_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
    //fndP1_SHOP_ID.Properties.ReadOnly := True;

    fndP2_SHOP_ID.Properties.ReadOnly := False;
    fndP2_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP2_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP2_SHOP_ID.Style);
    //fndP2_SHOP_ID.Properties.ReadOnly := True;

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

    fndP5_SHOP_ID.Properties.ReadOnly := False;
    fndP5_SHOP_ID.KeyValue := Global.SHOP_ID;
    fndP5_SHOP_ID.Text := Global.SHOP_NAME;
    //SetEditStyle(dsBrowse,fndP5_SHOP_ID.Style);
    //fndP5_SHOP_ID.Properties.ReadOnly := True;
  end;

  //Add ���ò鿴�ɱ���Ȩ��
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetNotShowCostPrice(DBGridEh1, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']);
    SetNotShowCostPrice(DBGridEh2, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']);
    SetNotShowCostPrice(DBGridEh3, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']);
    SetNotShowCostPrice(DBGridEh4, ['SALE_CST','SALE_ALLPRF','SALE_MNY','SALE_RATE','SALE_PRF']); 
    SetNotShowCostPrice(DBGridEh5, ['COST_MONEY','PROFIT_MONEY','NOTAX_MONEY','PROFIT_RATE','AVG_PROFIT']);
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label10.Caption := '�ֿ�Ⱥ��';

      Label11.Caption := '�ֿ�Ⱥ��';
      Label9.Caption := '�ֿ�����';

      Label12.Caption := '�ֿ�Ⱥ��';
      Label21.Caption := '�ֿ�����';

      Label28.Caption := '�ֿ�Ⱥ��';
      Label17.Caption := '�ֿ�����';

      Label23.Caption := '�ֿ�Ⱥ��';
      Label38.Caption := '�ֿ�����';
      //Label40.Caption := '�ֿ�����';

      Label39.Caption := 'ҵ��Ա';
      Label41.Caption := 'ҵ��Ա';
      Label42.Caption := 'ҵ��Ա';
      Label43.Caption := 'ҵ��Ա';
      Label44.Caption := 'ҵ��Ա';
    end;

  //���ӵ�λ��ʾ��
  SetUnitIDList(DBGridEh4,'UNIT_ID');
  SetUnitIDList(DBGridEh5,'UNIT_ID');

  //2011.07.16 �ͷŵ���ϸ
  SetNotShowCostPrice(DBGridEh5, ['COST_MONEY','PROFIT_MONEY','PROFIT_RATE','AVG_PROFIT']);
  //2011.09.22 Add ǧ��λ��
  SetGridColumnDisplayFormat(['DBGridEh1.SALE_TTL','DBGridEh1.SALE_TAX','DBGridEh1.SALE_MNY','DBGridEh1.SALE_CST','DBGridEh1.SALE_ALLPRF','DBGridEh1.SALE_PRF',
                              'DBGridEh2.SALE_TTL','DBGridEh2.SALE_TAX','DBGridEh2.SALE_MNY','DBGridEh2.SALE_CST','DBGridEh2.SALE_ALLPRF','DBGridEh2.SALE_PRF',
                              'DBGridEh3.SALE_TTL','DBGridEh3.SALE_TAX','DBGridEh3.SALE_MNY','DBGridEh3.SALE_CST','DBGridEh3.SALE_ALLPRF','DBGridEh3.SALE_PRF',
                              'DBGridEh4.SALE_TTL','DBGridEh4.SALE_TAX','DBGridEh4.SALE_MNY','DBGridEh4.SALE_CST','DBGridEh4.SALE_ALLPRF','DBGridEh4.SALE_PRF',
                              'DBGridEh5.AMONEY','DBGridEh5.NOTAX_MONEY','DBGridEh5.TAX_MONEY','DBGridEh5.AGIO_RATE','DBGridEh5.AGIO_MONEY','DBGridEh5.COST_MONEY','DBGridEh5.PROFIT_MONEY','DBGridEh5.AVG_PROFIT']);

  //2012.08.15�������롢��ɫ
  if ShopGlobal.GetVersionFlag=1 then
    CreateGridColForFIG(DBGridEh5,7);                              
end;


function TfrmSaleManSaleReport.AddReportReport(TitleList: TStringList; PageNo: string): string;
var
  FindCmp1,FindCmp2: TComponent;
begin
  //����
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  FindCmp1:=FindComponent('fndP'+PageNo+'_SALES_STYLE');
  if (FindCmp1<>nil) and (FindCmp1.Tag<>100) and (FindCmp1 is TcxComboBox) and (TcxComboBox(FindCmp1).Visible) and (TcxComboBox(FindCmp1).ItemIndex>-1)  then
  begin
    TitleList.add('���۷�ʽ��'+TcxComboBox(FindCmp1).Text);
  end;
  
  inherited AddReportReport(TitleList,PageNo);
end;

function TfrmSaleManSaleReport.etShopSQL(chk: boolean): string;
begin

end;

function TfrmSaleManSaleReport.GetGlideSQL(chk: boolean): string;
var
  strSql,strWhere,GoodTab,SQLData: string;
begin
  if P5_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P5_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+DataRight;

  //���۷�ʽ:    
  if fndP5_SALES_STYLE.ItemIndex>0 then
    strWhere:=strWhere+' and A.SALES_STYLE='''+TRecord_(fndP5_SALES_STYLE.Properties.Items.Objects[fndP5_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //��������:
  if fndP5_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP5_SALES_TYPE.Properties.Items.Objects[fndP5_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //�ŵ�����:
  if fndP5_SHOP_ID.AsString<>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP5_SHOP_ID.AsString+''' ';

  //GodsID��Ϊ�գ�
  //if trim(GodsID)<>'' then strWhere:=strWhere+' and A.GODS_ID='''+GodsID+''' ';
  //2012.09.23������Ʒ��ѯ����
  if trim(fndP5_GODS_ID.AsString)<>'' then
    strWhere := strWhere+GetGodsIdsCnd(fndP5_GODS_ID.AsString,'A.GODS_ID');

  //�·�����:
  if (P5_D1.Text<>'') and (P5_D1.Date=P5_D2.Date) then
     strWhere:=strWhere+' and A.SALES_DATE='+FormatDatetime('YYYYMMDD',P5_D1.Date)
  else if P5_D1.Date<P5_D2.Date then
     strWhere:=strWhere+' and A.SALES_DATE>='+FormatDatetime('YYYYMMDD',P5_D1.Date)+' and A.SALES_DATE<='+FormatDatetime('YYYYMMDD',P5_D2.Date)+' '
  else
    Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //�ŵ�������������|�ŵ�����:
  if (fndP5_SHOP_VALUE.AsString<>'') then
  begin
    case fndP5_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP5_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP5_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP5_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP5_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒָ��:
  if (fndP5_STAT_ID.Visible) and (fndP5_STAT_ID.AsString <> '') and (fndP5_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP5_TYPE_ID)+'='''+fndP5_STAT_ID.AsString+''' ';
  end;

  //��Ʒ����:
  if (fndP5_SORT_ID.Visible) and (trim(fndP5_SORT_ID.Text)<>'') and (trim(srid5)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid5+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid5+''' ';
    end;
    if trim(sid5)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid5+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add ��������:
  if trim(fndP5_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP5_DEPT_ID.AsString);

  //ҵ��Ա
  if Trim(fndP5_GUIDE_USER.Text) <> '' then
    strWhere := strWhere + ' and isnull(A.GUIDE_USER,'''')='''+fndP5_GUIDE_USER.AsString+''' ';

  if fndP5_SALEORDER.Checked then //���۵�:1
    strWhere := strWhere+' and SALES_TYPE=1 '
  else if fndP5_POSMAIN.Checked then //���۵�:4
    strWhere := strWhere+' and SALES_TYPE=4 '
  else if fndP5_SALRETU.Checked then //�����˻�:3
    strWhere := strWhere+' and SALES_TYPE=3 ';

  SQLData:= //'VIW_SALESDATA';
    '(select '+
     ' A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.CLIENT_ID,A.CREA_USER,A.CREA_DATE,A.INVOICE_FLAG,B.AGIO_RATE,A.GUIDE_USER,B.POLICY_TYPE,A.SALES_DATE,A.SALES_ID,B.BARTER_INTEGRAL,'+
     ' B.GODS_ID,B.PROPERTY_01,B.PROPERTY_02,B.IS_PRESENT,A.GLIDE_NO,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,A.INTEGRAL,B.HAS_INTEGRAL,A.SALES_TYPE,A.SALES_STYLE,'+
     ' B.CALC_AMOUNT as CALC_AMOUNT,B.CALC_MONEY as CALC_MONEY,B.ORG_PRICE,B.COST_PRICE,B.APRICE,B.AMOUNT,A.TAX_RATE,isnull(B.REMARK,A.REMARK) as REMARK,'+
     ' round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2) as TAX_MONEY,'+
     ' B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2) as NOTAX_MONEY,'+
     ' B.AGIO_MONEY,round(B.CALC_AMOUNT*B.COST_PRICE,2) as COST_MONEY,'+
     ' B.CALC_MONEY-round(B.CALC_MONEY/(1+case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*case when A.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end,2)-round(B.CALC_AMOUNT*B.COST_PRICE,2) as PRF_MONEY '+
    ' from SAL_SALESORDER A,SAL_SALESDATA B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.SALES_TYPE in (1,3,4) and A.COMM not in (''02'',''12''))';

  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GLIDE_NO '+
    ',A.GODS_ID '+
    ',A.BATCH_NO '+
    ',A.LOCUS_NO '+
    ',A.UNIT_ID '+
    ',A.SALES_DATE '+
    ',A.PROPERTY_01 '+
    ',A.PROPERTY_02 '+
    ',A.IS_PRESENT '+
    ',A.CLIENT_ID '+
    ',A.CREA_DATE '+
    ',A.CREA_USER '+
    ',A.REMARK '+    
    ',A.SHOP_ID '+
    ',A.GUIDE_USER '+
    ',A.SALES_TYPE '+
    ',A.AMOUNT '+
    ',A.ORG_PRICE '+   //ԭ�ۼ�
    ',A.APRICE '+      //���ۼ�
    ',A.CALC_MONEY as AMONEY '+
    ',A.NOTAX_MONEY '+  //����˰
    ',A.TAX_MONEY '+    //˰��
    ',A.AGIO_MONEY '+   //�ۿ۽��
    ',A.AGIO_RATE '+    //�ۿ��ʣ������ʣ�
    ',A.COST_MONEY '+   //���۳ɱ�
    ',A.NOTAX_MONEY-A.COST_MONEY as PROFIT_MONEY'+  //ë�� = ����˰���-���۳ɱ�
    ',(case when cast(A.NOTAX_MONEY as decimal(18,3))<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/cast(A.NOTAX_MONEY as decimal(18,3)) else 0 end) as PROFIT_RATE '+  //����˰���-���۳ɱ�
    ',(case when cast(A.AMOUNT as decimal(18,3))<>0 then cast(A.PRF_MONEY as decimal(18,3))*100.00/cast(A.AMOUNT as decimal(18,3)) else 0 end) as AVG_PROFIT'+    //--��λë��
    ',B.SHOP_NAME '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' ';

  Result := ParseSQL(Factor.iDbType,
    'select j.* '+
    ',e.USER_NAME as CREA_USER_TEXT '+
    ',d.USER_NAME as GUIDE_USER_TEXT '+
    ',c.CLIENT_NAME as CLIENT_NAME '+
    ',u.UNIT_NAME as UNIT_NAME '+
    ',isnull(b.BARCODE,r.BARCODE) as BARCODE,r.GODS_CODE as GODS_CODE,r.GODS_NAME as GODS_NAME '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID '+
    ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
    ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_CUSTOMER c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    ' left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.GUIDE_USER=d.USER_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '
    );
  result := result +  ' order by j.SALES_DATE,r.GODS_CODE';
end;

function TfrmSaleManSaleReport.GetGodsSQL(chk: boolean): string;
var
  UnitCalc,SORT_ID_Fields,SORT_ID_Group: string;  //��λ�����ϵ
  strSql,strCnd,ShopCnd,strWhere,GoodTab,SQLData: string;
begin
  strCnd:='';
  ShopCnd:='';
  if P4_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P4_D1.Date > P4_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+DataRight;

  //���۷�ʽ:    
  if fndP4_SALES_STYLE.ItemIndex>0 then
    strWhere:=strWhere+' and A.SALES_STYLE='''+TRecord_(fndP4_SALES_STYLE.Properties.Items.Objects[fndP4_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //��������:
  if fndP4_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP4_SALES_TYPE.Properties.Items.Objects[fndP4_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //�ŵ�����
  if (fndP4_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
  end;

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P4_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and SALES_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and SALES_DATE>='+InttoStr(vBegDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and SALES_DATE>'+InttoStr(RckMaxDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';
  end;

  //�ŵ�������������|�ŵ�����:
  if trim(fndP4_SHOP_VALUE.AsString)<>'' then
  begin
    case fndP4_SHOP_TYPE.ItemIndex of
      0:
       begin
         if FnString.TrimRight(trim(fndP4_SHOP_VALUE.AsString),2)='00' then //��ĩ������
           strWhere:=strWhere+' and B.REGION_ID like '''+GetRegionId(fndP4_SHOP_VALUE.AsString)+'%'' '
         else
           strWhere:=strWhere+' and B.REGION_ID='''+fndP4_SHOP_VALUE.AsString+''' ';
       end;
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP4_SHOP_VALUE.AsString+''' ';
    end;
  end;
    
  //2011.05.11 Add ��������:
  if trim(fndP4_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP4_DEPT_ID.AsString);

  //�ŵ�����
{  if (fndP4_SHOP_ID.AsString<>'') then
    begin
      StrCnd:=' and SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP4_SHOP_ID.AsString+''' ';
    end;}

  //��Ʒָ��:
  if (fndP4_STAT_ID.Visible) and (fndP4_STAT_ID.AsString <> '') and (fndP4_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP4_TYPE_ID)+'='''+fndP4_STAT_ID.AsString+''' ';
  end;
  //��Ʒ����:
  if (fndP4_SORT_ID.Visible) and (trim(fndP4_SORT_ID.Text)<>'')  and (trim(srid4)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid4+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid4+''' ';
    end;
    if trim(sid4)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid4+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';
  //2012.09.24 Add ��Ʒ����
  if trim(fndP4_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP4_GODS_ID.AsString,'A.GODS_ID');
  //ҵ��Ա
  if Trim(fndP4_GUIDE_USER.Text) <> '' then
  begin
    StrCnd := StrCnd + ' and isnull(GUIDE_USER,'''')='''+fndP4_GUIDE_USER.AsString+''' ';
    strWhere := strWhere + ' and isnull(GUIDE_USER,'''')='''+fndP4_GUIDE_USER.AsString+''' ';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
  begin
    SQLData:='(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
             'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  end else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
  begin
    SQLData:='RCK_C_GOODS_DAYS';
    strWhere:=strWhere+' and (A.SALE_AMT<>0 or A.SALE_MNY<>0) '; 
  end else
  begin
    SQLData :=
      '(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,CREA_DATE,GODS_ID,SALE_AMT,SALE_MNY,SALE_TAX,SALE_RTL,SALE_CST,SALE_AGO,SALE_PRF from RCK_C_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+
      ' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' and (SALE_AMT<>0 or SALE_MNY<>0)'+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
      'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ')';
  end;
  
  //�����ֶ�
  case StrToInt(GodsSortIdx) of
   -1:
     begin
       SORT_ID_Fields:=',-1 as SORT_ID';
       SORT_ID_Group:='';
     end;
    0:
     begin
       SORT_ID_Fields:=',C.RELATION_ID as SORT_ID';
       SORT_ID_Group:=',C.RELATION_ID';
     end
    else
     begin
       SORT_ID_Fields:=',(case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end) as SORT_ID';
       SORT_ID_Group:=',(case when isnull(C.SORT_ID'+GodsSortIdx+','''')='''' then ''#'' else C.SORT_ID'+GodsSortIdx+' end)';
     end;
  end;

  UnitCalc:=GetUnitTO_CALC(fndP4_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+SORT_ID_Fields+   
    ',A.GODS_ID '+
    ',sum(SALE_AMT*1.000/'+UnitCalc+') as SALE_AMT '+    //��������
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+')as decimal(18,3))<>0 then cast(isnull(sum(SALE_MNY),0)+isnull(sum(SALE_TAX),0) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+')as decimal(18,3)) else 0 end as SALE_PRC '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+   //��˰�ϼ�
    ',sum(SALE_MNY) as SALE_MNY '+  //δ˰���
    ',sum(SALE_TAX) as SALE_TAX '+  //˰��
    ',sum(SALE_RTL) as SALE_RTL '+  //���۽���ʱûʹ��
    ',sum(SALE_PRF) as SALE_ALLPRF '+  //ë��
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRF '+ //��λë��
    ',case when cast(sum(SALE_MNY) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_AGO) as SALE_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID'+SORT_ID_Group+',A.GODS_ID';

  strSql :=
    'select j.* '+
    ',r.BARCODE as CALC_BARCODE,r.GODS_CODE,r.GODS_NAME,''#'' as PROPERTY_01,''#'' as BATCH_NO,''#'' as PROPERTY_02,'+GetUnitID(fndP4_UNIT_ID.ItemIndex,'r')+' as UNIT_ID '+
    'from ('+strSql+') j inner join VIW_GOODSINFO r on j.TENANT_ID=r.TENANT_ID and j.GODS_ID=r.GODS_ID ';

  case StrtoInt(GodsSortIdx) of
   -1:
    begin
      strSql :=
        'select j.*,j.GODS_CODE as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by j.GODS_CODE';
    end;
   0: //��Ӧ��
    begin    
      strSql :=
        'select j.*,'+GetRelation_ID('j.SORT_ID')+' as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' order by '+GetRelation_ID('j.SORT_ID')+',j.GODS_CODE';
    end;
   else
    begin
      strSql :=
        'select j.*,s.ORDER_ID as ORDER_ID,isnull(b.BARCODE,j.CALC_BARCODE) as BARCODE,u.UNIT_NAME as UNIT_NAME from ('+strSql+') j '+
        ' left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) b '+
        ' on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and j.BATCH_NO=b.BATCH_NO and j.PROPERTY_01=b.PROPERTY_01 and j.PROPERTY_02=b.PROPERTY_02 and j.UNIT_ID=b.UNIT_ID '+
        ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
        ' left outer join '+
        '(select SORT_ID,'+IntToVarchar('(10000000+SEQ_NO)')+' as ORDER_ID from VIW_GOODSSORT where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SORT_TYPE='+GodsSortIdx+' and COMM not in (''02'',''12'')) s '+
        ' on j.SORT_ID=s.SORT_ID '+
        ' order by s.ORDER_ID,j.GODS_CODE';
    end;
  end;
  result:=ParseSQL(Factor.iDbType,strSql);
end;

function TfrmSaleManSaleReport.GetSortSQL(chk: boolean): string;
var
  GodsStateIdx: integer; //���ͳ��ָ��Idx  
  UnitCalc, JoinCnd,lv,LvField: string;  //��λ�����ϵ
  strSql,strCnd,strWhere,ShopCnd,GoodTab,SQLData: string;
begin
  lv:='';
  lvField:='';
  StrCnd:='';
  ShopCnd:='';
  if P3_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P3_D1.Date > P3_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //��Ʒָ��:
  if fndP3_REPORT_FLAG.ItemIndex < 0 then Raise Exception.Create('��ѡ�񱨱�����...');
  GodsStateIdx:=TRecord_(fndP3_REPORT_FLAG.Properties.Items.Objects[fndP3_REPORT_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+DataRight;

  //���۷�ʽ:    
  if fndP3_SALES_STYLE.ItemIndex>0 then
    strWhere:=strWhere+' and A.SALES_STYLE='''+TRecord_(fndP3_SALES_STYLE.Properties.Items.Objects[fndP3_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //��������:
  if fndP3_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP3_SALES_TYPE.Properties.Items.Objects[fndP3_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //�ŵ�����
  if (fndP3_SHOP_ID.AsString<>'') then
  begin
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' and B.SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
    StrCnd:=' and SHOP_ID='''+fndP3_SHOP_ID.AsString+''' ';
  end;

  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P3_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and SALES_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and SALES_DATE>='+InttoStr(vBegDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and SALES_DATE>'+InttoStr(RckMaxDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';
  end;

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
      1:strWhere:=strWhere+' and B.SHOP_TYPE='''+fndP3_SHOP_VALUE.AsString+''' ';
    end;
  end;

  //��Ʒ����:
  case GodsStateIdx of
   1:begin
       GoodTab:='VIW_GOODSPRICE_SORTEXT';
       lv := ',((case when C.RELATION_ID=0 then ''9999999'' else '+IntToVarchar('C.RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(C.LEVEL_ID,''''))';
       lvField:=lv+' as LEVEL_ID ';
     end;
   else
    GoodTab:='VIW_GOODSPRICE';
   end;

  //2011.05.11 Add ��������:
  if trim(fndP3_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP3_DEPT_ID.AsString);
  //2012.09.23 Add ��Ʒ����
  if trim(fndP3_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP3_GODS_ID.AsString,'A.GODS_ID');
  //ҵ��Ա
  if Trim(fndP3_GUIDE_USER.Text) <> '' then
  begin
    strWhere := strWhere + ' and isnull(GUIDE_USER,'''')='''+fndP3_GUIDE_USER.AsString+''' ';
    StrCnd := StrCnd + ' and isnull(GUIDE_USER,'''')='''+fndP3_GUIDE_USER.AsString+''' ';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
  begin
    SQLData:='(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
             'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  end else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_C_GOODS_DAYS'
  else
  begin
    SQLData :=
      '(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,CREA_DATE,GODS_ID,SALE_AMT,SALE_MNY,SALE_TAX,SALE_RTL,SALE_CST,SALE_AGO,SALE_PRF from RCK_C_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
      'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP3_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',A.GODS_ID,C.SORT_ID'+IntToStr(GodsStateIdx)+lvField+',C.RELATION_ID '+
    ',sum(SALE_AMT*1.000/'+UnitCalc+') as SALE_AMT '+  //��������
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+ //��˰���
    ',sum(SALE_MNY) as SALE_MNY '+   //δ˰���
    ',sum(SALE_TAX) as SALE_TAX '+   //˰��
    ',sum(SALE_RTL) as SALE_RTL '+   //��ʱûʹ��
    ',sum(SALE_PRF) as SALE_PRF '+   //ë��
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_AGO) as SALE_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,A.GODS_ID,C.SORT_ID'+IntToStr(GodsStateIdx)+lv+',C.RELATION_ID';

  case GodsStateIdx of
    1:begin
       case Factor.iDbType of
        4: JoinCnd:=' and j.LEVEL_ID=substr(r.LEVEL_ID,1,length(j.LEVEL_ID)) '
        else
           JoinCnd:=' and r.LEVEL_ID like j.LEVEL_ID '+GetStrJoin(Factor.iDbType)+'''%'' ';
       end;
       Result :=  ParseSQL(Factor.iDbType,
          'select '+
          ' sum(nvl(SALE_AMT,0)) as SALE_AMT '+
          ',case when cast(sum(nvl(SALE_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(SALE_TTL,0)) as decimal(18,3))*1.000/cast(sum(nvl(SALE_AMT,0)) as decimal(18,3)) else 0 end as SALE_PRC '+
          ',sum(nvl(SALE_TTL,0)) as SALE_TTL '+
          ',sum(nvl(SALE_MNY,0)) as SALE_MNY '+
          ',sum(nvl(SALE_TAX,0)) as SALE_TAX '+
          ',sum(nvl(SALE_RTL,0)) as SALE_RTL '+
          ',sum(nvl(SALE_PRF,0)) as SALE_ALLPRF '+   //ë��
          ',case when cast(sum(nvl(SALE_MNY,0)) as decimal(18,3))<>0 then cast(sum(nvl(SALE_PRF,0)) as decimal(18,3))*100.00/cast(sum(nvl(SALE_MNY,0)) as decimal(18,3)) else 0 end as SALE_RATE '+
          ',case when cast(sum(nvl(SALE_AMT,0)) as decimal(18,3))<>0 then cast(sum(nvl(SALE_PRF,0)) as decimal(18,3))*1.000/cast(sum(nvl(SALE_AMT,0)) as decimal(18,3)) else 0 end as SALE_PRF '+
          ',sum(nvl(SALE_CST,0)) as SALE_CST '+
          ',sum(nvl(SALE_AGO,0)) as SALE_AGO '+
          ',j.LEVEL_ID as LEVEL_ID '+
          ',substring(''                       '',1,len(j.LEVEL_ID)-6)'+GetStrJoin(Factor.iDbType)+'j.SORT_NAME as SORT_NAME,j.RELATION_ID as SORT_ID '+
          'from ('+
          'select 2 as A,RELATION_ID,SORT_ID,SORT_NAME,((case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end)'+GetStrJoin(Factor.iDbType)+'isnull(LEVEL_ID,'''')) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1 and COMM not in (''02'',''12'')'+
          'union all '+
          'select distinct 1 as A,RELATION_ID,'+IntToVarchar('RELATION_ID') +' as SORT_ID,RELATION_NAME as SORT_NAME,(case when RELATION_ID=0 then ''9999999'' else '+IntToVarchar('RELATION_ID')+' end) as LEVEL_ID from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+
          ' and SORT_TYPE=1 and COMM not in (''02'',''12'') ) j '+
          'left outer join ('+strSql+') r on j.RELATION_ID=r.RELATION_ID '+JoinCnd+
          ' group by j.A,j.RELATION_ID,j.LEVEL_ID,j.SORT_NAME '+
          ' order by '+GetRelation_ID('j.RELATION_ID')+',j.A,j.LEVEL_ID'
       );
      end;
    3:begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(SALE_AMT) as SALE_AMT '+
          ',case when cast(sum(SALE_AMT) as decimal(18,3))<>0 then cast(sum(SALE_TTL) as decimal(18,3))*1.000/cast(sum(SALE_AMT) as decimal(18,3)) else 0 end as SALE_PRC '+
          ',sum(SALE_TTL) as SALE_TTL '+
          ',sum(SALE_MNY) as SALE_MNY '+
          ',sum(SALE_TAX) as SALE_TAX '+
          ',sum(SALE_RTL) as SALE_RTL '+
          ',sum(SALE_PRF) as SALE_ALLPRF '+   //ë��          
          ',case when cast(sum(SALE_MNY) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
          ',case when cast(sum(SALE_AMT) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.000/cast(sum(SALE_AMT) as decimal(18,3)) else 0 end as SALE_PRF '+
          ',sum(SALE_CST) as SALE_CST '+
          ',sum(SALE_AGO) as SALE_AGO '+
        ',r.CLIENT_CODE as SORT_ID,isnull(r.CLIENT_NAME,''�޳���'') as SORT_NAME from ('+strSql+') j left outer join VIW_CLIENTINFO r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID3=r.CLIENT_ID group by r.CLIENT_ID,r.CLIENT_CODE,r.CLIENT_NAME order by r.CLIENT_CODE'
         );
      end;
    else
      begin
        Result :=  ParseSQL(Factor.iDbType,
        'select '+
          ' sum(SALE_AMT) as SALE_AMT '+
          ',case when cast(sum(SALE_AMT) as decimal(18,3))<>0 then cast(sum(SALE_TTL) as decimal(18,3))*1.000/cast(sum(SALE_AMT) as decimal(18,3)) else 0 end as SALE_PRC '+
          ',sum(SALE_TTL) as SALE_TTL '+
          ',sum(SALE_MNY) as SALE_MNY '+
          ',sum(SALE_TAX) as SALE_TAX '+
          ',sum(SALE_RTL) as SALE_RTL '+
          ',sum(SALE_PRF) as SALE_ALLPRF '+   //ë��          
          ',case when cast(sum(SALE_MNY) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
          ',case when cast(sum(SALE_AMT) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.000/cast(sum(SALE_AMT) as decimal(18,3)) else 0 end as SALE_PRF '+
          ',sum(SALE_CST) as SALE_CST '+
          ',sum(SALE_AGO) as SALE_AGO '+
          ',isnull(r.SORT_ID,''#'') as SID '+
        ',r.SEQ_NO as SORT_ID,isnull(r.SORT_NAME,''��'') as SORT_NAME from ('+strSql+') j left outer join ('+
        'select TENANT_ID,SORT_ID,SORT_NAME,SEQ_NO from VIW_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE='+IntToStr(GodsStateIdx)+' '+
        ') r on j.TENANT_ID=r.TENANT_ID and j.SORT_ID'+IntToStr(GodsStateIdx)+'=r.SORT_ID group by r.SEQ_NO,r.SORT_NAME,r.SORT_ID order by r.SEQ_NO'
         );
      end;
  end;
end;

function TfrmSaleManSaleReport.GetUnitIDIdx: integer;
begin
  result:=0;
  if (RzPage.ActivePage=TabSheet1) and (fndP1_UNIT_ID.ItemIndex<>-1) then       //���������۴�ͳ�Ʊ�
    result:=fndP1_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet2) and (fndP2_UNIT_ID.ItemIndex<>-1) then  //�ͻ�����ͳ�Ʊ�
    result:=fndP2_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet3) and (fndP3_UNIT_ID.ItemIndex<>-1) then  //��������ͳ�Ʊ�
    result:=fndP3_UNIT_ID.ItemIndex
  else if (RzPage.ActivePage=TabSheet4) and (fndP4_UNIT_ID.ItemIndex<>-1) then  //��Ʒ����ͳ�Ʊ�
    result:=fndP4_UNIT_ID.ItemIndex;
end;

procedure TfrmSaleManSaleReport.SetRzPageActivePage(IsGroupReport: Boolean);
var
  i: integer;
  IsVisble: Boolean;
  Rs: TZQuery;
begin
  {Rs:=Global.GetZQueryFromName('CA_DEPT_INFO');
  if Rs<>nil then
  begin
    try
      Rs.Filtered:=false;
      Rs.Filter:='DEPT_TYPE=1';
      Rs.Filtered:=true;
      rzPage.Pages[0].TabVisible:=(Rs.RecordCount>0);  //���Ӫ����ʱ��ʾ
    finally
      Rs.Filtered:=false;
      Rs.Filter:='';
    end;
  end;}

  IsVisble:=HasChild and (Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) = '0001');
  rzPage.Pages[1].TabVisible := true;
  rzPage.Pages[2].TabVisible := true;
  for i:=0 to rzPage.PageCount-1 do
  begin
    if rzPage.Pages[i].TabVisible then
    begin
      rzPage.ActivePageIndex:=i;
      break;
    end;
  end; 
end;

procedure TfrmSaleManSaleReport.SetUnitIDList(DBGrid: TDBGridEh;
  ColName: string);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(DBGrid,ColName); 
  if (Rs<>nil) and (Rs.Active) and (SetCol<>nil) then
  begin
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(Rs.fieldByName('UNIT_ID').AsString);
      SetCol.PickList.Add(Rs.fieldByName('UNIT_NAME').AsString);
      Rs.Next;
    end;
  end;
end;

function TfrmSaleManSaleReport.GetRowType: integer;
begin
  result :=0;
end;

procedure TfrmSaleManSaleReport.PrintBefore;
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

function TfrmSaleManSaleReport.GetClientSQL(chk: boolean): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,StrCnd,strWhere,ShopCnd,GoodTab,SQLData: string;
begin
  StrCnd:='';
  ShopCnd:='';
  if P2_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P2_D1.Date > P2_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+DataRight;

  //���۷�ʽ:    
  if fndP2_SALES_STYLE.ItemIndex>0 then
    strWhere:=strWhere+' and A.SALES_STYLE='''+TRecord_(fndP2_SALES_STYLE.Properties.Items.Objects[fndP2_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';
  
  //��������:
  if fndP2_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP2_SALES_TYPE.Properties.Items.Objects[fndP2_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P2_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and SALES_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and SALES_DATE>='+InttoStr(vBegDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and SALES_DATE>'+InttoStr(RckMaxDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';
  end;

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
  if (fndP2_STAT_ID.Visible) and (fndP2_STAT_ID.AsString <> '') and (fndP2_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP2_TYPE_ID)+'='''+fndP2_STAT_ID.AsString+''' ';
  end;

  //��Ʒ����:
  if (fndP2_SORT_ID.Visible) and (trim(fndP2_SORT_ID.Text)<>'') and (trim(srid2)<>'') then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    case Factor.iDbType of
     4: strWhere:=strWhere+' and C.RELATION_ID='+srid2+' ';
     else
        strWhere:=strWhere+' and C.RELATION_ID='''+srid2+''' ';
    end;
    if trim(sid2)<>'' then
      strWhere := strWhere+' and C.LEVEL_ID like '''+sid2+'%'' ';
  end else
    GoodTab:='VIW_GOODSPRICE';

  //2011.05.11 Add ��������:
  if trim(fndP2_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP2_DEPT_ID.AsString);
  //2011.05.11 Add ��Ʒ����:
  if trim(fndP2_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP2_GODS_ID.AsString,'A.GODS_ID');

  //�ŵ�����
  if Trim(fndP2_SHOP_ID.Text) <> '' then
    begin
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP2_SHOP_ID.AsString+''' ';
      StrCnd:=' and SHOP_ID='''+fndP2_SHOP_ID.AsString+''' ';
    end;

  //ҵ��Ա
  if Trim(fndP2_GUIDE_USER.Text) <> '' then
  begin
    strWhere:=strWhere + ' and isnull(GUIDE_USER,'''')='''+fndP2_GUIDE_USER.AsString+''' ';
    StrCnd := StrCnd + ' and isnull(GUIDE_USER,'''')='''+fndP2_GUIDE_USER.AsString+''' ';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
  begin
    SQLData:='(select TENANT_ID,SHOP_ID,isnull(GUIDE_USER,''#'')as GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
             'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  end else
  if RckMaxDate >= vEndDate then //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_C_GOODS_DAYS'
  else 
  begin
    SQLData :=
      '(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,CREA_DATE,GODS_ID,SALE_AMT,SALE_MNY,SALE_TAX,SALE_RTL,SALE_CST,SALE_AGO,SALE_PRF from RCK_C_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,isnull(GUIDE_USER,''#'')as GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
      'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP2_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',isnull(A.GUIDE_USER,''#'') as GUIDE_USER '+
    ',sum(SALE_AMT*1.000/'+UnitCalc+') as SALE_AMT '+
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(SALE_MNY)+sum(SALE_TAX) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRC '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+ //��˰�ϼ�
    ',sum(SALE_MNY) as SALE_MNY '+  //δ˰���
    ',sum(SALE_TAX) as SALE_TAX '+  //˰��
    ',sum(SALE_RTL) as SALE_RTL '+  //��ʱûʹ��
    ',sum(SALE_PRF) as SALE_ALLPRF '+  //ë��
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRF '+ //��λë��
    ',case when cast(sum(SALE_MNY) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_AGO) as SALE_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+ strWhere + ' '+
    'group by A.TENANT_ID,isnull(A.GUIDE_USER,''#'')';

  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',r.ACCOUNT,isnull(r.USER_NAME,''��'') as USER_NAME from ('+strSql+') j '+
    ' left outer join VIW_USERS r on j.TENANT_ID=r.TENANT_ID and j.GUIDE_USER=r.USER_ID order by r.USER_ID'
    );
end;

function TfrmSaleManSaleReport.GetRegionSQL(chk: boolean): string;
var
  UnitCalc: string;  //��λ�����ϵ
  strSql,StrCnd,strWhere,GoodTab,SQLData: string;
begin
  StrCnd:='';
  if P1_D1.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D2.EditValue = null then Raise Exception.Create('����������������Ϊ��');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('�������ڲ���С�ڿ�ʼ����...');
  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttoStr(Global.TENANT_ID)+DataRight;

  //���۷�ʽ:    
  if fndP1_SALES_STYLE.ItemIndex>0 then
    strWhere:=strWhere+' and A.SALES_STYLE='''+TRecord_(fndP1_SALES_STYLE.Properties.Items.Objects[fndP1_SALES_STYLE.ItemIndex]).FieldbyName('CODE_ID').AsString+''' ';

  //��������:
  if fndP1_SALES_TYPE.ItemIndex>0 then
    strWhere:=strWhere+' and A.IS_PRESENT='+TRecord_(fndP1_SALES_TYPE.Properties.Items.Objects[fndP1_SALES_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString+' ';

  //��ѯ������: ������ҵID
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D1.Date));  //��ʼ����
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',P1_D2.Date));  //��������
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);
  if RckMaxDate < vBegDate then
  begin
    if vBegDate=vEndDate then
      StrCnd:=StrCnd+' and SALES_DATE='+InttoStr(vBegDate)+' '  //������
    else
      StrCnd:=StrCnd+' and SALES_DATE>='+InttoStr(vBegDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  if RckMaxDate >= vEndDate then 
  begin
    if vBegDate=vEndDate then
      strWhere:=strWhere+' and A.CREA_DATE='+InttoStr(vBegDate)+' '  //������
    else
      strWhere:=strWhere+' and A.CREA_DATE>='+InttoStr(vBegDate)+' and A.CREA_DATE<='+InttoStr(vEndDate)+' ';  //������
  end else
  begin
    StrCnd:=StrCnd+' and SALES_DATE>'+InttoStr(RckMaxDate)+' and SALES_DATE<='+InttoStr(vEndDate)+' ';
  end;
  
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
  if (fndP1_STAT_ID.Visible) and (fndP1_STAT_ID.AsString <> '') and (fndP1_TYPE_ID.ItemIndex>=0) then
  begin
    strWhere:=strWhere+' and C.SORT_ID'+GetGodsSTAT_ID(fndP1_TYPE_ID)+'='''+fndP1_STAT_ID.AsString+''' ';
  end;

  //��Ʒ����:
  if (fndP1_SORT_ID.Visible) and (trim(fndP1_SORT_ID.Text)<>'') and (trim(srid1)<>'') then
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

  //2011.05.11 Add ��Ʒ����:
  if trim(fndP1_GODS_ID.AsString)<>'' then
    strWhere:=strWhere+GetGodsIdsCnd(fndP1_GODS_ID.AsString,'A.GODS_ID');
  //2011.05.11 Add ��������:
  if trim(fndP1_DEPT_ID.AsString)<>'' then
    strWhere:=strWhere+ShopGlobal.GetDeptID('A.DEPT_ID',fndP1_DEPT_ID.AsString);
  //�ŵ�����
  if Trim(fndP1_SHOP_ID.Text) <> '' then
    begin
      strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
      StrCnd:=' and SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
    end;
  //ҵ��Ա
  if Trim(fndP1_GUIDE_USER.Text) <> '' then
  begin
    strWhere:=strWhere + ' and GUIDE_USER='''+fndP1_GUIDE_USER.AsString+''' ';
    StrCnd := StrCnd + ' and GUIDE_USER='''+fndP1_GUIDE_USER.AsString+''' ';
  end;

  if RckMaxDate < vBegDate then      //--[ȫ����ѯ��ͼ]
  begin
    SQLData:='(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
             'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+')'
  end else
  if RckMaxDate >= vEndDate then  //--[ȫ����ѯ̨�ʱ�]
    SQLData:='RCK_C_GOODS_DAYS'
  else //union all
  begin
    SQLData :=
      '(select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,CREA_DATE,GODS_ID,SALE_AMT,SALE_MNY,SALE_TAX,SALE_RTL,SALE_CST,SALE_AGO,SALE_PRF from RCK_C_GOODS_DAYS where TENANT_ID='+Inttostr(Global.TENANT_ID)+' and CREA_DATE>='+InttoStr(vBegDate)+' and CREA_DATE<='+InttoStr(RckMaxDate)+' '+
      ' union all '+
      ' select TENANT_ID,SHOP_ID,GUIDE_USER,DEPT_ID,SALES_STYLE,IS_PRESENT,SALES_DATE as CREA_DATE,GODS_ID,CALC_AMOUNT as SALE_AMT,NOTAX_MONEY as SALE_MNY,TAX_MONEY as SALE_TAX,(CALC_MONEY+AGIO_MONEY) as SALE_RTL,'+
      'COST_MONEY as SALE_CST,AGIO_MONEY as SALE_AGO,NOTAX_MONEY-COST_MONEY as SALE_PRF  from VIW_SALESDATA where TENANT_ID='+Inttostr(Global.TENANT_ID)+' '+StrCnd+' '+
      ')';
  end;

  UnitCalc:=GetUnitTO_CALC(fndP1_UNIT_ID.ItemIndex,'C');
  strSql :=
    'SELECT '+
    ' A.TENANT_ID '+
    ',isnull(A.DEPT_ID,''#'')as DEPT_ID'+
    ',sum(SALE_AMT*1.000/'+UnitCalc+') as SALE_AMT '+
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(SALE_MNY)+sum(SALE_TAX) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRC '+
    ',sum(SALE_MNY)+sum(SALE_TAX) as SALE_TTL '+ //��˰�ϼ�
    ',sum(SALE_MNY) as SALE_MNY '+  //δ˰���
    ',sum(SALE_TAX) as SALE_TAX '+  //˰��
    ',sum(SALE_RTL) as SALE_RTL '+  //��ʱûʹ��
    ',sum(SALE_PRF) as SALE_ALLPRF '+  //ë��
    ',case when cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*1.000/cast(sum(SALE_AMT*1.000/'+UnitCalc+') as decimal(18,3)) else 0 end as SALE_PRF '+ //��λë��
    ',case when cast(sum(SALE_MNY) as decimal(18,3))<>0 then cast(sum(SALE_PRF) as decimal(18,3))*100.00/cast(sum(SALE_MNY) as decimal(18,3)) else 0 end as SALE_RATE '+
    ',sum(SALE_CST) as SALE_CST '+
    ',sum(SALE_AGO) as SALE_AGO '+
    'from '+SQLData+' A,CA_SHOP_INFO B,'+GoodTab+' C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID  '+ strWhere + ' '+
    'group by A.TENANT_ID,isnull(A.DEPT_ID,''#'')';

  Result :=  ParseSQL(Factor.iDbType,
    'select j.* '+
    ',isnull(r.DEPT_NAME,''��'') as DEPT_NAME from ('+strSql+') j '+
    ' left outer join CA_DEPT_INFO r on j.DEPT_ID=r.DEPT_ID order by j.DEPT_ID'
    );
end;

function TfrmSaleManSaleReport.GetGodsSortIdx: string;
var
  AObj: TRecord_;
begin
  AObj:=TRecord_(fndP4_RPTTYPE.Properties.Items.Objects[fndP4_RPTTYPE.ItemIndex]);
  result:=AObj.fieldbyName('SORT_ID').AsString;
  if result='' then result:='0';
end;

procedure TfrmSaleManSaleReport.DBGridEh4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  GridDrawColumnCell(Sender, Rect,DataCol, Column, State);
end;

procedure TfrmSaleManSaleReport.DBGridEh4TitleClick(Column: TColumnEh);
begin
  inherited;
  DBGridTitleClick(adoReport4,Column,'ORDER_ID');
end;

procedure TfrmSaleManSaleReport.RB_DGYClick(Sender: TObject);
begin
  inherited;
 { if RB_SYY.Checked then
    TabSheet2.Caption:='����Ա���ۻ��ܱ�'
  else
    TabSheet2.Caption:='����Ա���ۻ��ܱ�';
  }
end;

function TfrmSaleManSaleReport.GetDataRight: string;
begin
  //�����ݣ�RCK_C_GOODS_DAYS��VIW_SALESDATA  A
  result:=' '+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' '+ShopGlobal.GetDataRight('A.SHOP_ID',1);
end;

end.
