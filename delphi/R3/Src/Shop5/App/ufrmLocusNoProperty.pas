unit ufrmLocusNoProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, Grids, DBGridEh,
  RzButton, DB, ZDataSet, uframeOrderForm, RzBorder,ZBase,
  ZAbstractRODataset, ZAbstractDataset;

type
  TfrmLocusNoProperty = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    pnlBarCode: TRzPanel;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    RzBitBtn1: TRzBitBtn;
    Panel1: TPanel;
    RzLEDDisplay: TRzLEDDisplay;
    Label1: TLabel;
    Label2: TLabel;
    RzLEDDisplay2: TRzLEDDisplay;
    PopupMenu1: TPopupMenu;
    actDelete: TAction;
    actImport: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actDeleteAll: TAction;
    Label3: TLabel;
    RzLEDDisplay1: TRzLEDDisplay;
    cdsImport: TZQuery;
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteAllExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDataSet: TDataSet;
    FdbState: TDataSetState;
    FForm: TframeOrderForm;
    FWait: integer;
    AObj:TRecord_;
    UNIT_ID,MNG_UNIT_ID:string;
    CONV_RATE,MNG_CONV_RATE:real;
    FShopId: string;
    wait:currency;
    FCheckLocusNo: boolean;
    procedure SetDataSet(const Value: TDataSet);
    { Private declarations }
    procedure InitGrid;
    procedure Calc;
    procedure SetdbState(const Value: TDataSetState);
    procedure SetForm(const Value: TframeOrderForm);
    function GodsToLocusNo(id: string;lct:integer=1): boolean;
    procedure SetShopId(const Value: string);
    procedure SetCheckLocusNo(const Value: boolean);
  public
    { Public declarations }
    procedure LocusNo(DataSet:TDataSet);
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property dbState:TDataSetState read FdbState write SetdbState;
    property Form:TframeOrderForm read FForm write SetForm;
    property ShopId:string read FShopId write SetShopId;
    property CheckLocusNo:boolean read FCheckLocusNo write SetCheckLocusNo;
  end;

implementation

uses uGlobal,ufrmExcelFactory,uFnUtil, uShopGlobal;
var frmLocusNoProperty:TfrmLocusNoProperty;
{$R *.dfm}

procedure TfrmLocusNoProperty.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='LOCUS_NO' then
     begin
       Text := '合计:'+Text;
     end;
end;

procedure TfrmLocusNoProperty.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
  DataSource1.DataSet := Value;
end;

procedure TfrmLocusNoProperty.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DataSet.RecNo)),length(Inttostr(DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmLocusNoProperty.InitGrid;
function  FindColumn(FieldName:string):TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  Column := FindColumn('UNIT_ID');
  if Column<>nil then
  begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmLocusNoProperty.FormCreate(Sender: TObject);
begin
  inherited;
  CheckLocusNo := true;
  InitGrid;
  frmLocusNoProperty := self;
  AObj := TRecord_.Create;
end;

procedure TfrmLocusNoProperty.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmLocusNoProperty.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  //if wait<>0 then Raise Exception.Create('扫码没有完成,请确认扫完再确认');
  if wait <> 0 then
     begin
       if MessageBox(Handle,pchar('扫码没有完成,确认完毕吗!'),'友情提示...',MB_YESNO+MB_ICONINFORMATION) <> 6 then Exit; 
     end;
  self.ModalResult := MROK;
end;

procedure TfrmLocusNoProperty.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  pnlBarCode.Visible := (Value<>dsBrowse);
end;

procedure TfrmLocusNoProperty.SetForm(const Value: TframeOrderForm);
begin
  FForm := Value;
end;

procedure TfrmLocusNoProperty.edtInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if trim(edtInput.Text)='' then Exit;
  if Key=#13 then
     begin
       if GodsToLocusNo(trim(trim(edtInput.Text))) then Calc;
       //if trim(edtInput.Text) <> '' then DataSet.Locate('LOCUS_NO',trim(edtInput.Text),[]);
       edtInput.Text := '';
     end;
end;

procedure TfrmLocusNoProperty.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not edtInput.CanFocus then inherited;

end;

procedure TfrmLocusNoProperty.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if DataSet.IsEmpty then Exit;
  if MessageBox(Handle,pchar('是否确认删除'+DataSet.FieldbyName('LOCUS_NO').AsString+'，重新扫码？'),'友情提示...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  DataSet.Delete;
  Calc;
end;

procedure TfrmLocusNoProperty.actDeleteAllExecute(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,'是否确认删除所有扫码数据，重新扫码？','友情提示...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  if DataSet.IsEmpty then Exit;
  DataSet.First;
  while not DataSet.Eof do DataSet.Delete;
  Calc;
end;

procedure TfrmLocusNoProperty.actImportExecute(Sender: TObject);
function Save(CdsTable:TDataSet):Boolean;
begin
  result := true;
end;
function FindColumn(CdsCol:TDataSet):Boolean;
begin
  result := true;
  if not CdsCol.Locate('FieldName','LOCUS_NO',[]) then
    begin
      Result := False;
      Raise Exception.Create('缺少"物流跟踪码"字段!');
    end;
end;
function ImportLocusNo(Source, Dest: TDataSet;
  SFieldName, DFieldName: string): Boolean;
var amt:integer;  
begin
  result := false;
  if (SFieldName='') and (DFieldName='') then
     begin
       if Dest.FieldbyName('LOCUS_NO').AsString='' then Exit;
       amt := StrtoIntDef(Dest.FieldbyName('AMOUNT').AsString,1);
       frmLocusNoProperty.GodsToLocusNo(Dest.FieldbyName('LOCUS_NO').AsString,amt);
       result := true;
     end;
end;
begin
  inherited;
  if not DataSet.IsEmpty then Raise Exception.Create('已经存在扫码记录，不能导入');
  cdsImport.Close;
  cdsImport.CreateDataSet;
  TfrmExcelFactory.ExcelFactory(cdsImport,'LOCUS_NO=物流跟踪码,AMOUNT=数量',@ImportLocusNo,@Save,@FindColumn,'0=LOCUS_NO,1=AMOUNT',1);
  Calc;
end;

procedure TfrmLocusNoProperty.FormDestroy(Sender: TObject);
begin
  AObj.Free;
  inherited;
end;

procedure TfrmLocusNoProperty.LocusNo(DataSet: TDataSet);
var
  bs:TZQuery;
  r:currency;
begin
  AObj.ReadFromDataSet(DataSet);
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营商品中没找到，当前扫码商品，请重新登录系统再重试..');
  MNG_UNIT_ID := bs.FieldbyName('UNIT_ID').AsString;
  UNIT_ID := AObj.FieldbyName('UNIT_ID').AsString;
  if bs.FieldByName('BIG_UNITS').AsString=bs.FieldbyName('UNIT_ID').AsString then
     begin
       MNG_CONV_RATE := bs.FieldbyName('BIGTO_CALC').AsFloat;
     end
  else
  if bs.FieldByName('SMALL_UNITS').AsString=bs.FieldbyName('UNIT_ID').AsString then
     begin
       MNG_CONV_RATE := bs.FieldbyName('SMALLTO_CALC').AsFloat;
     end
  else
     MNG_CONV_RATE := 1;
  if bs.FieldByName('BIG_UNITS').AsString=AObj.FieldbyName('UNIT_ID').AsString then
     begin
       CONV_RATE := bs.FieldbyName('BIGTO_CALC').AsFloat;
     end
  else
  if bs.FieldByName('SMALL_UNITS').AsString=AObj.FieldbyName('UNIT_ID').AsString then
     begin
       CONV_RATE := bs.FieldbyName('SMALLTO_CALC').AsFloat;
     end
  else
     CONV_RATE := 1;
  if CONV_RATE>MNG_CONV_RATE then
     begin
       UNIT_ID := MNG_UNIT_ID;
       CONV_RATE := MNG_CONV_RATE;
     end;
  r := AObj.FieldbyName('CALC_AMOUNT').AsFloat/CONV_RATE;
  RzLEDDisplay1.Caption := floattostr(trunc(r));
  Calc;
end;

function TfrmLocusNoProperty.GodsToLocusNo(id: string;lct:integer=1): boolean;
var
  rs:TZQuery;
  r:boolean;
  sr:real;
begin
  if (length(id)<=4) and (FnString.IsNumberChar(id)) then
     begin
       if DataSet.IsEmpty then Raise Exception.Create('请扫码重，再输入数量...');
       if UNIT_ID=MNG_UNIT_ID then
          begin
            if Strtofloat(id)>1 then Raise Exception.Create('管理单位只能一个物流码只能对应一个商品');  
          end;
       if (Strtofloat(id)*CONV_RATE)>MNG_CONV_RATE then Raise Exception.Create('一个物流码对应的发货量大太了，请确认是否输错了.');
       DataSet.Edit;
       DataSet.FieldByName('AMOUNT').AsFloat := Strtofloat(id);
       DataSet.FieldByName('CALC_AMOUNT').AsFloat := DataSet.FieldByName('AMOUNT').AsFloat*CONV_RATE;
       DataSet.Post;
       result := true;
       Exit;
     end;
  if id = '' then Raise Exception.Create('输入的物流跟踪号无效');
  if UNIT_ID=MNG_UNIT_ID then
     begin
       if lct>1 then Raise Exception.Create('管理单位只能一个物流码只能对应一个商品');
     end;
  result := false;
  rs := TZQuery.Create(nil);
  try
     if (ShopGlobal.GetParameter('LOCUS_NO_MT')<>'1') and CheckLocusNo then  //不能强制出库
     begin
       rs.SQL.Text :=
       'select distinct LOCUS_NO from STK_LOCUS_FORSTCK A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.GODS_ID='''+AObj.FieldbyName('GODS_ID').AsString+''' and A.SHOP_ID='''+ShopId+''' and A.LOCUS_NO='''+id+''' ';
       Factor.Open(rs);
       if rs.IsEmpty then
          begin
            windows.beep(2000,500);
            Exit;
          end;
     end;
     r := DataSet.Locate('GODS_ID;BATCH_NO;UNIT_ID;PROPERTY_01,PROPERTY_02;LOCUS_NO',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,AObj.FieldbyName('BATCH_NO').AsString,AObj.FieldbyName('UNIT_ID').AsString,AObj.FieldbyName('PROPERTY_01').AsString,AObj.FieldbyName('PROPERTY_02').AsString,id]),[]);
     if not r then
     begin
        DataSet.Append;
        AObj.WriteToDataSet(DataSet,false);
        DataSet.FieldByName('UNIT_ID').AsString := UNIT_ID;
        DataSet.FieldByName('AMOUNT').AsFloat := lct;
        DataSet.FieldByName('CALC_AMOUNT').AsFloat := lct*CONV_RATE;
        DataSet.FieldByName('LOCUS_NO').AsString := id;
        DataSet.Post;
        MessageBeep(0);
     end else
     begin
        if UNIT_ID=MNG_UNIT_ID then
           begin
             windows.beep(2000,500);
             Exit;
           end
        else
           begin
             if ((DataSet.FieldByName('AMOUNT').AsFloat + lct)*CONV_RATE)>MNG_CONV_RATE then Raise Exception.Create('一个物流码对应的发货量大太了，请确认是否输错了.');
             DataSet.Edit;
             DataSet.FieldByName('AMOUNT').AsFloat := DataSet.FieldByName('AMOUNT').AsFloat + lct;
             DataSet.FieldByName('CALC_AMOUNT').AsFloat := DataSet.FieldByName('AMOUNT').AsFloat*CONV_RATE;
             DataSet.Post;
             MessageBeep(0);
           end;
     end;
    result := true;
  finally
    rs.Free;
  end;
end;

procedure TfrmLocusNoProperty.SetShopId(const Value: string);
begin
  FShopId := Value;
end;

procedure TfrmLocusNoProperty.Calc;
var
  r,t:currency;
  Locus_No:String;
begin
  t := AObj.FieldbyName('CALC_AMOUNT').asFloat/CONV_RATE;
  if trim(edtInput.Text) <> '' then
    Locus_No := Trim(edtInput.Text)
  else
    Locus_No := DataSet.FieldbyName('LOCUS_NO').AsString;
  r := 0;
  DataSet.DisableControls;
  try
    DataSet.First;
    while not DataSet.Eof do
      begin
        r := r + DataSet.FieldbyName('CALC_AMOUNT').asFloat;
        DataSet.Next;
      end;
    r := r / CONV_RATE;
    RzLEDDisplay.Caption := floattostr(trunc(r));
    wait := trunc(t)-trunc(r);
    RzLEDDisplay2.Caption := floattostr(wait);
  finally
    if Locus_No <> '' then DataSet.Locate('LOCUS_NO',Locus_No,[]);
    DataSet.EnableControls;
  end;
end;

procedure TfrmLocusNoProperty.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //t := AObj.FieldbyName('CALC_AMOUNT').asFloat/CONV_RATE;
  inherited;
  {if (wait<>0) and (wait<>trunc(t)) then
     begin
       CanClose := false;
       Raise Exception.Create('扫码没有完成,请确认扫完再确认');
     end;}

end;

procedure TfrmLocusNoProperty.SetCheckLocusNo(const Value: boolean);
begin
  FCheckLocusNo := Value;
end;

end.
