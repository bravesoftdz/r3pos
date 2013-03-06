unit ufrmInitGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel;

type
  TfrmInitGoods = class(TfrmWebDialogForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    cdsGoodsInfo: TZQuery;
    cdsSmallBarCode: TZQuery;
    cdsGoodsRelation: TZQuery;
    Label5: TLabel;
    edtBARCODE1: TcxTextEdit;
    Label11: TLabel;
    edtGODS_CODE: TcxTextEdit;
    Label3: TLabel;
    edtGODS_NAME: TcxTextEdit;
    Label30: TLabel;
    edtCALC_UNITS: TzrComboBoxList;
    Label8: TLabel;
    edtNEW_INPRICE: TcxTextEdit;
    Label10: TLabel;
    edtNEW_OUTPRICE: TcxTextEdit;
    lblSORT_ID1: TLabel;
    cdsBigBarCode: TZQuery;
    cdsBarCode: TZQuery;
    TabSheet3: TRzTabSheet;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    edtSMALL_UNITS: TzrComboBoxList;
    edtSMALLTO_CALC: TcxTextEdit;
    edtBARCODE2: TcxTextEdit;
    edtDefault1: TcxCheckBox;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    edtBIG_UNITS: TzrComboBoxList;
    edtBIGTO_CALC: TcxTextEdit;
    edtBARCODE3: TcxTextEdit;
    edtDefault2: TcxCheckBox;
    edtMoreUnits: TcxCheckBox;
    edtGOODS_OPTION1: TcxRadioButton;
    edtGOODS_OPTION2: TcxRadioButton;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    RzPanel6: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzPanel7: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzPanel5: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    btnNext: TRzBitBtn;
    btnPrev: TRzBitBtn;
    edtTable: TZQuery;
    edtSORT_ID: TcxButtonEdit;
    edtSORT_ID1: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtMoreUnitsPropertiesChange(Sender: TObject);
    procedure edtGOODS_OPTION1Click(Sender: TObject);
    procedure edtGOODS_OPTION2Click(Sender: TObject);
    procedure edtDefault1Click(Sender: TObject);
    procedure edtDefault2Click(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtSORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    procedure getGoodsInfo;
    procedure uploadGoodsInfo;
  public
    AObj:TRecord_;
    Finded:boolean;
    Simple:boolean;
    FY_RELATION_ID:string;
    FY_TENANT_ID:string;
    procedure ReadFromObject;
    procedure WriteToObject;
    procedure CheckInput1;
    procedure CheckInput2;
    procedure OpenDataSet(tenantId,godsId:string);
    procedure EditDataSet;
    procedure PostDataSet;
    procedure SetReadOnly;
    procedure CancelReadOnly;
    procedure Save;
    function  BarCodeSimpleInit(barcode:string):boolean;
  end;

implementation

uses uRspFactory,msxml,udllDsUtil,udllFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom;

const
  FY_CREATOR_ID = '110000002'; //非烟供应链创建者,允许修改商品分类

{$R *.dfm}

procedure TfrmInitGoods.FormCreate(Sender: TObject);
var
  i: integer;
  rs: TZQuery;
begin
  inherited;
  Finded := false;
  Simple := false;
  AObj := TRecord_.Create;

  FY_RELATION_ID := '';
  FY_TENANT_ID := '';

  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
    begin
      if (rs.FieldByName('RELATION_ID').AsInteger <> 1000006) and (rs.FieldByName('RELATION_TYPE').AsString = '1') then
        begin
          FY_RELATION_ID := rs.FieldByName('RELATION_ID').AsString;
          FY_TENANT_ID := rs.FieldByName('TENANT_ID').AsString;
          break;
        end;
      rs.Next;
    end;

  edtCALC_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  edtSMALL_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  edtBIG_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');

  for i := 0 to rzPage.PageCount - 1 do
    begin
      rzPage.Pages[i].TabVisible := False;
    end;
  rzPage.ActivePageIndex := 0;
  btnPrev.Visible := false;
  btnNext.Visible := true;
  edtDefault1.Checked := false;
  edtDefault2.Checked := false;

  if (FY_TENANT_ID = '') or (FY_RELATION_ID = '') then
    Raise Exception.Create('当前企业尚未加盟非烟供应链...');
end;

procedure TfrmInitGoods.btnNextClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 0 then
    begin
      Finded := false;
      edtSORT_ID.Text := '';
      edtDefault1.Checked := false;
      edtDefault2.Checked := false;
      if edtGOODS_OPTION1.Checked then
        begin
          getGoodsInfo;
          edtBARCODE1.Text := '';
          edtBARCODE2.Text := '';
          edtBARCODE3.Text := '';
          edtBARCODE1.Visible := true;
          edtBARCODE2.Visible := true;
          edtBARCODE3.Visible := true;
          Label5.Visible := true;
          Label9.Visible := true;
          Label16.Visible := true;
        end
      else
        begin
          OpenDataSet(token.tenantId, '');
          edtBARCODE1.Text := '自编条码...';
          edtBARCODE2.Text := '自编条码...';
          edtBARCODE3.Text := '自编条码...';
          edtBARCODE1.Visible := false;
          edtBARCODE2.Visible := false;
          edtBARCODE3.Visible := false;
          Label5.Visible := false;
          Label9.Visible := false;
          Label16.Visible := false;
        end;
      ReadFromObject;
      rzPage.ActivePageIndex := 1;
      btnPrev.Visible := True;
      btnNext.Visible := True;
      if edtGODS_CODE.CanFocus then edtGODS_CODE.SetFocus;
    end
  else if rzPage.ActivePageIndex = 1 then
    begin
      CheckInput1;
      if edtMoreUnits.Checked then
        begin
          rzPage.ActivePageIndex := 2;
          btnPrev.Visible := True;
          btnNext.Visible := True;
          btnNext.Caption := '完成';
        end
      else
        begin
          WriteToObject;
          if (not Finded) and (edtGOODS_OPTION1.Checked) then uploadGoodsInfo;
          Save;
          if not Simple then ShowMessage('商品保存成功...');
          rzPage.ActivePageIndex := 0;
          btnPrev.Visible := False;
          btnNext.Visible := True;
          btnNext.Caption := '下一步';
        end;
    end
  else if rzPage.ActivePageIndex = 2 then
    begin
      CheckInput2;
      WriteToObject;
      if (not Finded) and (edtGOODS_OPTION1.Checked) then uploadGoodsInfo;
      Save;
      if not Simple then ShowMessage('商品保存成功...');
      rzPage.ActivePageIndex := 0;
      btnPrev.Visible := False;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end;
end;

procedure TfrmInitGoods.btnPrevClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 1 then
    begin
      rzPage.ActivePageIndex := 0;
      btnPrev.Visible := False;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end
  else if rzPage.ActivePageIndex = 2 then
    begin
      rzPage.ActivePageIndex := 1;
      btnPrev.Visible := True;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end;
end;

procedure TfrmInitGoods.getGoodsInfo;
var
  barcode,godsId:string;
  outxml:widestring;
  doc:IXMLDomDocument;
  pubGoodsinfoResp:IXMLDOMNode;
  rs,hasGoods:TZQuery;
begin
  barcode := trim(edtInput.Text);
  if barcode = '' then Raise Exception.Create('请输入条形码...');
  Finded := false;
  godsId := '';

  hasGoods := TZQuery.Create(nil);
  try
    hasGoods.SQL.Text := 'select GODS_ID from PUB_BARCODE where COMM not in (''02'',''12'') and TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+') and BARCODE = '''+barcode+''' ';
    dataFactory.Open(hasGoods);
    if not hasGoods.IsEmpty then
      begin
        rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
        if rs.Locate('GODS_ID',hasGoods.FieldByName('GODS_ID').AsString,[]) then
          Raise Exception.Create('该条码已经存在于本地商品中...');
      end;
  finally
    hasGoods.Free;
  end;

  try
    outxml := rspFactory.getGoodsInfo(barcode);
    doc := rspFactory.CreateXML(outxml);
    pubGoodsinfoResp := rspFactory.FindNode(doc,'body\pubGoodsinfo');
    Finded := true;
    godsId := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId'); 
  except
    Finded := false;
    godsId := '';
  end;

  OpenDataSet(FY_TENANT_ID, godsId);

  if Finded then
    begin
      EditDataSet;

      cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'tenantId'));
      cdsGoodsInfo.FieldByName('GODS_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
      cdsGoodsInfo.FieldByName('GODS_CODE').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsCode');
      cdsGoodsInfo.FieldByName('GODS_NAME').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsName');
      cdsGoodsInfo.FieldByName('GODS_SPELL').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsSpell');
      cdsGoodsInfo.FieldByName('GODS_TYPE').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'godsType'));
      cdsGoodsInfo.FieldByName('SORT_ID1').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'sortId1');
      cdsGoodsInfo.FieldByName('UNIT_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'unitId');
      cdsGoodsInfo.FieldByName('CALC_UNITS').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'calcUnits');
      cdsGoodsInfo.FieldByName('BARCODE').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'barcode');
      cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'smallUnits');
      cdsGoodsInfo.FieldByName('SMALLTO_CALC').AsFloat := strtofloat(rspFactory.GetNodeValue(pubGoodsinfoResp,'smalltoCalc'));
      cdsGoodsInfo.FieldByName('BIG_UNITS').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigUnits');
      cdsGoodsInfo.FieldByName('BIGTO_CALC').AsFloat := strtofloat(rspFactory.GetNodeValue(pubGoodsinfoResp,'bigtoCalc'));
      cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat := strtofloat(rspFactory.GetNodeValue(pubGoodsinfoResp,'newInprice'));
      cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat := strtofloat(rspFactory.GetNodeValue(pubGoodsinfoResp,'newOutprice'));
      cdsGoodsInfo.FieldByName('NEW_LOWPRICE').AsFloat := strtofloat(rspFactory.GetNodeValue(pubGoodsinfoResp,'newLowprice'));
      cdsGoodsInfo.FieldByName('USING_PRICE').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'usingPrice'));
      cdsGoodsInfo.FieldByName('HAS_INTEGRAL').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'hasIntegral'));
      cdsGoodsInfo.FieldByName('USING_BATCH_NO').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'usingBatchNo'));
      cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'usingBarter'));
      cdsGoodsInfo.FieldByName('USING_LOCUS_NO').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'usingLocusNo'));
      cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'barterIntegral'));

      cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      cdsBarCode.FieldByName('TENANT_ID').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'tenantId'));
      cdsBarCode.FieldByName('GODS_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
      cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
      cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
      cdsBarCode.FieldByName('UNIT_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'calcUnits');
      cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '0';
      cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
      cdsBarCode.FieldByName('BARCODE').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'barcode');

      if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
        begin
          cdsSmallBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsSmallBarCode.FieldByName('TENANT_ID').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'tenantId'));
          cdsSmallBarCode.FieldByName('GODS_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
          cdsSmallBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsSmallBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsSmallBarCode.FieldByName('UNIT_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'smallUnits');
          cdsSmallBarCode.FieldByName('BARCODE_TYPE').AsString := '1';
          cdsSmallBarCode.FieldByName('BATCH_NO').AsString := '#';
          cdsSmallBarCode.FieldByName('BARCODE').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'smallBarcode');
        end;
      if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
        begin
          cdsBigBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsBigBarCode.FieldByName('TENANT_ID').AsInteger := strtoint(rspFactory.GetNodeValue(pubGoodsinfoResp,'tenantId'));
          cdsBigBarCode.FieldByName('GODS_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
          cdsBigBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsBigBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsBigBarCode.FieldByName('UNIT_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigUnits');
          cdsBigBarCode.FieldByName('BARCODE_TYPE').AsString := '2';
          cdsBigBarCode.FieldByName('BATCH_NO').AsString := '#';
          cdsBigBarCode.FieldByName('BARCODE').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigBarcode');
        end;

      cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      cdsGoodsRelation.FieldByName('GODS_ID').AsString := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
      cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
      cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;

      PostDataSet;

      edtTable.Data := cdsGoodsInfo.Data;
    end;
end;

procedure TfrmInitGoods.uploadGoodsInfo;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
begin
  doc := rspFactory.CreateRspXML;
  Node := doc.CreateElement('flag');
  Node.text := '1';
  rspFactory.FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.CreateElement('pubGoodsinfo');
  rspFactory.FindNode(doc,'body').appendChild(Node);

  Node := doc.CreateElement('tenantId');
  Node.text := cdsGoodsInfo.FieldByName('TENANT_ID').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('relationId');
  Node.text := FY_RELATION_ID;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('godsId');
  Node.text := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('godsCode');
  Node.text := cdsGoodsInfo.FieldByName('GODS_CODE').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('godsName');
  Node.text := cdsGoodsInfo.FieldByName('GODS_NAME').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('godsSpell');
  Node.text := cdsGoodsInfo.FieldByName('GODS_SPELL').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('godsType');
  Node.text := '1';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('sortId1');
  Node.text := cdsGoodsInfo.FieldByName('SORT_ID1').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('unitId');
  Node.text := cdsGoodsInfo.FieldByName('UNIT_ID').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('calcUnits');
  Node.text := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('barcode');
  Node.text := cdsGoodsInfo.FieldByName('BARCODE').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('newInprice');
  Node.text := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('newOutprice');
  Node.text := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsString;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
    begin
      Node := doc.CreateElement('smallUnits');
      Node.text := cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

      Node := doc.CreateElement('smalltoCalc');
      Node.text := cdsGoodsInfo.FieldByName('SMALLTO_CALC').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

      Node := doc.CreateElement('smallBarcode');
      Node.text := cdsSmallBarCode.FieldByName('BARCODE').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
    end;

  if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
    begin
      Node := doc.CreateElement('bigUnits');
      Node.text := cdsGoodsInfo.FieldByName('BIG_UNITS').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

      Node := doc.CreateElement('bigtoCalc');
      Node.text := cdsGoodsInfo.FieldByName('BIGTO_CALC').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

      Node := doc.CreateElement('bigBarcode');
      Node.text := cdsBigBarCode.FieldByName('BARCODE').AsString;
      rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
    end;
  
  Node := doc.CreateElement('usingPrice');
  Node.text := '1';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
  
  Node := doc.CreateElement('hasIntegral');
  Node.text := '1';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
  
  Node := doc.CreateElement('usingBatchNo');
  Node.text := '1';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
  
  Node := doc.CreateElement('usingBarter');
  Node.text := '1';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  Node := doc.CreateElement('usingLocusNo');
  Node.text := '2';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);
  
  Node := doc.CreateElement('barterIntegral');
  Node.text := '0';
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  try
    rspFactory.uploadGoods('<?xml version="1.0" encoding="gb2312"?>'+doc.xml)
  except
  end;
end;

procedure TfrmInitGoods.CheckInput1;
  procedure CheckGodsMaxPrice(edtPrice: TcxTextEdit;MsgInfo: string);
    begin
      if StrToFloatDef(edtPrice.Text,0) > 999999999 then
        begin
          if edtPrice.CanFocus then edtPrice.SetFocus;
          Raise Exception.Create('输入的〖'+MsgInfo+'〗数值过大，无效...');
        end;
    end;
begin
  if edtGOODS_OPTION1.Checked then //无条码商品不检测条形码
    begin
      if trim(edtBARCODE1.Text)='' then
        begin
          if edtBARCODE1.CanFocus then edtBARCODE1.SetFocus;
          Raise Exception.Create('条码不能为空，请输入！');
        end;
    end;

  if trim(edtGODS_CODE.Text)='' then
    begin
      if edtGODS_CODE.CanFocus then edtGODS_CODE.SetFocus;
      Raise Exception.Create('货号不能为空，请输入！');
    end;

  if Length(edtGODS_CODE.Text)>20 then edtGODS_CODE.Text:=Copy(edtGODS_CODE.Text,1,20);

  if trim(edtGODS_NAME.Text)='' then
    begin
      if edtGODS_NAME.CanFocus then edtGODS_NAME.SetFocus;
      Raise Exception.Create('商品名称不能为空！');
    end;

  if trim(edtCALC_UNITS.Text)='' then edtCALC_UNITS.KeyValue := null;

  if (trim(edtCALC_UNITS.AsString)='') or (trim(edtCALC_UNITS.Text)='') then
    begin
      if edtCALC_UNITS.CanFocus then edtCALC_UNITS.SetFocus;
      Raise Exception.Create('计量单位不能为空！');
    end;

  if trim(edtSORT_ID1.Text)='' then
    begin
      if edtSORT_ID.CanFocus then edtSORT_ID.SetFocus;
      Raise Exception.Create('商品分类不能为空！');
    end;

  if trim(edtNEW_INPRICE.Text)='' then
    begin
      if edtNEW_INPRICE.CanFocus then edtNEW_INPRICE.SetFocus;
      Raise Exception.Create('标准进价不能为空！');
    end;
  if trim(edtNEW_OUTPRICE.Text)='' then
    begin
      if edtNEW_OUTPRICE.CanFocus then edtNEW_OUTPRICE.SetFocus;
      Raise Exception.Create('标准售价不能为空！');
    end;
  CheckGodsMaxPrice(edtNEW_INPRICE,'标准进价');
  CheckGodsMaxPrice(edtNEW_OUTPRICE,'标准售价');
end;

procedure TfrmInitGoods.CheckInput2;
begin
  if trim(edtSMALL_UNITS.Text)='' then edtSMALL_UNITS.KeyValue := null;
  if trim(edtBIG_UNITS.Text)='' then edtBIG_UNITS.KeyValue := null;

  if edtGOODS_OPTION1.Checked then //无条码商品不检测条形码
    begin
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBARCODE2.Text)='') then
        begin
          if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
          Raise Exception.Create('小包装条码不能为空！');
        end;
      if (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)='') then
        begin
          if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
          Raise Exception.Create('大包装条码不能为空！');
        end;
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBARCODE2.Text)=trim(edtBARCODE1.Text)) then
        begin
          if edtBARCODE2.CanFocus then edtBARCODE2.SetFocus;
          Raise Exception.Create('小包装条码不能与计量单位条码相同！');
        end;
      if (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)=trim(edtBARCODE1.Text)) then
        begin
          if edtBARCODE3.CanFocus then edtBARCODE3.SetFocus;
          Raise Exception.Create('大包装条码不能与计量单位条码相同！');
        end;
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)=trim(edtBARCODE1.Text)) then
        begin
          if edtBARCODE3.CanFocus then edtBARCODE3.SetFocus;
          Raise Exception.Create('大包装条码不能与小包装条码相同！');
        end;
    end;
  
  if (trim(edtSMALL_UNITS.AsString)<>'') and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
    begin
      if edtSMALLTO_CALC.CanFocus then edtSMALLTO_CALC.SetFocus;
      Raise Exception.Create('小包装单位的换算系数不能小于等于0!');
    end;
  if (trim(edtBIG_UNITS.AsString)<>'') and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
    begin
      if edtBIGTO_CALC.CanFocus then   edtBIGTO_CALC.SetFocus;
      Raise Exception.Create('大包装单位的换算系数不能小于等于0!');
    end;

  if trim(edtCALC_UNITS.AsString)=trim(edtSMALL_UNITS.AsString) then
    begin
      if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
      Raise Exception.Create('小包装单位不能和计量单位相同！');
    end;
  if trim(edtCALC_UNITS.AsString)=trim(edtBIG_UNITS.AsString) then
    begin
      if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位不能和计量单位相同！');
    end;
  if (trim(edtSMALL_UNITS.AsString)=trim(edtBIG_UNITS.AsString)) and (trim(edtSMALL_UNITS.AsString)<>'') then
    begin
      if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位不能和小包装单位相同！');
    end;

  if (edtDefault1.Checked) and (trim(edtSMALL_UNITS.AsString)='') then
    begin
      if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus;
      Raise Exception.Create('小包装单位设为默认单位不能为空');
    end;
  if (edtDefault1.Checked) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
    begin
      if edtSMALLTO_CALC.CanFocus then edtSMALLTO_CALC.SetFocus;
      Raise Exception.Create('小包装单位的换算系数不能小于等于0!');
    end;
  if (edtDefault2.Checked) and (trim(edtBIG_UNITS.AsString)='') then
    begin
      if edtBIG_UNITS.CanFocus then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位设为默认单位不能为空');
    end;
  if (edtDefault2.Checked) and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
    begin
      if edtBIGTO_CALC.CanFocus then edtBIGTO_CALC.SetFocus;
      Raise Exception.Create('大包装单位的换算系数不能小于等于0!');
    end;
end;

procedure TfrmInitGoods.ReadFromObject;
var rs: TZQuery;
begin
  AObj.ReadFromDataSet(cdsGoodsInfo);
  udllShopUtil.ReadFromObject(AObj,self);
  edtBARCODE1.Text := cdsBarCode.FieldByName('BARCODE').AsString;

  if edtGOODS_OPTION1.Checked and (edtBARCODE1.Text = '') then
    edtBARCODE1.Text := edtInput.Text;
  if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
    edtBARCODE2.Text := cdsSmallBarCode.FieldByName('BARCODE').AsString;
  if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
    edtBARCODE3.Text := cdsBigBarCode.FieldByName('BARCODE').AsString;

  if (cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '') and
     (cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString) then
    edtDefault1.Checked := true
  else
  if (cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '') and
     (cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('BIG_UNITS').AsString) then
    edtDefault2.Checked := true;

  if Finded then
    begin
      SetReadOnly;
      // 非烟供应链允许修改商品分类
      if cdsGoodsInfo.FieldByName('TENANT_ID').AsString <> FY_CREATOR_ID then
        begin
          rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
          if rs.Locate('SORT_ID',cdsGoodsInfo.FieldByName('SORT_ID1').AsString,[]) then
            edtSORT_ID.Text := rs.FieldByName('SORT_NAME').AsString;
          edtSORT_ID.Properties.ReadOnly := true;
          SetEditStyle(dsBrowse, edtSORT_ID.Style);
        end
      else
        begin
          edtSORT_ID1.Text := '';
          edtSORT_ID.Properties.ReadOnly := false;
          SetEditStyle(dsInsert, edtSORT_ID.Style);
        end;

      if (cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '') or (cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '') then
        begin
          edtMoreUnits.Checked := true;
          btnNext.Caption := '下一步';
        end
      else
        begin
          edtMoreUnits.Checked := false;
          btnNext.Caption := '完成';
        end;
    end
  else
    begin
      CancelReadOnly;
      edtMoreUnits.Checked := false;
      btnNext.Caption := '完成';
      edtSORT_ID1.Text := '';
      edtSORT_ID.Properties.ReadOnly := false;
      SetEditStyle(dsInsert, edtSORT_ID.Style);
    end;
end;

procedure TfrmInitGoods.WriteToObject;
begin
  if not edtMoreUnits.Checked then
    begin
      edtSMALL_UNITS.KeyValue := null;
      edtBIG_UNITS.KeyValue := null;
    end;

  udllShopUtil.WriteToObject(AObj,self);
  AObj.FieldByName('BARCODE').AsString := edtBARCODE1.Text;
  AObj.WriteToDataSet(cdsGoodsInfo);
  EditDataSet;

  if not Finded then
    begin
      if edtGOODS_OPTION1.Checked then //供应链商品
        begin
          cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := strtoint(FY_TENANT_ID);
          cdsGoodsInfo.FieldByName('BARCODE').AsString := edtBARCODE1.Text;
        end
      else //无条码商品,自编条码
        begin
          cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          cdsGoodsInfo.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
        end;
      cdsGoodsInfo.FieldByName('GODS_ID').AsString := TSequence.NewId;
      cdsGoodsInfo.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(edtGODS_NAME.Text,3);
      cdsGoodsInfo.FieldByName('GODS_TYPE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_PRICE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('HAS_INTEGRAL').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_BATCH_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_LOCUS_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger := 0;

      cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      cdsBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
      cdsBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
      cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
      cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
      cdsBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
      cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '0';
      cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
      cdsBarCode.FieldByName('BARCODE').AsString := cdsGoodsInfo.FieldByName('BARCODE').AsString;

      if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
        begin
          cdsSmallBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsSmallBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          cdsSmallBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsSmallBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsSmallBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsSmallBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString;
          cdsSmallBarCode.FieldByName('BARCODE_TYPE').AsString := '1';
          cdsSmallBarCode.FieldByName('BATCH_NO').AsString := '#';
          if edtGOODS_OPTION1.Checked then //供应链商品
            cdsSmallBarCode.FieldByName('BARCODE').AsString := edtBARCODE2.Text
          else //无条码商品,自编条码
            cdsSmallBarCode.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
        end;
      if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
        begin
          cdsBigBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsBigBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          cdsBigBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsBigBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsBigBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsBigBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('BIG_UNITS').AsString;
          cdsBigBarCode.FieldByName('BARCODE_TYPE').AsString := '2';
          cdsBigBarCode.FieldByName('BATCH_NO').AsString := '#';
          if edtGOODS_OPTION1.Checked then //供应链商品
            cdsBigBarCode.FieldByName('BARCODE').AsString := edtBARCODE3.Text
          else //无条码商品,自编条码
            cdsBigBarCode.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
        end;

      if edtGOODS_OPTION1.Checked then //供应链商品
        begin
          cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          cdsGoodsRelation.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
          cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;
        end;

      // 管理单位
      if edtMoreUnits.Checked and edtDefault1.Checked then
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtSMALL_UNITS.AsString
      else if edtMoreUnits.Checked and edtDefault2.Checked then
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtBIG_UNITS.AsString
      else
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtCALC_UNITS.AsString;
    end;

  if edtGOODS_OPTION1.Checked then //供应链商品
    begin
      cdsGoodsRelation.FieldByName('GODS_CODE').AsString := cdsGoodsInfo.FieldByName('GODS_CODE').AsString;
      cdsGoodsRelation.FieldByName('GODS_NAME').AsString := cdsGoodsInfo.FieldByName('GODS_NAME').AsString;
      cdsGoodsRelation.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(cdsGoodsRelation.FieldByName('GODS_NAME').AsString,3);
      if Finded then
        cdsGoodsRelation.FieldByName('SORT_ID1').AsString := cdsGoodsInfo.FieldByName('SORT_ID1').AsString
      else
        cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
      cdsGoodsRelation.FieldByName('NEW_INPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat;
    end;

  // 多包装条码
  if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString = '' then
    cdsSmallBarCode.Delete;
  if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString = '' then
    cdsBigBarCode.Delete;

  PostDataSet;

  if Finded then cdsGoodsInfo.Data := edtTable.Data;
end;

procedure TfrmInitGoods.OpenDataSet(tenantId,godsId:string);
var
  Params: TftParamList;
begin
  Params := TftParamList.Create(nil);
  cdsGoodsInfo.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    dataFactory.Open(cdsGoodsInfo,'TGoodsInfoV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsBarCode.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('BARCODE_TYPE').AsString := '0';
    dataFactory.Open(cdsBarCode,'TBarCodeV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsSmallBarCode.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('BARCODE_TYPE').AsString := '1';
    dataFactory.Open(cdsSmallBarCode,'TBarCodeV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsBigBarCode.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('BARCODE_TYPE').AsString := '2';
    dataFactory.Open(cdsBigBarCode,'TBarCodeV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsGoodsRelation.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
    dataFactory.Open(cdsGoodsRelation,'TGoodsRelationV60',Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmInitGoods.Save;
var
  tmpGoodsInfo,tmpBarCode,tmpSmallBarCode,tmpBigBarCode,tmpGoodsRelation: TZQuery;
  Params: TftParamList;
  tmpObj: TRecord_;
begin
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',nil);
    dataFactory.AddBatch(cdsBarCode,'TBarCodeV60',nil);
    dataFactory.AddBatch(cdsSmallBarCode,'TBarCodeV60',nil);
    dataFactory.AddBatch(cdsBigBarCode,'TBarCodeV60',nil);
    if edtGOODS_OPTION1.Checked then //供应链商品
      dataFactory.AddBatch(cdsGoodsRelation,'TGoodsRelationV60',nil);
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    Raise;
  end;

  Finded := false;
  edtInput.Text := '';

  // 本地保存
  if dataFactory.iDbType <> 5 then
    begin
      tmpGoodsInfo := TZQuery.Create(nil);
      tmpBarCode := TZQuery.Create(nil);
      tmpSmallBarCode := TZQuery.Create(nil);
      tmpBigBarCode := TZQuery.Create(nil);
      tmpGoodsRelation := TZQuery.Create(nil);
      dataFactory.MoveToSqlite;
      try
        Params := TftParamList.Create(nil);
        tmpGoodsInfo.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          dataFactory.Open(tmpGoodsInfo,'TGoodsInfoV60',Params);
        finally
          Params.Free;
        end;

        Params := TftParamList.Create(nil);
        tmpBarCode.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsBarCode.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsBarCode.FieldByName('GODS_ID').AsString;
          Params.ParamByName('BARCODE_TYPE').AsString := cdsBarCode.FieldByName('BARCODE_TYPE').AsString;
          dataFactory.Open(tmpBarCode,'TBarCodeV60',Params);
        finally
          Params.Free;
        end;

        Params := TftParamList.Create(nil);
        tmpSmallBarCode.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsSmallBarCode.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsSmallBarCode.FieldByName('GODS_ID').AsString;
          Params.ParamByName('BARCODE_TYPE').AsString := cdsSmallBarCode.FieldByName('BARCODE_TYPE').AsString;
          dataFactory.Open(tmpSmallBarCode,'TBarCodeV60',Params);
        finally
          Params.Free;
        end;

        Params := TftParamList.Create(nil);
        tmpBigBarCode.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsBigBarCode.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsBigBarCode.FieldByName('GODS_ID').AsString;
          Params.ParamByName('BARCODE_TYPE').AsString := cdsBigBarCode.FieldByName('BARCODE_TYPE').AsString;
          dataFactory.Open(tmpBigBarCode,'TBarCodeV60',Params);
        finally
          Params.Free;
        end;

        Params := TftParamList.Create(nil);
        tmpGoodsRelation.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsGoodsRelation.FieldByName('GODS_ID').AsString;
          Params.ParamByName('RELATION_ID').AsInteger := cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger;
          dataFactory.Open(tmpGoodsRelation,'TGoodsRelationV60',Params);
        finally
          Params.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if tmpGoodsInfo.IsEmpty then tmpGoodsInfo.Append
          else tmpGoodsInfo.Edit;
          tmpObj.ReadFromDataSet(cdsGoodsInfo);
          tmpObj.WriteToDataSet(tmpGoodsInfo, false);
        finally
          tmpObj.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if tmpBarCode.IsEmpty then tmpBarCode.Append
          else tmpBarCode.Edit;
          tmpObj.ReadFromDataSet(cdsBarCode);
          tmpObj.WriteToDataSet(tmpBarCode, false);
        finally
          tmpObj.Free;
        end;

        if tmpSmallBarCode.IsEmpty then tmpSmallBarCode.Append
        else tmpSmallBarCode.Edit;

        if cdsSmallBarCode.IsEmpty then
          tmpSmallBarCode.Delete
        else
          begin
            tmpObj := TRecord_.Create;
            try
              tmpObj.ReadFromDataSet(cdsSmallBarCode);
              tmpObj.WriteToDataSet(tmpSmallBarCode, false);
            finally
              tmpObj.Free;
            end;
          end;

        if tmpBigBarCode.IsEmpty then tmpBigBarCode.Append
        else tmpBigBarCode.Edit;

        if cdsBigBarCode.IsEmpty then
          tmpBigBarCode.Delete
        else
          begin
            tmpObj := TRecord_.Create;
            try
              tmpObj.ReadFromDataSet(cdsBigBarCode);
              tmpObj.WriteToDataSet(tmpBigBarCode, false);
            finally
              tmpObj.Free;
            end;
          end;

        tmpObj := TRecord_.Create;
        try
          if tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Append
          else tmpGoodsRelation.Edit;
          tmpObj.ReadFromDataSet(cdsGoodsRelation);
          tmpObj.WriteToDataSet(tmpGoodsRelation, false);
        finally
          tmpObj.Free;
        end;

        if tmpGoodsInfo.State in [dsEdit,dsInsert] then
          tmpGoodsInfo.Post;
        if tmpBarCode.State in [dsEdit,dsInsert] then
          tmpBarCode.Post;
        if tmpSmallBarCode.State in [dsEdit,dsInsert] then
          tmpSmallBarCode.Post;
        if tmpBigBarCode.State in [dsEdit,dsInsert] then
          tmpBigBarCode.Post;
        if tmpGoodsRelation.State in [dsEdit,dsInsert] then
          tmpGoodsRelation.Post;

        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
          dataFactory.AddBatch(tmpBarCode,'TBarCodeV60',nil);
          dataFactory.AddBatch(tmpSmallBarCode,'TBarCodeV60',nil);
          dataFactory.AddBatch(tmpBigBarCode,'TBarCodeV60',nil);
          if edtGOODS_OPTION1.Checked then //供应链商品
            dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',nil);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
        tmpGoodsInfo.Free;
        tmpBarCode.Free;
        tmpSmallBarCode.Free;
        tmpBigBarCode.Free;
        tmpGoodsRelation.Free;
      end;
    end;
  dllGlobal.GetZQueryFromName('PUB_GOODSINFO').Close;
end;

procedure TfrmInitGoods.EditDataSet;
begin
  if not (cdsGoodsInfo.State in [dsEdit,dsInsert]) then
    begin
      if cdsGoodsInfo.IsEmpty then cdsGoodsInfo.Append
      else cdsGoodsInfo.Edit;
    end;
  if not (cdsBarCode.State in [dsEdit,dsInsert]) then
    begin
      if cdsBarCode.IsEmpty then cdsBarCode.Append
      else cdsBarCode.Edit;
    end;
  if not (cdsSmallBarCode.State in [dsEdit,dsInsert]) then
    begin
      if cdsSmallBarCode.IsEmpty then cdsSmallBarCode.Append
      else cdsSmallBarCode.Edit;
    end;
  if not (cdsBigBarCode.State in [dsEdit,dsInsert]) then
    begin
      if cdsBigBarCode.IsEmpty then cdsBigBarCode.Append
      else cdsBigBarCode.Edit;
    end;
  if not (cdsGoodsRelation.State in [dsEdit,dsInsert]) then
    begin
      if cdsGoodsRelation.IsEmpty then cdsGoodsRelation.Append
      else cdsGoodsRelation.Edit;
    end;
end;

procedure TfrmInitGoods.PostDataSet;
begin
  if cdsGoodsInfo.State in [dsEdit,dsInsert] then
    begin
      cdsGoodsInfo.Post;
    end;
  if cdsBarCode.State in [dsEdit,dsInsert] then
    begin
      cdsBarCode.Post;
    end;
  if cdsSmallBarCode.State in [dsEdit,dsInsert] then
    begin
      cdsSmallBarCode.Post;
    end;
  if cdsBigBarCode.State in [dsEdit,dsInsert] then
    begin
      cdsBigBarCode.Post;
    end;
  if cdsGoodsRelation.State in [dsEdit,dsInsert] then
    begin
      cdsGoodsRelation.Post;
    end;
end;

procedure TfrmInitGoods.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmInitGoods.edtMoreUnitsPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtMoreUnits.Checked then
    btnNext.Caption := '下一步'
  else
    btnNext.Caption := '完成';
end;

procedure TfrmInitGoods.edtGOODS_OPTION1Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION2.Checked := false;
  lblInput.Visible := true;
  edtInput.Visible := true;
end;

procedure TfrmInitGoods.edtGOODS_OPTION2Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION1.Checked := false;
  lblInput.Visible := false;
  edtInput.Visible := false;
end;

procedure TfrmInitGoods.edtDefault1Click(Sender: TObject);
begin
  inherited;
  if (edtDefault1.Checked) and (edtDefault2.Checked) then
    edtDefault2.Checked := false;
end;

procedure TfrmInitGoods.edtDefault2Click(Sender: TObject);
begin
  inherited;
  if (edtDefault2.Checked) and (edtDefault1.Checked) then
    edtDefault1.Checked := false;
end;

procedure TfrmInitGoods.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    if btnNext.Visible then btnNext.Click;
end;

procedure TfrmInitGoods.SetReadOnly;
begin
  edtBARCODE1.Properties.ReadOnly := true;
  edtCALC_UNITS.Properties.ReadOnly := true;
  edtSMALL_UNITS.Properties.ReadOnly := true;
  edtBARCODE2.Properties.ReadOnly := true;
  edtSMALLTO_CALC.Properties.ReadOnly := true;
  edtDEFAULT1.Properties.ReadOnly := true;
  edtBIG_UNITS.Properties.ReadOnly := true;
  edtBARCODE3.Properties.ReadOnly := true;
  edtBIGTO_CALC.Properties.ReadOnly := true;
  edtDEFAULT2.Properties.ReadOnly := true;
  edtMoreUnits.Properties.ReadOnly := true;

  SetEditStyle(dsBrowse, edtBARCODE1.Style);
  SetEditStyle(dsBrowse, edtCALC_UNITS.Style);
  SetEditStyle(dsBrowse, edtSMALL_UNITS.Style);
  SetEditStyle(dsBrowse, edtBARCODE2.Style);
  SetEditStyle(dsBrowse, edtSMALLTO_CALC.Style);
  SetEditStyle(dsBrowse, edtBIG_UNITS.Style);
  SetEditStyle(dsBrowse, edtBARCODE3.Style);
  SetEditStyle(dsBrowse, edtBIGTO_CALC.Style);
end;

procedure TfrmInitGoods.CancelReadOnly;
begin
  edtBARCODE1.Properties.ReadOnly := false;
  edtCALC_UNITS.Properties.ReadOnly := false;
  edtSMALL_UNITS.Properties.ReadOnly := false;
  edtBARCODE2.Properties.ReadOnly := false;
  edtSMALLTO_CALC.Properties.ReadOnly := false;
  edtDEFAULT1.Properties.ReadOnly := false;
  edtBIG_UNITS.Properties.ReadOnly := false;
  edtBARCODE3.Properties.ReadOnly := false;
  edtBIGTO_CALC.Properties.ReadOnly := false;
  edtDEFAULT2.Properties.ReadOnly := false;
  edtMoreUnits.Properties.ReadOnly := false;
  
  SetEditStyle(dsInsert, edtBARCODE1.Style);
  SetEditStyle(dsInsert, edtCALC_UNITS.Style);
  SetEditStyle(dsInsert, edtSMALL_UNITS.Style);
  SetEditStyle(dsInsert, edtBARCODE2.Style);
  SetEditStyle(dsInsert, edtSMALLTO_CALC.Style);
  SetEditStyle(dsInsert, edtBIG_UNITS.Style);
  SetEditStyle(dsInsert, edtBARCODE3.Style);
  SetEditStyle(dsInsert, edtBIGTO_CALC.Style);
end;

function TfrmInitGoods.BarCodeSimpleInit(barcode:string):boolean;
begin
  result := false;
  Simple := true;
  edtGOODS_OPTION1.Checked := true;
  edtInput.Text := barcode;
  btnNext.Click;
  if Finded then
    begin
      btnNext.Click;
      if edtMoreUnits.Checked then
        begin
          btnNext.Click;
        end;
    end;
  Simple := false;
  result := true;
end;

procedure TfrmInitGoods.edtSORT_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  if edtSORT_ID.Properties.ReadOnly then Exit;
  Obj := TRecord_.Create;
  try
    if edtGOODS_OPTION1.Checked and (not Finded) then
      begin
        frmSortDropFrom.RelationId := FY_RELATION_ID;
        if frmSortDropFrom.DropForm(edtSORT_ID, Obj) then
          begin
            edtSORT_ID1.Text := Obj.FieldbyName('SORT_ID').AsString;
            edtSORT_ID.Text := Obj.FieldbyName('SORT_NAME').AsString;
          end;
      end
    else
      begin
        if frmSortDropFrom.DropForm(edtSORT_ID, Obj) then
          begin
            edtSORT_ID1.Text := Obj.FieldbyName('SORT_ID').AsString;
            edtSORT_ID.Text := Obj.FieldbyName('SORT_NAME').AsString;
          end;
      end;
  finally
    Obj.Free;
  end;
end;

initialization
  RegisterClass(TfrmInitGoods);
finalization
  UnRegisterClass(TfrmInitGoods);
end.
