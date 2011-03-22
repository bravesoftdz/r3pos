unit ufrmBatchPmdPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, DB, StdCtrls, ExtCtrls,
  ComCtrls, RzTreeVw, cxCheckBox, cxSpinEdit, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, ADODB, zBase, zDataSet;

type
  TfrmBatchPmdPrice = class(TfrmBasic)
    cxBtnOk: TRzBitBtn;
    cxbtnCancel: TRzBitBtn;
    RadioGroup2: TRadioGroup;
    rzChkTree: TRzCheckTree;
    Panel1: TPanel;
    Label2: TLabel;
    edtSTD_RATE: TcxSpinEdit;
    lblCUS_RATE: TLabel;
    edtCUS_RATE: TcxSpinEdit;
    fndGODS_FLAG1: TcxComboBox;
    Label1: TLabel;
    edtRATE_OFF: TcxComboBox;
    Label5: TLabel;
    edtISINTEGRAL: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
    procedure fndGODS_FLAGPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    cdsTable:TDataSet;
    CarryRule,Deci:integer;
    procedure LoadLevelSort;
    procedure LoadBrandInfo;
    procedure LoadProvInfo;
    //截小数
    function ConvertToFight(value: Currency; deci: Integer): real;
  public
    { Public declarations }
    class function BatchPrice(DataSet:TDataSet):Boolean;

  end;

implementation

uses uGlobal, uDsUtil, uTreeUtil, uShopUtil, uShopGlobal;

{$R *.dfm}

{ TfrmBatchPrice }

class function TfrmBatchPmdPrice.BatchPrice(DataSet: TDataSet): Boolean;
begin
  with TfrmBatchPmdPrice.Create(Application.MainForm) do
    begin
      try
        cdsTable := DataSet;
        Result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

//商品树形:
{procedure TfrmBatchPmdPrice.LoadLevelSort;
var PUB_LEVELSORT: TZQuery;
begin
  rzChkTree.Items.Clear;
  PUB_LEVELSORT := Global.GetZQueryFromName('PUB_GOODSSORT');
  CreateLevelTree(PUB_LEVELSORT, rzChkTree, '4444444444', 'SORT_ID', 'SORT_NAME', 'LEVEL_ID', 1, 3);
end;}

//商品树形:
procedure TfrmBatchPmdPrice.LoadLevelSort;
var
  rs:TZQuery;
  w,i:integer;
  AObj,CurObj:TRecord_;
begin
  ClearTree(rzChkTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  w := -1;
  try
    CurObj:=TRecord_.Create;
    rs.First;
    while not rs.Eof do
    begin
      CurObj.ReadFromDataSet(rs); 
      if w<>CurObj.FieldByName('RELATION_ID').AsInteger then
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        rzChkTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
        w := CurObj.FieldByName('RELATION_ID').AsInteger;
      end;
      rs.Next;
    end;
  finally
    CurObj.Free;
  end;
  
  for i:=rzChkTree.Items.Count-1 downto 0 do
  begin
    rs.Filtered := false;
    rs.filter := 'RELATION_ID='+TRecord_(rzChkTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
    rs.Filtered := true;
    rs.SortedFields := 'LEVEL_ID';
    CreateLevelTree(rs,rzChkTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzChkTree.Items[i]);
  end;
  rzChkTree.FullExpand;
end;


procedure TfrmBatchPmdPrice.FormCreate(Sender: TObject);
begin
  inherited;
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
  Initform(self);
  fndGODS_FLAG1.ItemIndex := 0;
  edtRATE_OFF.ItemIndex := 0;
  edtISINTEGRAL.Checked := true;
end;

procedure TfrmBatchPmdPrice.cxBtnOkClick(Sender: TObject);
var
  basInfo:TZQuery;
  function EnCodeBarcode(cdsTable:TDataSet): string;
  var b,id:string;
  begin
    if basInfo.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) then
    begin
      b := basInfo.FieldbyName('BARCODE').asString;
      if trim(b)='' then
      begin
        id := TSequence.GetSequence('BARCODE_ID',InttoStr(ShopGlobal.TENANT_ID),'',6);
        b:=GetBarCode(id,'#','#');
      end;
    end else
      b := '';
    result := b;
  end;
var rs:TZQuery;
  cnd,s,CurID:string;
  i:integer;
begin
  if not ((edtSTD_RATE.Value>=0) and (edtSTD_RATE.Value <=100)) then
     Raise Exception.Create('统一价折扣率不合法'); 
  if (edtRATE_OFF.ItemIndex=2) and not ((edtCUS_RATE.Value>=0) and (edtCUS_RATE.Value <=100)) then
     Raise Exception.Create('会员价再折率不合法');

  for i:=0 to rzChkTree.Items.Count -1 do
  begin
    if rzChkTree.ItemState[i] in [csChecked,csPartiallyChecked] then
    begin
      CurID:=''''+trim(TRecord_(rzChkTree.Items[i].Data).FieldbyName('SORT_ID').asString)+'''';
      if fndGODS_FLAG1.ItemIndex=0 then
      begin
        if Pos((CurID+','),s)<=0 then
        begin
          if s <> '' then s := s+',';
          s := s +CurID;
        end;
      end else
      begin
        if s <> '' then s := s+',';
        s := s +CurID;
      end;
    end;
  end;

  if s='' then Raise Exception.Create('请选择适用范围...'); 
  rs := TZQuery.Create(nil);
  cdsTable.DisableControls;
  try
    case fndGODS_FLAG1.ItemIndex of
     0: cnd:=' and SORT_ID1 in ('+s+') ';  //货品分类
     1: cnd:=' and SORT_ID4 in ('+s+') ';  //商品品牌
     2: cnd:=' and SORT_ID3 in ('+s+') ';  //主供应商
    end;
    rs.SQL.Text := 'select GODS_ID,GODS_CODE,GODS_NAME,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,CALC_UNITS,SMALL_UNITS,BIG_UNITS '+
       ' from VIW_GOODSPRICE where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Cnd+' order by GODS_CODE';
    if rs.Params.FindParam('TENANT_ID')<>nil then
      rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;  
    Factor.Open(rs);
    //删除cdsTable空记录:
    cdsTable.First;
    while not cdsTable.Eof do
    begin
      if cdsTable.FieldByName('GODS_ID').AsString='' then
        cdsTable.Delete
      else
        cdsTable.Next;
    end;

    basInfo := Global.GetZQueryFromName('PUB_GOODSINFO'); 
    rs.First;
    while not rs.Eof do
      begin
        if cdsTable.Locate('GODS_ID',rs.Fields[0].asString,[]) then
          cdsTable.Edit
        else
        begin
          cdsTable.Append;
          cdsTable.FieldbyName('SEQNO').AsInteger := cdsTable.RecordCount+1;
          cdsTable.FieldbyName('GODS_ID').asString := rs.FieldbyName('GODS_ID').asString;
          cdsTable.FieldbyName('BARCODE').AsString := EnCodeBarcode(cdsTable);
        end;
        cdsTable.FieldbyName('GODS_ID').asString := rs.FieldbyName('GODS_ID').asString;
        cdsTable.FieldbyName('GODS_CODE').asString := rs.FieldbyName('GODS_CODE').asString;
        cdsTable.FieldbyName('GODS_NAME').asString := rs.FieldbyName('GODS_NAME').asString;
        cdsTable.FieldbyName('NEW_OUTPRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE').AsFloat;
        cdsTable.FieldbyName('OUT_PRICE').asString := formatFloat('#0.000',ConvertToFight(rs.FieldbyName('NEW_OUTPRICE').AsFloat*edtSTD_RATE.Value/100,Deci));
        cdsTable.FieldbyName('OUT_PRICE1').asString := formatFloat('#0.000',ConvertToFight(rs.FieldbyName('NEW_OUTPRICE1').AsFloat*edtSTD_RATE.Value/100,Deci));
        cdsTable.FieldbyName('OUT_PRICE2').asString := formatFloat('#0.000',ConvertToFight(rs.FieldbyName('NEW_OUTPRICE2').AsFloat*edtSTD_RATE.Value/100,Deci));
        cdsTable.FieldbyName('AGIO_RATE').Value := edtSTD_RATE.Value;
        cdsTable.FieldbyName('RATE_OFF').AsInteger := edtRATE_OFF.ItemIndex;

        case edtRATE_OFF.ItemIndex of  //0:不打折; 1:再打折; 2:指定折;
         0,1:cdsTable.FieldbyName('AGIO_RATE').asString := '';
         else
           cdsTable.FieldbyName('AGIO_RATE').Value := edtCUS_RATE.Value;
        end;
        if edtISINTEGRAL.Checked then
           cdsTable.FieldbyName('ISINTEGRAL').Value := 1
        else
           cdsTable.FieldbyName('ISINTEGRAL').Value := 0;
        cdsTable.FieldbyName('SMALL_UNITS').AsString := rs.FieldbyName('SMALL_UNITS').AsString;
        cdsTable.FieldbyName('BIG_UNITS').AsString := rs.FieldbyName('BIG_UNITS').AsString;
        cdsTable.FieldbyName('CALC_UNITS').AsString := rs.FieldbyName('CALC_UNITS').AsString;
        cdsTable.Post;
        rs.Next;
      end;
    ModalResult := MROK;
  finally
    cdsTable.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmBatchPmdPrice.fndGODS_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  case fndGODS_FLAG1.ItemIndex of
   0:LoadLevelSort;
   1:LoadBrandInfo;
   2:LoadProvInfo;
  end;
end;

//商品品牌
procedure TfrmBatchPmdPrice.LoadBrandInfo;
var rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:='select SORT_ID,SORT_NAME,null as PID from VIW_GOODSSORT where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and SORT_TYPE=4 order by SORT_ID ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;  
    Factor.Open(rs);
    rzChkTree.Items.Clear;
    CreateParantTree(rs, rzChkTree, 'SORT_ID', 'SORT_NAME', 'PID');
  finally
    rs.free;
  end;
end;

//商品主供应商
procedure TfrmBatchPmdPrice.LoadProvInfo;
var rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select CLIENT_ID as SORT_ID,CLIENT_NAME as SORT_NAME,null as PID from VIW_CLIENTINFO '+
                  ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and CLIENT_TYPE=''1'' order by CLIENT_CODE ';
    Factor.Open(rs);
    rzChkTree.Items.Clear;
    CreateParantTree(rs, rzChkTree, 'SORT_ID', 'SORT_NAME', 'PID');
  finally
    rs.free;
  end;
end;

function TfrmBatchPmdPrice.ConvertToFight(value: Currency;
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

end.
