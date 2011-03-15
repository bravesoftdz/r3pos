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
    Label12: TLabel;
    Lbl_1: TLabel;
    Label31: TLabel;
    edtNEW_LOWPRICE: TcxTextEdit;
    LblColorGroup: TLabel;
    edtSORT_ID7: TzrComboBoxList;
    lblSizeGroup: TLabel;
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
    procedure PriceGridColumns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure PriceGridColumns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtDefault1Click(Sender: TObject);
    procedure edtDefault2Click(Sender: TObject);
    procedure edtNEW_LOWPRICEExit(Sender: TObject);
    procedure edtMY_OUTPRICEExit(Sender: TObject);
    procedure edtNEW_OUTPRICEExit(Sender: TObject);
    procedure edtMY_OUTPRICE2Exit(Sender: TObject);
    procedure edtMY_OUTPRICE1Exit(Sender: TObject);
  private
    DropUNITS_Ds: TZQuery;
    FPriceChange: Boolean;  //会员价是否编辑过
    FSortID: string;      //Append传入的SortID值
    FSortName: string;    //Append传入的SortName值
    UnitBarCode: string;  //计量单位条形码
    SmallBarCode:string;  //小包装条形码
    BigBarCode: string;   //大包装条形码

    //商品分类: SORT_ID1_KeyValue
    SORT_ID1_KeyValue: string;
    procedure UpdateUNITSData; //更新当前选择单位
    function  IsChinese(str:string):Boolean;
    procedure OnGridKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure AddSORT_IDClick(Sender: TObject; SortType: integer); //添加Add
    procedure CheckGoodLowPrice(Kind: integer); //判断最低售价
    procedure CheckGoodsFieldIsEmpty; //判断商品非空属性是否为空；
    procedure CheckGoodsNameIsExist; //判断商品名称是否存在本地缓存中存在
    procedure SetZrCbxDefaultValue(SetCbx: TzrComboBoxList);  //设置默认值
    procedure CheckCLVersionSetParams;  //判断行业版本设置参数;
    function  GetColumnIdx(Gird:TDBGridEh; ColName: string): integer;  //返回Gird列Idx
    procedure CheckTabGoodPriceVisible; //判断会员价格是否显示
    procedure CALC_MenberProfitPrice(CdsMemberPrice: TZQuery; CALCType: integer; IsAll: Boolean=False);  //计算会员价折扣单价
  public
     AObj:TRecord_;
     SORT_ID1,flag:string;
     Saved,IsCompany:Boolean;
     CarryRule,Deci:integer;
     locked:boolean;
     //截小数
     function  ConvertToFight(value: Currency; deci: Integer): real;
     procedure Append(Sort_ID:string; Sort_Name:string; GODS_ID:string);
     procedure Edit(code: string);
     procedure Open(code: string);
     procedure OpenCopyNew(code: string);
     procedure ReadFromObject(AObj:TRecord_); //从Obj读取控件上显示。
     procedure WriteToObject(AObj:TRecord_);  //写入OBj记录对象中
     procedure Save;  //保存
     function  IsEdit(Aobj:TRecord_;cdsTable: TZQuery):Boolean;//判断商品资料是否有修改
     procedure IsBarCodeSame(Aobj:TRecord_);//判断条码有没有重复
     procedure SetdbState(const Value: TDataSetState); override;
     procedure EditPrice(IsRelation: Boolean=False); //只能修改价格
     procedure WriteBarCode(str:string);  //写入条形码
     procedure WriteMemberPrice(GODS_ID: String);   //写入会员价
     procedure ReadGoodsBarCode(CdsBarCode: TZQuery);      //读取商品条码
     function  ReadBarCode_INFO(BarCode: string):boolean;  //传入条码读取
     class function AddDialog(Owner:TForm;var _AObj:TRecord_;Default:string=''):boolean;
     class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
  end;

var
  SaveSid, SaveSName: string;

implementation

uses
  DBGrids,uShopUtil,uTreeUtil,uDsUtil,uFnUtil,uGlobal,uXDictFactory, ufrmMeaUnits,
  uShopGlobal,ufrmGoodssort, ufrmGoodsSortTree, uframeTreeFindDialog, ufrmClientInfo,
  ufrmSupplierInfo;

  //ufrmGoodsSort, ufrmBrandInfo, ufrmColorInfo, ufrmClientInfo,ufrmSizeInfo ,
  //ufrmGoodsColorDialog,ufrmGoodsSizeDialog


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
    //统计指标默认值:
    SetZrCbxDefaultValue(edtSORT_ID2);
    //SetZrCbxDefaultValue(edtSORT_ID3);  主供应商 改为  允许为空
    SetZrCbxDefaultValue(edtSORT_ID4);
    SetZrCbxDefaultValue(edtSORT_ID5);
    SetZrCbxDefaultValue(edtSORT_ID6);
    if not edtCALC_UNITS.DataSet.IsEmpty then
    begin
      edtCALC_UNITS.KeyValue := edtCALC_UNITS.DataSet.FieldbyName('UNIT_ID').AsString;
      edtCALC_UNITS.Text := edtCALC_UNITS.DataSet.FieldbyName('UNIT_NAME').AsString;
      if not TabGoodPrice.TabVisible then CheckTabGoodPriceVisible; //判断会员价格是否显示     
    end;
    edtSORT_ID7.KeyValue:='#';
    edtSORT_ID7.Text:='无';
    edtSORT_ID8.KeyValue:='#';
    edtSORT_ID8.Text:='无';
  end;
  edtGODS_CODE.Text := '自动编号';
  edtBARCODE1.Text := '自编条码';
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
  FPriceChange:=False;
  CheckTabGoodPriceVisible; //判断会员价格是否显示
  Tmp:=Global.GetZQueryFromName('CA_TENANT');
  if Tmp.Locate('TENANT_ID',AObj.FieldByName('TENANT_ID').AsString,[]) then
  begin
    if trim(cdsGoods.FieldByName('RELATION_ID').AsString)<>'0' then
      EditPrice;
  end;
end;

procedure TfrmGoodsInfo.FormCreate(Sender: TObject);
var rs: TZQuery;
begin
  inherited;
  RzPage.ActivePageIndex := 0;    
  CheckCLVersionSetParams; //判断行业版本设置相应控件: 服装版本显示颜色和条码组
  TabGoodPrice.TabVisible:=False;  //价格管理分页 默认为False;

  AObj := TRecord_.Create;
  UpdateUNITSData;  //单位下拉
  // edtCALC_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  // edtSMALL_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  // edtBIG_UNITS.DataSet := Global.GetZQueryFromName('PUB_MEAUNITS');
  //商品的的8个SORT_ID数据集:
  //edtSORT_ID1.DataSet:=Global.GetZQueryFromName('PUB_GOODSSORT');     //分类
  edtSORT_ID2.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');     //类别[烟草:一类烟、二类烟、三类烟]
  edtSORT_ID3.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');    //主供应商
  edtSORT_ID4.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');    //品牌
  edtSORT_ID5.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');     //重点品牌
  edtSORT_ID6.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');     //省内外
  edtSORT_ID7.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');    //颜色
  edtSORT_ID8.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');     //尺码

  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);

  //rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  //CreateLevelTree(rs,rzTree,'333333','SORT_ID','SORT_NAME','LEVEL_ID');
  //lblSizeGroup.Caption := XDictFactory.GetResString('PROPERTY_01',ShopGlobal.GetVersionFlag,'尺码')+'组';
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
  CID:string;
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
      Factor.AddBatch(CdsMemberPrice,'TGoodsPrice',Params);
      Factor.OpenBatch;
      AObj.ReadFromDataSet(cdsGoods);
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

    //浏览状态判断
    if (dbState=dsBrowse) and (not TabGoodPrice.Visible) then //判断会员价格是否显示
      CheckTabGoodPriceVisible;

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
   var IsExist: Boolean; GodsID: string; Temp:TZQuery; CurObj: TRecord_;
   begin
      Temp := Global.GetZQueryFromName('PUB_GOODSINFO');
      Temp.Filtered :=false;
      if not Temp.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
        Temp.Append
      else
        Temp.Edit;
      AObj.WriteToDataSet(Temp,False);
      Temp.Post;

      //刷新条形码
      try
        CurObj:=TRecord_.Create;
        Temp := Global.GetZQueryFromName('PUB_BARCODE');
        if Temp.Filtered then Temp.Filtered :=false;
        Temp.CommitUpdates; //清除Change
        //先删除该商品条码:
        GodsID:=trim(AObj.FieldbyName('GODS_ID').AsString);
        if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',0]),[]) then Temp.Delete;
        if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',1]),[]) then Temp.Delete;
        if Temp.Locate('GODS_ID;PROPERTY_01,PROPERTY_02,BATCH_NO;BARCODE_TYPE',VarArrayOf([GodsID,'#','#','#',2]),[]) then Temp.Delete;
        //循环添加:
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
   end;
var i,j:integer;
    CurObj: TRecord_;
    CurType: TFieldType;
    BARCODE_ID,BARCODECOMP_ID:string;
    Params:TftParamList;
    IsModifPrice: Boolean;
begin
  CheckGoodsFieldIsEmpty;  //检查商品非空字段是否为空?
  CheckGoodsNameIsExist;   //检查商品编码和商品名称是否在本地缓村中存在[]

  if dbState = dsInsert then
  begin
    AObj.FieldbyName('GODS_ID').AsString :=TSequence.NewId;  //GUID号
    if (trim(edtGODS_CODE.Text)='自动编号') or (trim(edtGODS_CODE.Text)='') or (IsChinese(trim(edtGODS_CODE.Text))) then
    begin
      edtGODS_CODE.Text:=TSequence.GetSequence('GODS_CODE',InttoStr(ShopGlobal.TENANT_ID),'',6);  //企业内码ID
      AObj.FieldbyName('GODS_CODE').AsString :=edtGODS_CODE.Text;  //企业内码ID
    end else AObj.FieldbyName('GODS_CODE').AsString:=trim(edtGODS_CODE.Text);
  end;

  if (edtBARCODE1.Text = '自编条码') or (trim(edtBARCODE1.Text)='') or (IsChinese(trim(edtBARCODE1.Text))) then
  begin
    BARCODE_ID:=TSequence.GetSequence('BARCODE_ID',InttoStr(ShopGlobal.TENANT_ID),'',6);
    edtBARCODE1.Text := GetBarCode(BARCODE_ID,'#','#');
  end;

  WriteToObject(AObj);  //表单的控件的Value写入Obj对象中:

  if (AObj.FieldbyName('GODS_CODE').AsString='') or (pos('自动编号',AObj.FieldbyName('GODS_CODE').AsString)>0) then
  begin
    //AObj.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('BCODE').AsString;
    edtGODS_CODE.Text:=AObj.FieldbyName('GODS_CODE').AsString;
  end;

  //判断条码有没有重复
  IsBarCodeSame(AObj);

  //(1)商品主表保存数据
  cdsGoods.Edit;
  AObj.WriteToDataSet(cdsGoods);
  cdsGoods.Post;

  //(2)写条码
  SaveSId :=SORT_ID1_KeyValue;
  SaveSName := edtSORT_ID1.Text;
  //写入商品的条形码表
  WriteBarCode('');

  //(3)写会员定价表[循环删除掉没有输入价格]
  WriteMemberPrice(AObj.FieldbyName('GODS_ID').AsString);   //写入会员价

  //判断商品档案有没有修改
  if (not isEdit(AObj,cdsGoods)) and (flag<>'1')  then Raise Exception.Create('您当前没有修改，不需要保存');

  Factor.BeginBatch;
  Params:=TftParamList.Create(nil);
  try
    try
      if dbState=dsEdit then
      begin
        Params.ParamByName('ROWS_ID').AsString:=TSequence.NewId;     //GUID号
        Params.ParamByName('PRICING_USER').AsString:=Global.UserID;  //操作员
      end;
      Factor.AddBatch(cdsGoods,'TGoodsInfo',Params);
      Factor.AddBatch(BarCode,'TPUB_BARCODE',nil);
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
  save; //提交数据库
  if not Saved then exit; //保存异常则退出；
  
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bol then
  begin
    if MessageBox(handle,Pchar('是否要继续新增吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION)=6 then
    begin
      //继续新增前，把商品分类，计量单位等等保存下来
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
        edtGODS_CODE.Text := '自动编号';
        edtBARCODE1.Text := '自编条码';
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

  //是否管制积分换购:
  RB_NotUSING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=1);   //禁用
  RB_USING_BARTER.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=2);      //启用积分兑换
  RB_USING_BARTER2.Checked:=(AObj.FieldbyName('USING_BARTER').AsInteger=3);     //启用积分换购
  if RB_USING_BARTER.Checked then edtBARTER_INTEGRAL.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsInteger;
  if RB_USING_BARTER2.Checked then edtBARTER_INTEGRAL2.Value:=AObj.FieldbyName('BARTER_INTEGRAL').AsInteger;

  //商品分类：
  SORT_ID1_KeyValue:=trim(AObj.FieldbyName('SORT_ID1').AsString);
  edtSORT_ID1.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',SORT_ID1_KeyValue);

  //主供应商:
  edtSORT_ID3.KeyValue:=AObj.FieldbyName('SORT_ID3').AsString;  //主供应商ID
  edtSORT_ID3.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTINFO'),'CLIENT_ID','CLIENT_NAME',Aobj.FieldByName('SORT_ID3').AsString);

  //读取商品其它表属性；
  ReadGoodsBarCode(self.BarCode);     //读取条码

  edtNEW_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('RTL_OUTPRICE').AsFloat);   //标准售价
  edtMY_OUTPRICE.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE').AsFloat);    //门店售价
  edtMY_OUTPRICE1.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE1').AsFloat);  //包装1门店售价
  edtMY_OUTPRICE2.Text:=FloattoStr(AObj.fieldbyname('NEW_OUTPRICE2').AsFloat);  //包装2门店售价

  //默认单位读取
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
begin
  edtPROFIT_RATE.Properties.ReadOnly:=true;
  uShopUtil.WriteToObject(AObj,self);
  edtPROFIT_RATE.Properties.ReadOnly:=False;

  AObj.FieldByName('RTL_OUTPRICE').AsFloat:=StrtoFloatDef(edtNEW_OUTPRICE.Text,0);   //标准售价
  AObj.FieldByName('NEW_LOWPRICE').AsFloat:=StrtoFloatDef(edtNEW_LOWPRICE.Text,0);   //最低售价
  AObj.FieldByName('NEW_OUTPRICE').AsFloat:=StrtoFloatDef(edtMY_OUTPRICE.Text,0);    //本店售价

  //门店自定价:
  AObj.FieldByName('NEW_OUTPRICE1').AsFloat:=0;  //先设为0，只有满足条件有值
  if (StrtoFloatDef(edtMY_OUTPRICE1.Text,0)>0) and (edtSMALL_UNITS.AsString<>'') and (strtoFloatDef(edtSMALLTO_CALC.Text,0)>0)then
    AObj.FieldByName('NEW_OUTPRICE1').AsFloat:=StrtoFloatDef(edtMY_OUTPRICE1.Text,0);
  AObj.FieldByName('NEW_OUTPRICE2').AsFloat:=0;  //先设为0，只有满足条件有值
  if (StrtoFloatDef(edtMY_OUTPRICE2.Text,0)>0) and (edtBIG_UNITS.AsString<>'') and (strtoFloatDef(edtBIGTO_CALC.Text,0)>0)then
    AObj.FieldByName('NEW_OUTPRICE2').AsFloat:=StrtoFloat(edtMY_OUTPRICE2.Text);

  AObj.FieldByName('SHOP_ID').AsString:=Global.SHOP_ID;
  AObj.FieldbyName('USING_PRICE').AsInteger := edtUSING_PRICE.ItemIndex+1;    //会员折扣率
  AObj.FieldbyName('GODS_TYPE').AsInteger := edtGODS_TYPE.ItemIndex+1;        //库存管理选项
  AObj.FieldbyName('HAS_INTEGRAL').AsInteger := edtHAS_INTEGRAL.ItemIndex+1;  //会员积分
  AObj.FieldbyName('USING_BATCH_NO').AsInteger := edtUSING_BATCH_NO.ItemIndex+1;    //启用批号
  AObj.FieldbyName('USING_LOCUS_NO').AsInteger := edtUSING_LOCUS_NO.ItemIndex+1;    //启用物流跟踪号

  //是否管制积分换购:
  if RB_NotUSING_BARTER.Checked then     //禁用:
    AObj.FieldbyName('USING_BARTER').AsInteger :=1
  else if RB_USING_BARTER.Checked then   //兑换:
    AObj.FieldbyName('USING_BARTER').AsInteger:=2
  else if RB_USING_BARTER2.Checked then  //换购:
    AObj.FieldbyName('USING_BARTER').AsInteger :=3;
  ////积分换购商品(换算关系):        
  if edtBARTER_INTEGRAL.Enabled then
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=edtBARTER_INTEGRAL.Value
  else if edtBARTER_INTEGRAL2.Enabled then
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=edtBARTER_INTEGRAL2.Value
  else AObj.FieldbyName('BARTER_INTEGRAL').AsInteger:=0;
  AObj.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;

  //写入商品类别[edtSORT_ID1.KeyValue ..  edtSORT_ID8.KeyValue]
  AObj.FieldByName('SORT_ID1').AsString:=SORT_ID1_KeyValue;
  AObj.FieldByName('SORT_ID2').AsString:=edtSORT_ID2.KeyValue;
  AObj.FieldByName('SORT_ID3').AsString:=edtSORT_ID3.KeyValue;
  AObj.FieldByName('SORT_ID4').AsString:=edtSORT_ID4.KeyValue;
  AObj.FieldByName('SORT_ID5').AsString:=edtSORT_ID5.KeyValue;
  AObj.FieldByName('SORT_ID6').AsString:=edtSORT_ID6.KeyValue;
  AObj.FieldByName('SORT_ID7').AsString:=edtSORT_ID7.KeyValue;
  AObj.FieldByName('SORT_ID8').AsString:=edtSORT_ID8.KeyValue;
  //写入条形码:            
  AObj.FieldByName('BARCODE').AsString:=edtBARCODE1.Text;

  //默认单位写入:
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
      UpdateUNITSData;  //单位下拉
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
    if AObj.Fields[i].AsString<>cdsGoods.Fields[i].AsString then
    begin
      Result:=True;
      break;
    end;
  end;
  //判断条形码是否改变:
  if (UnitBarCode<>Trim(edtBARCODE1.Text)) or(SmallBarCode<>Trim(edtBARCODE2.Text)) or (BigBarCode<>Trim(edtBARCODE3.Text)) then
    Result:=True;
  if not Result then
    result:=(cdsGoods.UpdateStatus <> usUnmodified);
  //判断[会员等级价格是否修改]
  if (not Result) and (CdsMemberPrice.Active) and (TabGoodPrice.TabVisible) and (FPriceChange) then  //会员等级价有判断继续循环AsOldValue与AsValue
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
  IsDUPBARCODE: Boolean; //不允许条码重复
begin
  if (Trim(edtBARCODE1.Text)<>'') and (edtBARCODE1.Text=edtBARCODE2.Text) and (edtBARCODE2.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
    raise Exception.Create('计量单位的条码、小包装条码和大包装条码不能一样!');
  end;
  if (Trim(edtBARCODE1.Text)<>'') and (edtBARCODE1.Text=edtBARCODE2.Text) then
  begin
    if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
    raise Exception.Create('计量单位的条码不能和小包装条码一样!');
  end;
  if (Trim(edtBARCODE2.Text)<>'') and (edtBARCODE2.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
    raise Exception.Create('小包装的条码不能和大包装条码一样!');
  end;
  if (Trim(edtBARCODE3.Text)<>'') and (edtBARCODE1.Text=edtBARCODE3.Text) then
  begin
    if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
    raise Exception.Create('大包装条码不能和计量单位的条码一样!');
  end;

  IsDUPBARCODE:=ShopGlobal.GetParameter('DUPBARCODE')<>'1'; //不允许条码重复
  if dbState=dsInsert then
  begin
    try
      tmp:=TZQuery.Create(nil);
      //判断主单位的条形码
      if ChechBarCodeExist(tmp, edtBARCODE1.Text,'') then
      begin
        if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'计量单位的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'重复!');
      end;
      //判断小包装条形码
      if ChechBarCodeExist(tmp, edtBARCODE2.Text,'') then
      begin
        if edtBARCODE2.CanFocus then edtBARCODE2.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'小包装的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'重复!');
      end;
      //判断大包装的条形码
      if ChechBarCodeExist(tmp, edtBARCODE3.Text,'') then
      begin
        if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'大包装的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'重复!');
      end;
    finally
      tmp.Free;
    end;
  end else
  if dbState=dsEdit then
  begin
    try
      tmp:=TZQuery.Create(nil);
      //判断主单位的条形码
      if ChechBarCodeExist(tmp, edtBARCODE1.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE1.CanFocus then  edtBARCODE1.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'计量单位的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'的商品重复!');
      end;

      if ChechBarCodeExist(tmp, edtBARCODE2.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE2.CanFocus then  edtBARCODE2.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'小包装的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'的商品重复!');
      end;

      if ChechBarCodeExist(tmp, edtBARCODE3.Text,Aobj.FieldByName('GODS_ID').AsString) then
      begin
        if edtBARCODE3.CanFocus then  edtBARCODE3.SetFocus;
        ShowMsgBox(IsDUPBARCODE,'大包装的条码已经存在，和货号为'+tmp.FieldByName('GODS_CODE').AsString+',商品名称为'+tmp.FieldByName('GODS_NAME').AsString+'的商品重复!');
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
      UpdateUNITSData;  //单位下拉
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
      UpdateUNITSData;  //单位下拉
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
    //计算会员价:
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

    CheckTabGoodPriceVisible;  //判断是否显示会员价页
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
    i:=MessageBox(handle,Pchar('商品档案有修改，是否保存修改信息？'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
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
  //edtUSING_BARTER[启用积分]
  RB_NotUSING_BARTER.Enabled:=True;
  RB_USING_BARTER.Enabled:=True;
  edtBARTER_INTEGRAL.Enabled:=True;
  RB_USING_BARTER2.Enabled:=True;
  edtBARTER_INTEGRAL2.Enabled:=True;

  edtUSING_LOCUS_NO.Enabled:=True;
  BtnOk.Visible := (value<>dsBrowse);
  edtPROFIT_RATE.Enabled:=True;
  PriceGrid.ReadOnly:=(dbState=dsBrowse);
  edtDefault1.Enabled:=true;
  edtDefault2.Enabled:=true;
  if dbState=dsBrowse then
    PriceGrid.Options:=[dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit]
  else
    PriceGrid.Options:=[dgEditing,dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];

  case Value of
  dsInsert:
    begin
      Caption := '商品档案--(新增)';
      edtPROFIT_RATE.Enabled:=True;
    end;
  dsEdit:
    begin
      Caption := '商品档案--(修改)';
      edtPROFIT_RATE.Enabled:=True;
    end;
  else
    begin
      Caption := '商品档案';
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
      //是否启用积分:
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
   if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('你没有新增商品的权限,请和管理员联系.');
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
   if not ShopGlobal.GetChkRight('32600001',3) then Raise Exception.Create('你没有新增商品的权限,请和管理员联系.');
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

procedure TfrmGoodsInfo.EditPrice(IsRelation: Boolean=False);
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
  end;
  //edtUSING_BARTER[启用积分]
  RB_NotUSING_BARTER.Enabled:=False;
  RB_USING_BARTER.Enabled:=False;
  edtBARTER_INTEGRAL.Enabled:=False;
  RB_USING_BARTER2.Enabled:=False;
  edtBARTER_INTEGRAL2.Enabled:=False;
  //是总店才有权限修改:标准售价：
  if inttostr(Global.TENANT_ID)+'0001'=trim(Global.SHOP_ID) then 
  begin
    SetEditStyle(dsEdit,edtNEW_OUTPRICE.Style);
    edtNEW_OUTPRICE.Properties.ReadOnly:=False;
  end;
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
    BarCode.Delete;
  end;

  //计量单位条码[不为空，且没定位到]
  if trim(edtBarCode1.Text)<>''  then //计量单位
  begin
    BarCode.Append;
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //行号[GUID编号]
    BARCode.FieldByName('PROPERTY_01').AsString:='#';
    BARCode.FieldByName('PROPERTY_02').AsString:='#';
    BARCode.FieldByName('BARCODE_TYPE').AsString:='0';
    BARCode.FieldByName('UNIT_ID').AsString:=edtCALC_UNITS.AsString;
    BARCode.FieldByName('BATCH_NO').AsString:='#';
    BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode1.Text);
    BarCode.Post;
  end;
  
  //小单位条码 [单位和条码不为空，且没定位到]
  if trim(edtBarCode2.Text)<>'' then
  begin
    BarCode.Append;
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //行号[GUID编号]
    BARCode.FieldByName('PROPERTY_01').AsString:='#';
    BARCode.FieldByName('PROPERTY_02').AsString:='#';
    BARCode.FieldByName('BARCODE_TYPE').AsString:='1';    
    BARCode.FieldByName('UNIT_ID').AsString:=edtSMALL_UNITS.AsString;
    BARCode.FieldByName('BATCH_NO').AsString:='#';
    BARCode.FieldByName('BARCODE').AsString:=Trim(edtBarCode2.Text);
    BarCode.Post;
  end;

  if trim(edtBarCode3.Text)<>'' then  //大单位条码
  begin
    BarCode.Append;
    BARCode.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    BARCode.FieldByName('GODS_ID').AsString:=AObj.FieldbyName('GODS_ID').AsString;
    BARCode.FieldByName('ROWS_ID').AsString:=TSequence.NewId;  //行号[GUID编号]
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
    if MessageBox(Handle,'没找到你想查找的“计量单位”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtCALC_UNITS.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if (edtSMALL_UNITS.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的“包装单位”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
    if MessageBox(Handle,'没找到你想查找的“包装单位”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
    if MessageBox(Handle,'没找到你想查找的“主供应商”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID3.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID4SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID4.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的“所属品牌”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
    if MessageBox(Handle,'没找到你想查找的“是否重点品牌”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID5.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID7SaveValue(Sender: TObject);
begin
  if (edtSORT_ID7.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的“颜色组”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  edtBARCODE1.Text := '自编条码';
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

    //计算会员价:
    CALC_MenberProfitPrice(CdsMemberPrice,0);
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfo.RzPageChange(Sender: TObject);
var
  Params:TftParamList;
begin
  inherited;
  //暂时先关闭 
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

function TfrmGoodsInfo.ReadBarCode_INFO(BarCode: string):boolean;
var tmp: TZQuery;
begin
    result := false;
    tmp:=TZQuery.Create(nil);
    try
      tmp.Close;
      tmp.SQL.Text:='select GODS_ID,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE from PUB_BARCODE '+
        ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and (BARCODE ='+QuotedStr(BarCode)+') ';
      tmp.Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Factor.Open(tmp);
      if not tmp.IsEmpty then
      begin
        result := true;
        ReadGoodsBarCode(tmp);  
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

    //读取条码信息:
    ReadGoodsBarCode(GoodBarCode);   //读取条码   
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
  if edtGODS_CODE.Enabled then  //可修改商品编码
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
          raise Exception.Create('货号已经存在，不能重复！');
        end;
      end;
      tmp.Next;
    end;
  end;
  
  if edtGODS_NAME.Enabled then //可修改商品名称
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
          raise Exception.Create('  提示:商品名称已经存在！ ');
        end;
      end;
      tmp.Next;
    end;
  end;
end;

//参数: Kind：1判断标准售价; 2判断门店售价; 3判断最低售价;
procedure TfrmGoodsInfo.CheckGoodLowPrice(Kind: integer);
begin
  case Kind of
   1:  //判断输入标准售价是判断是否 小于 最低售价;
    begin
      if (StrToFloatDef(edtNEW_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' 您当前输入〖标准售价〗小于〖最低售价〗，是否重新输入？','提示..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtNEW_OUTPRICE.Text:='';
          if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
        end else
        begin
          if edtNEW_LOWPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end;
      end;
    end;
   2:  //判断门店售价;
    begin
      if (StrToFloatDef(edtMY_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' 您当前输入〖本店售价〗小于〖最低售价〗，是否重新输入？','提示..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtMY_OUTPRICE.Text:='';
          if edtMY_OUTPRICE.CanFocus then edtMY_OUTPRICE.SetFocus;
        end else
        begin
          if edtNEW_LOWPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end;
      end;
    end;
   3:  //判断最低售价;
    begin
      // [最低售价] 与 [标准售价]
      if (StrToFloatDef(edtNEW_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' 您当前输入〖最低售价〗大于〖标准售价〗，是否重新输入？','提示..',MB_YESNO+MB_ICONQUESTION)=6 then
        begin
          edtNEW_OUTPRICE.Text:='';
          if edtNEW_LOWPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
        end else
        begin
          if edtNEW_OUTPRICE.CanFocus then edtNEW_LOWPRICE.SetFocus;
        end;
      end;
      // [最低售价] 与 [本店售价]
      if (StrToFloatDef(edtMY_OUTPRICE.Text,0)>=0) and (StrToFloatDef(edtNEW_LOWPRICE.Text,0)>=0) and
         (StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0)) then
      begin
        if MessageBox(Handle,' 您当前输入〖最低售价〗大于 〖本店售价〗，是否重新输入？','提示..',MB_YESNO+MB_ICONQUESTION)=6 then
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
  if Trim(edtGODS_NAME.Text)='' then
  begin
    if edtGODS_NAME.CanFocus then edtGODS_NAME.SetFocus;
    raise Exception.Create('商品名称不能为空！');
  end;
  if Trim(edtGODS_SPELL.Text)='' then
  begin
    if edtGODS_SPELL.CanFocus then edtGODS_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空！');
  end;
  if Trim(edtNEW_OUTPRICE.Text)='' then
  begin
    if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
    raise Exception.Create('标准售价不能为空！');
  end;
  //判断: 标准售价  与  低售价
  if StrToFloatDef(edtNEW_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0) then
  begin
    if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
    raise Exception.Create(' 标准售价不能低于本店的最低售价！ ');
  end;
  //判断: 门店售价  与  低售价
  if StrToFloatDef(edtMY_OUTPRICE.Text,0)<StrToFloatDef(edtNEW_LOWPRICE.Text,0) then
  begin
    if edtMY_OUTPRICE.CanFocus then edtMY_OUTPRICE.SetFocus;
    raise Exception.Create(' 门店售价不能低于本店的最低售价！ ');
  end;
  {==  商品SORT_ID1..8  ==}
  if (SORT_ID1_KeyValue='') or (Trim(edtSORT_ID1.Text)='') then
  begin
    if edtSORT_ID1.CanFocus then edtSORT_ID1.SetFocus;
    raise Exception.Create('商品分类不能为空！');
  end;
  if Trim(edtSORT_ID2.KeyValue)='' then
  begin
    if edtSORT_ID2.CanFocus then edtSORT_ID2.SetFocus;
    raise Exception.Create('商品类别不能为空！');
  end;

  {
  if Trim(edtSORT_ID3.KeyValue)='' then
  begin
    if edtSORT_ID3.CanFocus then edtSORT_ID3.SetFocus;
    raise Exception.Create('商品主供应商不能为空！');
  end;
  }
  if Trim(edtSORT_ID4.KeyValue)='' then
  begin
    if edtSORT_ID4.CanFocus then edtSORT_ID4.SetFocus;
    raise Exception.Create('商品品牌不能为空！');
  end;
  if Trim(edtSORT_ID5.KeyValue)='' then
  begin
    if edtSORT_ID5.CanFocus then edtSORT_ID5.SetFocus;
    raise Exception.Create('商品是否重点品牌不能为空！');
  end;
  if Trim(edtSORT_ID6.KeyValue)='' then
  begin
    if edtSORT_ID6.CanFocus then edtSORT_ID6.SetFocus;
    raise Exception.Create('商品是否是省内外不能为空！');
  end;  
  if Trim(edtSORT_ID7.KeyValue)='' then
  begin
    if edtSORT_ID7.CanFocus then edtSORT_ID7.SetFocus;
    raise Exception.Create('商品颜色组不能为空！');
  end; 
  if Trim(edtSORT_ID8.KeyValue)='' then
  begin
    if edtSORT_ID8.CanFocus then edtSORT_ID8.SetFocus;
    raise Exception.Create('商品尺码组不能为空！');
  end;

  //积分换算关系
  if (RB_USING_BARTER.Checked) and (edtBARTER_INTEGRAL.Enabled) and (edtBARTER_INTEGRAL.Value=0)  then
  begin
    if edtBARTER_INTEGRAL.CanFocus then edtBARTER_INTEGRAL.SetFocus;
    raise Exception.Create('积分换算关系的不能为0！');
  end;

  if Trim(edtCALC_UNITS.AsString)='' then
  begin
    if edtCALC_UNITS.CanFocus then edtCALC_UNITS.SetFocus;
    raise Exception.Create('计量单位不能为空！');
  end;
  if (Trim(edtSMALL_UNITS.AsString)='') AND (Trim(edtBARCODE2.Text)<>'') then
  begin
     if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
     raise Exception.Create('小包装单位不能为空！');
  end;
  if (Trim(edtBIG_UNITS.AsString)='') AND (Trim(edtBARCODE3.Text)<>'') then
  begin
     if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
     raise Exception.Create('大包装单位不能为空！');
  end;
  if Trim(edtCALC_UNITS.AsString)=Trim(edtSMALL_UNITS.AsString) then
  begin
    if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
    raise Exception.Create('小包装单位不能和计量单位相同！');
  end;
  if Trim(edtCALC_UNITS.AsString)=Trim(edtBIG_UNITS.AsString) then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    raise Exception.Create('大包装单位不能和计量单位相同！');
  end;
  if (Trim(edtSMALL_UNITS.AsString)=Trim(edtBIG_UNITS.AsString)) and (Trim(edtSMALL_UNITS.AsString)<>'') then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    raise Exception.Create('大包装单位不能和小包装单位相同！');
  end;
  //小包装/大包装单位换算:
  if (Trim(edtSMALL_UNITS.AsString)<>'') and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
  begin
    if edtSMALLTO_CALC.CanFocus then   edtSMALLTO_CALC.SetFocus;
    raise Exception.Create('小包装单位的换算系数不能小于等于0!');
  end;
  if (Trim(edtBIG_UNITS.AsString)<>'') and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
  begin
    if edtBIGTO_CALC.CanFocus then   edtBIGTO_CALC.SetFocus;
    raise Exception.Create('大包装单位的换算系数不能小于等于0!');
  end;

  //2011.03.03 Add 检查设定为管理单位：单位ID和换算关系不能为空
  if (edtDefault1.Checked) and (trim(edtSMALL_UNITS.AsString)='') then
  begin
    if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
    Raise Exception.Create(' 小包装单位设为默认单位不能为空  '); 
  end;
  if (edtDefault1.Checked) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
  begin
    if edtSMALLTO_CALC.CanFocus then edtSMALLTO_CALC.SetFocus;
    raise Exception.Create('小包装单位的换算系数不能小于等于0!');
  end;
  //2011.03.03 Add 检查设定为管理单位：单位ID和换算关系不能为空
  if (edtDefault2.Checked) and (trim(edtBIG_UNITS.AsString)='') then
  begin
    if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
    Raise Exception.Create(' 大包装单位设为默认单位不能为空  '); 
  end;
  if (edtDefault2.Checked) and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
  begin
    if edtBIGTO_CALC.CanFocus then edtBIGTO_CALC.SetFocus;
    raise Exception.Create('大包装单位的换算系数不能小于等于0!');
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID2SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID2.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的商品类别是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
    if MessageBox(Handle,'没找到你想查找的“省内外”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    edtSORT_ID6.OnAddClick(nil);
    Exit;
  end;
end;

procedure TfrmGoodsInfo.edtSORT_ID8SaveValue(Sender: TObject);
begin
  inherited;
  if (edtSORT_ID8.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的“尺码组”，是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  if (Key=#161) or (Key='。') then Key:='.';
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
  if (Key=#161) or (Key='。') then Key:='.';
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
  if Key=#13 then
  begin
    //会车进行计算
    if trim(PriceGrid.Columns[PriceGrid.Col].FieldName)='PROFIT_RATE' then  //在折扣率列
      CALC_MenberProfitPrice(self.CdsMemberPrice,0)
    else if trim(PriceGrid.Columns[PriceGrid.Col].FieldName)='NEW_OUTPRICE' then  //在折扣率列
      CALC_MenberProfitPrice(self.CdsMemberPrice,1);
    if CdsMemberPrice.State<>dsEdit then CdsMemberPrice.Edit;
    CdsMemberPrice.Post;
    if PriceGrid.Col<PriceGrid.Columns.Count-1 then PriceGrid.Col:= PriceGrid.Col + 1; //跳下一列
  end else
    OnGridKeyPress(Sender,Key); 
end;

procedure TfrmGoodsInfo.edtCALC_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  PriceGrid.FieldColumns['NEW_OUTPRICE'].Visible:=(edtCALC_UNITS.KeyValue<>'');
  if edtCALC_UNITS.KeyValue<>'' then
  begin
    PriceGrid.FieldColumns['NEW_OUTPRICE'].Title.Caption:='计量单位('+edtCALC_UNITS.Text+')售价';
  end;
end;

procedure TfrmGoodsInfo.edtSMALL_UNITSPropertiesChange(Sender: TObject);
var
  i: integer;
begin
  inherited;
  PriceGrid.FieldColumns['NEW_OUTPRICE1'].Visible:=(edtSMALL_UNITS.KeyValue<>'');
  if edtSMALL_UNITS.Text<>'' then
  begin
    i:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE1');
    if (i>0) and (i<PriceGrid.Columns.Count-1) then
      PriceGrid.Columns[i].Title.Caption:='小包装('+edtSMALL_UNITS.Text+')售价';
  end;
end;

procedure TfrmGoodsInfo.edtBIG_UNITSPropertiesChange(Sender: TObject);
var
  i:integer;
begin
  inherited;
  PriceGrid.FieldColumns['NEW_OUTPRICE2'].Visible:=(edtBIG_UNITS.KeyValue<>'');
  if edtBIG_UNITS.Text<>'' then
  begin
    i:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE2');
    if (i>0) and (i<PriceGrid.Columns.Count-1) then
      PriceGrid.Columns[i].Title.Caption:='大包装('+edtBIG_UNITS.Text+')售价';
  end;
end;

// 启用物流跟踪号管制

procedure TfrmGoodsInfo.CheckTabGoodPriceVisible;
var
  Cal_UNit,Cal_UNi: Boolean;
  i: integer;
begin
  TabGoodPrice.TabVisible:=False;
  if edtUSING_PRICE.ItemIndex=1 then Exit; {==是否启用会员价==}
  if (trim(edtCALC_UNITS.Text)='') and (trim(edtSMALL_UNITS.Text)='') and (trim(edtBIG_UNITS.Text)='') then Exit;  //三个单位都同时为空情况;
  if StrtoFloatDef(edtNEW_OUTPRICE.Text,0)<=0 then Exit;
  TabGoodPrice.TabVisible:=true;
  //判断Columns的显示:
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
    case CALCType of  // 0:根据折扣率计算折扣价  1: 根据折扣价计算折扣率
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
  CheckTabGoodPriceVisible; //判断会员价格是否显示
end;

procedure TfrmGoodsInfo.edtCALC_UNITSExit(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible; //判断会员价格是否显示
end;

procedure TfrmGoodsInfo.edtBIG_UNITSExit(Sender: TObject);
begin
  inherited;
  CheckTabGoodPriceVisible; //判断会员价格是否显示
end;

procedure TfrmGoodsInfo.WriteMemberPrice(GODS_ID: String); //写如会员表
var
  tmp: TZQuery;
  CurObj: TRecord_;
  StrmData: TStream;
  NewOutPrice, PROFIT_RATE: Real;
begin
  if not CdsMemberPrice.Active then Exit;
  try
    tmp:=TZQuery.Create(nil);
    CurObj:=TRecord_.Create;
    StrmData:=TMemoryStream.Create;
    CdsMemberPrice.SaveToStream(StrmData);
    tmp.LoadFromStream(StrmData);
    if tmp.Active then
    begin
      //第一步: 先删除记录
      CdsMemberPrice.First;
      while not CdsMemberPrice.Eof do
      begin
        CdsMemberPrice.Delete;
      end;
      //第二步: 循环临时数据集[重新插入]
      tmp.First;
      while not tmp.Eof do
      begin
        CurObj.ReadFromDataSet(tmp);
        NewOutPrice:=StrToFloatDef(edtNEW_OUTPRICE.Text,0);
        PROFIT_RATE:=CurObj.fieldbyName('PROFIT_RATE').AsFloat*0.01;
        //循环临时数据集判断条件[数量大于0才插入]
        if (NewOutPrice>0) and (PROFIT_RATE>0) then
        begin
          CurObj.FieldByName('TENANT_ID').AsInteger:=shopGlobal.TENANT_ID;  //企业ID
          CurObj.FieldByName('SHOP_ID').AsString:=shopGlobal.SHOP_ID;       //门店ID
          CurObj.FieldByName('GODS_ID').AsString:=GODS_ID;                  //货物ID
          CurObj.FieldByName('PRICE_METHOD').AsString:='1';                 //定价方式
          if CurObj.fieldbyName('NEW_OUTPRICE').AsFloat<>0 then
            CurObj.FieldByName('NEW_OUTPRICE').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE,Deci);
          if (CurObj.fieldbyName('NEW_OUTPRICE1').AsFloat<>0) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)>0) then
            CurObj.FieldByName('NEW_OUTPRICE1').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE*(StrToFloatDef(edtSMALLTO_CALC.Text,0)),Deci);
          if (CurObj.fieldbyName('NEW_OUTPRICE2').AsFloat<>0) and (StrToFloatDef(edtBIG_UNITS.Text,0)>0) then
            CurObj.FieldByName('NEW_OUTPRICE2').AsFloat:=ConvertToFight(NewOutPrice*PROFIT_RATE*(StrToFloatDef(edtBIGTO_CALC.Text,0)),Deci);
          CdsMemberPrice.Append;
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
    if r>100 then MsgStr:='输入的折扣率不能大于100，无效';

    if VarIsNull(Value) then
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
       r := StrtoFloat(Text);
    if r>999999 then Raise Exception.Create('输入的数值不能100，无效');
  except
    on E:Exception do
      begin
        Text :='0';
        Value :='0';
        MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
        Exit;
      end;
  end;

  if VarIsNull(Value) then r:=0 else r:=Value;

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
  if (Key=#161) or (Key='。') then Key:='.';
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
  if not ((edtBIG_UNITS.AsString<>'') and (StrtoFloatDef(edtBIGTO_CALC.Text,0)>0)) then //不满足才提示
  begin
    if StrtoFloatDef(edtMY_OUTPRICE2.Text,0)>0 then
    begin
      edtMY_OUTPRICE2.Text:='';
      if trim(edtBIG_UNITS.Text)='' then
      begin
        edtBIG_UNITS.SetFocus;
        Raise Exception.Create('  请输入大单位！ ');
      end else
      begin
        edtBIGTO_CALC.SetFocus;
        Raise Exception.Create('  请输入大单位的换算比例！ ');
      end;
    end;
  end;
end;

procedure TfrmGoodsInfo.edtMY_OUTPRICE1Exit(Sender: TObject);
begin
  inherited;
  if not ((edtSMALL_UNITS.AsString<>'') and (StrtoFloatDef(edtSMALLTO_CALC.Text,0)>0)) then //不满足才提示
  begin
    if StrtoFloatDef(edtMY_OUTPRICE1.Text,0)>0 then
    begin
      edtMY_OUTPRICE1.Text:='';
      if trim(edtSMALL_UNITS.AsString)='' then
      begin
        edtSMALL_UNITS.SetFocus;
        Raise Exception.Create('  请输入小单位！ ');
      end else
      begin
        edtSMALLTO_CALC.SetFocus;
        Raise Exception.Create('  请输入小单位的换算比例！ ');
      end;
    end;
  end;

end;

procedure TfrmGoodsInfo.UpdateUNITSData;
var
  Rs: TZQuery;
begin
  if DropUNITS_Ds=nil then
  begin
    DropUNITS_Ds:=TZQuery.Create(self); //判断是否存在，不存在则增加
    edtCALC_UNITS.DataSet:=DropUNITS_Ds;
    edtSMALL_UNITS.DataSet:=DropUNITS_Ds;
    edtBIG_UNITS.DataSet:=DropUNITS_Ds;
  end;
  
  Rs:=Global.GetZQueryFromName('PUB_MEAUNITS');
  if (Rs<>nil) and (Rs.Active) then
  begin
    DropUNITS_Ds.Close;
    DropUNITS_Ds.Data:=Rs.Data;
    if DropUNITS_Ds.Active then
    begin
      DropUNITS_Ds.Filtered:=False;
      DropUNITS_Ds.Filter:=' RELATION_FLAG=''2'' ';
      DropUNITS_Ds.Filtered:=true;
    end;
  end;
end;

end.
