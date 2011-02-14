unit ufrmGoodsInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, cxMaskEdit, cxDropDownEdit, cxMemo,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB,
  DBClient, ADODB, cxCheckBox, zBase, ComCtrls, RzTreeVw, RzRadChk, Grids,
  DBGridEh, cxListBox, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxSpinEdit, Buttons;

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
    Label14: TLabel;
    Label9: TLabel;
    TabGoodPrice: TRzTabSheet;
    Label20: TLabel;
    Label27: TLabel;
    edtGODS_TYPE: TRadioGroup;
    edtUSING_PRICE: TRadioGroup;
    edtUSING_BATCH_NO: TRadioGroup;
    Label18: TLabel;
    Label28: TLabel;
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
    cdsGoods1: TZQuery;
    BarCode1: TZQuery;
    BarCode: TZQuery;
    cdsGoods: TZQuery;
    PUB_GoodsPrice: TZQuery;
    Label45: TLabel;
    Label17: TLabel;
    Label40: TLabel;
    edtSORT_ID6: TzrComboBoxList;
    edtSORT_ID2: TzrComboBoxList;
    Label29: TLabel;
    Label13: TLabel;
    Label44: TLabel;
    edtSORT_ID5: TzrComboBoxList;
    edtSORT_ID4: TzrComboBoxList;
    edtSORT_ID3: TzrComboBoxList;
    Label24: TLabel;
    PUB_GoodsPrice1: TZQuery;
    Label12: TLabel;
    Lbl_1: TLabel;
    edtPRICE_METHOD: TcxComboBox;
    Label31: TLabel;
    edtNEW_LOWPRICE: TcxTextEdit;
    LblColorGroup: TLabel;
    edtSORT_ID7: TzrComboBoxList;
    lblSizeGroup: TLabel;
    edtSORT_ID8: TzrComboBoxList;
    Log_GoodsPrice: TZQuery;
    edtUSING_BARTER: TGroupBox;
    RB_USING_BARTER: TRadioButton;
    RB_NotUSING_BARTER: TRadioButton;
    Label47: TLabel;
    edtBARTER_INTEGRAL: TcxSpinEdit;
    RzPnl_Price: TRzPanel;
    DBGridEh1: TDBGridEh;
    edtSORT_ID1: TcxButtonEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtGODS_NAMEPropertiesChange(Sender: TObject);
    procedure edtSORT_ID4AddClick(Sender: TObject);
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
    procedure btnAppendClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtSORT_ID1_AddClick(Sender: TObject);
    procedure edtCALC_UNITSSaveValue(Sender: TObject);
    procedure edtSMALL_UNITSSaveValue(Sender: TObject);
    procedure edtBIG_UNITSSaveValue(Sender: TObject);
    procedure edtSORT_ID3SaveValue(Sender: TObject);
    procedure edtSORT_ID4SaveValue(Sender: TObject);
    procedure edtSORT_ID7SaveValue(Sender: TObject);
    procedure edtNEW_INPRICEPropertiesChange(Sender: TObject);
    procedure edtPROFIT_RATEPropertiesChange(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure edtBARCODE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtBIGTO_CALCPropertiesChange(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure edtMY_OUTPRICEPropertiesChange(Sender: TObject);
    procedure edtSORT_ID2SaveValue(Sender: TObject);
    procedure edtSORT_ID2AddClick(Sender: TObject);
    procedure edtSORT_ID6AddClick(Sender: TObject);
    procedure edtSORT_ID5AddClick(Sender: TObject);
    procedure edtSORT_ID5SaveValue(Sender: TObject);
    procedure edtSORT_ID6SaveValue(Sender: TObject);
    procedure edtSORT_ID8SaveValue(Sender: TObject);
    procedure edtNEW_OUTPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtPROFIT_RATEKeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_OUTPRICE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtUSING_PRICEClick(Sender: TObject);
    procedure RB_USING_BARTERClick(Sender: TObject);
    procedure edtSORT_ID1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FRELATION_FLAG: Integer; //Append�������Ʒ���������[������Ӫ��������Ӫ] 1��2
    FSortID: string;      //Append�����SortIDֵ
    FSortName: string;    //Append�����SortNameֵ
    UnitBarCode: string;  //������λ������
    SmallBarCode:string;  //С��װ������
    BigBarCode: string;   //���װ������

    //��Ʒ����: SORT_ID1_KeyValue
    SORT_ID1_KeyValue: string;

    procedure EditKeyPress(Sender: TObject; var Key: Char);    
    procedure AddSORT_IDClick(Sender: TObject; SortType: integer); //���Add
    procedure CheckGoodsFieldIsEmpty; //�ж���Ʒ�ǿ������Ƿ�Ϊ�գ�
    procedure CheckGoodsNameIsExist; //�ж���Ʒ�����Ƿ���ڱ��ػ����д���
    function  GetIsRELATION_FLAG: Boolean; //�����ж��Ƿ�ɱ༭
    procedure SetZrCbxDefaultValue(SetCbx: TzrComboBoxList);  //����Ĭ��ֵ
    procedure CheckCLVersionSetParams;  //�ж���ҵ�汾���ò���;
  public
     AObj:TRecord_;
     SORT_ID1,flag,ccid:string;
     Saved,IsCompany:Boolean;
     CarryRule,Deci:integer;
     locked:boolean;
     //��С��
     function  ConvertToFight(value: Currency; deci: Integer): real;
     procedure Append(FRELATION_FLAG: Integer; Sort_ID:string; Sort_Name:string; GODS_ID:string);
     procedure Edit(code: string);
     procedure Open(code: string);
     procedure OpenCopyNew(code: string);
     procedure ReadFromObject(AObj:TRecord_); //��Obj��ȡ�ؼ�����ʾ��
     procedure WriteToObject(AObj:TRecord_);  //д��OBj��¼������
     procedure Save;  //����
     function  IsEdit(Aobj:TRecord_;cdsTable: TZQuery):Boolean;//�ж���Ʒ�����Ƿ����޸�
     procedure IsBarCodeSame(Aobj:TRecord_);//�ж�������û���ظ�
     procedure SetdbState(const Value: TDataSetState); override;
     procedure EditPrice; //ֻ���޸ļ۸�
     procedure WriteBarCode(str:string);  //д��������
     procedure ReadGoodsBarCode(CdsBarCode: TZQuery);          //��ȡ��Ʒ����
     function  ReadBarCode_INFO(str:string):boolean;  //���������ȡ
     procedure WriteGoodsPrices(InObj: TRecord_);  //д����Ʒ�۸�
     class function AddDialog(Owner:TForm;var _AObj:TRecord_;Default:string=''):boolean;
     class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
     property  IsRELATION_FLAG: Boolean read GetIsRELATION_FLAG;
  end;

var
  SaveSid, SaveSName: string;

implementation

uses
  uShopUtil,uTreeUtil,uDsUtil,uFnUtil,uGlobal,uXDictFactory, ufrmMeaUnits,uShopGlobal,
  ufrmGoodssort, ufrmGoodsSortTree, uframeTreeFindDialog;

  //ufrmGoodsSort, ufrmBrandInfo, ufrmColorInfo, ufrmClientInfo,ufrmSizeInfo ,
  //ufrmGoodsColorDialog,ufrmGoodsSizeDialog


{$R *.dfm}

procedure TfrmGoodsInfo.Append(FRELATION_FLAG: Integer; Sort_ID,Sort_Name,GODS_ID:string);
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
    RB_NotUSING_BARTER.Checked:=true;
    //ͳ��ָ��Ĭ��ֵ:
    SetZrCbxDefaultValue(edtSORT_ID2);
    //SetZrCbxDefaultValue(edtSORT_ID3);  ����Ӧ�� ��Ϊ  ����Ϊ��
    SetZrCbxDefaultValue(edtSORT_ID4);
    SetZrCbxDefaultValue(edtSORT_ID5);
    SetZrCbxDefaultValue(edtSORT_ID6);
    //Ĭ�ϵ��۷�ʽ:
    if edtPRICE_METHOD.Properties.Items.Count>0 then
      edtPRICE_METHOD.ItemIndex:=0;
    if not edtCALC_UNITS.DataSet.IsEmpty then
    begin
      edtCALC_UNITS.KeyValue := edtCALC_UNITS.DataSet.FieldbyName('UNIT_ID').AsString;
      edtCALC_UNITS.Text := edtCALC_UNITS.DataSet.FieldbyName('UNIT_NAME').AsString;
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
end;

procedure TfrmGoodsInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmGoodsInfo.Edit(code: string);
var Tmp: TZQuery;
begin
  Open(code);
  dbState := dsEdit;
  Tmp:=Global.GetZQueryFromName('CA_TENANT');
  if Tmp.Locate('TENANT_ID',AObj.FieldByName('TENANT_ID').AsString,[]) then
  begin
    if trim(cdsGoods.FieldByName('RELATION_FLAG').AsString)='1' then
      EditPrice;
  end;
end;

procedure TfrmGoodsInfo.FormCreate(Sender: TObject);
var
  rs: TZQuery;
begin
  inherited;
  RzPage.ActivePageIndex := 0;    
  CheckCLVersionSetParams; //�ж���ҵ�汾������Ӧ�ؼ�: ��װ�汾��ʾ��ɫ��������
  TabGoodPrice.TabVisible:=False;  //�۸�����ҳ Ĭ��ΪFalse;

  AObj := TRecord_.Create;
  edtCALC_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  edtSMALL_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  edtBIG_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  //��Ʒ�ĵ�8��SORT_ID���ݼ�:
  //edtSORT_ID1.DataSet:=Global.GetZQueryFromName('PUB_GOODSSORT');     //����
  edtSORT_ID2.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');     //���[�̲�:һ���̡������̡�������]
  edtSORT_ID3.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');    //����Ӧ��
  edtSORT_ID4.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');    //Ʒ��
  edtSORT_ID5.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');     //�ص�Ʒ��
  edtSORT_ID6.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');     //ʡ����
  edtSORT_ID7.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');    //��ɫ
  edtSORT_ID8.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');     //����

  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);

  //��λ����
  // CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);

  //  rs := Global.GetADODataSetFromName('PUB_GOODSSORT');
  //  CreateLevelTree(rs,rzTree,'333333','SORT_ID','SORT_NAME','LEVEL_ID');

  // lblSizeGroup.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'����')+'��';
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
  tmp:TADODataSet;
  CID:string;
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
      Factor.AddBatch(PUB_GoodsPrice,'TGoodsPrice',Params);
      Factor.OpenBatch;
      AObj.ReadFromDataSet(cdsGoods);
      ReadFromObject(AObj);
      edtGODS_SPELL.Text:=AObj.FieldByName('GODS_SPELL').AsString;
      if not ShopGlobal.GetChkRight('400019') then
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

    if BarCode.Locate('UNIT_ID',AObj.FieldByName('CALC_UNITS').AsString,[])  then
    begin
      if (BarCode.FieldByName('PROPERTY_01').AsString='#')  and  (BarCode.FieldByName('PROPERTY_02').AsString='#')  and (BarCode.FieldByName('BATCH_NO').AsString='#') and (BarCode.FieldByName('TENANT_ID').AsString=CID)then
         edtBARCODE1.Text:=BarCode.FieldByName('BARCODE').AsString;
      UnitBarCode:=BarCode.FieldByName('BARCODE').AsString;
    end;
    if BarCode.Locate('UNIT_ID',AObj.FieldByName('SMALL_UNITS').AsString,[]) then
    begin
      if (BarCode.FieldByName('PROPERTY_01').AsString='#')  and  (BarCode.FieldByName('PROPERTY_02').AsString='#')  and (BarCode.FieldByName('BATCH_NO').AsString='#') and (BarCode.FieldByName('TENANT_ID').AsString=CID) then
        edtBARCODE2.Text:=BarCode.FieldByName('BARCODE').AsString;
      SmallBarCode:=BarCode.FieldByName('BARCODE').AsString;
    end;
    if BarCode.Locate('UNIT_ID',AObj.FieldByName('BIG_UNITS').AsString,[])  then
    begin
      if (BarCode.FieldByName('PROPERTY_01').AsString='#')  and  (BarCode.FieldByName('PROPERTY_02').AsString='#')  and (BarCode.FieldByName('BATCH_NO').AsString='#') and (BarCode.FieldByName('TENANT_ID').AsString=CID) then
        edtBARCODE3.Text:=BarCode.FieldByName('BARCODE').AsString;
      BigBarCode:=BarCode.FieldByName('BARCODE').AsString;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('PUB_GOODSINFO');
      Temp.Filtered :=false;
      if not Temp.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
        Temp.Append
      else
        Temp.Edit;
      AObj.WriteToDataSet(Temp,False);
      {Temp.FieldbyName('UNIT_ID').ReadOnly := false;
      Temp.FieldbyName('UNIT_ID').asString := AObj.FieldbyName('CALC_UNITS').asString;
      Temp.FieldbyName('BARCODE').ReadOnly := false;
      Temp.FieldbyName('BARCODE').asString := Trim(edtBARCODE1.Text);
      Temp.FieldByName('PROPERTY_01').ReadOnly:=False;
      Temp.FieldByName('PROPERTY_01').AsString:=AObj.FieldbyName('PROPERTY_01').asString;
      Temp.FieldByName('PROPERTY_02').ReadOnly:=False;
      Temp.FieldByName('PROPERTY_02').AsString:=AObj.FieldbyName('PROPERTY_02').asString;
      }
      Temp.Post;
   end;
var i,j:integer;
    BARCODECOMP_ID:string;
    Params:TftParamList;
    IsModifPrice: Boolean;
begin
  //����ǰ�ر���־���ݼ�
  if dbState=dsEdit then 
    Log_GoodsPrice.Close;

  CheckGoodsFieldIsEmpty;  //�����Ʒ�ǿ��ֶ��Ƿ�Ϊ��?
  CheckGoodsNameIsExist;   //�����Ʒ�������Ʒ�����Ƿ��ڱ��ػ����д���[]

  if dbState = dsInsert then
  begin
    AObj.FieldbyName('GODS_ID').AsString :=TSequence.NewId;  //GUID��
    if trim(edtGODS_CODE.Text)='�Զ����' then
    begin
      edtGODS_CODE.Text:=TSequence.GetSequence('GODS_CODE',InttoStr(ShopGlobal.TENANT_ID),'',6);  //��ҵ����ID
      AObj.FieldbyName('GODS_CODE').AsString :=edtGODS_CODE.Text;  //��ҵ����ID
    end else AObj.FieldbyName('GODS_CODE').AsString:=trim(edtGODS_CODE.Text);
  end;

  if (edtBARCODE1.Text = '�Ա�����') or (trim(edtBARCODE1.Text)='') then
    edtBARCODE1.Text := GetBarCode(AObj.FieldbyName('GODS_CODE').asString,'#','#');
    
  WriteToObject(AObj);  //���Ŀؼ���Valueд��Obj������:

  if (AObj.FieldbyName('GODS_CODE').AsString='') or (pos('�Զ����',AObj.FieldbyName('GODS_CODE').AsString)>0) then
  begin
    //AObj.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('BCODE').AsString;
    edtGODS_CODE.Text:=AObj.FieldbyName('GODS_CODE').AsString;
  end;

  //�ж�������û���ظ�
  IsBarCodeSame(AObj);
  //�ж���Ʒ������û���޸�
  if (not isEdit(AObj,cdsGoods)) and (flag<>'1')  then exit;

  //(1)��Ʒ����������
  cdsGoods.Edit;
  AObj.WriteToDataSet(cdsGoods);
  cdsGoods.Post;

  //(2)д����
  SaveSId :=SORT_ID1_KeyValue;
  SaveSName := edtSORT_ID1.Text;
  //д����Ʒ���������
  WriteBarCode('');

  //(3)д��Ʒ�۸��
  WriteGoodsPrices(AObj);   //������:AObj ��ȡGODE_ID������
  
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsGoods,'TGoodsInfo',nil);
    Factor.AddBatch(BarCode,'TPUB_BARCODE',nil);
    Factor.AddBatch(PUB_GoodsPrice,'TGoodsPrice',nil);
    if (dbState=dsEdit) and (Log_GoodsPrice.Active) and (Log_GoodsPrice.RecordCount=1) then
      Factor.AddBatch(Log_GoodsPrice,'TGoodsPriceLog',nil);
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
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

procedure TfrmGoodsInfo.edtSORT_ID4AddClick(Sender: TObject);
begin
  inherited;
  AddSORT_IDClick(Sender, 4);
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
        Append(self.FRELATION_FLAG , SORT_ID1_KeyValue, edtSORT_ID1.Text,'');
        locked := true;
        try
          ReadFromObject(AObj1);
        finally
          locked := false;
        end;
        edtGODS_CODE.Text := '�Զ����..';
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
    edtPROFIT_RATE.Text:=formatFloat('#0.0',AObj.FieldByName('NEW_INPRICE').AsFloat*100/AObj.FieldByName('NEW_OUTPRICE').AsFloat)
  else
    edtPROFIT_RATE.Text:= '';
  edtUSING_PRICE.ItemIndex := AObj.FieldbyName('USING_PRICE').AsInteger-1;
  edtGODS_TYPE.ItemIndex := AObj.FieldbyName('GODS_TYPE').AsInteger-1;
  edtHAS_INTEGRAL.ItemIndex := AObj.FieldbyName('HAS_INTEGRAL').AsInteger-1;
  edtUSING_BATCH_NO.ItemIndex := AObj.FieldbyName('USING_BATCH_NO').AsInteger-1;
  if AObj.FieldbyName('USING_BARTER').AsInteger=1 then
    edtBARTER_INTEGRAL.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsFloat
  else
    edtBARTER_INTEGRAL.Value:=null;

  RB_USING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=1);
  RB_NotUSING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=2);
  
  //��Ʒ���ࣺ
  SORT_ID1_KeyValue:=trim(AObj.FieldbyName('SORT_ID1').AsString);
  edtSORT_ID1.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',SORT_ID1_KeyValue);

  //����Ӧ��:
  edtSORT_ID3.KeyValue:=AObj.FieldbyName('SORT_ID3').AsString;  //����Ӧ��ID
  edtSORT_ID3.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTINFO'),'CLIENT_ID','CLIENT_NAME',Aobj.FieldByName('SORT_ID3').AsString);

  //��ȡ��Ʒ���������ԣ�
  ReadGoodsBarCode(self.BarCode);     //��ȡ����

  //�۸���д����Ʒ��ͼ[���۷�ʽ����ʱ����ʾ]
  // if PUB_GoodsPrice.Active then edtPRICE_METHOD.ItemIndex:=TdsItems.FindItems(edtPRICE_METHOD.Properties.Items,'CODE_ID',PUB_GoodsPrice.FieldbyName('PRICE_METHOD').AsString);

  edtNEW_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('RTL_OUTPRICE').AsFloat);   //��׼�ۼ�
  edtMY_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE').AsFloat);    //�ŵ��ۼ�
  edtMY_OUTPRICE1.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE1').AsFloat);  //��װ1�ŵ��ۼ�
  edtMY_OUTPRICE2.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE2').AsFloat);  //��װ2�ŵ��ۼ�
end;

procedure TfrmGoodsInfo.WriteToObject(AObj: TRecord_);
begin
  uShopUtil.WriteToObject(AObj,self);
  if StrtoFloatDef(edtNEW_OUTPRICE.Text,0)>0 then AObj.FieldByName('RTL_OUTPRICE').AsFloat:=StrtoFloat(edtNEW_OUTPRICE.Text);   //��׼�ۼ�
  if StrtoFloatDef(edtNEW_LOWPRICE.Text,0)>0 then AObj.FieldByName('NEW_LOWPRICE').AsFloat:=StrtoFloat(edtNEW_LOWPRICE.Text);   //����ۼ�
  if StrtoFloatDef(edtMY_OUTPRICE.Text,0)>0  then AObj.FieldByName('NEW_OUTPRICE').AsFloat:=StrtoFloat(edtMY_OUTPRICE.Text);    //�����ۼ�
  if StrtoFloatDef(edtMY_OUTPRICE1.Text,0)>0 then AObj.FieldByName('NEW_OUTPRICE1').AsFloat:=StrtoFloat(edtMY_OUTPRICE1.Text);
  if StrtoFloatDef(edtMY_OUTPRICE2.Text,0)>0 then AObj.FieldByName('NEW_OUTPRICE2').AsFloat:=StrtoFloat(edtMY_OUTPRICE2.Text);
  AObj.FieldbyName('USING_PRICE').AsInteger := edtUSING_PRICE.ItemIndex+1;    //��Ա�ۿ���
  AObj.FieldbyName('GODS_TYPE').AsInteger := edtGODS_TYPE.ItemIndex+1;        //������ѡ��
  AObj.FieldbyName('HAS_INTEGRAL').AsInteger := edtHAS_INTEGRAL.ItemIndex+1;  //��Ա����
  AObj.FieldbyName('USING_BATCH_NO').AsInteger := edtUSING_BATCH_NO.ItemIndex+1;    //��������
  RB_USING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=1);
  RB_NotUSING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=2);
  //�Ƿ���ƻ��ֻ���
  if RB_USING_BARTER.Checked then AObj.FieldbyName('USING_BARTER').AsInteger :=1
  else AObj.FieldbyName('USING_BARTER').AsInteger :=2;         
  if edtBARTER_INTEGRAL.Enabled then
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger := edtBARTER_INTEGRAL.Value;  //���û��ֻ�����Ʒ
  AObj.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;

  //д����Ʒ���[edtSORT_ID1.KeyValue ..  edtSORT_ID8.KeyValue]
  AObj.FieldByName('SORT_ID1').AsString:=SORT_ID1_KeyValue;
  AObj.FieldByName('SORT_ID2').AsString:=edtSORT_ID2.KeyValue;
  AObj.FieldByName('SORT_ID3').AsString:=edtSORT_ID3.KeyValue;
  AObj.FieldByName('SORT_ID4').AsString:=edtSORT_ID4.KeyValue;
  AObj.FieldByName('SORT_ID5').AsString:=edtSORT_ID5.KeyValue;
  AObj.FieldByName('SORT_ID6').AsString:=edtSORT_ID6.KeyValue;
  AObj.FieldByName('SORT_ID7').AsString:=edtSORT_ID7.KeyValue;
  AObj.FieldByName('SORT_ID8').AsString:=edtSORT_ID8.KeyValue;
  //д��������:            
  AObj.FieldByName('BARCODE').AsString:=edtBARCODE1.Text;
end;

procedure TfrmGoodsInfo.FormShow(Sender: TObject);
var tmp:TADODataSet;
begin
  inherited;
  if dbState=dsBrowse then
  begin
    if edtGODS_CODE.CanFocus then  edtGODS_CODE.SetFocus;
  end
  else
  begin
    if CLVersion='OHR' then
    begin
      if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
    end
    else
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
       end;
  finally
    AObj.Free;
  end;
end;

function TfrmGoodsInfo.IsEdit(Aobj: TRecord_; cdsTable:  TZQuery): Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to cdsGoods.FieldCount-1 do
  begin
    if AObj.Fields[i].AsString<>cdsGoods.Fields[i].AsString then
    begin
      Result:=True;
      break;
    end;
  end;
  //�ж��������Ƿ�ı�:
  if (UnitBarCode<>Trim(edtBARCODE1.Text)) or(SmallBarCode<>Trim(edtBARCODE2.Text)) or (BigBarCode<>Trim(edtBARCODE3.Text)) then
    Result:=True;
end;

procedure TfrmGoodsInfo.IsBarCodeSame(Aobj: TRecord_);
var
  tmp: TZQuery;
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
  if ShopGlobal.GetParameter('DUPBARCODE')<>'1' then
  begin
    if dbState=dsInsert then
    begin
      try
        //�ж�����λ��������
        tmp:=TZQuery.Create(nil);
        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B '+
                      ' where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE1.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
          raise Exception.Create('������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
        end;
        //�ж�С��װ������
        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B '+
                      ' where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE2.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE2.CanFocus then edtBARCODE2.SetFocus;
          raise Exception.Create('С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
        end;
        //�жϴ��װ��������
        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B '+
                      ' where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE3.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
          raise Exception.Create('���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'�ظ�!');
        end;
      finally
        tmp.Free;
      end;
    end;
    
    if dbState=dsEdit then
    begin
      try
        tmp:=TZQuery.Create(nil);
        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B '+
            ' where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBARCODE1.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
          raise Exception.Create('������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B '+
            ' where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBARCODE2.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
          raise Exception.Create('С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBARCODE3.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
          raise Exception.Create('���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!');
        end;
      finally
        tmp.Free;
      end;
    end;
  end
  else if ShopGlobal.GetParameter('DUPBARCODE')='1' then
  begin
    if dbState=dsInsert then
    begin
      try
        tmp:=TZQuery.Create(nil);
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE1.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
          MessageBox(handle,Pchar('������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE2.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
          MessageBox(handle,Pchar('С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.BARCODE='+QuotedStr(edtBARCODE3.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
          MessageBox(handle,Pchar('���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;
      finally
        tmp.Free;
      end;
    end;
    if dbState=dsEdit then
    begin
      try
        tmp:=TZQuery.Create(nil);
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBarCode1.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
          MessageBox(handle,Pchar('������λ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBarCode2.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
          MessageBox(handle,Pchar('С��װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;

        tmp.Close;
        tmp.SQL.Text:='select A.BARCODE BARCODE,A.GODS_ID GODS_ID,B.GODS_NAME GODS_NAME,B.GODS_CODE GODS_CODE from PUB_BARCODE A,(select GODS_ID,GODS_NAME,GODS_CODE FROM VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID='+QuotedStr(ccid)+') B  where (A.TENANT_ID=''----'' or A.TENANT_ID='+QuotedStr(ccid)+') and A.GODS_ID=B.GODS_ID and A.GODS_ID<>'+QuotedStr(Aobj.FieldByName('GODS_ID').AsString)+' and A.BARCODE='+QuotedStr(edtBarCode3.Text);
        Factor.Open(tmp);
        if tmp.RecordCount>0 then
        begin
          if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
          MessageBox(handle,Pchar('���װ�������Ѿ����ڣ��ͻ���Ϊ'+tmp.FieldByName('GODS_CODE').AsString+',��Ʒ����Ϊ'+tmp.FieldByName('GODS_NAME').AsString+'����Ʒ�ظ�!'),Pchar(Caption),MB_OK);
        end;
      finally
        tmp.Free;
      end;
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
       end;
  finally
    AObj.Free;
  end;
end;
procedure TfrmGoodsInfo.edtSORT_ID3AddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  {AObj := TRecord_.Create;
  try
    if TfrmClientInfo.AddDialog(self,AObj) then
       begin
         edtPROVIDE.KeyValue :=AObj.FieldbyName('CLIENT_ID').AsString;
         edtPROVIDE.Text := AObj.FieldbyName('CLIENT_NAME').asString;
       end;
  finally
    AObj.Free;
  end;}
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
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsInfo.btnAppendClick(Sender: TObject);
//var Aobj:TRecord_;
//    rs:TADODataSet;
begin
  inherited;
{  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.AddDialog(self,AObj) then
       begin
         rs := Global.GetADODataSetFromName('PUB_GOODSSORT');
         CreateLevelTree(rs,rzTree,'333333','SORT_ID','SORT_NAME','LEVEL_ID');
         SortId:= AObj.FieldbyName('SORT_ID').asString;
         edtSORT_ID.DroppedDown := false;
       end;
  finally
    AObj.Free;
  end; }
end;
procedure TfrmGoodsInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
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

procedure TfrmGoodsInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label4.Visible:=true;
  Label6.Visible:=true;
  Label9.Visible:=true;
  Label41.Visible:=true;
  Label42.Visible:=true;
  edtGODS_TYPE.Enabled:=True;
  edtUSING_PRICE.Enabled:=True;
  edtUSING_BATCH_NO.Enabled:=True;
  edtHAS_INTEGRAL.Enabled:=True;
  edtUSING_BARTER.Enabled:=True;
  BtnOk.Visible := (value<>dsBrowse);
  edtPROFIT_RATE.Enabled:=True;
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
    end;
  else
    begin
      Caption := '��Ʒ����';
      Label4.Visible:=False;
      Label6.Visible:=False;
      Label9.Visible:=False;
      Label41.Visible:=False;
      Label42.Visible:=False;
      edtGODS_TYPE.Enabled:=False;
      edtUSING_PRICE.Enabled:=False;
      edtUSING_BATCH_NO.Enabled:=False;
      edtHAS_INTEGRAL.Enabled:=False;
      edtPROFIT_RATE.Enabled:=False;
      edtUSING_BARTER.Enabled:=False;
    end;
  end;
end;

class function TfrmGoodsInfo.AddDialog(Owner: TForm; var _AObj: TRecord_;Default:string=''): boolean;
function IsChinese(str:string):Boolean;
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
begin
   if not ShopGlobal.GetChkRight('200036') then Raise Exception.Create('��û��������Ʒ��Ȩ��,��͹���Ա��ϵ.');
   with TfrmGoodsInfo.Create(Owner) do
    begin
      try
        if (Pos('{',Default)>0) and (Pos('}',Default)>0) then
          Append(0,'','',Default)
        else
        begin
          Append(0,'','','');
          if Default<>'' then
          begin
            if IsChinese(Default) then
            begin
              edtGODS_NAME.Text:=Default;
            end
            else if not ReadBarCode_INFO(Default) then
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
   if not ShopGlobal.GetChkRight('200037') then Raise Exception.Create('��û���޸���Ʒ��Ȩ��,��͹���Ա��ϵ.');
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

procedure TfrmGoodsInfo.EditPrice;
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
  end;
  SetEditStyle(dsEdit,edtNEW_OUTPRICE.Style);
  edtNEW_OUTPRICE.Properties.ReadOnly:=False;
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
end;



procedure TfrmGoodsInfo.WriteBarCode(str: string);
begin
  BarCode.First;
  while not BarCode.Eof do
  begin
    if trim(BarCode.fieldbyName('BARCODE_TYPE').AsString)='0' then  //������λ����
    begin
      BarCode.Edit;
      BARCode.FieldByName('UNIT_ID').AsString:=edtCALC_UNITS.AsString;
      BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode1.Text);
      BarCode.Post;
    end else
    if trim(BarCode.fieldbyName('BARCODE_TYPE').AsString)='1' then  //С��λ����
    begin
      BarCode.Edit;
      BARCode.FieldByName('UNIT_ID').AsString:=edtSMALL_UNITS.AsString;
      BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode2.Text);
      BarCode.Post;
    end else
    if trim(BarCode.fieldbyName('BARCODE_TYPE').AsString)='2' then  //��λ����
    begin
      BarCode.Edit;
      BARCode.FieldByName('UNIT_ID').AsString:=edtBIG_UNITS.AsString;
      BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode3.Text);
      BarCode.Post;
    end;
    BarCode.Next;
  end;
  //������λ����[��Ϊ�գ���û��λ��]
  if (trim(edtBarCode1.Text)<>'') and (not BarCode.Locate('BARCODE_TYPE','0',[])) then
  begin
    BarCode.Append;
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
  if ((trim(edtSMALL_UNITS.Text)<>'') and (trim(edtBARCODE2.Text)<>'')) and
      (not BarCode.Locate('BARCODE_TYPE','1',[])) then
  begin
    BarCode.Append;
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
  //��λ���� [��λ�����벻Ϊ�գ���û��λ��]
  if ((edtBIG_UNITS.Text<>'') and (Trim(edtBARCODE3.Text)<>'')) and
      (not BarCode.Locate('BARCODE_TYPE','2',[])) then
  begin
    BarCode.Append;
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

procedure TfrmGoodsInfo.edtSORT_ID3SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID3.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ�����Ӧ�̡����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID3.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID4SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID4.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ�����Ʒ�ơ����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID4.OnAddClick(nil);
    Exit;
  end;
end;


procedure TfrmGoodsInfo.edtSORT_ID5SaveValue(Sender: TObject);
begin
  inherited;
  inherited;
  if (edtSORT_ID5.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ��Ƿ��ص�Ʒ�ơ����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID5.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID7SaveValue(Sender: TObject);
begin
  if (edtSORT_ID7.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ���ɫ�顱���Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID7.OnAddClick(nil);
    Exit;
  end;
end;

function TfrmGoodsInfo.ConvertToFight(value: Currency;
  deci: Integer): real;
var s:string;
  n,w:integer;
  jw:Currency;
begin
  if CarryRule=0 then
  begin
    if Deci=0 then
       s := FormatFloat('#0',value);
    if Deci=1 then
       s := FormatFloat('#0.0',value);
    if Deci=2 then
       s := FormatFloat('#0.00',value);
    if Deci=3 then
       s := FormatFloat('#0.000',value);
    result := StrtoFloat(s);
    exit;
  end;
  if CarryRule=2 then
  begin
    if Deci=0 then
       result := Trunc(value);
    if Deci=1 then
       result := Trunc(value*10)/10;
    if Deci=2 then
       result := Trunc(value*100)/100;
    if Deci=3 then
       result := Trunc(value*1000)/1000;
    exit;
  end;
  if CarryRule=1 then
  begin
    if Deci=0 then
      s := FormatFloat('#0',value);
    if Deci=1 then
      s := FormatFloat('#0.0',value);
    if Deci=2 then
      s := FormatFloat('#0.00',value);
    if Deci=3 then
      s := FormatFloat('#0.000',value);
    n := length(s);
    if StrtoInt(s[n]) in [1..4] then
       begin
         s[n] := '5';
         Result := StrtoFloat(s);
       end
    else
    if StrtoInt(s[n]) in [6..9] then
       begin
         s[n] := '0';
         if Deci=0 then
           jw := 10;
         if Deci=1 then
           jw := 1;
         if Deci=2 then
           jw := 0.1;
         if Deci=3 then
           jw := 0.01;
         Result := StrtoFloat(s)+jw;
       end
    else
       Result := StrtoFloat(s);
  end;
  if CarryRule=3 then
  begin
    if Deci=0 then
      s := FormatFloat('#0',value);
    if Deci=1 then
      s := FormatFloat('#0.0',value);
    if Deci=2 then
      s := FormatFloat('#0.00',value);
    if Deci=3 then
      s := FormatFloat('#0.000',value);
    n := length(s);
    if StrtoInt(s[n]) in [1..4] then
       begin
         s[n] := '0';
         Result := StrtoFloat(s);
       end
    else
    if StrtoInt(s[n]) in [6..9] then
       begin
         s[n] := '0';
         if Deci=0 then
           jw := 10;
         if Deci=1 then
           jw := 1;
         if Deci=2 then
           jw := 0.1;
         if Deci=3 then
           jw := 0.01;
         Result := StrtoFloat(s)+jw;
       end
    else
       Result := StrtoFloat(s);
  end;
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
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.RzPageChange(Sender: TObject);
var
  Params:TftParamList;
begin
  inherited;
  //��ʱ�ȹر� 
 {
  if RzPage.ActivePageIndex=4 then
  begin
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger :=ShopGlobal.TENANT_ID;
      Params.ParamByName('USER_ID').asString :=Global.UserID;
      Params.ParamByName('GODS_ID').asString :=cdsGoods.FieldByName('GODS_ID').AsString;
      GetStorage.Close;
      Factor.Open(GetStorage,'TGetStorage',Params);
    finally
      Params.Free;
    end;
  end;

  if RzPage.ActivePageIndex=5 then
  begin
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger :=ShopGlobal.TENANT_ID;
      Params.ParamByName('USER_ID').asString :=Global.UserID;
      Params.ParamByName('GODS_ID').asString :=cdsGoods.FieldByName('GODS_ID').AsString;
      GetStockData.Close;
      Factor.Open(GetStockData,'TGetStockData',Params);
    finally
      Params.Free;
    end;
  end;

  if RzPage.ActivePageIndex=6 then
  begin
    Params := TftParamList.Create(nil);
    try
        Params.ParamByName('TENANT_ID').AsInteger :=ShopGlobal.TENANT_ID;
        Params.ParamByName('USER_ID').asString :=Global.UserID;
        Params.ParamByName('GODS_ID').asString :=cdsGoods.FieldByName('GODS_ID').AsString;
        GetSalesData.Close;
        Factor.Open(GetSalesData,'TGetSalesData',Params);
    finally
      Params.Free;
    end;
  end;
 }
end;

function TfrmGoodsInfo.ReadBarCode_INFO(str: string):boolean;
var tmp,tmp1: TZQuery;
begin
    result := false;
    tmp:=TZQuery.Create(nil);
    try
      tmp.Close;
      tmp.SQL.Text:='select BARCODE,CODE_ID, CODE_NAME,UNIT_NAME,SALE_PRICE, '+
      ' BARCODE1,UNIT_NAME1, BARCODE2,UNIT_NAME2,SMALLTO_CALC,BIGTO_CALC '+
      ' from SYS_BARCODE_INFO where COMM not in (''02'',''12'') '+
      ' and (BARCODE ='+QuotedStr(str)+' or BARCODE1 ='+QuotedStr(str)+' or BARCODE2 ='+QuotedStr(str)+')';
      Factor.Open(tmp);
      if not tmp.IsEmpty then
      begin
        result := true;
        if tmp.FieldByName('CODE_ID').AsString<>'' then
        begin
          edtGODS_CODE.Text:=tmp.FieldByName('CODE_ID').AsString;
        end;
        edtBARCODE1.Text:=tmp.FieldByName('BARCODE').AsString;
        if tmp.FieldByName('CODE_NAME').AsString<>'' then
        begin
          edtGODS_NAME.Text:=tmp.FieldByName('CODE_NAME').AsString;
        end;
        if tmp.FieldByName('UNIT_NAME').AsString<>'' then
        begin
          tmp1:=Global.GetZQueryFromName('PUB_MEAUNITS');
          tmp1.Filtered:=False;
          tmp1.Filter:=' UNIT_NAME='+QuotedStr(tmp.FieldByName('UNIT_NAME').AsString);
          tmp1.Filtered:=True;
          if tmp1.FieldByName('UNIT_ID').AsString<>'' then
          begin
            edtCALC_UNITS.KeyValue:=tmp1.FieldByName('UNIT_ID').AsString;
            edtCALC_UNITS.Text:=tmp1.FieldByName('UNIT_NAME').AsString;
          end;
        end;
        if tmp.FieldByName('SALE_PRICE').AsString<>'' then
        begin
          edtNEW_OUTPRICE.Text:=tmp.FieldByName('SALE_PRICE').AsString;
        end;   

        if tmp.FieldByName('UNIT_NAME1').AsString<>'' then
        begin
          tmp1:=Global.GetZQueryFromName('PUB_MEAUNITS');
          tmp1.Filtered:=False;
          tmp1.Filter:=' UNIT_NAME='+QuotedStr(tmp.FieldByName('UNIT_NAME1').AsString);
          tmp1.Filtered:=True;
          if tmp1.FieldByName('UNIT_ID').AsString<>'' then
          begin
            edtSMALL_UNITS.KeyValue:=tmp1.FieldByName('UNIT_ID').AsString;
            edtSMALL_UNITS.Text:=tmp1.FieldByName('UNIT_NAME').AsString;
            if tmp.FieldByName('SMALLTO_CALC').AsString<>'' then
              edtSMALLTO_CALC.Text:=tmp.FieldByName('SMALLTO_CALC').AsString;
          end;
        end;
        if tmp.FieldByName('BARCODE1').AsString<>'' then
        begin
          edtBARCODE2.Text:=tmp.FieldByName('BARCODE1').AsString;
        end;
        
        if tmp.FieldByName('UNIT_NAME2').AsString<>'' then
        begin
          tmp1:=Global.GetZQueryFromName('PUB_MEAUNITS');
          tmp1.Filtered:=False;
          tmp1.Filter:=' UNIT_NAME='+QuotedStr(tmp.FieldByName('UNIT_NAME2').AsString);
          tmp1.Filtered:=True;
          if tmp1.FieldByName('UNIT_ID').AsString<>'' then
          begin
            edtBIG_UNITS.KeyValue:=tmp1.FieldByName('UNIT_ID').AsString;
            edtBIG_UNITS.Text:=tmp1.FieldByName('UNIT_NAME').AsString;
            if tmp.FieldByName('BIGTO_CALC').AsString<>'' then
              edtBIGTO_CALC.Text:=tmp.FieldByName('BIGTO_CALC').AsString;
          end;
        end;
        if tmp.FieldByName('BARCODE2').AsString<>'' then
        begin
          edtBARCODE3.Text:=tmp.FieldByName('BARCODE2').AsString;
        end;
      end;
   finally
     tmp.Free;
   end;
end;

procedure TfrmGoodsInfo.OpenCopyNew(code: string);
var
  CID:string;
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
      if not ShopGlobal.GetChkRight('400019') then
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
  GoodValue:=trim(edtGODS_CODE.Text);
  tmp.First;
  while not tmp.Eof do
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
    tmp.Next;
  end;

  if GoodValue<>trim(cdsGoods.FieldByName('GODS_NAME').AsString) then
  begin
    IsExists:=False;
    GoodValue:=trim(edtGODS_NAME.Text);
    tmp.First;
    while not tmp.Eof do
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
      tmp.Next;
    end;
  end;
end;

function TfrmGoodsInfo.GetIsRELATION_FLAG: Boolean;
var
  rs: TZQuery;
  ParamValue: integer;
begin
  result:=False;
  rs:=Global.GetZQueryFromName('PUB_PARAMS');
  try
    rs.Filtered:=False;
    rs.Filter:=' TYPE_CODE=''RELATION_FLAG'' and CODE_NAME=''������Ӫ'' ';
    rs.Filtered:=true;
    if (rs.Active) and (not rs.IsEmpty) then
      ParamValue:=rs.fieldbyName('CODE_ID').AsInteger;
    if (cdsGoods.Active) and (trim(cdsGoods.FieldByName('GODS_ID').AsString)<>'') then
      result:=(ParamValue=cdsGoods.FieldByName('RELATION_FLAG').AsInteger)
    else
      result:=(ParamValue=self.FRELATION_FLAG);
  finally
    rs.Filtered:=False;
    rs.Filter:='';
  end;
end;

procedure TfrmGoodsInfo.CheckGoodsFieldIsEmpty;
begin
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
    raise Exception.Create('���ۼ۲���Ϊ�գ�');
  end;

  {==  ��ƷSORT_ID1..8  ==}
  if (SORT_ID1_KeyValue<>'') and (Trim(edtSORT_ID1.Text)='') then
  begin
    if edtSORT_ID1.CanFocus then edtSORT_ID1.SetFocus;
    raise Exception.Create('��Ʒ���಻��Ϊ�գ�');
  end;
  if Trim(edtSORT_ID2.KeyValue)='' then
  begin
    if edtSORT_ID2.CanFocus then edtSORT_ID2.SetFocus;
    raise Exception.Create('��Ʒ�����Ϊ�գ�');
  end;

  {
  if Trim(edtSORT_ID3.KeyValue)='' then
  begin
    if edtSORT_ID3.CanFocus then edtSORT_ID3.SetFocus;
    raise Exception.Create('��Ʒ����Ӧ�̲���Ϊ�գ�');
  end;
  }
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

  //���ֻ����ϵ
  if (RB_USING_BARTER.Checked) and (edtBARTER_INTEGRAL.Enabled) and (edtBARTER_INTEGRAL.Value=0)  then
  begin
    if edtBARTER_INTEGRAL.CanFocus then edtBARTER_INTEGRAL.SetFocus;
    raise Exception.Create('���ֻ����ϵ�Ĳ���Ϊ0��');
  end;

  if Trim(edtCALC_UNITS.AsString)='' then
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
end;

procedure TfrmGoodsInfo.edtSORT_ID2SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID2.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵ���Ʒ����Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID2.OnAddClick(nil);
    Exit;
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


procedure TfrmGoodsInfo.edtSORT_ID6SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID6.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ�ʡ���⡱���Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID6.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID8SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID8.AsString='') then
  begin
    if MessageBox(Handle,'û�ҵ�������ҵġ������顱���Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID8.OnAddClick(nil);
    Exit;
  end;

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

procedure TfrmGoodsInfo.WriteGoodsPrices(InObj: TRecord_);
var PRICE_METHOD: string;
  CurObj: TRecord_; 
begin
  PRICE_METHOD:='';
  PUB_GoodsPrice.Edit; 
  if trim(PUB_GoodsPrice.FieldByName('PRICE_ID').AsString)='' then
    PUB_GoodsPrice.FieldByName('PRICE_ID').AsString:='#';//�������ŵ궨��: # TSequence.NewId;
  PUB_GoodsPrice.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
  PUB_GoodsPrice.FieldByName('SHOP_ID').AsString:=ShopGlobal.SHOP_ID;
  PUB_GoodsPrice.FieldByName('GODS_ID').AsString:=InObj.fieldbyName('GODS_ID').AsString;
  if edtPRICE_METHOD.ItemIndex>-1 then
  begin
    CurObj:=TRecord_(edtPRICE_METHOD.Properties.Items.Objects[edtPRICE_METHOD.ItemIndex]);
    PRICE_METHOD:=CurObj.fieldbyName('CODE_ID').AsString;
  end;
  PUB_GoodsPrice.FieldByName('PRICE_METHOD').AsString:=PRICE_METHOD;
  PUB_GoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat:=StrtoFloat(edtMY_OUTPRICE.Text);
  PUB_GoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat:=StrtoFloat(edtMY_OUTPRICE1.Text);
  PUB_GoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat:=StrtoFloat(edtMY_OUTPRICE2.Text);
  PUB_GoodsPrice.Post;

  //�����ۼ۸ı�ʱ:
  if (AObj.FieldByName('NEW_OUTPRICE').AsFloat <>AObj.FieldByName('NEW_OUTPRICE').AsOldFloat) or
     (AObj.FieldByName('NEW_OUTPRICE1').AsFloat<>AObj.FieldByName('NEW_OUTPRICE1').AsOldFloat) or
     (AObj.FieldByName('NEW_OUTPRICE2').AsFloat<>AObj.FieldByName('NEW_OUTPRICE2').AsOldFloat) then
  begin
    Log_GoodsPrice.Close;
    Log_GoodsPrice.SQL.Text:='select * from LOG_PRICING_INFO where 1=2 ';
    Factor.Open(Log_GoodsPrice); 
    Log_GoodsPrice.Edit;
    Log_GoodsPrice.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //GUID��
    Log_GoodsPrice.FieldByName('PRICING_DATE').AsString:=FormatDatetime('YYYYMMDD',Date()); //��־����
    Log_GoodsPrice.FieldByName('PRICING_USER').AsString:=ShopGlobal.UserID;  //GUID��
    Log_GoodsPrice.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID; //��ҵID
    Log_GoodsPrice.FieldByName('PRICE_ID').AsString:='#';                 //1���ͻ����� #��Ϊ���пͻ�;  2������Ա���ǻ�Ա��
    Log_GoodsPrice.FieldByName('SHOP_ID').AsString:=ShopGlobal.SHOP_ID;   //SHOP_ID��
    Log_GoodsPrice.FieldByName('GODS_ID').AsString:=InObj.fieldbyName('GODS_ID').AsString;
    Log_GoodsPrice.FieldByName('PRICE_METHOD').AsString:=PRICE_METHOD;
    Log_GoodsPrice.FieldByName('ORG_OUTPRICE').AsFloat :=InObj.fieldbyName('NEW_OUTPRICE').AsOldFloat;
    Log_GoodsPrice.FieldByName('ORG_OUTPRICE1').AsFloat:=InObj.fieldbyName('NEW_OUTPRICE1').AsOldFloat;
    Log_GoodsPrice.FieldByName('ORG_OUTPRICE2').AsFloat:=InObj.fieldbyName('NEW_OUTPRICE2').AsOldFloat;
    Log_GoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat :=InObj.fieldbyName('NEW_OUTPRICE').AsFloat;
    Log_GoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat:=InObj.fieldbyName('NEW_OUTPRICE1').AsFloat;
    Log_GoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat:=InObj.fieldbyName('NEW_OUTPRICE2').AsFloat;
    Log_GoodsPrice.Post;
  end;
end;

procedure TfrmGoodsInfo.ReadGoodsBarCode(CdsBarCode: TZQuery);
begin
  if not CdsBarCode.Active then Exit;
  CdsBarCode.First;
  while not CdsBarCode.Eof do
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
  //TabGoodPrice.TabVisible:=(edtUSING_PRICE.ItemIndex=0); 
end;

procedure TfrmGoodsInfo.RB_USING_BARTERClick(Sender: TObject);
begin
  if RB_NotUSING_BARTER.Checked then
    edtBARTER_INTEGRAL.Value:=0;
  edtBARTER_INTEGRAL.Enabled:=RB_USING_BARTER.Checked;
end;

procedure TfrmGoodsInfo.CheckCLVersionSetParams;
begin
  LblColorGroup.Visible:=(trim(CLVersion)='FIG');
  edtSORT_ID7.Visible:=LblColorGroup.Visible;
  lblSizeGroup.Visible:=LblColorGroup.Visible;
  edtSORT_ID8.Visible:=LblColorGroup.Visible;

  if not LblColorGroup.Visible then
  begin
    GB_Small.Top:=22;
    GB_Big.Top:=103;
  end else
  begin
    GB_Small.Top:=35;
    GB_Big.Top:=116;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID1PropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  rs:TRecord_;
begin
  inherited;
  rs := TRecord_.Create;
  try
  if TframeTreeFindDialog.FindDialog1(self,Global.GetZQueryFromName('PUB_GOODSSORT'),
      'SORT_ID','LEVEL_ID','SORT_NAME','444444',rs)
  then
     begin
       SORT_ID1_KeyValue := rs.FieldbyName('SORT_ID').AsString;
       edtSORT_ID1.Text := rs.FieldbyName('SORT_NAME').AsString;
     end;
  finally
     rs.Free;
  end;
end;

end.
