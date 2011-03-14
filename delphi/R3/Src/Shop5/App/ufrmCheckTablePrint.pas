unit ufrmCheckTablePrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrameBaseReport, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, RzLstBox,
  RzChkLst, RzCmboBx, RzBckgnd, RzButton, Mask, RzEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  cxCalendar, cxButtonEdit, cxCheckBox, zBase, zrComboBoxList, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmCheckTablePrint = class(TframeBaseReport)
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label19: TLabel;
    btnOk: TRzBitBtn;
    fndP1_UNIT_ID: TcxComboBox;
    fndP1_SORT_ID: TcxButtonEdit;
    fndP1_SHOP_ID: TzrComboBoxList;
    fndP1_TYPE_ID: TcxComboBox;
    fndP1_STAT_ID: TzrComboBoxList;
    fndP1_SHOW_ZERO: TcxCheckBox;  
    fndP1_PRINT_DATE: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fndP1_TYPE_IDPropertiesChange(Sender: TObject);
    procedure fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure fndP1_PRINT_DATEBeforeDropList(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    sid1,//��Ʒ����ID1;
    srid1,//��Ʒ����REGLATION_ID; ��ϵID
    sid2: string;
    cdsPrintDate: TZQuery;
    LastPrintDateShopID: string; //���һ�δ�cdsPrintDate��SHOP_ID

    procedure GetPrintDataList;  //�̵���������ѡ��Items
    function  GetUnitIDIdx: integer;
    //�̵���ձ�
    function  GetGoodPrintSQL: string;
  public
    procedure RzPage1Open;  //ȡ��ѯ����
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
    procedure DoOpenDefaultData(Aobj: TRecord_); //Ĭ����ʾ��������
    class procedure frmCheckTablePrint(Aobj: TRecord_); //��������ʾ
    property  UnitIDIdx: integer read GetUnitIDIdx; //��ǰͳ�Ƽ�����ʽ
  end;

implementation

uses
  uShopGlobal, uShopUtil,uDsUtil, uFnUtil, uGlobal, uCtrlUtil,
  ufrmSelectGoodSort, ObjCommon;

{$R *.dfm}

procedure TfrmCheckTablePrint.FormCreate(Sender: TObject);
 procedure SetGridColItems(SetCol:TColumnEh; rs:TZQuery);
 begin
   if (SetCol<>nil) and (rs.Active) then
   begin
     SetCol.KeyList.Add('#');
     SetCol.PickList.Add('��');
     SetCol.KeyList.Add('T');
     SetCol.PickList.Add('С��');
     rs.First;
     while not rs.Eof do
     begin
       SetCol.KeyList.Add(rs.fieldbyName('SORT_ID').asString);
       SetCol.PickList.Add(rs.fieldbyName('SORT_NAME').asString);
       rs.Next;
     end;
   end;
 end;
var
  i: integer;
  rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;   
  LastPrintDateShopID:='';
  cdsPrintDate:=TZQuery.Create(self);
  fndP1_PRINT_DATE.DataSet:=cdsPrintDate;
  InitGridPickList(DBGridEh1);
  //���ͳ�Ƶ�λItems;
  rs:=Global.GetZQueryFromName('PUB_MEAUNITS'); //������λ
  AddDBGridEhColumnItems(DBGridEh1,rs,'UNIT_ID','UNIT_ID','UNIT_NAME');

  //����DBGird������
  rs:=Global.GetZQueryFromName('PUB_SIZE_GROUP');
  SetCol:=FindColumn(self.DBGridEh1, 'PROPERTY_01');
  SetGridColItems(SetCol,rs);
  //����DBGird��ɫ��
  rs:=Global.GetZQueryFromName('PUB_COLOR_GROUP');
  SetCol:=FindColumn(self.DBGridEh1, 'PROPERTY_02');
  SetGridColItems(SetCol,rs);

  //�ŵ�List:
  fndP1_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
  fndP1_SHOP_ID.Text := Global.SHOP_NAME;

  fndP1_SHOW_ZERO.Checked := true;

  GetPrintDataList;  //�̵���������ѡ��Items
  if cdsPrintDate.Active then
  begin
    fndP1_PRINT_DATE.KeyValue := fndP1_PRINT_DATE.DataSet.FieldbyName('PRINT_DATE').asString;
    fndP1_PRINT_DATE.Text := fndP1_PRINT_DATE.DataSet.FieldbyName('PRINT_DATE').asString;
  end;
  
  rzPage.ActivePageIndex := 0;
  RefreshColumn;
  //TDbGridEhSort.InitForm(self);
  TDbGridEhSort.InitForm(self);
end;

function TfrmCheckTablePrint.GetRowType: integer;
begin
{  if DBGridEh.DataSource.DataSet.FieldbyName('grp0').AsInteger=1 then
  result := 1
  else
  if DBGridEh.DataSource.DataSet.FieldbyName('grp2').AsInteger=1 then
  result := 2
  else
  result := 0;
 }
end;

procedure TfrmCheckTablePrint.fndP1_TYPE_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  AddGoodSortTypeItemsList(Sender,fndP1_STAT_ID); 
end;

function TfrmCheckTablePrint.GetGoodPrintSQL: string;
var
  SortTypeIdx: integer;
  strSql,strWhere,GoodTab,CalcFields,UnitField,CodeID: string;
begin
  //�ŵ�����
  if trim(fndP1_SHOP_ID.AsString)='' then Raise Exception.Create('  ��ѡ���ŵ����ƣ�  ');
  strWhere := ' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';

  //�̵�����
  if fndP1_PRINT_DATE.AsString = '' then Raise Exception.Create('��ѡ���̵�����...');
  strWhere := strWhere + ' and A.PRINT_DATE='+fndP1_PRINT_DATE.AsString+' ';  

  //��Ʒ����[��Ӧ��] (��ǰ����Ϊ���Ż���ѯ���ܣ��Ӳ��ӽ��һ��)
  strWhere := strWhere+' and (B.TENANT_ID='+InttoStr(Global.TENANT_ID)+' and B.SHOP_ID='''+Global.SHOP_ID+''')';  //������ҵID���ŵ�
  if trim(fndP1_SORT_ID.Text)<>'' then
  begin
    GoodTab:='VIW_GOODSPRICE_SORTEXT';
    strWhere := strWhere+' and ('+GetLikeCnd(Factor.iDbType,'B.LEVEL_ID',sid1,'','R',false)+' and B.RELATION_ID='''+srid1+''')';
  end else
    GoodTab:='VIW_GOODSPRICEEXT'; 

  //��Ʒ����:
  if fndP1_STAT_ID.AsString<>'' then
  begin
    CodeID:=trim(TRecord_(fndP1_TYPE_ID.Properties.Items.Objects[fndP1_TYPE_ID.ItemIndex]).fieldbyName('CODE_ID').asString);
    strWhere := strWhere +' and (B.SORT_ID'+CodeID+'='+QuotedStr(fndP1_STAT_ID.AsString)+')';
  end;

  //����
  if not fndP1_SHOW_ZERO.Checked then
    strWhere := strWhere + ' and (A.CHK_AMOUNT <> 0 or A.RCK_AMOUNT<>0)';

  //ͳ������������λ:
  // strWhere := strWhere + ' and '+ GetUnitIDCnd(UnitIDIdx,'B');

  //��ǰͳ�Ƶ�λ:
  UnitField:=GetUnitID(UnitIDIdx,'B','UNIT_ID'); //UNIT_ID
  CalcFields:='('+GetUnitTO_CALC(UnitIDIdx,'B')+')'; //[ͳ�Ƶ�λIndex,��ѯ�����,�ֶα���]
  strSql:=
    'select A.TENANT_ID as TENANT_ID,A.GODS_ID as GODS_ID '+   //--��Ʒ����
    ','+UnitField+                    // UNIT_IDͳ�Ƶ�λ
    //  ',B.BARCODE as BARCODE'+          //[��ѯ��λ��]������
    ',GODS_NAME,GODS_CODE'+           //--��Ʒ���ơ���Ʒ����
    ',A.BATCH_NO as BATCH_NO,A.LOCUS_NO as LOCUS_NO,'+   //--���š�������
    'A.PROPERTY_01 as PROPERTY_01,A.PROPERTY_02 as PROPERTY_02' +   //--��ɫ�롢������
    ',(RCK_AMOUNT/'+CalcFields+') as RCK_AMOUNT ' +  //--����������
    ',(case when D.CHECK_STATUS<>3 then null else CHK_AMOUNT/'+CalcFields+' end) as CHK_AMOUNT ' + //--ʵ�̵�����:[ֻ�е������ʱ����ʾ����]
    ',(case when D.CHECK_STATUS<>3 then null else (isnull(RCK_AMOUNT,0)-isnull(CHK_AMOUNT,0))/'+CalcFields+' end) as PAL_AMOUNT ' +  //--��������
    ',isnull(B.NEW_INPRICE,0) as NEW_INPRICE '+      //--�ɱ���
    ',isnull(B.NEW_OUTPRICE,0) as NEW_OUTPRICE '+    //--���ۼ�  
    ',(case when D.CHECK_STATUS<>3 then null else ((isnull(RCK_AMOUNT,0)-isnull(CHK_AMOUNT,0))*isnull(B.NEW_INPRICE,0))/'+CalcFields+' end) as PAL_INAMONEY ' +    //--����ɱ����
    ',(case when D.CHECK_STATUS<>3 then null else ((isnull(RCK_AMOUNT,0)-isnull(CHK_AMOUNT,0))*isnull(B.NEW_OUTPRICE,0))/'+CalcFields+' end) as PAL_OUTAMONEY ' +  //--�������۽��
    ' from STO_PRINTDATA A,STO_PRINTORDER D,'+GoodTab+' B  ' +
    'where A.PRINT_DATE=D.PRINT_DATE and A.TENANT_ID=D.TENANT_ID and D.TENANT_ID=B.TENANT_ID and D.SHOP_ID=B.SHOP_ID and '+
    ' A.TENANT_ID='+InttoStr(Global.TENANT_ID)+' and B.TENANT_ID=A.TENANT_ID and A.GODS_ID=B.GODS_ID '+StrWhere;

  strSql:='select M.*,bar.BARCODE as BARCODE from ('+strSql+') M '+
    ' left outer join VIW_BARCODE Bar '+
    ' on M.TENANT_ID=Bar.TENANT_ID and Bar.TENANT_ID='+inttostr(Global.TENANT_ID)+' and M.GODS_ID=Bar.GODS_ID and M.UNIT_ID=Bar.UNIT_ID and '+
    ' M.BATCH_NO=Bar.BATCH_NO and M.PROPERTY_01=Bar.PROPERTY_01 and M.PROPERTY_02=Bar.PROPERTY_02  ';

  result:=ParseSQL(Factor.iDbType, strSql);
end;

procedure TfrmCheckTablePrint.PrintBefore;
var s:string; TitlList: TStringList;
begin
  inherited;
  s:='';
  PrintDBGridEh1.Title.Clear;
  PrintDBGridEh1.PageHeader.CenterText.Text := rzPage.ActivePage.Caption;
  try
    TitlList:=TStringList.Create;
    if fndP1_PRINT_DATE.AsString <> '' then TitlList.Add(' �̵����ڣ�'+fndP1_PRINT_DATE.AsString);
    if fndP1_SHOP_ID.AsString <> '' then TitlList.Add('�ŵ����ƣ�'+fndP1_SHOP_ID.Text);
    if trim(fndP1_SORT_ID.Text) <> '' then TitlList.Add('��Ʒ���ࣺ'+fndP1_SORT_ID.Text);
    if trim(fndP1_STAT_ID.AsString) <> '' then TitlList.Add(fndP1_TYPE_ID.Text+'��'+fndP1_STAT_ID.Text);
    if fndP1_UNIT_ID.ItemIndex >= 0 then TitlList.Add('��ʾ��λ��'+fndP1_UNIT_ID.Text);
    s:=FormatReportHead(TitlList,2,10);
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]', s]);
  finally
    TitlList.Free;
  end;
end;

procedure TfrmCheckTablePrint.fndP1_SORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  sid1 := '';
  srid1 := '';
  fndP1_SORT_ID.Text := '';
end;

procedure TfrmCheckTablePrint.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
//  if (Column.FieldName = 'PROPERTY_01') or (Column.FieldName = 'PROPERTY_02') then Exit;
//  if adoReport1.IsEmpty then Exit;

{  if Column.Title.SortMarker= smNoneEh then Column.Title.SortMarker := smUpEh
  else
  begin
    if Column.Title.SortMarker= smUpEh then Column.Title.SortMarker := smDownEh
    else Column.Title.SortMarker := smNoneEh;
  end;

  case Column.Title.SortMarker of
  smNoneEh:adoReport1.Sort := '';
  smDownEh:
    if (Column.FieldName = 'BATCH_NO')
      or
       (Column.FieldName = 'LOCUS_NO')
    then
      adoReport1.Sort :='grp0 DESC,'+Column.FieldName+',gods_id,grp1,grp2 DESC'
    else
      adoReport1.Sort :='grp0 DESC,'+Column.FieldName+'_order,gods_id,grp1,grp2 DESC';
  smUpEh:
    if (Column.FieldName = 'BATCH_NO')
      or
       (Column.FieldName = 'LOCUS_NO')
    then
      adoReport1.Sort :='grp0 DESC,'+Column.FieldName+' DESC,gods_id,grp1,grp2 DESC'
    else
      adoReport1.Sort :='grp0 DESC,'+Column.FieldName+'_order DESC,gods_id,grp1,grp2 DESC';
  end;
  }
end;

procedure TfrmCheckTablePrint.GetPrintDataList;
begin
  if (trim(fndP1_SHOP_ID.AsString)<>'') and (trim(LastPrintDateShopID)<>trim(fndP1_SHOP_ID.AsString)) then
  begin
    LastPrintDateShopID:=trim(fndP1_SHOP_ID.AsString);
    cdsPrintDate.Close;
    cdsPrintDate.SQL.Text := 'select PRINT_DATE,CHECK_STATUS from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID order by PRINT_DATE desc';
    if cdsPrintDate.Params.FindParam('TENANT_ID')<> nil then
      cdsPrintDate.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if cdsPrintDate.Params.FindParam('SHOP_ID')<> nil then
      cdsPrintDate.ParamByName('SHOP_ID').AsString:=fndP1_SHOP_ID.AsString;
    Factor.Open(cdsPrintDate);
  end;
end;

procedure TfrmCheckTablePrint.fndP1_PRINT_DATEBeforeDropList(Sender: TObject);
begin
  inherited;
  GetPrintDataList;
end;
 

procedure TfrmCheckTablePrint.RzPage1Open;
begin
  try
    if adoReport1.Active then adoReport1.Close;
    adoReport1.SQL.Text:=GetGoodPrintSQL;
    Factor.Open(adoReport1);
  finally
  end;
end;

function TfrmCheckTablePrint.GetUnitIDIdx: integer;
begin
  result:=0;
  if RzPage.ActivePage=TabSheet1 then //�̵��ӡ
  begin
    if fndP1_UNIT_ID.ItemIndex<>-1 then
      result:=fndP1_UNIT_ID.ItemIndex;
  end;
end;

procedure TfrmCheckTablePrint.actFindExecute(Sender: TObject);
begin
  inherited;
  case rzPage.ActivePageIndex of
   0: //��һ��ҳ
    begin
      self.RzPage1Open;//��ѯ�̵�
    end;
   1:
    begin

    end;
  end;
end;

class procedure TfrmCheckTablePrint.frmCheckTablePrint(Aobj: TRecord_);
var
  FrmPrintTab: TfrmCheckTablePrint;
begin
  try
    FrmPrintTab:=TfrmCheckTablePrint.Create(nil);
    FrmPrintTab.DoOpenDefaultData(Aobj);
    FrmPrintTab.WindowState := wsMaximized;
    FrmPrintTab.BringToFront;
  finally
  end;
end;

procedure TfrmCheckTablePrint.DoOpenDefaultData(Aobj: TRecord_);
var DropDs: TDataSet; CurID: string;
begin
  CurID:='';
  if (Aobj.FindField('PRINT_DATE')<>nil) then
  begin
    fndP1_PRINT_DATE.KeyValue:=trim(Aobj.fieldbyName('PRINT_DATE').AsString);
    fndP1_PRINT_DATE.Text:=trim(Aobj.fieldbyName('PRINT_DATE').AsString);
  end;
  if Aobj.FindField('SHOP_ID')<>nil then
  begin
    CurID:=trim(Aobj.fieldbyName('SHOP_ID').AsString);
    DropDs:=fndP1_SHOP_ID.DataSet;
    fndP1_SHOP_ID.KeyField:=CurID;
    fndP1_SHOP_ID.Text:=TdsFind.GetNameByID(DropDs,fndP1_SHOP_ID.KeyField,fndP1_SHOP_ID.ListField,CurID);
  end;
  if (trim(Aobj.fieldbyName('PRINT_DATE').AsString)<>'') and (CurID<>'')then
    self.RzPage1Open;//��ѯ�̵�
end;

procedure TfrmCheckTablePrint.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);
end;

procedure TfrmCheckTablePrint.fndP1_SORT_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var SortName: string;
begin
  if SelectGoodSortType(sid1,srid1,SortName) then
    fndP1_SORT_ID.Text:=SortName;
end;

end.
 
