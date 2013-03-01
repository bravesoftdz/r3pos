unit ufrmInitGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory;

type
  TfrmInitGoods = class(TfrmWebDialogForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    btnNext: TRzBitBtn;
    btnPrev: TRzBitBtn;
    cdsGoods: TZQuery;
    cdsBarcode: TZQuery;
    cdsRelation: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
  private
    procedure getGoodsInfo;
  public
    { Public declarations }
  end;

implementation

uses uRspFactory,msxml;

{$R *.dfm}

procedure TfrmInitGoods.FormCreate(Sender: TObject);
var i: integer;
begin
  inherited;
  for i := 0 to rzPage.PageCount - 1 do
    begin
      rzPage.Pages[i].TabVisible := False;
    end;
  rzPage.ActivePageIndex := 0;
  btnPrev.Visible := False;
  btnNext.Visible := True;
end;

procedure TfrmInitGoods.btnNextClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 0 then
    begin
      getGoodsInfo;
      rzPage.ActivePageIndex := 1;
      btnPrev.Visible := True;
      btnNext.Visible := True;
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
    end;
end;

procedure TfrmInitGoods.getGoodsInfo;
var
  barcode:string;
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
  pubGoodsinfoResp:IXMLDOMNode;
  Params:TftParamList;
begin
  barcode := trim(edtInput.Text);
  if barcode = '' then Raise Exception.Create('«Î ‰»ÎÃı–Œ¬Î...');

{  doc := rspFactory.CreateRspXML;
  Node := doc.CreateElement('flag');
  Node.text := '1';
  rspFactory.FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.CreateElement('pubGoodsinfo');
  rspFactory.FindNode(doc,'body').appendChild(Node);

  Node := doc.CreateElement('barcode');
  Node.text := barcode;
  rspFactory.FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  doc := rspFactory.CreateXML(rspFactory.getGoodsInfo(inxml));
  rspFactory.CheckRecAck(doc);
}
  try
//    pubGoodsinfoResp := rspFactory.FindNode(doc,'body\pubGoodsinfo');
    Params := TftParamList.Create(nil);
    dataFactory.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger := 1;
      Params.ParamByName('RELATION_ID').AsInteger := 1;
      Params.ParamByName('SHOP_ID').AsString := '1';
      Params.ParamByName('GODS_ID').AsString := '1';
//      dataFactory.AddBatch(cdsGoods,'TGoodsInfo',Params);
//      dataFactory.AddBatch(cdsBarcode,'TPUB_BARCODE',Params);
      dataFactory.AddBatch(cdsRelation,'TGoodsRelation',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  except
    Raise;
  end;
{
    godsId := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsId');
    tenantId := rspFactory.GetNodeValue(pubGoodsinfoResp,'tenantId');
    relationId := rspFactory.GetNodeValue(pubGoodsinfoResp,'relationId');
    godsCode := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsCode');
    godsSpell := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsSpell');
    godsType := rspFactory.GetNodeValue(pubGoodsinfoResp,'godsType');
    sortId1 := rspFactory.GetNodeValue(pubGoodsinfoResp,'sortId1');
    unitId := rspFactory.GetNodeValue(pubGoodsinfoResp,'unitId');
    calcUnits := rspFactory.GetNodeValue(pubGoodsinfoResp,'calcUnits');
    barcode := rspFactory.GetNodeValue(pubGoodsinfoResp,'barcode');
    smallUnits := rspFactory.GetNodeValue(pubGoodsinfoResp,'smallUnits');
    smalltoCalc := rspFactory.GetNodeValue(pubGoodsinfoResp,'smalltoCalc');
    smallBarcode := rspFactory.GetNodeValue(pubGoodsinfoResp,'smallBarcode');
    bigUnits := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigUnits');
    bigtoCalc := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigtoCalc');
    bigBarcode := rspFactory.GetNodeValue(pubGoodsinfoResp,'bigBarcode');
    newInprice := rspFactory.GetNodeValue(pubGoodsinfoResp,'newInprice');
    newOutprice := rspFactory.GetNodeValue(pubGoodsinfoResp,'newOutprice');
    newLowprice := rspFactory.GetNodeValue(pubGoodsinfoResp,'newLowprice');
    usingPrice := rspFactory.GetNodeValue(pubGoodsinfoResp,'usingPrice');
    hasIntegral := rspFactory.GetNodeValue(pubGoodsinfoResp,'hasIntegral');
    usingBatchNo := rspFactory.GetNodeValue(pubGoodsinfoResp,'usingBatchNo');
    usingBarter := rspFactory.GetNodeValue(pubGoodsinfoResp,'usingBarter');
    usingLocusNo := rspFactory.GetNodeValue(pubGoodsinfoResp,'usingLocusNo');
    barterIntegral := rspFactory.GetNodeValue(pubGoodsinfoResp,'barterIntegral');
    remark := rspFactory.GetNodeValue(pubGoodsinfoResp,'remark');
}
end;

initialization
  RegisterClass(TfrmInitGoods);
finalization
  UnRegisterClass(TfrmInitGoods);
end.
