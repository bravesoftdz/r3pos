unit ufrmGodsComPare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase;

type
  TfrmGodsComPare = class(TframeDialogForm)
    pnlBarCode: TRzPanel;
    lblInput: TLabel;
    lblHint: TLabel;
    edtInput: TcxTextEdit;
    DBGridEh1: TDBGridEh;
    RzBitBtn2: TRzBitBtn;
    DsGods: TDataSource;
    CdsGods: TZQuery;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    FInputFlag: integer;
    FInputMode: integer;
    fndStr:String;
    { Private declarations }
    procedure ReadFrom(DataSet:TDataSet);
    function EnCodeBarcode:string;
    procedure SetInputFlag(const Value: integer);
    procedure SetInputMode(const Value: integer);
    function CheckSumField(FieldName:string):boolean;
    procedure InitGrid;
    procedure DecodeBarcode(BarCode: string);
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
  protected
    procedure BarcodeFilterRecord(DataSet: TDataSet;var Accept: Boolean);
    procedure GodsInfoFilterRecord(DataSet: TDataSet;var Accept: Boolean);
  public
    { Public declarations }
    class function ShowDialog(AOwner:TForm;DataSet:TDataSet):boolean;
    property InputFlag:integer read FInputFlag write SetInputFlag;
    property InputMode:integer read FInputMode write SetInputMode;
  end;


implementation
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil,uXDictFactory,uframeListDialog;
{$R *.dfm}

function TfrmGodsComPare.EnCodeBarcode: string;
var
  b:string;
  rs,basInfo:TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_BARCODE');
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO');
  if basInfo.Locate('GODS_ID',CdsGods.FieldbyName('GODS_ID').AsString,[]) then
     begin
       if (basInfo.FieldbyName('CALC_UNITS').asString=CdsGods.FieldbyName('UNIT_ID').asString)
       then
          b := basInfo.FieldbyName('BARCODE').asString
       else
          begin
            if rs.Locate('GODS_ID,UNIT_ID',VarArrayOf([CdsGods.FieldbyName('GODS_ID').asString,CdsGods.FieldbyName('UNIT_ID').asString]),[]) then
               b := rs.FieldbyName('BARCODE').asString
            else
               b := basInfo.FieldbyName('BARCODE').asString;
          end;
     end
  else
     b := '';
  result := b;
end;

procedure TfrmGodsComPare.ReadFrom(DataSet: TDataSet);
var
  i,RowID:integer;
  r:boolean;
begin
  CdsGods.DisableControls;
  try
  CdsGods.Close;
  CdsGods.CreateDataSet;
  RowID := 0;
  DataSet.First;
  while not DataSet.Eof do
    begin
     {r := CdsGods.Locate('GODS_ID;BATCH_NO;UNIT_ID',
          VarArrayOf([DataSet.FieldbyName('GODS_ID').asString,
                    DataSet.FieldbyName('BATCH_NO').asString,
                    DataSet.FieldbyName('UNIT_ID').asString]),[]);
      if r then
      begin
        CdsGods.Edit;
        for i:=0 to CdsGods.Fields.Count -1 do
          begin
            if (CdsGods.Fields[i].FieldName<>'SEQNO') and (DataSet.FindField(CdsGods.Fields[i].FieldName)<>nil) then
            begin
              if CheckSumField(CdsGods.Fields[i].FieldName) then
                CdsGods.Fields[i].AsFloat := CdsGods.Fields[i].AsFloat + DataSet.FieldbyName(CdsGods.Fields[i].FieldName).AsFloat
              else
                CdsGods.Fields[i].Value := DataSet.FieldbyName(CdsGods.Fields[i].FieldName).Value;
            end;
          end;
        CdsGods.Post;
      end
      else}
      begin
        CdsGods.Append;
        for i:=0 to CdsGods.Fields.Count -1 do
          begin
             if DataSet.FindField(CdsGods.Fields[i].FieldName)<>nil then
                CdsGods.Fields[i].Value := DataSet.FieldbyName(CdsGods.Fields[i].FieldName).Value;
          end;
        inc(RowID);
        CdsGods.FieldbyName('SEQNO').AsInteger := RowID;
        CdsGods.FieldbyName('BARCODE').AsString := EnCodeBarcode;
        CdsGods.Post;
      end;
      DataSet.Next;
    end;
    CdsGods.SortedFields := 'SEQNO';
  finally
    CdsGods.EnableControls;
  end;
end;

procedure TfrmGodsComPare.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmGodsComPare.ShowDialog(AOwner: TForm;
  DataSet: TDataSet): boolean;
begin
  with TfrmGodsComPare.Create(AOwner) do
  begin
    ReadFrom(DataSet);
    ShowModal;
  end;
end;

procedure TfrmGodsComPare.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift=[]) and (Key = VK_F2) then
     begin
       if edtInput.CanFocus and Visible and not edtInput.Focused then edtInput.SetFocus;
       Exit;
     end;
end;

procedure TfrmGodsComPare.edtInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = []) and(Key = VK_TAB) then
     begin
       if InputMode = 0 then InputMode := 1 else InputMode := 0;
       InputFlag := 0;
       Key := 0;
       Exit;
     end;
end;

procedure TfrmGodsComPare.edtInputKeyPress(Sender: TObject; var Key: Char);
var
  s:string;
  IsNumber,IsFind,isAdd:Boolean;
  amt:Real;
begin
  inherited;
  try
    if Key=#13 then
      begin
        Key := #0;
        if (dbState = dsBrowse) then Exit;
        s := trim(edtInput.Text);
        if s = '' then Exit;
        DecodeBarcode(s);
      end;

  finally
    edtInput.SelectAll;
    if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
  end;
end;

procedure TfrmGodsComPare.SetInputFlag(const Value: integer);
begin
  FInputFlag := Value;
end;

procedure TfrmGodsComPare.SetInputMode(const Value: integer);
begin
  FInputMode := Value;
  case InputMode of
  0:begin
     lblInput.Caption := '条码输入';
     lblHint.Caption := '切换成“货号”输入按 tab 键  <F2>激活输入框';
    end;
  1:begin
     lblInput.Caption := '货号输入';
     lblHint.Caption := '切换成“条码”输入按 tab 键  <F2>激活输入框';
    end;
  end;  
end;

function TfrmGodsComPare.CheckSumField(FieldName: string): boolean;
var s:string;
begin
  s := uppercase(FieldName);
  result := (s='AMOUNT') or (s='CALC_AMOUNT') or (s='AMONEY') or (s='CALC_MONEY') or (s='AGIO_MONEY') or
            (s='RCK_AMOUNT') or (s='PAL_AMOUNT') or (s='PAL_INAMONEY') or (s='PAL_OUTAMONEY') or (s='SHIP_AMOUNT') or (s='FNSH_AMOUNT');
end;

procedure TfrmGodsComPare.FormShow(Sender: TObject);
begin
  inherited;
  InputMode := 0;
  InitGrid;
end;

procedure TfrmGodsComPare.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEh1,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;

  rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
  Column := FindColumn(DBGridEh1,'PROPERTY_01');
  if Column <> nil then
  begin
    rs.First;
    while not rs.Eof do
      begin
        Column.KeyList.Add(rs.FieldbyName('SIZE_ID').AsString);
        Column.PickList.Add(rs.FieldbyName('SIZE_NAME').AsString);
        rs.Next;
      end;
  end;

  rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
  Column := FindColumn(DBGridEh1,'PROPERTY_02');
  if Column <> nil then
  begin
    rs.First;
    while not rs.Eof do
      begin
        Column.KeyList.Add(rs.FieldbyName('COLOR_ID').AsString);
        Column.PickList.Add(rs.FieldbyName('COLOR_NAME').AsString);
        rs.Next;
      end;
  end;
end;

function TfrmGodsComPare.FindColumn(DBGrid: TDBGridEh;
  FieldName: String): TColumnEh;
var i:Integer;
begin
  Result := nil;
  for i:=0 to DBGrid.Columns.Count-1 do
    begin
      if DBGrid.Columns.Items[i].FieldName = FieldName then
        begin
          Result := DBGrid.Columns[i];
          Exit;
        end;
    end;
end;

procedure TfrmGodsComPare.DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       if FindColumn(DBGridEh1,'GODS_CODE')<>nil then
       begin
         if FindColumn(DBGridEh1,'BARCODE')=nil then
            R.Right := Rect.Right + FindColumn(DBGridEh1,'GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn(DBGridEh1,'GODS_CODE').Width+ FindColumn(DBGridEh1,'BARCODE').Width;
       end
       else
       begin
         if FindColumn(DBGridEh1,'BARCODE')=nil then
            R.Right := Rect.Right + FindColumn(DBGridEh1,'GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn(DBGridEh1,'GODS_CODE').Width+ FindColumn(DBGridEh1,'BARCODE').Width;
       end;
       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s笔',[Inttostr(CdsGods.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh1.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmGodsComPare.FormCreate(Sender: TObject);
begin
  inherited;
  if ShopGlobal.GetVersionFlag <> 1 then
     begin
       FindColumn(DBGridEh1,'PROPERTY_02').Free;
       FindColumn(DBGridEh1,'PROPERTY_01').Free;
     end;
end;

procedure TfrmGodsComPare.DecodeBarcode(BarCode: string);
function CheckDupBar(rs:TZQuery):boolean;
var
  r:integer;
begin
  result := true;
  r := 0;
  rs.First;
  while not rs.Eof do
    begin
      if rs.FieldByName('BARCODE').AsString=BarCode then
         begin
           inc(r);
         end;
      rs.Next;
    end;
  result := (r<>1);
end;
var
  rs:TZQuery;
  r,bulk:Boolean;
  AObj:TRecord_;
  uid:string;
  vgds,vP1,vP2,vBtNo:string;
  amt:real;
  mny:real;
  Pri:real;
begin
  if BarCode='' then Exit;
  fndStr := BarCode;
  try
    if InputMode=0 then
    begin
      rs := Global.GetZQueryFromName('PUB_BARCODE');
      rs.OnFilterRecord := BarcodeFilterRecord;
      rs.Filtered := true;
    end
    else
      rs := nil;

    if not assigned(rs) or ((InputMode=0) and rs.IsEmpty) then
       begin
          //看看货号是否存在
          rs := Global.GetZQueryFromName('PUB_GOODSINFO');
          rs.Filtered := false;
          rs.OnFilterRecord := GodsInfoFilterRecord;
          rs.Filtered := true;
          if rs.IsEmpty then
             begin
               Exit;
             end;
          if (rs.RecordCount > 1) and not TframeListDialog.FindDSDialog(self,rs,'GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价',nil) then
             begin
               Exit;
             end
          else
             begin
               vgds := rs.FieldbyName('GODS_ID').AsString;
               vP1 := '#';
               vP2 := '#';
               vBtNo := '#';
               uid := rs.FieldbyName('UNIT_ID').asString;
             end;
       end
    else
       begin
          if (rs.RecordCount > 1) and CheckDupBar(RS) then
             begin
                rs.first;
                while not rs.eof do
                  begin
                    if fndStr<>'' then fndStr := fndStr+',';
                    fndStr := fndStr + ''''+rs.FieldbyName('GODS_ID').asString+'''';
                    rs.next;
                  end;
                AObj := TRecord_.Create;
                try
                  if not TframeListDialog.FindDialog(self,'select GODS_ID,GODS_CODE,GODS_NAME,NEW_OUTPRICE from VIW_GOODSINFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and GODS_ID in ('+fndStr+') and COMM not in (''02'',''12'')','GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价',AObj) then
                     begin
                       fndStr := '';
                       Exit;
                     end
                  else
                     rs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
                finally
                  AObj.free;
                end;
             end;
               
             vgds := rs.FieldbyName('GODS_ID').AsString;
             vP1 := rs.FieldbyName('PROPERTY_01').AsString;
             vP2 := rs.FieldbyName('PROPERTY_02').AsString;
             if vP1='' then vP1 := '#';
             if vP2='' then vP2 := '#';
             uid := rs.FieldbyName('UNIT_ID').AsString;
             vBtNo := rs.FieldbyName('BATCH_NO').AsString;
       end;
  finally
    if Assigned(rs) then
    begin
    rs.OnFilterRecord := nil;
    rs.filtered := false;
    end;
//    rs.Free;
  end;

  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  AObj := TRecord_.Create;
  try

    if CdsGods.Locate('GODS_ID,UNIT_ID,BATCH_NO,PROPERTY_01,PROPERTY_02',VarArrayOf([vgds,uid,vBtNo,vP1,vP2]),[]) then
    begin
       CdsGods.Edit;
       CdsGods.FieldByName('SCANAMOUNT').AsFloat := CdsGods.FieldByName('SCANAMOUNT').AsFloat + 1;
       CdsGods.Post;
       if CdsGods.FieldByName('SCANAMOUNT').AsFloat > CdsGods.FieldByName('AMOUNT').AsFloat then
       begin
       end;
    end
    else
    begin
       if rs.Locate('GODS_ID',vgds,[]) then
       begin
         AObj.ReadFromDataSet(rs);
         CdsGods.Append;
         CdsGods.FieldByName('SEQNO').AsInteger := CdsGods.RecordCount;
         CdsGods.FieldByName('GODS_ID').AsString := AObj.FieldByName('GODS_ID').AsString;
         CdsGods.FieldByName('GODS_CODE').AsString := AObj.FieldByName('GODS_CODE').AsString;
         CdsGods.FieldByName('GODS_NAME').AsString := AObj.FieldByName('GODS_NAME').AsString;
         CdsGods.FieldByName('BARCODE').AsString := AObj.FieldByName('BARCODE').AsString;
         CdsGods.FieldByName('UNIT_ID').AsString := AObj.FieldByName('UNIT_ID').AsString;
         CdsGods.FieldByName('BATCH_NO').AsString := vBtNo;
         CdsGods.FieldByName('PROPERTY_01').AsString := vP1;
         CdsGods.FieldByName('PROPERTY_02').AsString := vP2;
         CdsGods.FieldByName('AMOUNT').AsFloat := 0;
         CdsGods.FieldByName('SCANAMOUNT').AsFloat := 1;
         CdsGods.FieldByName('STATUS').AsString := '';
         CdsGods.Post;
       end;
    end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGodsComPare.BarcodeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if length(fndStr)=6 then
     Accept := copy(DataSet.FieldbyName('BARCODE').AsString,length(DataSet.FieldbyName('BARCODE').AsString)-5,6)=fndStr
  else
     Accept := DataSet.FieldbyName('BARCODE').AsString=fndStr;
end;

procedure TfrmGodsComPare.GodsInfoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept :=
    (pos(fndStr,DataSet.FieldbyName('GODS_CODE').AsString)>0)
end;

end.
