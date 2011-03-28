unit ufrmBarCodePrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, RzButton, Grids, DBGridEh, ExtCtrls, StdCtrls,
  ActnList, Menus, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, DB, ADODB, FR_DSet, FR_Class, FR_BarC,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmBarCodePrint = class(TfrmBasic)
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    BtnPrint: TRzBitBtn;
    RzPrintFormatSet: TRzBitBtn;
    RzClose: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    dsPrint: TDataSource;
    frBarCodeObj: TfrBarCodeObject;
    frMasterDs: TfrUserDataset;
    frBarCodeRpt13: TfrReport;
    RzBitBtn1: TRzBitBtn;
    Image3: TImage;
    adoPrint: TZQuery;
    adoPrintTemp: TZQuery;
    procedure RzCloseClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RzPrintFormatSetClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure frBarCodeRpt13UserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure frMasterDsCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frMasterDsNext(Sender: TObject);
    procedure frMasterDsPrior(Sender: TObject);
    procedure frBarCodeRpt13GetValue(const ParName: String;
      var ParValue: Variant);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FaGodsID: String;
    FBarCodeBit: String;
    FaSizeGrp: String;
    FaColorGrp: String;
    FRefreshed: Boolean;
    vBarCodeLen:Integer;
    procedure SetPrintFormat;
    procedure IntPrintInfo;

    procedure SetaGodsID(const Value: String);
    procedure SetaColorGrp(const Value: String);
    procedure SetaSizeGrp(const Value: String);
    procedure SetRefreshed(const Value: Boolean);
  public
    procedure LoadBarCodeInfo(ID: String);
    { Public declarations }
    property aGodsID: String read FaGodsID write SetaGodsID;
    property aSizeGrp: String read FaSizeGrp write SetaSizeGrp;
    property aColorGrp: String read FaColorGrp write SetaColorGrp;
    property Refreshed:Boolean read FRefreshed write SetRefreshed;
  end;

implementation

uses uFnUtil,uShopUtil,uShopGlobal,uDsUtil, ufrmFastReport, ufrmDesinger, uGlobal;

{$R *.dfm}

procedure TfrmBarCodePrint.RzCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBarCodePrint.N1Click(Sender: TObject);
var
  n: Integer;
begin
  inherited;
  //全选
  n := adoPrint.RecNo;
  adoPrint.DisableControls;
  try
    adoPrint.First;
    while not adoPrint.Eof do
    begin
      adoPrint.Edit;
      adoPrint.FieldByName('A').AsBoolean := True;
      adoPrint.Post;
      adoPrint.Next;
    end;
  finally
    if n > 0 then adoPrint.RecNo := n;
    adoPrint.EnableControls;
  end;
end;

procedure TfrmBarCodePrint.N2Click(Sender: TObject);
var
  n: Integer;
begin
  inherited;
  //反选
  n := adoPrint.RecNo;
  adoPrint.DisableControls;
  try
    adoPrint.First;
    while not adoPrint.Eof do
    begin
      adoPrint.Edit;
      adoPrint.FieldByName('A').AsBoolean := (not adoPrint.FieldByName('A').AsBoolean);
      adoPrint.Post;
      adoPrint.Next;
    end;
  finally
    if n > 0 then adoPrint.RecNo := n;
    adoPrint.EnableControls;
  end;
end;

procedure TfrmBarCodePrint.N3Click(Sender: TObject);
var
  n: Integer;
begin
  inherited;
  //不选
  n := adoPrint.RecNo;
  adoPrint.DisableControls;
  try
    adoPrint.First;
    while not adoPrint.Eof do
    begin
      adoPrint.Edit;
      adoPrint.FieldByName('A').AsBoolean := False;
      adoPrint.Post;
      adoPrint.Next;
    end;
  finally
    if n > 0 then adoPrint.RecNo := n;
    adoPrint.EnableControls;
  end;
end;

procedure TfrmBarCodePrint.SetaGodsID(const Value: String);
begin
  FaGodsID := Value;
end;

procedure TfrmBarCodePrint.LoadBarCodeInfo(ID: String);
var
  QTemp: TZQuery;
begin
  adoPrint.Close;
  adoPrint.CreateDataSet;
  QTemp := TZQuery.Create(nil);
  try
    QTemp.Close;
    QTemp.SQL.Text :=
         'select distinct A.GODS_ID,B.GODS_NAME,B.GODS_CODE,A.PROPERTY_01,A.PROPERTY_02,A.BARCODE,B.NEW_OUTPRICE,B.NEW_OUTPRICE1,B.NEW_OUTPRICE2,B.NEW_LOWPRICE '+
         ' from PUB_BARCODE A,VIW_GOODSPRICE B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.= and A.GODS_ID='''+ID+''' and B.SHOP_ID='''+Global.SHOP_ID+'''';
    Factor.Open(QTemp);
    if QTemp.RecordCount = 0 then
    begin
      QTemp.Close;
      QTemp.SQL.Text :=
         'select distinct A.GODS_ID,B.GODS_NAME,B.GODS_CODE,A.PROPERTY_01,A.PROPERTY_02,'' as BARCODE,B.NEW_OUTPRICE,B.NEW_OUTPRICE1,B.NEW_OUTPRICE2,B.NEW_LOWPRICE '+
         ' from STO_STORAGE A,VIW_GOODSPRICE B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.GODS_ID='''+ID+''' and B.SHOP_ID='''+Global.SHOP_ID+'''';
      Factor.Open(QTemp);
    end;
    adoPrint.First;
    while not adoPrint.Eof do adoPrint.Delete;
    QTemp.First;
    while not QTemp.Eof do
      begin
        adoPrint.Append;
        adoPrint.FieldByName('A').AsBoolean := False;
        adoPrint.FieldByName('GODS_ID').AsString := QTemp.FieldByName('GODS_ID').AsString;
        //adoPrint.FieldByName('BCODE').AsString := QTemp.FieldByName('BCODE').AsString;
        adoPrint.FieldByName('GODS_CODE').AsString := QTemp.FieldByName('GODS_CODE').AsString;
        adoPrint.FieldByName('GODS_NAME').AsString := QTemp.FieldByName('GODS_NAME').AsString;
        adoPrint.FieldByName('PROPERTY_01').AsString := QTemp.FieldByName('PROPERTY_01').AsString;
        adoPrint.FieldByName('PROPERTY_02').AsString := QTemp.FieldByName('PROPERTY_02').AsString;
        //
        if (QTemp.FieldByName('BARCODE').AsString<>'') and not fnString.IsCustBarCode(QTemp.FieldByName('BARCODE').AsString) then
           adoPrint.FieldByName('BARCODE').AsString := QTemp.FieldByName('BARCODE').AsString
        else
           adoPrint.FieldByName('BARCODE').AsString := GetBarCode(QTemp.FieldByName('GODS_CODE').AsString,QTemp.FieldByName('PROPERTY_01').AsString,QTemp.FieldByName('PROPERTY_02').AsString);
        //
        adoPrint.FieldByName('NEW_OUTPRICE').AsString := QTemp.FieldByName('NEW_OUTPRICE').AsString;
        adoPrint.FieldByName('NEW_OUTPRICE1').AsString := QTemp.FieldByName('NEW_OUTPRICE1').AsString;
        adoPrint.FieldByName('NEW_OUTPRICE2').AsString := QTemp.FieldByName('NEW_OUTPRICE2').AsString;
        adoPrint.FieldByName('NEW_LOWPRICE').AsString := QTemp.FieldByName('NEW_LOWPRICE').AsString;

        adoPrint.FieldByName('AMOUNT').AsString := '1';
        adoPrint.Post;
      QTemp.Next;
    end;
    //
  finally
    QTemp.Free;
  end;
end;

procedure TfrmBarCodePrint.SetPrintFormat;
var
  frmDesinger:TfrmDesigner;
begin
  inherited;
  frmDesinger := TfrmDesigner.Create(Self);
  try
    frmDesinger.Form := Self;
    frmDesinger.ShowExecute(frBarCodeRpt13,'');
  finally
    frmDesinger.Free;
  end;
end;

procedure TfrmBarCodePrint.SetaColorGrp(const Value: String);
begin
  FaColorGrp := Value;
end;

procedure TfrmBarCodePrint.SetaSizeGrp(const Value: String);
begin
  FaSizeGrp := Value;
end;

procedure TfrmBarCodePrint.RzPrintFormatSetClick(Sender: TObject);
begin
  inherited;
  SetPrintFormat;
end;

procedure TfrmBarCodePrint.IntPrintInfo;
function FindColumn(FieldName:string):TColumnEh;
var
  i:integer;
begin
  result :=nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if uppercase(DBGridEh1.Columns[i].FieldName) = uppercase(FieldName) then
         begin
           result := DBGridEh1.Columns[i];
           break;
         end;
    end;
end;
var
  i,n,j: Integer;
  rs:TZQuery;
  s,s1,s2,s3,s4:string;
  Column1,Column2:TColumnEh;
begin
  if adoPrint.RecordCount = 0 then exit;
  Column1 := FindColumn('PROPERTY_01');
  Column2 := FindColumn('PROPERTY_02');
  adoPrintTemp.Close;
  adoPrintTemp.CreateDataSet;
  rs := TZQuery.Create(nil);
  adoPrint.DisableControls;
  try
  adoPrint.First;
  while not adoPrint.Eof do
  begin
    if (adoPrint.FieldByName('A').AsBoolean) and (adoPrint.FieldByName('BARCODE').AsString <> '') then
    begin
      rs.Close;
      rs.SQL.Text :=
      'select SORT_ID4,SORT_ID3,UNIT_ID from VIW_GOODSPRICE where GODS_ID='''+adoPrint.FieldByName('GODS_ID').AsString+''' and SHOP_ID='''+Global.SHOP_ID+'''';
      Factor.Open(rs);
      for i := 0 to adoPrint.FieldByName('AMOUNT').AsInteger - 1 do
      begin
        adoPrintTemp.Append;
        adoPrintTemp.FieldByName('GODS_NAME').AsString := stringreplace(adoPrint.FieldByName('GODS_NAME').AsString,' ','',[rfReplaceAll]);
        adoPrintTemp.FieldByName('NEW_OUTPRICE').AsString := adoPrint.FieldByName('NEW_OUTPRICE').AsString;
        adoPrintTemp.FieldByName('NEW_OUTPRICE1').AsString := adoPrint.FieldByName('NEW_OUTPRICE1').AsString;
        adoPrintTemp.FieldByName('NEW_OUTPRICE2').AsString := adoPrint.FieldByName('NEW_OUTPRICE2').AsString;
        adoPrintTemp.FieldByName('NEW_LOWPRICE').AsString := adoPrint.FieldByName('NEW_LOWPRICE').AsString;

        adoPrintTemp.FieldByName('BARCODE').AsString := adoPrint.FieldByName('BARCODE').AsString;
        adoPrintTemp.FieldByName('GODS_CODE').AsString := adoPrint.FieldByName('GODS_CODE').AsString;
        adoPrintTemp.FieldByName('GODS_ID').AsString := adoPrint.FieldByName('GODS_ID').AsString;
        //adoPrintTemp.FieldByName('BCODE').AsString := adoPrint.FieldByName('BCODE').AsString;
        adoPrintTemp.FieldByName('BRAND').AsString := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_BRAND_INFO'),'CODE_ID','CODE_NAME',rs.FieldByName('SORT_ID4').AsString);
        adoPrintTemp.FieldByName('PROVIDE').AsString := TdsFind.GetNameByID(Global.GetZQueryFromName('BAS_CLIENTINFO'),'CLIENT_ID','CLIENT_NAME',rs.FieldByName('SORT_ID3').AsString);
        adoPrintTemp.FieldByName('UNIT_NAME').AsString := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_MEAUNITS'),'UNIT_ID','UNIT_NAME',rs.FieldByName('UNIT_ID').AsString);
        if length(adoPrint.FieldByName('PROPERTY_01').AsString)=3 then
        adoPrintTemp.FieldByName('PROPERTY_01').AsString := Column1.PickList[Column1.KeyList.IndexOf(adoPrint.FieldByName('PROPERTY_01').AsString)];
        if length(adoPrint.FieldByName('PROPERTY_02').AsString)=3 then
        adoPrintTemp.FieldByName('PROPERTY_02').AsString := Column2.PickList[Column2.KeyList.IndexOf(adoPrint.FieldByName('PROPERTY_02').AsString)];
        adoPrintTemp.Post;
      end;
    end ;
    adoPrint.Next;
  end;
  adoPrintTemp.First;
  finally
    adoPrint.First;
    adoPrint.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmBarCodePrint.BtnPrintClick(Sender: TObject);
begin
  inherited;
  IntPrintInfo;
  with TfrmFastReport.Create(self) do
  begin
    try
      Preview(frBarCodeRpt13);
    finally
      free;
    end;
  end;
end;

procedure TfrmBarCodePrint.frBarCodeRpt13UserFunction(const Name: String;
  p1, p2, p3: Variant; var Val: Variant);
begin
  inherited;
  if Name='nextrow' then
     begin
      Val := '';
      adoPrintTemp.Next;
     end;
end;

procedure TfrmBarCodePrint.frMasterDsCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;
  Eof :=adoPrintTemp.Eof;
end;

procedure TfrmBarCodePrint.frMasterDsNext(Sender: TObject);
begin
  inherited;
  adoPrintTemp.Next;
end;

procedure TfrmBarCodePrint.frMasterDsPrior(Sender: TObject);
begin
  inherited;
  adoPrintTemp.Prior;
end;

procedure TfrmBarCodePrint.frBarCodeRpt13GetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='品名' then ParValue := adoPrintTemp.FieldbyName('GODS_NAME').Value else
  if ParName='价格' then ParValue := adoPrintTemp.FieldbyName('NEW_OUTPRICE').Value else
  if ParName='零售价' then ParValue := adoPrintTemp.FieldbyName('NEW_OUTPRICE').Value else
  if ParName='会员价' then ParValue := adoPrintTemp.FieldbyName('NEW_CUSTPRICE').Value else
  if ParName='条码' then ParValue := adoPrintTemp.FieldbyName('BARCODE').Value else
  if ParName='颜色' then ParValue := adoPrintTemp.FieldbyName('PROPERTY_02').Value else
  if ParName='尺码' then ParValue := adoPrintTemp.FieldbyName('PROPERTY_01').Value else
  if ParName='编码' then ParValue := adoPrintTemp.FieldbyName('GODS_ID').Value else
  if ParName='货号' then ParValue := adoPrintTemp.FieldbyName('GODS_CODE').Value else
  if ParName='单位' then ParValue := adoPrintTemp.FieldbyName('UNIT_NAME').Value else
  if ParName='品牌' then ParValue := adoPrintTemp.FieldbyName('BRAND').Value else
  if ParName='供应商' then ParValue := adoPrintTemp.FieldbyName('PROVIDE').Value;
end;

procedure TfrmBarCodePrint.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  IntPrintInfo;
  with TfrmFastReport.Create(self) do
  begin
    try
      Print(frBarCodeRpt13);
    finally
      free;
    end;
  end;
end;

procedure TfrmBarCodePrint.SetRefreshed(const Value: Boolean);
begin
  FRefreshed := Value;
end;

procedure TfrmBarCodePrint.FormCreate(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  Refreshed := true;
  DBGridEh1.Columns[2].KeyList.Add('#');
  DBGridEh1.Columns[2].PickList.Add('无');
  DBGridEh1.Columns[3].KeyList.Add('#');
  DBGridEh1.Columns[3].PickList.Add('无');
  rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[2].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[2].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;

  rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[3].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[3].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;
end;

procedure TfrmBarCodePrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

end.
