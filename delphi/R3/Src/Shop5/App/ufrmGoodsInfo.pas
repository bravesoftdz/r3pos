unit ufrmGoodsInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, cxMaskEdit, cxDropDownEdit, cxMemo,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB,
  cxCheckBox, zBase, ComCtrls, RzTreeVw, RzRadChk, Grids, DBGridEh,
  cxListBox, ZAbstractRODataset, ZAbstractDataset, ZDataset, cxSpinEdit,
  Buttons;

type
  TfrmGoodsInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label32: TLabel;
    Label33: TLabel;
    RzPanel1: TRzPanel;
    Label11: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label42: TLabel;
    edtGODS_SPELL: TcxTextEdit;
    edtGODS_NAME: TcxTextEdit;
    edtGODS_CODE: TcxTextEdit;
    edtNEW_OUTPRICE: TcxTextEdit;
    edtMY_OUTPRICE: TcxTextEdit;
    Label30: TLabel;
    Label41: TLabel;
    edtCALC_UNITS: TzrComboBoxList;
    Label5: TLabel;
    edtBARCODE1: TcxTextEdit;
    TabSheet3: TRzTabSheet;
    Label9: TLabel;
    TabGoodPrice: TRzTabSheet;
    Label20: TLabel;
    Label27: TLabel;
    edtGODS_TYPE: TRadioGroup;
    edtUSING_PRICE: TRadioGroup;
    edtUSING_BATCH_NO: TRadioGroup;
    Label18: TLabel;
    edtHAS_INTEGRAL: TRadioGroup;
    GB_Small: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label38: TLabel;
    Label36: TLabel;
    edtSMALL_UNITS: TzrComboBoxList;
    edtSMALLTO_CALC: TcxTextEdit;
    edtBARCODE2: TcxTextEdit;
    edtMY_OUTPRICE1: TcxTextEdit;
    GB_Big: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtBIG_UNITS: TzrComboBoxList;
    edtBIGTO_CALC: TcxTextEdit;
    edtBARCODE3: TcxTextEdit;
    edtMY_OUTPRICE2: TcxTextEdit;
    tabProperty: TRzTabSheet;
    Label23: TLabel;
    edtNEW_INPRICE: TcxTextEdit;
    edtPROFIT_RATE: TcxMaskEdit;
    lblPROFIT_RATE: TLabel;
    Label43: TLabel;
    CtrlUp1: TAction;
    CtrlDown1: TAction;
    CtrlUp2: TAction;
    CtrlDown2: TAction;
    Label19: TLabel;
    BarCode: TZQuery;
    cdsGoods: TZQuery;
    CdsMemberPrice: TZQuery;
    Label45: TLabel;
    lblSORT_ID3: TLabel;
    edtSORT_ID3: TzrComboBoxList;
    lblSORT_ID1: TLabel;
    Lbl_1: TLabel;
    Label31: TLabel;
    edtNEW_LOWPRICE: TcxTextEdit;
    lblSORT_ID7: TLabel;
    edtSORT_ID7: TzrComboBoxList;
    lblSORT_ID8: TLabel;
    edtSORT_ID8: TzrComboBoxList;
    edtUSING_BARTER: TGroupBox;
    RB_USING_BARTER: TRadioButton;
    RB_NotUSING_BARTER: TRadioButton;
    edtBARTER_INTEGRAL: TcxSpinEdit;
    RzPnl_Price: TRzPanel;
    PriceGrid: TDBGridEh;
    edtSORT_ID1: TcxButtonEdit;
    PRICEPrice_DS: TDataSource;
    RB_USING_BARTER2: TRadioButton;
    edtBARTER_INTEGRAL2: TcxSpinEdit;
    edtUSING_LOCUS_NO: TRadioGroup;
    Label14: TLabel;
    Label21: TLabel;
    edtDefault1: TcxCheckBox;
    edtDefault2: TcxCheckBox;
    TabSheet2: TRzTabSheet;
    Label22: TLabel;
    edtREMARK: TcxMemo;
    TabSheet4: TRzTabSheet;
    RzPnl_BarCode: TRzPanel;
    ExtBarCode: TZQuery;
    ExtBarCodeDs: TDataSource;
    ExtBarCodeGrid: TDBGridEh;
    fndUNIT_ID: TzrComboBoxList;
    ExtPm: TPopupMenu;
    N1: TMenuItem;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtGODS_NAMEPropertiesChange(Sender: TObject);
    procedure edtSORT_ID3AddClick(Sender: TObject);
    procedure edtGODS_CODEKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCALC_UNITSAddClick(Sender: TObject);
    procedure edtSMALL_UNITSAddClick(Sender: TObject);
    procedure edtBIG_UNITSAddClick(Sender: TObject);
    procedure edtSORT_ID7AddClick(Sender: TObject);
    procedure edtSORT_ID8AddClick(Sender: TObject);
    procedure edtSMALLTO_CALCPropertiesChange(Sender: TObject);
    procedure edtNEW_OUTPRICEPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtSORT_ID1_AddClick(Sender: TObject);
    procedure edtCALC_UNITSSaveValue(Sender: TObject);
    procedure edtSMALL_UNITSSaveValue(Sender: TObject);
    procedure edtBIG_UNITSSaveValue(Sender: TObject);
    procedure edtNEW_INPRICEPropertiesChange(Sender: TObject);
    procedure edtPROFIT_RATEPropertiesChange(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure edtBARCODE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtBIGTO_CALCPropertiesChange(Sender: TObject);
    procedure edtMY_OUTPRICEPropertiesChange(Sender: TObject);
    procedure edtSORT_ID2AddClick(Sender: TObject);
    procedure edtSORT_ID6AddClick(Sender: TObject);
    procedure edtSORT_ID5AddClick(Sender: TObject);
    procedure edtNEW_OUTPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtPROFIT_RATEKeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_OUTPRICE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtUSING_PRICEClick(Sender: TObject);
    procedure edtSORT_ID1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure PriceGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure PriceGridExit(Sender: TObject);
    procedure RB_NotUSING_BARTERClick(Sender: TObject);
    procedure edtSORT_ID1KeyPress(Sender: TObject; var Key: Char);
    procedure PriceGridKeyPress(Sender: TObject; var Key: Char);
    procedure edtCALC_UNITSPropertiesChange(Sender: TObject);
    procedure edtSMALL_UNITSPropertiesChange(Sender: TObject);
    procedure edtBIG_UNITSPropertiesChange(Sender: TObject);
    procedure edtSMALL_UNITSExit(Sender: TObject);
    procedure edtCALC_UNITSExit(Sender: TObject);
    procedure edtBIG_UNITSExit(Sender: TObject);
    procedure edtMY_OUTPRICE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_LOWPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtMY_OUTPRICE2KeyPress(Sender: TObject; var Key: Char);
    procedure PriceGridColumns2UpdateData(Sender: TObject; var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure PriceGridColumns3UpdateData(Sender: TObject; var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtDefault1Click(Sender: TObject);
    procedure edtDefault2Click(Sender: TObject);
    procedure edtNEW_LOWPRICEExit(Sender: TObject);
    procedure edtMY_OUTPRICEExit(Sender: TObject);
    procedure edtNEW_OUTPRICEExit(Sender: TObject);
    procedure edtMY_OUTPRICE2Exit(Sender: TObject);
    procedure edtMY_OUTPRICE1Exit(Sender: TObject);
    procedure ExtBarCodeGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure ExtBarCodeGridColumns1BeforeShowControl(Sender: TObject);
    procedure fndUNIT_IDEnter(Sender: TObject);
    procedure fndUNIT_IDExit(Sender: TObject);
    procedure fndUNIT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndUNIT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndUNIT_IDPropertiesChange(Sender: TObject);
    procedure fndUNIT_IDSaveValue(Sender: TObject);
    procedure ExtBarCodeGridKeyPress(Sender: TObject; var Key: Char);
    procedure ExtBarCodeGridMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
  private
    DropUNITS_Ds: TZQuery;
    FPriceChange: Boolean;  //��Ա���Ƿ�༭��
    FSortID: string;      //Append�����SortIDֵ
    FSortName: string;    //Append�����SortNameֵ
    UnitBarCode: string;  //������λ������
    SmallBarCode:string;  //С��װ������
    BigBarCode: string;   //���װ������

    //��Ʒ����: SORT_ID1_KeyValue
    SORT_ID1_KeyValue: string;
 
    //2011.04.26 PM ��ȡ��Ʒָ�������;
    function  GetLblCaption(LblName: string): string;  //���ر�ǩCaption
    procedure DoAddSORT_IDClick(Sender: TObject); //���Add
    procedure DoSaveValueSORT_IDClick(Sender: TObject); //���Add
    procedure CreateComponent(LblCaption: string; NameIdx,vLeft,vTop: integer; DataSet: TDataSet);
    procedure CreateGodsSTAT_INFO(IsExists: Boolean=False);

    procedure UpdateUNITSData(IsEdit: Boolean=true); //���µ�ǰѡ��λ
    function  IsChinese(str:string):Boolean;
    procedure OnGridKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure AddSORT_IDClick(Sender: TObject; SortType: integer); //���Add
    procedure CheckGoodLowPrice(Kind: integer); //�ж�����ۼ�
    procedure CheckGoodsFieldIsEmpty; //�ж���Ʒ�ǿ������Ƿ�Ϊ�գ�
    procedure CheckGoodsNameIsExist; //�ж���Ʒ�����Ƿ���ڱ��ػ����д���
    procedure SetZrCbxDefaultValue(SetCbx: TzrComboBoxList);  //����Ĭ��ֵ
    procedure CheckCLVersionSetParams;  //�ж���ҵ�汾���ò���;
    function  GetColumnIdx(Gird:TDBGridEh; ColName: string): integer;  //����Gird��Idx
    procedure CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
    procedure CALC_MenberProfitPrice(CdsMemberPrice: TZQuery; CALCType: integer; IsAll: Boolean=False); //�����Ա���ۿ۵���
    procedure InitRecord;  //�¼�¼
    procedure ExtGridFocusNextColumn; //����

    procedure UpdateToGlobal(AObj:TRecord_); //����Global
  public
     //SEQNO���ƺ�
     RowID:integer;

     AObj:TRecord_;
     SORT_ID1,flag:string;
     Saved,IsCompany:Boolean;
     CarryRule,Deci:integer;
     locked:boolean;
     //��С��
     function  FindColumn(DBGrid: TDBGridEh; FieldName:string):TColumnEh;
     function  ConvertToFight(value: Currency; deci: Integer): real;
     procedure Append(Sort_ID:string; Sort_Name:string; GODS_ID:string);
     procedure Edit(code: string);
     procedure Open(code: string);
     procedure OpenCopyNew(code: string);
     procedure ReadFromObject(AObj:TRecord_); //��Obj��ȡ�ؼ�����ʾ��
     procedure WriteToObject(AObj:TRecord_);  //д��OBj��¼������
     procedure Save;  //����
     function  IsEdit(Aobj:TRecord_;cdsTable: TZQuery):Boolean;//�ж���Ʒ�����Ƿ����޸�
     procedure IsBarCodeSame(Aobj:TRecord_);//�ж�������û���ظ�
     procedure SetdbState(const Value: TDataSetState); override;
     procedure EditPrice(NotChangPrice: Boolean=False); //ֻ���޸ļ۸�
     procedure WriteBarCode;  //д��������
     procedure WriteExtBarCode;  //д�븽��������
     procedure WriteMemberPrice(GODS_ID: String);   //д���Ա��
     procedure ReadGoodsBarCode(CdsBarCode: TZQuery);      //��ȡ��Ʒ����
     function  ReadBarCode_INFO(BarCode: string):boolean;  //���������ȡ
     class function AddDialog(Owner:TForm;var _AObj:TRecord_;Default:string=''):boolean;
     class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
  end;

var
  SaveSid, SaveSName: string;

implementation

uses
  DBGrids,uShopUtil,uTreeUtil,uDsUtil,uFnUtil,uGlobal,uXDictFactory, ufrmMeaUnits,
  uShopGlobal,ufrmGoodssort, ufrmGoodsSortTree, uframeTreeFindDialog, ufrmClientInfo,
  ufrmSupplierInfo,uGodsFactory;

{$R *.dfm}

procedure TfrmGoodsInfo.Append(Sort_ID,Sort_Name,GODS_ID:string);
begin
  FSortID:=Sort_ID;
  FSortName:=Sort_Name;
  Open('');
  if GODS_ID<>'' then
    OpenCopyNew(GODS_ID);

  dbState := dsInsert;
  //SortId := sid;
  if GODS_ID='' then
  begin
    if Sort_ID<>'' then
    begin
      SORT_ID1_KeyValue:=Sort_ID;
      edtSORT_ID1.Text:=Sort_Name;
    end else
    begin
      SORT_ID1_KeyValue:=SaveSid;
      edtSORT_ID1.Text:=Savesname;
    end;
    edtUSING_PRICE.ItemIndex := 0;
    edtHAS_INTEGRAL.ItemIndex := 0;
    edtGODS_TYPE.ItemIndex := 0;
    edtUSING_BATCH_NO.ItemIndex:=1;
    edtUSING_LOCUS_NO.ItemIndex:=1;
    RB_NotUSING_BARTER.Checked:=true;
    //ͳ��ָ��Ĭ��ֵ:
    // SetZrCbxDefaultValue(edtSORT_ID2);
    // SetZrCbxDefaultValue(edtSORT_ID3);  ����Ӧ�� ��Ϊ  ����Ϊ��
    // SetZrCbxDefaultValue(edtSORT_ID4);
    // SetZrCbxDefaultValue(edtSORT_ID5);
    // SetZrCbxDefaultValue(edtSORT_ID6);
    if not edtCALC_UNITS.DataSet.IsEmpty then
    begin
      edtCALC_UNITS.KeyValue := edtCALC_UNITS.DataSet.FieldbyName('UNIT_ID').AsString;
      edtCALC_UNITS.Text := edtCALC_UNITS.DataSet.FieldbyName('UNIT_NAME').AsString;
      if not TabGoodPrice.TabVisible then CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
    end;
    edtSORT_ID7.KeyValue:='#';
    edtSORT_ID7.Text:='��';
    edtSORT_ID8.KeyValue:='#';
    edtSORT_ID8.Text:='��';
  end;
  edtGODS_CODE.Text := '�Զ����';
  edtBARCODE1.Text := '�Ա�����';
  edtBARCODE2.Text := '';
  edtBARCODE3.Text := '';
  InitRecord;
end;

procedure TfrmGoodsInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

function TfrmGoodsInfo.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGrid.Columns.Count -1 do
  begin
    if UpperCase(DBGrid.Columns[i].FieldName)=UpperCase(FieldName) then
    begin
      Result := DBGrid.Columns[i];
      Exit;
    end;
  end;
end;

{
 2011.06.08 Modif��
  

}
procedure TfrmGoodsInfo.Edit(code: string);
var
  Tmp: TZQuery;
  NotChangePrice: Boolean; //�Ƿ��ǹ�Ӧ��
begin
  Open(code);
  dbState := dsEdit;
  FPriceChange:=False;
  CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
  //�����޸���Ʒ��Ӧ��ID:RELATION_ID;�����Ƿ�����ļۣ�CHANGE_PRICE��;
  Tmp:=Global.GetZQueryFromName('CA_RELATIONS'); 
  if Tmp.Locate('RELATION_ID',trim(cdsGoods.FieldByName('RELATION_ID').AsString),[]) then
  begin
    NotChangePrice:=(Tmp.FieldByName('CHANGE_PRICE').AsString='2');  {== 1:��ҵ���; 2:ͳһ���� ===}
  end;

  if trim(cdsGoods.FieldByName('RELATION_ID').AsString)='0' then //����������Ʒ
  begin
    if Inttostr(Global.TENANT_ID)+'0001'<>trim(Global.SHOP_ID) then //������Ӫ �� �����ܵ� ֻ���޸ı�����ۼ�
      EditPrice(NotChangePrice);
  end else
  begin //���˾�Ӫ��Ʒ
    EditPrice(NotChangePrice);
  end;

  InitRecord;
  
end;

procedure TfrmGoodsInfo.FormCreate(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  CheckCLVersionSetParams; //�ж���ҵ�汾������Ӧ�ؼ�: ��װ�汾��ʾ��ɫ��������
  TabGoodPrice.TabVisible:=False;  //�۸�����ҳ Ĭ��ΪFalse;

  AObj := TRecord_.Create;
  // edtCALC_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  // edtSMALL_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  // edtBIG_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  //��Ʒ�ĵ�8��SORT_ID���ݼ�:
  //edtSORT_ID1.DataSet:=Global.GetZQueryFromName('PUB_GOODSSORT');     //����

  edtSORT_ID3.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');    //����Ӧ��

  //2011.05.02�ر�����
 {
  edtSORT_ID2.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');     //���[�̲�:һ���̡������̡�������]
  edtSORT_ID4.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');    //Ʒ��
  edtSORT_ID5.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');     //�ص�Ʒ��
  edtSORT_ID6.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');     //ʡ����
  edtSORT_ID7.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');    //��ɫ
  edtSORT_ID8.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');     //����
  }

  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
  //��λ����
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);

  //rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  //CreateLevelTree(rs,rzTree,'333333','SORT_ID','SORT_NAME','LEVEL_ID');
  //lblSizeGroup.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'����')+'��';

  //������̬�ؼ�
  CreateGodsSTAT_INFO;

  //ѡ��λ�����Ŀ�Ⱥ͸߶�����:
  SetCol:=FindColumn(self.ExtBarCodeGrid, 'UNIT_ID');
  if SetCol<>nil then
    fndUNIT_ID.DropWidth:=SetCol.Width+17;
end;

procedure TfrmGoodsInfo.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  {for i:=0 to ComponentCount-1 do
  begin
    if (Components[i] is TZQuery) and (TZQuery(Components[i]).Active)  then
      TZQuery(Components[i]).Close;
  end;}
  inherited;
  AObj.Free;
end;

procedure TfrmGoodsInfo.Open(code: string);
var
  Params: TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    Factor.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Params.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(ShopGlobal.TENANT_ID)+'0001';
      Params.ParamByName('SHOP_ID').AsString:=ShopGlobal.SHOP_ID;
      Params.ParamByName('PRICE_ID').AsString:='';
      Params.ParamByName('GODS_ID').asString := code;
      Factor.AddBatch(cdsGoods,'TGoodsInfo',Params);
      Factor.AddBatch(BarCode,'TPUB_BARCODE',Params);
      Factor.AddBatch(ExtBarCode,'TEXT_BARCODE',Params);
      Factor.AddBatch(CdsMemberPrice,'TGoodsPrice',Params);
      Factor.OpenBatch;
      AObj.ReadFromDataSet(cdsGoods);

      //��������SEQNO
      if ExtBarCode.Active then
      begin
        ExtBarCode.First;
        while not ExtBarCode.Eof do
        begin
          ExtBarCode.Edit;
          ExtBarCode.FieldByName('SEQNO').AsInteger:=ExtBarCode.RecNo;
          ExtBarCode.Post;
          ExtBarCode.Next;
        end;
        RowID:=ExtBarCode.RecordCount;
      end;
      //���ݵ�λ:���ݼ�DataSet
      if (trim(cdsGoods.FieldByName('RELATION_ID').AsString)='0') or (trim(cdsGoods.FieldByName('RELATION_ID').AsString)='') then //������Ӫ
        UpdateUNITSData 
      else  //���˹�Ӧ��
        UpdateUNITSData(False);

      ReadFromObject(AObj);
      edtGODS_SPELL.Text:=AObj.FieldByName('GODS_SPELL').AsString;
      if not ShopGlobal.GetChkRight('14500001',2) then
      begin
        Label23.Visible:=False;
        edtNEW_INPRICE.Visible:=False;
        edtPROFIT_RATE.visible:=False;
        lblPROFIT_RATE.Visible:=False;
        Label43.Visible:=False;
      end;
      dbState := dsBrowse;
    except
      Factor.CancelBatch;
      Raise;
    end;

    //���״̬�ж�
    if (dbState=dsBrowse) and (not TabGoodPrice.Visible) then //�жϻ�Ա�۸��Ƿ���ʾ
      CheckTabGoodPriceVisible;

  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.UpdateToGlobal(AObj: TRecord_);
var
  Temp:TZQuery;
  CurObj: TRecord_;
  IsExist,IsRun: Boolean; GodsID: string;
begin
  Temp := Global.GetZQueryFromName('PUB_GOODSINFO');
  Temp.Filtered :=false;
  if not Temp.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
    Temp.Append
  else
    Temp.Edit;
  AObj.WriteToDataSet(Temp,False);
  Temp.Post;

  //ˢ��������[3��]
  try
    CurObj:=TRecord_.Create;
    Temp := Global.GetZQueryFromName('PUB_BARCODE');
    if Temp.Filtered then Temp.Filtered :=false;
    Temp.CommitUpdates; //���Change
    //��ɾ������Ʒ����:
    GodsID:=trim(AObj.FieldbyName('GODS_ID').AsString);
    if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',0]),[]) then Temp.Delete;
    if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',1]),[]) then Temp.Delete;
    if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',2]),[]) then Temp.Delete;
    //ѭ�����:
    BarCode.First;
    while not BarCode.Eof do
    begin
      if Temp.IsEmpty then Temp.Edit else Temp.Append;
      CurObj.ReadFromDataSet(BarCode);
      CurObj.WriteToDataSet(Temp);
      Temp.Post;
      BarCode.Next;
    end;
  finally
    CurObj.Free;
  end;
  //ˢ�¸���������
  try
    IsRun:=true;
    CurObj:=TRecord_.Create;
    Temp := Global.GetZQueryFromName('PUB_BARCODE');
    if Temp.Filtered then Temp.Filtered :=false;
    Temp.CommitUpdates; //���Change
    //��ɾ������Ʒ����:
    GodsID:=trim(AObj.FieldbyName('GODS_ID').AsString);
    while IsRun do
    begin
      if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',3]),[]) then Temp.Delete
      else IsRun:=False;
    end;
    //ѭ�����:
    ExtBarCode.First;
    while not ExtBarCode.Eof do
    begin
      if Temp.IsEmpty then Temp.Edit else Temp.Append;
      CurObj.ReadFromDataSet(ExtBarCode);
      CurObj.WriteToDataSet(Temp);
      Temp.Post;
      ExtBarCode.Next;
    end; 
  finally
    CurObj.Free;
  end; 
end;

procedure TfrmGoodsInfo.Save;
var
  BARCODE_ID:string;
  Params:TftParamList;
begin
  CheckGoodsFieldIsEmpty;  //�����Ʒ�ǿ��ֶ��Ƿ�Ϊ��?
  CheckGoodsNameIsExist;   //�����Ʒ�������Ʒ�����Ƿ��ڱ��ػ����д���[]

  if dbState = dsInsert then
  begin
    AObj.FieldByName('RELATION_ID').AsString:='0'; //��������
    AObj.FieldbyName('GODS_ID').AsString :=TSequence.NewId;  //GUID��
    if (trim(edtGODS_CODE.Text)='�Զ����') or (trim(edtGODS_CODE.Text)='') or (IsChinese(trim(edtGODS_CODE.Text))) then
    begin
      edtGODS_CODE.Text:=TSequence.GetSequence('GODS_CODE',InttoStr(ShopGlobal.TENANT_ID),'',6);  //��ҵ����ID
      AObj.FieldbyName('GODS_CODE').AsString :=edtGODS_CODE.Text;  //��ҵ����ID
    end else
      AObj.FieldbyName('GODS_CODE').AsString:=trim(edtGODS_CODE.Text);
  end;

  if (edtBARCODE1.Text = '�Ա�����') or (trim(edtBARCODE1.Text)='') or (IsChinese(trim(edtBARCODE1.Text))) then
  begin
    BARCODE_ID:=TSequence.GetSequence('BARCODE_ID',InttoStr(ShopGlobal.TENANT_ID),'',6);
    edtBARCODE1.Text := GetBarCode(BARCODE_ID,'#','#');
  end;

  WriteToObject(AObj);  //���Ŀؼ���Valueд��Obj������:

  if (AObj.FieldbyName('GODS_CODE').AsString='') or (pos('�Զ����',AObj.FieldbyName('GODS_CODE').AsString)>0) then
  begin
    //AObj.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('BCODE').AsString;
    edtGODS_CODE.Text:=AObj.FieldbyName('GODS_CODE').AsString;
  end;

  //�ж�������û���ظ�
  IsBarCodeSame(AObj);

  //(1)��Ʒ����������
  cdsGoods.Edit;
  AObj.WriteToDataSet(cdsGoods);
  cdsGoods.Post;

  //(2)д����
  SaveSId :=SORT_ID1_KeyValue;
  SaveSName := edtSORT_ID1.Text;

  //д����Ʒ��������� [���������Ž���д����]
  if trim(AObj.FieldByName('RELATION_ID').AsString)='0' then
  begin
    WriteBarCode;     //д������[��������С��λ]
    WriteExtBarCode;  //д��������
  end;

  //(3)д��Ա���۱�[ѭ��ɾ����û������۸�]
  WriteMemberPrice(AObj.FieldbyName('GODS_ID').AsString);   //д���Ա��

  //�ж���Ʒ������û���޸�
  if (not isEdit(AObj,cdsGoods)) and (flag<>'1')  then Raise Exception.Create('����ǰû���޸ģ�����Ҫ����');

  Factor.BeginBatch;
  Params:=TftParamList.Create(nil);
  try
    try
      if dbState=dsEdit then
      begin
        Params.ParamByName('ROWS_ID').AsString:=TSequence.NewId;     //GUID��
        Params.ParamByName('PRICING_USER').AsString:=Global.UserID;  //����Ա
      end;
      Factor.AddBatch(cdsGoods,'TGoodsInfo',Params);
      Factor.AddBatch(BarCode,'TPUB_BARCODE',nil);
      Factor.AddBatch(ExtBarCode,'TEXT_BARCODE',nil);
      Factor.AddBatch(CdsMemberPrice,'TGoodsPrice',nil);
      Factor.CommitBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;
  UnitBarCode:=Trim(edtBARCODE1.Text);
  SmallBarCode:=Trim(edtBARCODE2.Text);
  BigBarCode:=Trim(edtBARCODE3.Text);
  UpdateToGlobal(Aobj);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmGoodsInfo.edtGODS_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtGODS_SPELL.Text := fnString.GetWordSpell(edtGODS_NAME.Text,3);
end;


procedure TfrmGoodsInfo.edtGODS_CODEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
{  if key<>#8 then
  begin
    if length(edtGODS_CODE.Text)=6 then
    begin
      key:=#0;
      exit;
    end;
  end; }
end;

procedure TfrmGoodsInfo.btnOkClick(Sender: TObject);
var AObj1: TRecord_;
    bl,bol,SaveFalg:Boolean;
begin
  inherited;
  Saved:=False;
  bol:=(dbState<>dsEdit);
  save; //�ύ���ݿ�
  if not Saved then exit; //�����쳣���˳���
  
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bol then
  begin
    if MessageBox(handle,Pchar('�Ƿ�Ҫ����������?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION)=6 then
    begin
      //��������ǰ������Ʒ���࣬������λ�ȵȱ�������
      AObj1:=TRecord_.Create;
      try
        AObj.CopyTo(AObj1);
        Append(SORT_ID1_KeyValue, edtSORT_ID1.Text,'');
        locked := true;
        try
          ReadFromObject(AObj1);
        finally
          locked := false;
        end;
        edtGODS_CODE.Text := '�Զ����';
        edtBARCODE1.Text := '�Ա�����';
        if CLVersion='OHR'  then
        begin
          if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
        end else
        begin
          if edtGODS_CODE.CanFocus then
          begin
            edtGODS_CODE.SetFocus;
            edtGODS_CODE.SelectAll;
          end;
        end;
      finally
        AObj1.Free;
      end;
    end
    else ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmGoodsInfo.ReadFromObject(AObj: TRecord_);
var
  rs:TZQuery;
  s:string;
begin
  uShopUtil.ReadFromObject(AObj,self);

  if AObj.FieldByName('NEW_OUTPRICE').AsFloat<>0 then
    edtPROFIT_RATE.Text:=formatFloat('#0',AObj.FieldByName('NEW_INPRICE').AsFloat*100/AObj.FieldByName('NEW_OUTPRICE').AsFloat)
  else
    edtPROFIT_RATE.Text:= '';
  edtUSING_PRICE.ItemIndex := AObj.FieldbyName('USING_PRICE').AsInteger-1;
  edtGODS_TYPE.ItemIndex := AObj.FieldbyName('GODS_TYPE').AsInteger-1;
  edtHAS_INTEGRAL.ItemIndex := AObj.FieldbyName('HAS_INTEGRAL').AsInteger-1;
  edtUSING_BATCH_NO.ItemIndex := AObj.FieldbyName('USING_BATCH_NO').AsInteger-1;
  edtUSING_LOCUS_NO.ItemIndex := AObj.FieldbyName('USING_LOCUS_NO').AsInteger-1; 

  if AObj.FieldbyName('USING_BARTER').AsInteger=1 then
    edtBARTER_INTEGRAL.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsFloat
  else
    edtBARTER_INTEGRAL.Value:=null;

  //�Ƿ���ƻ��ֻ���:
  RB_NotUSING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=1);   //����
  RB_USING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=2);      //���û��ֶһ�
  RB_USING_BARTER2.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=3);     //���û��ֻ���
  if RB_USING_BARTER.Checked then edtBARTER_INTEGRAL.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsInteger;
  if RB_USING_BARTER2.Checked then edtBARTER_INTEGRAL2.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsInteger;
  
  //��Ʒ���ࣺ
  SORT_ID1_KeyValue:=trim(AObj.FieldbyName('SORT_ID1').AsString);
  edtSORT_ID1.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',SORT_ID1_KeyValue);

  //����Ӧ��:
  edtSORT_ID3.KeyValue:=AObj.FieldbyName('SORT_ID3').AsString;  //����Ӧ��ID
  edtSORT_ID3.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTINFO'),'CLIENT_ID','CLIENT_NAME',Aobj.FieldByName('SORT_ID3').AsString);

  //��ȡ��Ʒ���������ԣ�
  ReadGoodsBarCode(self.BarCode);     //��ȡ����

  edtNEW_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('RTL_OUTPRICE').AsFloat);   //��׼�ۼ�
  edtMY_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE').AsFloat);    //�ŵ��ۼ�
  edtMY_OUTPRICE1.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE1').AsFloat);  //��װ1�ŵ��ۼ�
  edtMY_OUTPRICE2.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE2').AsFloat);  //��װ2�ŵ��ۼ�

  //Ĭ�ϵ�λ��ȡ
  if trim(AObj.fieldbyName('UNIT_ID').AsString)<>'' then
  begin
    edtDefault1.Checked:=trim(AObj.fieldbyName('UNIT_ID').AsString)=trim(AObj.fieldbyName('SMALL_UNITS').AsString);
    edtDefault2.Checked:=trim(AObj.fieldbyName('UNIT_ID').AsString)=trim(AObj.fieldbyName('BIG_UNITS').AsString);
  end else
  begin
    edtDefault1.Checked:=False;
    edtDefault1.Checked:=False;
  end;
end;

procedure TfrmGoodsInfo.WriteToObject(AObj: TRecord_);
var
  i: integer;
  SORT_NAME: string;
  edtSORT_ID: TzrComboBoxList;
begin
  edtPROFIT_RATE.Properties.ReadOnly:=true;
  uShopUtil.WriteToObject(AObj,self);
  edtPROFIT_RATE.Properties.ReadOnly:=False;

  //ˢ��[С�����װ]���½���
  AObj.FieldByName('NEW_INPRICE1').AsFloat:=AObj.FieldByName('NEW_INPRICE').AsFloat*StrtoFloatDef(edtSMALLTO_CALC.Text,0);  //С��װ���½���
  AObj.FieldByName('NEW_INPRICE2').AsFloat:=AObj.FieldByName('NEW_INPRICE').AsFloat*StrtoFloatDef(edtBIGTO_CALC.Text,0);    //���װ���½���

  AObj.FieldByName('RTL_OUTPRICE').AsFloat:=StrtoFloatDef(edtNEW_OUTPRICE.Text,0);   //��׼�ۼ�
  AObj.FieldByName('NEW_LOWPRICE').AsFloat:=StrtoFloatDef(edtNEW_LOWPRICE.Text,0);   //����ۼ�
  AObj.FieldByName('NEW_OUTPRICE').AsFloat:=StrtoFloatDef(edtMY_OUTPRICE.Text,0);    //�����ۼ�

  //�ŵ��Զ���:
  AObj.FieldByName('NEW_OUTPRICE1').AsFloat:=0;  //����Ϊ0��ֻ������������ֵ
  if (StrtoFloatDef(edtMY_OUTPRICE1.Text,0)>0) and (edtSMALL_UNITS.AsString<>'') and (strtoFloatDef(edtSMALLTO_CALC.Text,0)>0)then
    AObj.FieldByName('NEW_OUTPRICE1').AsFloat:=StrtoFloatDef(edtMY_OUTPRICE1.Text,0);
  AObj.FieldByName('NEW_OUTPRICE2').AsFloat:=0;  //����Ϊ0��ֻ������������ֵ
  if (StrtoFloatDef(edtMY_OUTPRICE2.Text,0)>0) and (edtBIG_UNITS.AsString<>'') and (strtoFloatDef(edtBIGTO_CALC.Text,0)>0)then
    AObj.FieldByName('NEW_OUTPRICE2').AsFloat:=StrtoFloat(edtMY_OUTPRICE2.Text);

  AObj.FieldByName('SHOP_ID').AsString:=Global.SHOP_ID;
  AObj.FieldbyName('USING_PRICE').AsInteger := edtUSING_PRICE.ItemIndex+1;    //��Ա�ۿ���
  AObj.FieldbyName('GODS_TYPE').AsInteger := edtGODS_TYPE.ItemIndex+1;        //������ѡ��
  AObj.FieldbyName('HAS_INTEGRAL').AsInteger := edtHAS_INTEGRAL.ItemIndex+1;  //��Ա����
  AObj.FieldbyName('USING_BATCH_NO').AsInteger := edtUSING_BATCH_NO.ItemIndex+1;    //��������
  AObj.FieldbyName('USING_LOCUS_NO').AsInteger := edtUSING_LOCUS_NO.ItemIndex+1;    //�����������ٺ�

  //�Ƿ���ƻ��ֻ���:
  if RB_NotUSING_BARTER.Checked then     //����:
    AObj.FieldbyName('USING_BARTER').AsInteger :=1
  else if RB_USING_BARTER.Checked then   //�һ�:
    AObj.FieldbyName('USING_BARTER').AsInteger:=2
  else if RB_USING_BARTER2.Checked then  //����:
    AObj.FieldbyName('USING_BARTER').AsInteger :=3;
  ////���ֻ�����Ʒ(�����ϵ):        
  if (RB_USING_BARTER.Checked) and (edtBARTER_INTEGRAL.Enabled) then //���ֶһ�
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=edtBARTER_INTEGRAL.Value
  else if (RB_USING_BARTER2.Checked) and (edtBARTER_INTEGRAL2.Enabled) then //���ֻ���
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=edtBARTER_INTEGRAL2.Value
  else
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=0;
  AObj.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;

  //д����Ʒ����:
  if trim(edtSORT_ID1.Text)='' then
     AObj.FieldByName('SORT_ID1').AsString:= ''
  else
     AObj.FieldByName('SORT_ID1').AsString:=SORT_ID1_KeyValue;
  //д����Ʒ���[edtSORT_ID1.KeyValue ..  edtSORT_ID8.KeyValue]
  for i:=0 to ComponentCount-1 do
  begin
    if Components[i] is TzrComboBoxList then
    begin
      edtSORT_ID:=TzrComboBoxList(Components[i]);
      SORT_NAME:=trim(LowerCase(EdtSORT_ID.Name));
      if (pos('edtsort_id',SORT_NAME)>0) and (AObj.FindField(SORT_NAME)<>nil) then
      begin
        AObj.FieldByName('SORT_NAME').AsString:=edtSORT_ID.KeyValue;
      end;
    end;
  end;

  //д��������:
  AObj.FieldByName('BARCODE').AsString:=edtBARCODE1.Text;

  //Ĭ�ϵ�λд��:
  if edtDefault1.Checked then AObj.FieldByName('UNIT_ID').AsString:=AObj.FieldByName('SMALL_UNITS').AsString
  else if edtDefault2.Checked  then AObj.FieldByName('UNIT_ID').AsString:=AObj.FieldByName('BIG_UNITS').AsString
  else AObj.FieldByName('UNIT_ID').AsString:=AObj.FieldByName('CALC_UNITS').AsString;
end;

procedure TfrmGoodsInfo.FormShow(Sender: TObject);
begin
  inherited;
  if dbState=dsBrowse then
  begin
    if edtGODS_CODE.CanFocus then  edtGODS_CODE.SetFocus;
  end else
  begin
    if CLVersion='OHR' then
    begin
      if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
    end else
    begin
      if edtGODS_CODE.CanFocus then  edtGODS_CODE.SetFocus;
    end;
  end;
end;

procedure TfrmGoodsInfo.edtCALC_UNITSAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  try
    if TfrmMeaUnits.AddDialog(self,AObj) then
    begin
      edtCALC_UNITS.KeyValue := AObj.FieldbyName('UNIT_ID').asString;
      edtCALC_UNITS.Text := AObj.FieldbyName('UNIT_NAME').asString;
      UpdateUNITSData;  //��λ����
    end;
  finally
    AObj.Free;
  end;
end;

function TfrmGoodsInfo.IsEdit(Aobj: TRecord_; cdsTable:  TZQuery): Boolean;
  function CheckIsChange(cdsTable:  TZQuery; FieldName: string): Boolean;
  var CurValue,OldValue: string;
  begin
    result:=false;
    if not cdsTable.Active then Exit;
    CurValue:='';
    OldValue:='';
    if not CdsTable.FieldByName(FieldName).IsNull then
      CurValue:=CdsTable.FieldByName(FieldName).Value;
    if not VarIsNull(CdsTable.FieldByName(FieldName).OldValue) then
      OldValue:=CdsTable.FieldByName(FieldName).OldValue;
    result:=(StrtoFloatDef(CurValue,0)<>StrtoFloatDef(OldValue,0));
  end;
var i:integer; CurObj:TRecord_;
begin
  Result:=False;
  for i:=0 to cdsGoods.FieldCount-1 do
  begin
    case cdsGoods.Fields[i].DataType of
      ftSmallint,ftInteger, ftWord, ftFloat,ftCurrency, ftDate, ftTime, ftDateTime:
      begin
        if AObj.Fields[i].AsFloat<>cdsGoods.Fields[i].AsFloat then
        begin
          Result:=True;
          break;
        end;
      end else
      begin
        if AObj.Fields[i].AsString<>cdsGoods.Fields[i].AsString then
        begin
          Result:=True;
          break;
        end;
      end;
    end;
  end;
  
  //�ж��������Ƿ�ı�:
  if trim(cdsGoods.FieldByName('RELATION_ID').AsString)='0' then  //������Ӫ���ж�
  begin
    if (UnitBarCode<>Trim(edtBARCODE1.Text)) or(SmallBarCode<>Trim(edtBARCODE2.Text)) or (BigBarCode<>Trim(edtBARCODE3.Text)) then
      Result:=True;
  end;
  
  if not Result then
    result:=(cdsGoods.UpdateStatus <> usUnmodified);

  //�ж�[��Ա�ȼ��۸��Ƿ��޸�]
  if (not Result) and (CdsMemberPrice.Active) and (TabGoodPrice.TabVisible) and (FPriceChange) then  //��Ա�ȼ������жϼ���ѭ��AsOldValue��AsValue
  begin
    if CdsMemberPrice.State=dsEdit then CdsMemberPrice.Post;
    CdsMemberPrice.First;
    while not CdsMemberPrice.Eof do
    begin
      result:=CheckIsChange(CdsMemberPrice, 'PROFIT_RATE');
      if result then break;
      result:=CheckIsChange(CdsMemberPrice, 'NEW_OUTPRICE');
      if result then break;
      result:=CheckIsChange(CdsMemberPrice, 'NEW_OUTPRICE1');
      if result then break;
      result:=CheckIsChange(CdsMemberPrice, 'NEW_OUTPRICE2');
      if result then break;
      CdsMemberPrice.Next;
    end;
  end;
end;

procedure TfrmGoodsInfo.IsBarCodeSame(Aobj: TRecord_);
  procedure ShowMsgBox(IsRaiseMsg: Boolean; Msg: string);
  begin
    if IsRaiseMsg then raise Exception.Create(Msg)
    else MessageBox(handle,Pchar(Msg),Pchar(Caption),MB_OK);
  end;
  function ChechBarCodeExist(rs: TZQuery; BarCode,GODS_ID: string): Boolean;
  var Str,Cnd: string;
  begin
    result:=False;
    Cnd:='';
    if trim(GODS_ID)<>'' then Cnd:=' and  GODS_ID<>'''+GODS_ID+''' ';
    Str:='select A.BARCODE as BARCODE,A.GODS_ID as GODS_ID,B.GODS_NAME as GODS_NAME,B.GODS_CODE as GODS_CODE from '+
      ' (select BARCODE,GODS_ID from PUB_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and COMM not in (''02'',''12'') and BARCODE='''+BarCode+''' '+Cnd+')A, '+
      ' (select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and COMM not in (''02'',''12'') '+Cnd+') B  '+
      ' where A.GODS_ID=B.GODS_ID ';
    rs.Close;
    rs.SQL.Text:=Str;
    Factor.Open(rs);
    if rs.Active then
      result:=(rs.RecordCount>0);
  end;
var
  tmp: TZQuery;
  IsDUPBARCODE: Boolean; //�����������ظ�
begin
  if (Trim(edtBARCODE1.Text)<>'') and (edtBARCODE1.Text=edtBARCODE2.Text) and (edtBARCODE2.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
    raise Exception.Create('������λ�����롢С��װ����ʹ��װ���벻��һ��!');
  end;
  if (Trim(edtBARCODE1.Text)<>'') and (edtBARCODE1.Text=edtBARCODE2.Text) then
  begin
    if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
    raise Exception.Create('������λ�����벻�ܺ�С��װ����һ��!');
  end;
  if (Trim(edtBARCODE2.Text)<>'') and (edtBARCODE2.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
    raise Exception.Create('С��װ�����벻�ܺʹ��װ����һ��!');
  end;
  if (Trim(edtBARCODE3.Text)<>'') and (edtBARCODE1.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
    raise Exception.Create('���װ���벻�ܺͼ�����λ������һ��!');
  end;

  IsDUPBARCODE:=ShopGlobal.GetParameter('DUPBARCODE')<>'1'; //�����������ظ�
  if dbState=dsInsert then
  begin
    try
      tmp:=TZQuery.Create(nil);
      //�ж�����λ��������
      if ChechBarCodeExist(tmp, edtBARCODE1.Text,'') then
      begin
        if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
      end;
      //�ж�С��װ������
      if ChechBarCodeExist(tmp, edtBARCODE2.Text,'') then
      begin
        if edtBARCODE2.CanFocus then edtBARCODE2.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
      end;
      //�жϴ��װ��������
      if ChechBarCodeExist(tmp, edtBARCODE3.Text,'') then
      begin
        if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
      end;
    finally
      tmp.Free;
    end;
  end else
  if dbState=dsEdit then
  begin
    try
      tmp:=TZQuery.Create(nil);
      //�ж�����λ��������
      if ChechBarCodeExist(tmp, edtBARCODE1.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
      end;

      if ChechBarCodeExist(tmp, edtBARCODE2.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
      end;

      if ChechBarCodeExist(tmp, edtBARCODE3.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
      end;
    finally
      tmp.Free;
    end;
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
 AObj := TRecord_.Create;
  try
    if TfrmMeaUnits.AddDialog(self,AObj) then
    begin
      edtSMALL_UNITS.KeyValue := AObj.FieldbyName('UNIT_ID').asString;
      edtSMALL_UNITS.Text := AObj.FieldbyName('UNIT_NAME').asString;
      UpdateUNITSData;  //��λ����
    end;
  finally
    AObj.Free;
  end;

end;

procedure TfrmGoodsInfo.edtBIG_UNITSAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  try
    if TfrmMeaUnits.AddDialog(self,AObj) then
    begin
      edtBIG_UNITS.KeyValue := AObj.FieldbyName('UNIT_ID').asString;
      edtBIG_UNITS.Text := AObj.FieldbyName('UNIT_NAME').asString;
      UpdateUNITSData;  //��λ����
    end;
  finally
    AObj.Free;
  end;
end;
procedure TfrmGoodsInfo.edtSORT_ID3AddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  try
    if TfrmSupplierInfo.AddDialog(self,AObj) then
    begin
      edtSORT_ID3.KeyValue :=AObj.FieldbyName('CLIENT_ID').AsString;
      edtSORT_ID3.Text := AObj.FieldbyName('CLIENT_NAME').asString;
    end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID7AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 7);
end;

procedure TfrmGoodsInfo.edtSORT_ID8AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 8);
end;

procedure TfrmGoodsInfo.edtSMALLTO_CALCPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
    if Trim(edtSMALLTO_CALC.Text)='' then edtSMALLTO_CALC.Text:='0';
    if (Trim(edtMY_OUTPRICE.Text)<>'') and (Trim(edtSMALL_UNITS.AsString)<>'') then
       edtMY_OUTPRICE1.Text:=FloatToStr(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtSMALLTO_CALC.Text,0));
    //�����Ա��:
    CALC_MenberProfitPrice(CdsMemberPrice,0);
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.edtNEW_OUTPRICEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
    edtMY_OUTPRICE.Text:= floattostr(StrToFloatDef(edtNEW_OUTPRICE.Text,0));
    if edtPROFIT_RATE.Text<>'' then
       edtNEW_INPRICE.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtNEW_OUTPRICE.Text,0)*StrToFloatDef(edtPROFIT_RATE.Text,0)/100,Deci));
    if (Trim(edtSMALLTO_CALC.Text)<>'') and (Trim(edtSMALL_UNITS.AsString)<>'') then
       edtMY_OUTPRICE1.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtSMALLTO_CALC.Text,0),Deci));
    if (Trim(edtBIGTO_CALC.Text)<>'') and (Trim(edtBIG_UNITS.AsString)<>'') then
       edtMY_OUTPRICE2.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtBIGTO_CALC.Text,0),Deci));

    CheckTabGoodPriceVisible;  //�ж��Ƿ���ʾ��Ա��ҳ
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if Application.Terminated then Exit;
  try
   if not((dbState = dsInsert) and (trim(edtGODS_NAME.Text)='')) then
   begin
    WriteToObject(AObj);
    if (not IsEdit(Aobj,cdsGoods)) and (flag<>'1') then Exit;
    i:=MessageBox(handle,Pchar('��Ʒ�������޸ģ��Ƿ񱣴��޸���Ϣ��'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=6 then
    begin
       Save;
       if Saved and Assigned(OnSave) then OnSave(AObj);
      end;
    if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

function TfrmGoodsInfo.IsChinese(str:string):Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to length(str)-1 do
  begin
    if str[i] in LeadBytes then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

procedure TfrmGoodsInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label4.Visible:=true;
  Label6.Visible:=true;
  Label9.Visible:=true;
  Label19.Visible:=true;
  Label41.Visible:=true;
  Label42.Visible:=true;
  edtGODS_TYPE.Enabled:=True;
  edtUSING_PRICE.Enabled:=True;
  edtUSING_BATCH_NO.Enabled:=True;
  edtHAS_INTEGRAL.Enabled:=True;
  //edtUSING_BARTER[���û���]
  RB_NotUSING_BARTER.Enabled:=True;
  RB_USING_BARTER.Enabled:=True;
  edtBARTER_INTEGRAL.Enabled:=True;
  RB_USING_BARTER2.Enabled:=True;
  edtBARTER_INTEGRAL2.Enabled:=True;

  edtUSING_LOCUS_NO.Enabled:=True;
  BtnOk.Visible := (value<>dsBrowse);
  edtPROFIT_RATE.Enabled:=True;
  PriceGrid.ReadOnly:=(dbState=dsBrowse);       //�۸�ȼ�
  ExtBarCodeGrid.ReadOnly:=(dbState=dsBrowse);  //����������
  edtDefault1.Enabled:=true;
  edtDefault2.Enabled:=true;
  if dbState=dsBrowse then
    PriceGrid.Options:=[dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit]
  else
    PriceGrid.Options:=[dgEditing,dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];

  case Value of
  dsInsert:
    begin
      Caption := '��Ʒ����--(����)';
      edtPROFIT_RATE.Enabled:=True;
    end;
  dsEdit:
    begin
      Caption := '��Ʒ����--(�޸�)';
      edtPROFIT_RATE.Enabled:=True;
      edtBARTER_INTEGRAL.Enabled:=RB_USING_BARTER.Checked;
      edtBARTER_INTEGRAL2.Enabled:=RB_USING_BARTER2.Checked;
    end;
  else
    begin
      Caption := '��Ʒ����';
      Label4.Visible:=False;
      Label6.Visible:=False;
      Label9.Visible:=False;
      Label41.Visible:=False;
      Label42.Visible:=False;
      Label19.Visible:=False;
      edtGODS_TYPE.Enabled:=False;
      edtUSING_PRICE.Enabled:=False;
      edtUSING_BATCH_NO.Enabled:=False;
      edtUSING_LOCUS_NO.Enabled:=False;
      edtHAS_INTEGRAL.Enabled:=False;
      edtPROFIT_RATE.Enabled:=False;
      //�Ƿ����û���:
      RB_NotUSING_BARTER.Enabled:=False;
      RB_USING_BARTER.Enabled:=False;
      edtBARTER_INTEGRAL.Enabled:=False;
      RB_USING_BARTER2.Enabled:=False;
      edtBARTER_INTEGRAL2.Enabled:=False;

      edtDefault1.Enabled:=False;
      edtDefault2.Enabled:=False;
    end;
  end;
end;

class function TfrmGoodsInfo.AddDialog(Owner: TForm; var _AObj: TRecord_; Default:string=''): boolean;
begin
   if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('��û��������Ʒ��Ȩ��,��͹���Ա��ϵ.');
   with TfrmGoodsInfo.Create(Owner) do
    begin
      try
        if (Pos('{',Default)>0) and (Pos('}',Default)>0) then
          Append('','',Default)
        else
        begin
          Append('','','');
          if Default<>'' then
          begin
            if IsChinese(Default) then
            begin
              edtGODS_NAME.Text:=Default;
            end
            else if fnString.IsBarCode(Default) then
              begin
                edtBARCODE1.Text:=Default;
                ReadBarCode_INFO(Default);
              end
              else
              begin
                edtGODS_CODE.Text:=Default;
              end;
          end;
        end;
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

class function TfrmGoodsInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('32600001',3) then Raise Exception.Create('��û��������Ʒ��Ȩ��,��͹���Ա��ϵ.');
   with TfrmGoodsInfo.Create(Owner) do
    begin
      try
        Edit(id);
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfo.EditPrice(NotChangPrice: Boolean);
var i:integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TcxComboBox then
       begin
         SetEditStyle(dsBrowse,TcxComboBox(Components[i]).Style);
         TcxComboBox(Components[i]).Properties.ReadOnly:=True;
       end;
    if Components[i] is TcxMemo then
       begin
         SetEditStyle(dsBrowse,TcxMemo(Components[i]).Style);
         TcxMemo(Components[i]).Properties.ReadOnly:=True;
       end;
    if Components[i] is TzrComboBoxList then
       begin
         SetEditStyle(dsBrowse,TzrComboBoxList(Components[i]).Style);
         TzrComboBoxList(Components[i]).Properties.ReadOnly:=True;
       end;
    if Components[i] is TcxTextEdit then
       begin
         SetEditStyle(dsBrowse,TcxTextEdit(Components[i]).Style);
         TcxTextEdit(Components[i]).Properties.ReadOnly:=True;
       end;
    if Components[i] is TcxMaskEdit then
       begin
         SetEditStyle(dsBrowse,TcxMaskEdit(Components[i]).Style);
         TcxMaskEdit(Components[i]).Properties.ReadOnly:=True;
       end;
    if Components[i] is TRadioGroup then
       begin
         TRadioGroup(Components[i]).Enabled:=False;
       end;
    if Components[i] is TcxButtonEdit then
      begin
        TcxButtonEdit(Components[i]).Enabled:=False;
      end;
    if Components[i] is TcxButtonEdit then
      begin
        TcxButtonEdit(Components[i]).Enabled:=False;
      end;
    if Components[i] is TcxCheckBox then
      begin
        TcxCheckBox(Components[i]).Enabled:=False;
      end;
    if Components[i] is TDBGridEh then
      begin
        TDBGridEh(Components[i]).ReadOnly:=true;
      end;
  end;
  //edtUSING_BARTER[���û���]
  RB_NotUSING_BARTER.Enabled:=False;
  RB_USING_BARTER.Enabled:=False;
  edtBARTER_INTEGRAL.Enabled:=False;
  RB_USING_BARTER2.Enabled:=False;
  edtBARTER_INTEGRAL2.Enabled:=False;
  //���ܵ����Ȩ���޸�:��׼�ۼۣ�
  //SetEditStyle(dsEdit,edtNEW_OUTPRICE.Style);
  //edtNEW_OUTPRICE.Properties.ReadOnly:=False;

  //��Ӧ����ҵͳһ�������˳�
  if NotChangPrice then Exit;

  SetEditStyle(dsEdit,edtMY_OUTPRICE.Style);
  edtMY_OUTPRICE.Properties.ReadOnly:=False;
  SetEditStyle(dsEdit,edtMY_OUTPRICE1.Style);
  edtMY_OUTPRICE1.Properties.ReadOnly:=False;
  SetEditStyle(dsEdit,edtMY_OUTPRICE2.Style);
  edtMY_OUTPRICE2.Properties.ReadOnly:=False;
  SetEditStyle(dsEdit,edtNEW_INPRICE.Style);
  edtNEW_INPRICE.Properties.ReadOnly:=False;
  SetEditStyle(dsEdit,edtPROFIT_RATE.Style);
  edtPROFIT_RATE.Properties.ReadOnly:=False;
  PriceGrid.ReadOnly:=false;
end;

procedure TfrmGoodsInfo.WriteBarCode;
begin
  //����������Ӫ���˳�
  if cdsGoods.FieldByName('RELATION_ID').AsString<>'0' then Exit;
  BarCode.First;
  while not BarCode.Eof do
  begin
    BarCode.Delete;
  end;

  //������λ����[��Ϊ�գ���û��λ��]
  if trim(edtBarCode1.Text)<>''  then //������λ
  begin
    BarCode.Append;
    BARCode.FieldByName('RELATION_FLAG').AsString:='2';
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //�к�[GUID���]
    BARCode.FieldByName('PROPERTY_01').AsString:='#';
    BARCode.FieldByName('PROPERTY_02').AsString:='#';
    BARCode.FieldByName('BARCODE_TYPE').AsString:='0';
    BARCode.FieldByName('UNIT_ID').AsString:=edtCALC_UNITS.AsString;
    BARCode.FieldByName('BATCH_NO').AsString:='#';
    BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode1.Text);
    BarCode.Post;
  end;

  //С��λ���� [��λ�����벻Ϊ�գ���û��λ��]
  if trim(edtBarCode2.Text)<>'' then
  begin
    BarCode.Append;
    BARCode.FieldByName('RELATION_FLAG').AsString:='2';
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //�к�[GUID���]
    BARCode.FieldByName('PROPERTY_01').AsString:='#';
    BARCode.FieldByName('PROPERTY_02').AsString:='#';
    BARCode.FieldByName('BARCODE_TYPE').AsString:='1';
    BARCode.FieldByName('UNIT_ID').AsString:=edtSMALL_UNITS.AsString;
    BARCode.FieldByName('BATCH_NO').AsString:='#';
    BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode2.Text);
    BarCode.Post;
  end;

  if trim(edtBarCode3.Text)<>'' then  //��λ����
  begin
    BarCode.Append;
    BARCode.FieldByName('RELATION_FLAG').AsString:='2';
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //�к�[GUID���]
    BARCode.FieldByName('PROPERTY_01').AsString:='#';
    BARCode.FieldByName('PROPERTY_02').AsString:='#';
    BARCode.FieldByName('BARCODE_TYPE').AsString:='2';
    BARCode.FieldByName('UNIT_ID').AsString:=edtBIG_UNITS.AsString;
    BARCode.FieldByName('BATCH_NO').AsString:='#';
    BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode3.Text);
    BarCode.Post;
  end;
end;

procedure TfrmGoodsInfo.WriteExtBarCode;
var
  Str,Unit_ID: string;
  EditQry,Rs: TZQuery;
begin
  //����������Ӫ���˳�
  if cdsGoods.FieldByName('RELATION_ID').AsString<>'0' then Exit;
  try
    //�жϵ�λ�Ƿ�����Ʒ�ĵ�λ
    Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
    ExtBarCode.First;
    while not ExtBarCode.Eof do
    begin
      Unit_ID:=trim(ExtBarCode.fieldbyName('UNIT_ID').AsString);
      if (Unit_ID<>'')and (Unit_ID<>trim(edtCALC_UNITS.AsString)) and (Unit_ID<>trim(edtSMALL_UNITS.AsString)) and (Unit_ID<>trim(edtBIG_UNITS.AsString)) then
      begin
        if Rs.Locate('UNIT_ID',Unit_ID,[]) then
          Raise Exception.Create('��λ��'+Rs.fieldbyName('UNIT_NAME').AsString+'��������Ʒ�ĵ�λ��������ѡ��')
        else
          Raise Exception.Create('��λID��'+Unit_ID+'��������Ʒ�ĵ�λ��������ѡ��');
      end;
      ExtBarCode.Next;
    end;

    EditQry:=TZQuery.Create(nil);
    EditQry.Data:=ExtBarCode.Data;
    ExtBarCode.First;
    while not ExtBarCode.Eof do
    begin
      ExtBarCode.Delete;
    end;

    //������λ����[��Ϊ�գ���û��λ��]
    EditQry.First;
    while not EditQry.Eof do
    begin
      if (trim(EditQry.FieldByName('UNIT_ID').AsString)<>'') and (trim(EditQry.FieldByName('BARCODE').AsString)<>'') then
      begin
        ExtBarCode.Append;
        ExtBarCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;   //�к�[GUID���]
        ExtBarCode.FieldByName('RELATION_FLAG').AsString:='2';
        ExtBarCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
        ExtBarCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
        ExtBarCode.FieldByName('UNIT_ID').AsString:=EditQry.FieldByName('UNIT_ID').AsString;
        ExtBarCode.FieldByName('BARCODE').AsString:=EditQry.FieldByName('BARCODE').AsString;
        ExtBarCode.FieldByName('PROPERTY_01').AsString:='#';
        ExtBarCode.FieldByName('PROPERTY_02').AsString:='#';
        ExtBarCode.FieldByName('BARCODE_TYPE').AsString:='3';
        ExtBarCode.FieldByName('BATCH_NO').AsString:='#';
        ExtBarCode.Post;
      end;
      EditQry.Next;
    end;
  finally
    EditQry.Free;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID1_AddClick(Sender: TObject);
var AObj:TRecord_;
begin
  AObj := TRecord_.Create;
  try
    if TfrmGoodsSortTree.AddDialog(self,AObj,1) then
    begin
      TzrComboBoxList(Sender).KeyValue := AObj.FieldbyName('SORT_ID').asString;
      TzrComboBoxList(Sender).Text := AObj.FieldbyName('SORT_NAME').asString;
    end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsInfo.edtCALC_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if (edtCALC_UNITS.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ�������λ�����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtCALC_UNITS.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if (edtSMALL_UNITS.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ���װ��λ�����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSMALL_UNITS.OnAddClick(nil);
    Exit;
  end;
  if locked then exit;
  locked := true;
  try
    if (Trim(edtMY_OUTPRICE.Text)<>'') and (Trim(edtSMALLTO_CALC.Text)<>'') then
       edtMY_OUTPRICE1.Text:=FloatToStr(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtSMALLTO_CALC.Text,0));
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.edtBIG_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if (edtBIG_UNITS.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ���װ��λ�����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtBIG_UNITS.OnAddClick(nil);
    Exit;
  end;
  if locked then exit;
  locked := true;
  try
    if (Trim(edtMY_OUTPRICE.Text)<>'') and (Trim(edtBIGTO_CALC.Text)<>'') then
       edtMY_OUTPRICE2.Text:=FloatToStr(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtBIGTO_CALC.Text,0));
  finally
    locked:=False;
  end;
end;

function TfrmGoodsInfo.ConvertToFight(value: Currency;
  deci: Integer): real;
begin
  result := FnNumber.ConvertToFight(value,CarryRule,deci);
end;

procedure TfrmGoodsInfo.edtNEW_INPRICEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
  if StrToFloatDef(edtNEW_OUTPRICE.Text,0)<>0 then
     edtPROFIT_RATE.Text := formatFloat('#0',StrToFloatDef(edtNEW_INPRICE.Text,0)*100/StrToFloatDef(edtNEW_OUTPRICE.Text,0));
  finally
     locked := false;
  end;

end;

procedure TfrmGoodsInfo.edtPROFIT_RATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
     edtNEW_INPRICE.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtNEW_OUTPRICE.Text,0)*StrToFloatDef(edtPROFIT_RATE.Text,0)/100,Deci));
  finally
     locked := false;
  end;
end;

procedure TfrmGoodsInfo.RzBitBtn4Click(Sender: TObject);
begin
  inherited;
  edtBARCODE1.Text := '�Ա�����';
end;

procedure TfrmGoodsInfo.edtBARCODE1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if dbState=dsBrowse then Exit;
  if dbState<>dsInsert then exit;
  if Key=#13  then
  begin
    if trim(edtBARCODE1.Text)='' then exit;
    if ReadBarCode_INFO(trim(edtBARCODE1.Text)) then
    begin
      if (self.SORT_ID1_KeyValue<>'') and (trim(edtSORT_ID1.Text)<>'') then edtNEW_OUTPRICE.SetFocus else edtSORT_ID1.SetFocus;
    end;
  end;
  //  if not(Key in ['0'..'9']) then Key := #0;
end;

procedure TfrmGoodsInfo.edtBIGTO_CALCPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
    if Trim(edtBIGTO_CALC.Text)='' then edtBIGTO_CALC.Text:='0';
    if (Trim(edtMY_OUTPRICE.Text)<>'') and (Trim(edtBIG_UNITS.AsString)<>'') then
       edtMY_OUTPRICE2.Text:=FloatToStr(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtBIGTO_CALC.Text,0));

    //�����Ա��:
    CALC_MenberProfitPrice(CdsMemberPrice,0);
  finally
    locked:=False;
  end;
end;

function TfrmGoodsInfo.ReadBarCode_INFO(BarCode: string):boolean;
var
  GObj:TRecord_;
begin
  result := false;
  GObj := GodsFactory.Check(BarCode);
  if GObj<>nil then
     begin
      ReadFromObject(GObj);
      result := true;
     end;
end;

procedure TfrmGoodsInfo.OpenCopyNew(code: string);
var
  CurObj:TRecord_;
  Params: TftParamList;
  GoodInfo,GoodBarCode: TZQuery;
begin
  locked:=True;
  try
    GoodInfo:=TZQuery.Create(nil);            
    GoodBarCode:=TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    CurObj:=TRecord_.Create;
    Factor.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Params.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(ShopGlobal.TENANT_ID)+'0001';
      Params.ParamByName('SHOP_ID').AsString:=ShopGlobal.SHOP_ID;
      Params.ParamByName('PRICE_ID').AsString:='';
      Params.ParamByName('GODS_ID').asString:=code;
      Factor.AddBatch(GoodInfo,'TGoodsInfo',Params);
      Factor.AddBatch(GoodBarCode,'TPUB_BARCODE',Params);
      Factor.OpenBatch;
      CurObj.ReadFromDataSet(GoodInfo);
      ReadFromObject(CurObj);
      edtGODS_SPELL.Text:=CurObj.FieldByName('GODS_SPELL').AsString;
      if not ShopGlobal.GetChkRight('14500001',2)  then
      begin
        Label23.Visible:=False;
        edtNEW_INPRICE.Visible:=False;
        edtPROFIT_RATE.visible:=False;
        lblPROFIT_RATE.Visible:=False;
        Label43.Visible:=False;
      end;
      dbState := dsBrowse;
    except
    end;

    //��ȡ������Ϣ:
    ReadGoodsBarCode(GoodBarCode);   //��ȡ����   
  finally
    locked:=False;
    GoodInfo.Free;
    GoodBarCode.Free;
    Params.Free;
    CurObj.Free;
  end;
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
    if (Trim(edtSMALLTO_CALC.Text)<>'') and (Trim(edtSMALL_UNITS.AsString)<>'') then
       edtMY_OUTPRICE1.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtSMALLTO_CALC.Text,0),Deci));
    if (Trim(edtBIGTO_CALC.Text)<>'') and (Trim(edtBIG_UNITS.AsString)<>'') then
       edtMY_OUTPRICE2.Text:=FloatToStr(ConvertToFight(StrToFloatDef(edtMY_OUTPRICE.Text,0)*StrToFloatDef(edtBIGTO_CALC.Text,0),Deci));
  finally
     locked := false;
  end; 
end;

procedure TfrmGoodsInfo.CheckGOODSNameIsExist;
var
  IsExists: Boolean; tmp: TZQuery;
  CurValue,GoodValue: string;
begin
  tmp:=Global.GetZQueryFromName('PUB_GOODSINFO');
  tmp.Filtered:=False;
  IsExists:=False;
  if (not edtGODS_CODE.Properties.ReadOnly) then  //���޸���Ʒ����
  begin
    GoodValue:=trim(edtGODS_CODE.Text);
    tmp.First;
    while not tmp.Eof do
    begin
      if trim(tmp.FieldByName('RELATION_ID').AsString)='0' then
      begin
        CurValue:=trim(tmp.FieldByName('GODS_CODE').AsString);
        if dbState=dsInsert then
          IsExists:=(CurValue=GoodValue)
        else if (dbState=dsEdit)and(CurValue=GoodValue) then
          IsExists:=(trim(cdsGoods.FieldbyName('GODS_ID').AsString)<>trim(tmp.FieldByname('GODS_ID').AsString));
        if IsExists then
        begin
          if edtGODS_CODE.CanFocus then edtGODS_CODE.SetFocus;
          raise Exception.Create('�����Ѿ����ڣ������ظ���');
        end;
      end;
      tmp.Next;
    end;
  end;
  
  if (not edtGODS_NAME.Properties.ReadOnly) then //���޸���Ʒ����
  begin
    IsExists:=False;
    GoodValue:=trim(edtGODS_NAME.Text);
    tmp.First;
    while not tmp.Eof do
    begin
      if trim(tmp.FieldByName('RELATION_ID').AsString)='0' then
      begin
        CurValue:=trim(tmp.FieldByName('GODS_NAME').AsString);
        if dbState=dsInsert then
          IsExists:=(CurValue=GoodValue)
        else if (dbState=dsEdit) and (CurValue=GoodValue) then
          IsExists:=(trim(tmp.FieldByName('GODS_ID').AsString)<>trim(cdsGoods.FieldByName('GODS_ID').AsString));
        if IsExists then
        begin
          if edtGODS_NAME.CanFocus then edtGODS_NAME.SetFocus;
          raise Exception.Create('  ��ʾ:��Ʒ�����Ѿ����ڣ� ');
        end;
      end;
      tmp.Next;
    end;
  end;
end;

//����: Kind��1�жϱ�׼�ۼ�; 2�ж��ŵ��ۼ�; 3�ж�����ۼ�;
procedure TfrmGoodsInfo.CheckGoodLowPrice(Kind: integer);
begin
  case Kind of
   1:  //�ж������׼�ۼ����ж��Ƿ� С�� ����ۼ�;
    begin
      if (StrToFloatDef(edtNEW_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' ����ǰ���롼��׼�ۼۡ�С�ڡ�����ۼۡ����Ƿ��������룿','��ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtNEW_OUTPRICE.Text:='';
          if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
        end else
        begin
          if (not edtNEW_LOWPRICE.Properties.ReadOnly) and (edtNEW_LOWPRICE.CanFocus) then
             edtNEW_LOWPRICE.SetFocus;
        end;
      end;
    end;
   2:  //�ж��ŵ��ۼ�;
    begin
      if (StrToFloatDef(edtMY_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' ����ǰ���롼�����ۼۡ�С�ڡ�����ۼۡ����Ƿ��������룿','��ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtMY_OUTPRICE.Text:='';
          if edtMY_OUTPRICE.CanFocus then edtMY_OUTPRICE.SetFocus;
        end else
        begin
          if (not edtNEW_LOWPRICE.Properties.ReadOnly) and (edtNEW_LOWPRICE.CanFocus) then
            edtNEW_LOWPRICE.SetFocus;
        end;
      end;
    end;
   3:  //�ж�����ۼ�;
    begin
      // [����ۼ�] �� [��׼�ۼ�]
      if (StrToFloatDef(edtNEW_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' ����ǰ���롼����ۼۡ����ڡ���׼�ۼۡ����Ƿ��������룿','��ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtNEW_OUTPRICE.Text:='';
          if edtNEW_LOWPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
        end else
        begin
          if edtNEW_OUTPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end;
      end;
      
      // [����ۼ�] �� [�����ۼ�]
      if (StrToFloatDef(edtMY_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' ����ǰ���롼����ۼۡ����� �������ۼۡ����Ƿ��������룿','��ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtNEW_LOWPRICE.Text:='';
          if edtNEW_LOWPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end else
        begin
          if edtMY_OUTPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end;
      end;    
    end;
  end;
end;

procedure TfrmGoodsInfo.CheckGoodsFieldIsEmpty;
begin
  if (dbState = dsEdit) and (trim(edtGODS_CODE.Text)='') then
  begin
    if edtGODS_CODE.CanFocus then edtGODS_CODE.SetFocus;
    Raise Exception.Create('���Ų���Ϊ�գ������룡');
  end;

  if Trim(edtGODS_NAME.Text)='' then
  begin
    if edtGODS_NAME.CanFocus then edtGODS_NAME.SetFocus;
    raise Exception.Create('��Ʒ���Ʋ���Ϊ�գ�');
  end;
  if Trim(edtGODS_SPELL.Text)='' then
  begin
    if edtGODS_SPELL.CanFocus then edtGODS_SPELL.SetFocus;
    raise Exception.Create('ƴ���벻��Ϊ�գ�');
  end;
  if Trim(edtNEW_OUTPRICE.Text)='' then
  begin
    if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
    raise Exception.Create('��׼�ۼ۲���Ϊ�գ�');
  end;
  //�ж�: ��׼�ۼ�  ��  ���ۼ�
  if StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0) then
  begin
    if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
    raise Exception.Create(' ��׼�ۼ۲��ܵ��ڱ��������ۼۣ� ');
  end;
  //�ж�: �ŵ��ۼ�  ��  ���ۼ�
  if StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0) then
  begin
    if edtMY_OUTPRICE.CanFocus then edtMY_OUTPRICE.SetFocus;
    raise Exception.Create(' �ŵ��ۼ۲��ܵ��ڱ��������ۼۣ� ');
  end;
  {==  ��ƷSORT_ID1..8  ==}
  if (SORT_ID1_KeyValue='') or (Trim(edtSORT_ID1.Text)='') then
  begin
    if edtSORT_ID1.CanFocus then edtSORT_ID1.SetFocus;
    raise Exception.Create('��Ʒ���಻��Ϊ�գ�');
  end;

  { 2011.03.31  �رյ�ָ������Ϊ��
   if Trim(edtSORT_ID2.KeyValue)='' then
   begin
    if edtSORT_ID2.CanFocus then edtSORT_ID2.SetFocus;
    raise Exception.Create('��Ʒ�����Ϊ�գ�');
  end;

  if Trim(edtSORT_ID3.KeyValue)='' then
  begin
    if edtSORT_ID3.CanFocus then edtSORT_ID3.SetFocus;
    raise Exception.Create('��Ʒ����Ӧ�̲���Ϊ�գ�');
  end;
  if Trim(edtSORT_ID4.KeyValue)='' then
  begin
    if edtSORT_ID4.CanFocus then edtSORT_ID4.SetFocus;
    raise Exception.Create('��ƷƷ�Ʋ���Ϊ�գ�');
  end;
  if Trim(edtSORT_ID5.KeyValue)='' then
  begin
    if edtSORT_ID5.CanFocus then edtSORT_ID5.SetFocus;
    raise Exception.Create('��Ʒ�Ƿ��ص�Ʒ�Ʋ���Ϊ�գ�');
  end;
  if Trim(edtSORT_ID6.KeyValue)='' then
  begin
    if edtSORT_ID6.CanFocus then edtSORT_ID6.SetFocus;
    raise Exception.Create('��Ʒ�Ƿ���ʡ���ⲻ��Ϊ�գ�');
  end;
  if Trim(edtSORT_ID7.KeyValue)='' then
  begin
    if edtSORT_ID7.CanFocus then edtSORT_ID7.SetFocus;
    raise Exception.Create('��Ʒ��ɫ�鲻��Ϊ�գ�');
  end;
  if Trim(edtSORT_ID8.KeyValue)='' then
  begin
    if edtSORT_ID8.CanFocus then edtSORT_ID8.SetFocus;
    raise Exception.Create('��Ʒ�����鲻��Ϊ�գ�');
  end;
  }

  //���ֶһ���ϵ
  if (RB_USING_BARTER.Checked) and (edtBARTER_INTEGRAL.Enabled) and (edtBARTER_INTEGRAL.Value=0)  then
  begin
    if edtBARTER_INTEGRAL.CanFocus then edtBARTER_INTEGRAL.SetFocus;
    raise Exception.Create('���ֶһ���ϵ�Ĳ���Ϊ0��');
  end;

  //2011.08.20 Add ���ֻ��������ϵ
  if (RB_USING_BARTER2.Checked) and (edtBARTER_INTEGRAL2.Enabled) and (edtBARTER_INTEGRAL2.Value=0)  then
  begin
    if edtBARTER_INTEGRAL2.CanFocus then edtBARTER_INTEGRAL2.SetFocus;
    raise Exception.Create('���ֻ�����ϵ�Ĳ���Ϊ0��');
  end;


  if (Trim(edtCALC_UNITS.Text)='') then edtCALC_UNITS.KeyValue := null;
  if (Trim(edtSMALL_UNITS.Text)='') then edtSMALL_UNITS.KeyValue := null;
  if (Trim(edtBIG_UNITS.Text)='') then edtBIG_UNITS.KeyValue := null;

  if (Trim(edtCALC_UNITS.AsString)='') or (Trim(edtCALC_UNITS.Text)='') then
  begin
    if edtCALC_UNITS.CanFocus then edtCALC_UNITS.SetFocus;
    raise Exception.Create('������λ����Ϊ�գ�');
  end;
  if (Trim(edtSMALL_UNITS.AsString)='') AND (Trim(edtBARCODE2.Text)<>'') then
  begin
     if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
     raise Exception.Create('С��װ��λ����Ϊ�գ�');
  end;
  if (Trim(edtBIG_UNITS.AsString)='') AND (Trim(edtBARCODE3.Text)<>'') then
  begin
     if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
     raise Exception.Create('���װ��λ����Ϊ�գ�');
  end;
  if Trim(edtCALC_UNITS.AsString)=Trim(edtSMALL_UNITS.AsString) then
  begin
    if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
    raise Exception.Create('С��װ��λ���ܺͼ�����λ��ͬ��');
  end;
  if Trim(edtCALC_UNITS.AsString)=Trim(edtBIG_UNITS.AsString) then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    raise Exception.Create('���װ��λ���ܺͼ�����λ��ͬ��');
  end;
  if (Trim(edtSMALL_UNITS.AsString)=Trim(edtBIG_UNITS.AsString)) and (Trim(edtSMALL_UNITS.AsString)<>'') then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    raise Exception.Create('���װ��λ���ܺ�С��װ��λ��ͬ��');
  end;
  //С��װ/���װ��λ����:
  if (Trim(edtSMALL_UNITS.AsString)<>'') and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
  begin
    if edtSMALLTO_CALC.CanFocus then   edtSMALLTO_CALC.SetFocus;
    raise Exception.Create('С��װ��λ�Ļ���ϵ������С�ڵ���0!');
  end;
  if (Trim(edtBIG_UNITS.AsString)<>'') and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
  begin
    if edtBIGTO_CALC.CanFocus then   edtBIGTO_CALC.SetFocus;
    raise Exception.Create('���װ��λ�Ļ���ϵ������С�ڵ���0!');
  end;

  //2011.03.03 Add ����趨Ϊ����λ����λID�ͻ����ϵ����Ϊ��
  if (edtDefault1.Checked) and (trim(edtSMALL_UNITS.AsString)='') then
  begin
    if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
    Raise Exception.Create(' С��װ��λ��ΪĬ�ϵ�λ����Ϊ��  '); 
  end;
  if (edtDefault1.Checked) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
  begin
    if edtSMALLTO_CALC.CanFocus then edtSMALLTO_CALC.SetFocus;
    raise Exception.Create('С��װ��λ�Ļ���ϵ������С�ڵ���0!');
  end;
  //2011.03.03 Add ����趨Ϊ����λ����λID�ͻ����ϵ����Ϊ��
  if (edtDefault2.Checked) and (trim(edtBIG_UNITS.AsString)='') then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    Raise Exception.Create(' ���װ��λ��ΪĬ�ϵ�λ����Ϊ��  '); 
  end;
  if (edtDefault2.Checked) and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
  begin
    if edtBIGTO_CALC.CanFocus then edtBIGTO_CALC.SetFocus;
    raise Exception.Create('���װ��λ�Ļ���ϵ������С�ڵ���0!');
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID2AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 2);
end;

procedure TfrmGoodsInfo.AddSORT_IDClick(Sender: TObject; SortType: integer);
var AObj:TRecord_;
begin
  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.AddDialog(self,AObj,SortType) then
    begin
      TzrComboBoxList(Sender).KeyValue := AObj.FieldbyName('SORT_ID').asString;
      TzrComboBoxList(Sender).Text := AObj.FieldbyName('SORT_NAME').asString;
    end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID6AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 6);
end;

procedure TfrmGoodsInfo.edtSORT_ID5AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 5);
end;


procedure TfrmGoodsInfo.SetZrCbxDefaultValue(SetCbx: TzrComboBoxList);
begin
  if (SetCbx.DataSet<>nil) and (SetCbx.DataSet.Active) then
  begin
    SetCbx.DataSet.First;
    SetCbx.KeyValue:=SetCbx.DataSet.fieldbyName(SetCbx.KeyField).AsString;
    SetCbx.Text:=SetCbx.DataSet.fieldbyName(SetCbx.ListField).AsString;
  end;
end;

procedure TfrmGoodsInfo.ReadGoodsBarCode(CdsBarCode: TZQuery);
begin
  if not CdsBarCode.Active then Exit;

  CdsBarCode.First;
  while not CdsBarCode.Eof do
  begin
    if (trim(CdsBarCode.FieldByName('BATCH_NO').AsString)='#') and (trim(CdsBarCode.FieldByName('PROPERTY_01').AsString)='#') and
       (trim(CdsBarCode.FieldByName('PROPERTY_02').AsString)='#') then
    begin
      if trim(CdsBarCode.fieldbyName('BARCODE_TYPE').AsString)='0' then
      begin
        UnitBarCode:=CdsBarCode.fieldbyName('BARCODE').AsString;
        edtBARCODE1.Text:=CdsBarCode.fieldbyName('BARCODE').AsString;
      end else
      if trim(CdsBarCode.fieldbyName('BARCODE_TYPE').AsString)='1' then
      begin
        SmallBarCode:=CdsBarCode.fieldbyName('BARCODE').AsString;
        edtBARCODE2.Text:=CdsBarCode.fieldbyName('BARCODE').AsString;
      end else
      if trim(CdsBarCode.fieldbyName('BARCODE_TYPE').AsString)='2' then
      begin
        BigBarCode:=CdsBarCode.fieldbyName('BARCODE').AsString;
        edtBARCODE3.Text:=CdsBarCode.fieldbyName('BARCODE').AsString;
      end;
    end;
    CdsBarCode.Next;
  end;
end;

procedure TfrmGoodsInfo.EditKeyPress(Sender: TObject; var Key: Char);
var CurText: string;
begin
  if (Key=#161) or (Key='��') then Key:='.';
  if Sender is TcxTextEdit then
  begin
    CurText:=trim(TcxTextEdit(Sender).Text);
    if Pos('.',CurText)>0 then
    begin
      if Key in ['0'..'9',#8] then
      else Key:=#0;
    end else
    begin
      if Key in ['0'..'9','.',#8] then
      else Key:=#0;
    end;
  end;
end;

procedure TfrmGoodsInfo.edtNEW_OUTPRICEKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.edtPROFIT_RATEKeyPress(Sender: TObject; var Key: Char);
var
  CurText: string;
begin
  if (Key=#161) or (Key='��') then Key:='.';
  CurText:=trim(edtPROFIT_RATE.Text);
  if Pos('.',CurText)>0 then
  begin
    if Key in ['0'..'9',#8] then
    else Key:=#0;
  end else
  begin
    if Key in ['0'..'9','.',#8] then
    else Key:=#0;
  end;
end;

procedure TfrmGoodsInfo.edtNEW_OUTPRICE1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.edtUSING_PRICEClick(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible;
end;

procedure TfrmGoodsInfo.CheckCLVersionSetParams;
begin
  lblSORT_ID7.Visible:=(trim(CLVersion)='FIG');
  edtSORT_ID7.Visible:=lblSORT_ID7.Visible;
  lblSORT_ID7.Visible:=lblSORT_ID7.Visible;
  edtSORT_ID8.Visible:=lblSORT_ID7.Visible;

  if not lblSORT_ID7.Visible then
  begin
    GB_Small.Top:=22;
    GB_Big.Top:=103;
  end else
  begin
    GB_Small.Top:=35;
    GB_Big.Top:=116;
  end;
end;
                      
procedure TfrmGoodsInfo.edtSORT_ID1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  rs:TRecord_;
  Qry: TZQuery;
begin
  inherited;
  rs := TRecord_.Create;
  try
    Qry:=Global.GetZQueryFromName('PUB_GOODSSORT');
    if Qry.Active then
    begin
      Qry.Filtered:=False;
      Qry.Filter:='RELATION_ID=''0'' ';
      Qry.Filtered:=true;
    end;
    if TframeTreeFindDialog.FindDialog1(self,Qry,'SORT_ID','LEVEL_ID','SORT_NAME','444444',rs) then
    begin
      SORT_ID1_KeyValue := rs.FieldbyName('SORT_ID').AsString;
      edtSORT_ID1.Text := rs.FieldbyName('SORT_NAME').AsString;
    end;
  finally
    Qry.Filtered:=False;
    Qry.Filter:='';
    rs.Free;
  end;
end;

procedure TfrmGoodsInfo.PriceGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var RecNo: string; ARect:TRect; 
begin
  inherited;
  if (Column.FieldName = 'SEQNO') and (PriceGrid.DataSource.DataSet.Active)then
  begin
    ARect := Rect;
    PriceGrid.canvas.FillRect(ARect);
    RecNo:=Inttostr(PriceGrid.DataSource.DataSet.RecNo);
    DrawText(PriceGrid.Canvas.Handle,pchar(RecNo),length(RecNo),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmGoodsInfo.PriceGridExit(Sender: TObject);
begin
  inherited;
  if not (CdsMemberPrice.State in [dsEdit, dsInsert]) then
    CdsMemberPrice.Edit;
  CdsMemberPrice.Post;
end;

procedure TfrmGoodsInfo.RB_NotUSING_BARTERClick(Sender: TObject);
begin
  inherited;
  if not RB_USING_BARTER.Checked then edtBARTER_INTEGRAL.Value:=0;
  if not RB_USING_BARTER2.Checked then edtBARTER_INTEGRAL2.Value:=0;
  edtBARTER_INTEGRAL.Enabled:=RB_USING_BARTER.Checked;
  edtBARTER_INTEGRAL2.Enabled:=RB_USING_BARTER2.Checked;
end;

procedure TfrmGoodsInfo.edtSORT_ID1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key:=#0;
  self.edtSORT_ID1.Properties.OnButtonClick(Sender,1);
end;

procedure TfrmGoodsInfo.PriceGridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then  //�ᳵ���м���
    if PriceGrid.Col<PriceGrid.Columns.Count-1 then PriceGrid.Col:= PriceGrid.Col + 1 //����һ��
  else
    OnGridKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.edtCALC_UNITSPropertiesChange(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  SetCol:=FindColumn(PriceGrid,'NEW_OUTPRICE');
  if SetCol<>nil then
  begin
    SetCol.Visible:=(edtCALC_UNITS.KeyValue<>'');
    if edtCALC_UNITS.KeyValue<>'' then
      SetCol.Title.Caption:='�ۼ�(Ԫ/'+edtCALC_UNITS.Text+')';
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSPropertiesChange(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  SetCol:=FindColumn(PriceGrid,'NEW_OUTPRICE1');
  if SetCol<>nil then
  begin
    SetCol.Visible:=(edtSMALL_UNITS.KeyValue<>'');
    if edtSMALL_UNITS.Text<>'' then
      SetCol.Title.Caption:='�ۼ�(Ԫ/'+edtSMALL_UNITS.Text+')';
  end;
end;

procedure TfrmGoodsInfo.edtBIG_UNITSPropertiesChange(Sender: TObject);
var
  SetCol: TColumnEh;
begin
  inherited;
  SetCol:=FindColumn(PriceGrid,'NEW_OUTPRICE2');
  if SetCol<>nil then
  begin
    SetCol.Visible:=(edtBIG_UNITS.KeyValue<>'');
    if edtBIG_UNITS.Text<>'' then
      SetCol.Title.Caption:='�ۼ�(Ԫ/'+edtBIG_UNITS.Text+')';
  end;
end;

// �����������ٺŹ���   
procedure TfrmGoodsInfo.CheckTabGoodPriceVisible;
var
  Cal_UNit,Cal_UNi: Boolean;
  i: integer;
begin
  TabGoodPrice.TabVisible:=False;
  if edtUSING_PRICE.ItemIndex=1 then Exit; {==�Ƿ����û�Ա��==}
  if (trim(edtCALC_UNITS.Text)='') and (trim(edtSMALL_UNITS.Text)='') and (trim(edtBIG_UNITS.Text)='') then Exit;  //������λ��ͬʱΪ�����;
  // if StrtoFloatDef(edtNEW_OUTPRICE.Text,0)<=0 then Exit;
  TabGoodPrice.TabVisible:=true;
  //�ж�Columns����ʾ:
  for i:=0 to PriceGrid.Columns.Count-1 do
  begin
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE' then
    begin
      if (edtCALC_UNITS.KeyValue=null) or (trim(edtCALC_UNITS.Text)='') then
        PriceGrid.Columns[i].Visible:=False
      else
        PriceGrid.Columns[i].Visible:=true;
    end;
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE1' then
    begin
      if (edtSMALL_UNITS.KeyValue=null) or (trim(edtSMALL_UNITS.Text)='') then
        PriceGrid.Columns[i].Visible:=False
      else
        PriceGrid.Columns[i].Visible:=true;
    end;
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE2' then
    begin
      if (edtBIG_UNITS.KeyValue=null) or (trim(edtBIG_UNITS.Text)='') then
        PriceGrid.Columns[i].Visible:=False
      else
        PriceGrid.Columns[i].Visible:=true;
    end;
  end;
end;

function TfrmGoodsInfo.GetColumnIdx(Gird:TDBGridEh; ColName: string): integer;
var i: integer;
begin
  result:=0;
  for i:=0 to Gird.Columns.Count-1 do
  begin
    if trim(Gird.Columns[i].FieldName)=trim(ColName) then
      result:=i;
  end;
end;

procedure TfrmGoodsInfo.CALC_MenberProfitPrice(CdsMemberPrice: TZQuery; CALCType: integer; IsAll: Boolean);
var
  CurObj: TRecord_;
  ColIdx: integer;
  NewOutPrice,PROFIT_RATE: Real;
begin
  if not (dbState in [dsInsert, dsEdit]) then Exit;
  if CdsMemberPrice.State=dsEdit then CdsMemberPrice.Post;
  NewOutPrice:=StrToFloatDef(edtNEW_OUTPRICE.Text,0); 
  if NewOutPrice<=0 then exit;
  if not CdsMemberPrice.Active then exit;
  try
    CurObj:=TRecord_.Create;
    CurObj.ReadFromDataSet(CdsMemberPrice);
    case CALCType of  // 0:�����ۿ��ʼ����ۿۼ�  1: �����ۿۼۼ����ۿ���
     0:
      begin
        PROFIT_RATE:=StrtoFloatDef(CurObj.FieldByName('PROFIT_RATE').asstring,0);
        PROFIT_RATE:=PROFIT_RATE*0.01;
        if PROFIT_RATE>1 then PROFIT_RATE:=1;
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) then
          CurObj.FieldByName('NEW_OUTPRICE').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE,Deci);
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE1');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)>0) then
          CurObj.FieldByName('NEW_OUTPRICE1').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE*StrToFloatDef(edtSMALLTO_CALC.Text,0),Deci);
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE2');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) and (StrToFloatDef(edtBIGTO_CALC.Text,0)>0) then
          CurObj.FieldByName('NEW_OUTPRICE2').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE*StrToFloatDef(edtBIGTO_CALC.Text,0),Deci);
      end;
     1:
      begin
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) then
          CurObj.FieldByName('PROFIT_RATE').AsFloat:=StrtoFloat(FormatFloat('#0',(100*CurObj.FieldByName('NEW_OUTPRICE').AsFloat)/NewOutPrice));
        if (CurObj.FieldByName('PROFIT_RATE').AsFloat>100) or (CurObj.FieldByName('PROFIT_RATE').AsFloat<0) then
          CurObj.FieldByName('PROFIT_RATE').AsFloat:=100;
      end;
    end;
    if CdsMemberPrice.State=dsEdit then CdsMemberPrice.Edit;
    CurOBj.WriteToDataSet(CdsMemberPrice);
    if CdsMemberPrice.State=dsEdit then CdsMemberPrice.Edit;
      CdsMemberPrice.Post;
    FPriceChange:=true;
  finally
    CurOBj.Free;
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSExit(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
end;

procedure TfrmGoodsInfo.edtCALC_UNITSExit(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
end;

procedure TfrmGoodsInfo.edtBIG_UNITSExit(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible; //�жϻ�Ա�۸��Ƿ���ʾ
end;

procedure TfrmGoodsInfo.WriteMemberPrice(GODS_ID: String); //д���Ա��
var
  tmp: TZQuery;
  CurObj: TRecord_;
  NewOutPrice, PROFIT_RATE: Real;
begin
  if not CdsMemberPrice.Active then Exit;
  try
    tmp:=TZQuery.Create(nil);
    tmp.Data:=CdsMemberPrice.Data;  //ֱ�Ӵ�Data��
    CurObj:=TRecord_.Create;
    if tmp.Active then
    begin
      //��һ��: ��ɾ����¼
      CdsMemberPrice.First;
      while not CdsMemberPrice.Eof do
      begin
        CdsMemberPrice.Delete;
      end;
      //�ڶ���: ѭ����ʱ���ݼ�[���²���]
      tmp.First;
      while not tmp.Eof do
      begin
        CurObj.ReadFromDataSet(tmp);
        NewOutPrice:=StrToFloatDef(edtNEW_OUTPRICE.Text,0);
        PROFIT_RATE:=CurObj.fieldbyName('PROFIT_RATE').AsFloat*0.01;
        //ѭ����ʱ���ݼ��ж�����[��������0�Ų���]
        if (NewOutPrice>0) and (PROFIT_RATE>0) then
        begin
          CurObj.FieldByName('TENANT_ID').AsInteger:=shopGlobal.TENANT_ID;  //��ҵID
          CurObj.FieldByName('SHOP_ID').AsString:=shopGlobal.SHOP_ID;       //�ŵ�ID
          CurObj.FieldByName('GODS_ID').AsString:=GODS_ID;                  //����ID
          CurObj.FieldByName('PRICE_METHOD').AsString:='1';                 //���۷�ʽ
          if (CurObj.fieldbyName('NEW_OUTPRICE').AsFloat=0) and (PROFIT_RATE>0) and (NewOutPrice>0)  then
            CurObj.FieldByName('NEW_OUTPRICE').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE,Deci);
          if (StrToFloatDef(edtSMALLTO_CALC.Text,0)>0) and (CurObj.FieldByName('NEW_OUTPRICE').AsFloat>0) then
            CurObj.FieldByName('NEW_OUTPRICE1').AsFloat:=ConvertToFight(CurObj.fieldbyName('NEW_OUTPRICE').AsFloat*(StrToFloatDef(edtSMALLTO_CALC.Text,0)),Deci);
          if (StrToFloatDef(edtBIGTO_CALC.Text,0)>0) and (CurObj.FieldByName('NEW_OUTPRICE').AsFloat>0) then
            CurObj.FieldByName('NEW_OUTPRICE2').AsFloat:=ConvertToFight(CurObj.fieldbyName('NEW_OUTPRICE').AsFloat*(StrToFloatDef(edtBIGTO_CALC.Text,0)),Deci);
          //����д�����ݼ�
          if CdsMemberPrice.IsEmpty then CdsMemberPrice.Edit
          else CdsMemberPrice.Append;
          CurObj.WriteToDataSet(CdsMemberPrice);
          CdsMemberPrice.Post;
        end;
        tmp.Next;
      end;
    end;
  finally
    CurObj.Free;
    tmp.Free;   
  end;
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICE1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;  
  EditKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.edtNEW_LOWPRICEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICE2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender,Key);
end;

procedure TfrmGoodsInfo.PriceGridColumns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r: Real; MsgStr: string;
begin
  inherited;
  MsgStr:='';
  try
    if Text='' then
      r := 0
    else
       r := StrtoFloat(Text);
    if r>100 then MsgStr:='������ۿ��ʲ��ܴ���100����Ч';

    if (VarIsNull(Value)) then
    begin
      r:=0;
      Text:='0';
    end else
      r:=Value;
    if r>100 then
    begin
      r:=100;
      Text:='100';
    end;

    if (PriceGrid.DataSource.DataSet.Active) and (Value<>CdsMemberPrice.FieldByName('PROFIT_RATE').AsVariant) then
    begin
      if not (CdsMemberPrice.State in [dsEdit,dsInsert]) then CdsMemberPrice.Edit;
      CdsMemberPrice.FieldByName('PROFIT_RATE').AsString:=FloattoStr(r);
      CdsMemberPrice.Post;
      CALC_MenberProfitPrice(CdsMemberPrice,0);
      if not (CdsMemberPrice.State in [dsEdit,dsInsert]) then CdsMemberPrice.Edit;
    end;
    if MsgStr<>'' then  Raise Exception.Create(MsgStr);
  except
  end;   
end;

procedure TfrmGoodsInfo.PriceGridColumns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r: Real;
begin
  inherited;
  try
    if Text='' then
      r := 0
    else
       r := StrtoFloatDef(Text,0);
  except
    on E:Exception do
      begin
        Text :='0';
        Value :='0';
        MessageBox(Handle,pchar('������Ч��ֵ��,����'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
        Exit;
      end;
  end;
  if r>999999999 then Raise Exception.Create('�������ֵ����100����Ч');

  if (VarIsNull(Value)) then r:=0 else r:=Value;

  if (PriceGrid.DataSource.DataSet.Active) and (Value<>CdsMemberPrice.FieldByName('NEW_OUTPRICE').AsVariant) then
  begin
    if not (CdsMemberPrice.State in [dsEdit,dsInsert]) then CdsMemberPrice.Edit;
    CdsMemberPrice.FieldByName('NEW_OUTPRICE').AsString:=FloattoStr(r);
    CdsMemberPrice.Post;
    CALC_MenberProfitPrice(CdsMemberPrice,1);
    if not (CdsMemberPrice.State in [dsEdit,dsInsert]) then CdsMemberPrice.Edit;
  end; 
end;

procedure TfrmGoodsInfo.edtDefault1Click(Sender: TObject);
begin
  inherited;
  if (edtDefault1.Checked) and (edtDefault2.Checked) then
    edtDefault2.Checked:=False;
end;

procedure TfrmGoodsInfo.edtDefault2Click(Sender: TObject);
begin
  inherited;
  if (edtDefault2.Checked) and (edtDefault1.Checked) then
    edtDefault1.Checked:=False;
end;

procedure TfrmGoodsInfo.OnGridKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#161) or (Key='��') then Key:='.';
  if ((Ord(key) < 48) or (Ord(key) > 57)) and
     (Ord(key) <> 8) and (Ord(key) <> 3) and (Ord(key) <> 24) and (Ord(key) <> 22) and (Key<>#8) then
    Key:=#0;
end;

procedure TfrmGoodsInfo.edtNEW_LOWPRICEExit(Sender: TObject);
begin
  inherited;
  CheckGoodLowPrice(3);
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICEExit(Sender: TObject);
begin
  inherited;
  CheckGoodLowPrice(2);
end;

procedure TfrmGoodsInfo.edtNEW_OUTPRICEExit(Sender: TObject);
begin
  inherited;
  CheckGoodLowPrice(1);
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICE2Exit(Sender: TObject);
begin
  inherited;
  if not ((edtBIG_UNITS.AsString<>'') and (StrtoFloatDef(edtBIGTO_CALC.Text,0)>0)) then //���������ʾ
  begin
    if StrtoFloatDef(edtMY_OUTPRICE2.Text,0)>0 then
    begin
      edtMY_OUTPRICE2.Text:='';
      if trim(edtBIG_UNITS.Text)='' then
      begin
        edtBIG_UNITS.SetFocus;
        Raise Exception.Create('  �������λ�� ');
      end else
      begin
        edtBIGTO_CALC.SetFocus;
        Raise Exception.Create('  �������λ�Ļ�������� ');
      end;
    end;
  end;
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICE1Exit(Sender: TObject);
begin
  inherited;
  if not ((edtSMALL_UNITS.AsString<>'') and (StrtoFloatDef(edtSMALLTO_CALC.Text,0)>0)) then //���������ʾ
  begin
    if StrtoFloatDef(edtMY_OUTPRICE1.Text,0)>0 then
    begin
      edtMY_OUTPRICE1.Text:='';
      if trim(edtSMALL_UNITS.AsString)='' then
      begin
        edtSMALL_UNITS.SetFocus;
        Raise Exception.Create('  ������С��λ�� ');
      end else
      begin
        edtSMALLTO_CALC.SetFocus;
        Raise Exception.Create('  ������С��λ�Ļ�������� ');
      end;
    end;
  end;   
end;

procedure tfrmGoodsInfo.UpdateUNITSData(IsEdit: Boolean=true);
var
  i: integer;
  Rs: TZQuery;
  SetCol: TColumnEh;  
begin
  if DropUNITS_Ds=nil then
  begin
    DropUNITS_Ds:=TZQuery.Create(self); //�ж��Ƿ���ڣ�������������
    edtCALC_UNITS.DataSet:=DropUNITS_Ds;
    edtSMALL_UNITS.DataSet:=DropUNITS_Ds;
    edtBIG_UNITS.DataSet:=DropUNITS_Ds;
    fndUNIT_ID.DataSet:=DropUNITS_Ds;
  end;
  
  Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
  if (Rs<>nil) and (Rs.Active) then
  begin
    DropUNITS_Ds.Close;
    DropUNITS_Ds.Data:=Rs.Data;
    //Add 2011.03.30 Add ������Ӫ����Ʒ��Ҫ��������
    if IsEdit then
    begin
      for i:=DropUNITS_Ds.RecordCount downto 1 do
      begin
        DropUNITS_Ds.RecNo:=i;
        if trim(DropUNITS_Ds.FieldByName('RELATION_FLAG').AsString)<>'2' then //�жϵ�������������
        begin

          DropUNITS_Ds.Delete;
        end;
      end;
    end;
  end;

  //���ø�������UINT_NAME
  SetCol:=FindColumn(ExtBarCodeGrid,'UNIT_ID');
  if (SetCol<>nil) and (DropUNITS_Ds.Active) and (DropUNITS_Ds.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    DropUNITS_Ds.First;
    while not DropUNITS_Ds.Eof do
    begin
      SetCol.KeyList.Add(DropUNITS_Ds.FieldbyName('UNIT_ID').AsString);
      SetCol.PickList.Add(DropUNITS_Ds.FieldbyName('UNIT_NAME').AsString);
      DropUNITS_Ds.Next;
    end;
  end;
end;
 

//����ͳ��ָ������:
procedure TfrmGoodsInfo.CreateGodsSTAT_INFO(IsExists: Boolean);
var
  StrValue: String;
  CurCmp: TComponent;
  vHint,LblCaption: string;  
  i,CodeID,vLeft,vRight,vTop,vCount: integer;
  Rs, CdsList, DropDs: TZQuery;
begin
  vLeft:=76;
  vRight:=304;
  vTop:=28;
  vCount:=1;
  //1..8:Ϊ�޸ı�ǩһ����ʾ
  Rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
  DropDs:=Global.GetZQueryFromName('PUB_GOODS_INDEXS');
  if (Rs=nil) or (not Rs.Active) or (Rs.IsEmpty) then Exit;

  try
    CdsList:=TZQuery.Create(nil);
    CdsList.Data:=Rs.Data;
    //����ؼ�����
    Rs.First;
    while not Rs.Eof do
    begin
      CodeID:=Rs.FieldByName('CODE_ID').AsInteger;
      LblCaption:=trim(Rs.fieldByName('CODE_NAME').AsString);
      if (CodeID=1) or (CodeID=3) or (CodeID=7) or (CodeID=8) then
      begin
        CurCmp:=FindComponent('lblSORT_ID'+InttoStr(CodeID));
        if (CurCmp<>nil) and (CurCmp is TLabel) then
          TLabel(CurCmp).Caption:=LblCaption;
      end else
      begin
        if vCount mod 2=1 then
          CreateComponent(LblCaption,CodeID,vLeft,vTop,DropDs)
        else
          CreateComponent(LblCaption,CodeID,vRight,vTop,DropDs);
        if vCount mod 2=0 then vTop:=vTop+22;
        inc(vCount);                         
      end;
      Rs.Next;
    end;

    //�ͷŵ�����ʾ�ؼ���
    if IsExists then
    begin
      for i:=1 to 20 do
      begin
        if (i=1) or (i=3) or (i=7) or (i=8) then Continue;
        if not Rs.Locate('CODE_ID',inttoStr(i),[]) then  
        begin
          CurCmp:=FindComponent('edtSORT_ID'+InttoStr(i));
          if (CurCmp<>nil) and (CurCmp is TzrComboBoxList) then
            TzrComboBoxList(CurCmp).Free;
          CurCmp:=FindComponent('lblSORT_ID'+InttoStr(i));
          if (CurCmp<>nil) and (CurCmp is TLabel) then
            TLabel(CurCmp).Free;
        end;
      end;
    end;
  finally
    CdsList.Free;
  end;
end;

procedure TfrmGoodsInfo.DoAddSORT_IDClick(Sender: TObject);
var
  CmpName: string;
begin
  if Sender is TzrComboBoxList then
  begin
    CmpName:=Copy(TzrComboBoxList(Sender).Name,11,4);   //edtSORT_ID3
    AddSORT_IDClick(Sender, StrtoInt(CmpName));
  end;
end;

function TfrmGoodsInfo.GetLblCaption(LblName: string): string;
var
  FindCmp: TComponent;
begin
  result:='';
  FindCmp:=FindComponent(LblName);
  if (FindCmp<>nil) and (FindCmp is TLabel) then
    result:=TLabel(FindCmp).Caption;
end;

procedure TfrmGoodsInfo.DoSaveValueSORT_IDClick(Sender: TObject);
var
  LblCaption: string;
  ZrCmp: TzrComboBoxList;
begin
  if Sender is TzrComboBoxList then
  begin
    ZrCmp:=TzrComboBoxList(Sender);
    LblCaption:=Copy(ZrCmp.Name,11,4);
    LblCaption:=GetLblCaption('lblSORT_ID'+LblCaption);
    if (ZrCmp.AsString='') then
    begin
      if MessageBox(Handle,Pchar('û�ҵ�������ҵġ�'+LblCaption+'�����Ƿ�����һ����'),Pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
      ZrCmp.OnAddClick(Sender);
      Exit;
    end;
  end;
end;

procedure TfrmGoodsInfo.CreateComponent(LblCaption: string; NameIdx, vLeft, vTop: integer; DataSet: TDataSet);
var
  LblSort: TLabel;
  Columns: TColumnEh;
  FindCmp: TComponent;
  EdtSort: TzrComboBoxList;
begin
  FindCmp:=FindComponent('edtSORT_ID'+InttoStr(NameIdx));
  if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
    TzrComboBoxList(FindCmp).Free;
  EdtSort:=TzrComboBoxList.Create(self);
  EdtSort.Name:='edtSORT_ID'+InttoStr(NameIdx);
  EdtSort.Parent:=tabProperty;
  EdtSort.Left:=vLeft;
  EdtSort.Top:=vTop;
  EdtSort.Width:=162;
  EdtSort.DataSet:=DataSet;
  EdtSort.Buttons:=[zbNew,zbClear];
  EdtSort.AutoFitColWidth:=true;
  //��������Grid��Column��:
  Columns:=EdtSort.Columns.Add;
  Columns.FieldName:='SORT_NAME';
  Columns.Title.Caption:='����';
  Columns.Width:=130;
  Columns:=EdtSort.Columns.Add;
  Columns.FieldName:='SEQ_NO';
  Columns.Title.Caption:='���';
  Columns.Width:=40; 

  EdtSort.DropWidth:=EdtSort.Width;
  EdtSort.DropHeight:=200;
  EdtSort.FilterFields:='SORT_NAME;SORT_SPELL;SORT_ID';
  EdtSort.Height:=20;
  EdtSort.KeyField:='SORT_ID';
  EdtSort.ListField:='SORT_NAME';
  EdtSort.LocateStyle:=lsDark;
  EdtSort.MultiSelect:=False;
  EdtSort.Properties.AutoSelect:=False;
  EdtSort.Properties.ReadOnly:=true;
  EdtSort.ShowButton:=true;
  EdtSort.ShowTitle:=true;
  EdtSort.KeyValue:='';  //��ֵ
  EdtSort.Text:='';      //��ֵ
  EdtSort.Properties.ReadOnly:=edtSORT_ID3.Properties.ReadOnly;
  EdtSort.Style.Color:=edtSORT_ID3.Style.Color;

  //����SORT_TYPE
  EdtSort.RangeField:='SORT_TYPE';
  EdtSort.RangeValue:=InttoStr(NameIdx);
  //�����¼�
  EdtSort.OnAddClick:= DoAddSORT_IDClick;
  EdtSort.OnSaveValue:=DoSaveValueSORT_IDClick;

  //������ǩ
  FindCmp:=FindComponent('lblSORT_ID'+InttoStr(NameIdx));
  if (FindCmp<>nil) and (FindCmp is TLabel) then
    TLabel(FindCmp).Free;
  LblSort:=TLabel.Create(self);
  LblSort.Name:='lblSORT_ID'+InttoStr(NameIdx);
  LblSort.Parent:=tabProperty;
  LblSort.Alignment:=taRightJustify;
  LblSort.Caption:=LblCaption;
  LblSort.Top:=vTop+3;
  LblSort.Left:=vLeft-4-LblSort.Width;
end;

procedure TfrmGoodsInfo.ExtBarCodeGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;
begin
  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    ExtBarCodeGrid.canvas.FillRect(ARect);
    DrawText(ExtBarCodeGrid.Canvas.Handle,pchar(Inttostr(ExtBarCode.RecNo)),length(Inttostr(ExtBarCode.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end; 
end;

procedure TfrmGoodsInfo.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if ExtBarCodeGrid.ReadOnly then Exit;
  if ExtBarCode.State in [dsEdit,dsInsert] then ExtBarCode.Post;
  fndUNIT_ID.Visible := false;
  ExtBarCode.DisableControls;
  try
    ExtBarCode.Last;
    if ExtBarCode.IsEmpty or (ExtBarCode.FieldbyName('UNIT_ID').AsString <>'') then
    begin
      inc(RowID);
      ExtBarCode.Append;
      ExtBarCode.FieldByName('UNIT_ID').Value := null;
      if ExtBarCode.FindField('SEQNO')<> nil then
        ExtBarCode.FindField('SEQNO').asInteger := RowID;
      ExtBarCode.Post;
    end;
    ExtBarCodeGrid.Col := 1 ;
    if ExtBarCodeGrid.CanFocus and Visible and (dbState <> dsBrowse) then ExtBarCodeGrid.SetFocus;
  finally
    ExtBarCode.EnableControls;
    ExtBarCode.Edit;
  end;
end;
procedure TfrmGoodsInfo.ExtGridFocusNextColumn;
var
  i:Integer;
begin
  i:=ExtBarCodeGrid.Col;
  Inc(i);
  while True do
  begin
    if i>=ExtBarCodeGrid.Columns.Count then
      i:= 1;
    if (ExtBarCodeGrid.Columns[i].ReadOnly or not ExtBarCodeGrid.Columns[i].Visible) and (i<>1) then
      inc(i)
    else
    begin
      if Trim(ExtBarCode.FieldbyName('UNIT_ID').asString)='' then i := 1;
      if (i=1) and (Trim(ExtBarCode.FieldbyName('UNIT_ID').asString)<>'') then
      begin
        ExtBarCode.Next;
        if ExtBarCode.Eof and not ExtBarCodeGrid.Readonly then
        begin
          InitRecord;
        end;
        ExtBarCodeGrid.SetFocus;
        ExtBarCodeGrid.Col := 1 ;
      end else
        ExtBarCodeGrid.Col := i;
      Exit;
    end;
  end;
end;

procedure TfrmGoodsInfo.ExtBarCodeGridColumns1BeforeShowControl(Sender: TObject);
var
  rs:TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  if rs.Locate('UNIT_ID',ExtBarCode.FieldbyName('UNIT_ID').AsString,[]) then
  begin
    fndUNIT_ID.KeyValue := ExtBarCode.FieldbyName('UNIT_ID').AsString;
    fndUNIT_ID.Text := rs.FieldbyName('UNIT_NAME').AsString
  end else
  begin
    fndUNIT_ID.KeyValue :='';
    fndUNIT_ID.Text := '';
  end;
end;

procedure TfrmGoodsInfo.fndUNIT_IDEnter(Sender: TObject);
begin
  inherited;
  fndUNIT_ID.Properties.ReadOnly := ExtBarCodeGrid.ReadOnly;
end;

procedure TfrmGoodsInfo.fndUNIT_IDExit(Sender: TObject);
begin
  inherited;
  if not fndUNIT_ID.DropListed then fndUNIT_ID.Visible := false;
end;

procedure TfrmGoodsInfo.fndUNIT_IDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) then
  begin
    ExtBarCodeGrid.SetFocus;
    fndUNIT_ID.Visible := false;
    ExtGridFocusNextColumn;
  end;
  if (Key=VK_LEFT) then
  begin
    ExtBarCodeGrid.SetFocus;
    fndUNIT_ID.Visible := false;
    ExtBarCodeGrid.Col := ExtBarCodeGrid.Col -1;
  end;
end;

procedure TfrmGoodsInfo.fndUNIT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    Key := #0;
    ExtBarCodeGrid.SetFocus;
    ExtGridFocusNextColumn;
  end;
end;

procedure TfrmGoodsInfo.fndUNIT_IDPropertiesChange(Sender: TObject);
var
  w:integer;
  rs:TZQuery;
begin
  inherited;
  {
  if fndUNIT_ID.Tag = 1 then Exit;
  if fndUNIT_ID.ItemIndex < 0 then Exit;
  if not fndUNIT_ID.Visible then Exit;
  w := Integer(fndUNIT_ID.Properties.Items.Objects[fndUNIT_ID.ItemIndex]);
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  }
end;

procedure TfrmGoodsInfo.fndUNIT_IDSaveValue(Sender: TObject);
begin
  inherited;
  if ExtBarCode.State = dsBrowse then ExtBarCode.Edit;
  ExtBarCode.FieldByName('UNIT_ID').AsString := fndUNIT_ID.AsString;
end;

procedure TfrmGoodsInfo.ExtBarCodeGridKeyPress(Sender: TObject;
  var Key: Char);
begin
//  inherited;
  if Key=#13 then
     ExtGridFocusNextColumn;
end;

procedure TfrmGoodsInfo.ExtBarCodeGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  inherited;
  Cell := ExtBarCodeGrid.MouseCoord(X,Y);
  if (Cell.Y > ExtBarCodeGrid.VisibleRowCount) or (Cell.Y<0) then
    InitRecord;
end;

procedure TfrmGoodsInfo.N1Click(Sender: TObject);
begin
  inherited;
  if ExtBarCode.Active then
    ExtBarCode.Delete;
end;

end.
