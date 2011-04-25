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
  cxRadioGroup, Buttons;

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
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
       var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String);
  private
    function  GetGoodDetailSQL(chk:boolean=true): widestring;
    procedure AddBillTypeItems; //����ʵ�����Items

    function AddReportReport(TitleList: TStringList; PageNo: string): string; override; //���Title
  public
    procedure PrintBefore;override;
    function  GetRowType:integer;override;
  end;

implementation

uses uShopGlobal, uFnUtil, uGlobal, uCtrlUtil, uShopUtil, ufrmSelectGoodSort, ufrmCostCalc;

{$R *.dfm}

procedure TfrmGodsRunningReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(self,false);
  AddBillTypeItems; //��ӵ�������
  P1_D1.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-01', date));
  P1_D2.Date := fnTime.fnStrtoDate(FormatDateTime('YYYY-MM-DD', date));
  fndP1_BarType_ID.ItemIndex:=0;

  SetRzPageActivePage(false); //����Ĭ�Ϸ�ҳ
  RefreshColumn;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      fndP1_SHOP_ID.Properties.ReadOnly := False;
      fndP1_SHOP_ID.KeyValue := Global.SHOP_ID;
      fndP1_SHOP_ID.Text := Global.SHOP_NAME;
      SetEditStyle(dsBrowse,fndP1_SHOP_ID.Style);
      fndP1_SHOP_ID.Properties.ReadOnly := True;
    end;
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '�ֿ�Ⱥ��';
      Label4.Caption := '�ֿ�����';
    end;
end;

function TfrmGodsRunningReport.GetGoodDetailSQL(chk:boolean=true): widestring;
var
  mx: string;
  strSql,strWhere,CLIENT_Tab: widestring;
begin
  result:='';
  if P1_D1.EditValue = null then Raise Exception.Create(' ������������Ϊ�գ� ');
  if P1_D2.EditValue = null then Raise Exception.Create(' ������������Ϊ�գ� ');
  if P1_D1.Date > P1_D2.Date then Raise Exception.Create('  ��ѯ��ʼ���ڲ��ܴ��ڽ���������������Ϊ�գ� ');
  if trim(fndP1_GODS_ID.AsString)='' then Raise Exception.Create('  ��ѡ��Ҫ��ѯ��Ʒ��  '); 

  //������ҵID
  strWhere:=' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' ';
  //�ŵ�����:
  if fndP1_SHOP_ID.AsString <>'' then
    strWhere:=strWhere+' and A.SHOP_ID='''+fndP1_SHOP_ID.AsString+''' ';
  //��Ʒ����
  if fndP1_GODS_ID.AsString <>'' then
    strWhere:=strWhere+' and A.GODS_ID='''+fndP1_GODS_ID.AsString+''' ';

  //�����루 �������ٺ�|���ţ�:
  if trim(fndP1_BarCode.Text)<>'' then
  begin
    case fndP1_BarType_ID.ItemIndex of
     0: strWhere:=strWhere+' and LOCUS_NO='''+trim(fndP1_BarCode.Text)+''' ';
     1: strWhere:=strWhere+' and BATCH_NO='''+trim(fndP1_BarCode.Text)+''' '
    end;
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

  //��Ӧ��+�ͻ�+��ҵ����
  case Factor.iDbType of
   0,5: CLIENT_Tab:=' select TENANT_ID,cast(TENANT_ID as varchar(36)) as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
   4:   CLIENT_Tab:=' select TENANT_ID,trim(char(TENANT_ID))as CLIENT_ID,TENANT_NAME as CLIENT_NAME from CA_TENANT ';
  end;
  CLIENT_Tab:=
     ' select TENANT_ID,CLIENT_ID,CLIENT_NAME from PUB_CLIENTINFO '+  //��Ӧ�̱�
     ' union all select TENANT_ID,CUST_ID as CLIENT_ID,CUST_NAME as CLIENT_NAME from PUB_CUSTOMER '+  //�ͻ���
     ' union all '+CLIENT_Tab+' ';  //��ҵ��

  strSql :=
    'select A.TENANT_ID'+
     ',A.SHOP_ID'+
     ',B.SHOP_NAME'+
     ',A.CREA_DATE'+
     ',GLIDE_NO'+
     ',ORDER_TYPE'+
     ',A.GODS_ID'+
     ',C.GODS_CODE as GODS_CODE'+
     ',C.GODS_NAME as GODS_NAME'+
     ',C.BARCODE as BARCODE'+
     ',A.CLIENT_ID'+
     ',A.CREA_USER'+
     ',A.UNIT_ID'+
     ',A.PROPERTY_01'+
     ',A.PROPERTY_02'+
     ',BATCH_NO'+
     ',LOCUS_NO'+
     ',APRICE'+
     ',(case when ORDER_TYPE in (11,12,21,22,24) then AMOUNT else -AMOUNT end) as AMOUNT'+
     ',(case when ORDER_TYPE in (11,12,21,22,24) then CALC_MONEY else -CALC_MONEY end) as AMONEY '+
    'from VIW_GOODS_DAYS A,CA_SHOP_INFO B,VIW_GOODSINFO C '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
    ' '+ strWhere + ' ';
    
  //������Ʒ��
  strSql :=
    'select j.*'+
    ',h.CLIENT_NAME as CLIENT_NAME'+
    ',isnull(i.BARCODE,j.BARCODE) as BARCODE'+
    ',u.UNIT_NAME as UNIT_NAME'+
    ',e.USER_NAME as CREA_USER_TXT from '+
    ' ('+strSql+') j '+
    ' left outer join ('+CLIENT_Tab+') h on j.TENANT_ID=h.TENANT_ID and j.CLIENT_ID=h.CLIENT_ID '+                         //��Ӧ��  //j.BATCH_NO=bar.BATCH_NO and
    ' left outer join VIW_BARCODE i on i.BARCODE_TYPE in (''0'',''1'',''2'') and j.TENANT_ID=i.TENANT_ID and j.GODS_ID=i.GODS_ID and j.PROPERTY_01=i.PROPERTY_01 and j.PROPERTY_02=i.PROPERTY_02 and j.UNIT_ID=i.UNIT_ID '+
    ' left outer join VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
    ' left outer join VIW_USERS e on j.TENANT_ID=e.TENANT_ID and j.CREA_USER=e.USER_ID '+
    ' order by CREA_DATE,ORDER_TYPE,GLIDE_NO ';

  Result :=  ParseSQL(Factor.iDbType, strSql);
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
    0:begin //��Ʒ�������ˮ
        if adoReport1.Active then adoReport1.Close;
        strSql := GetGoodDetailSQL;
        if strSql='' then Exit;
        adoReport1.SQL.Text := strSql;
        Factor.Open(adoReport1);
      end;
    1: begin //���ŵ���ܱ�
 
      end;
    2: begin //��������ܱ�

      end;
    3: begin //����Ʒ���ܱ�

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
    PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
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
  //1������
  FindCmp1:=FindComponent('P'+PageNo+'_D1');
  FindCmp2:=FindComponent('P'+PageNo+'_D2');
  if (FindCmp1<>nil) and (FindCmp2<>nil) and (FindCmp1 is TcxDateEdit) and (FindCmp2 is TcxDateEdit) and
     (TcxDateEdit(FindCmp1).Visible) and (TcxDateEdit(FindCmp2).Visible)  then
    TitleList.add('���ڣ�'+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp1).Date)+' �� '+formatDatetime('YYYY-MM-DD',TcxDateEdit(FindCmp2).Date));

  //�̳л���
  inherited AddReportReport(TitleList,PageNo);
end;
                              
procedure TfrmGodsRunningReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName = 'CLIENT_NAME' then Text := '�ϼ�:'+Text+'��';
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
  //��ⵥ��:
  AddSingeItems(SetCol,'11','��ⵥ');
  AddSingeItems(SetCol,'12','���뵥');
  AddSingeItems(SetCol,'13','�˻���');
  //���۵���:
  AddSingeItems(SetCol,'21','���۵�');
  AddSingeItems(SetCol,'22','������');
  AddSingeItems(SetCol,'23','�˻���');
  AddSingeItems(SetCol,'24','���۵�');
  //��������:
  rs := Global.GetZQueryFromName('STO_CHANGECODE');
  if (rs<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add('3'+trim(rs.fieldbyName('CHANGE_CODE').AsString));
      CurName:=trim(rs.fieldbyName('CHANGE_NAME').AsString);
      if not (pos('��',CurName)>0) then CurName:=CurName+'��'; 
      SetCol.PickList.Add(CurName);
      rs.Next;
    end;
  end;
end;                                                      

end.

