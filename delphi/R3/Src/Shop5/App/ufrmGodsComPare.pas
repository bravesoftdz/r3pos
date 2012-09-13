unit ufrmGodsComPare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase,
  RzStatus;

type
  TfrmGodsComPare = class(TframeDialogForm)
    pnlBarCode: TRzPanel;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    DBGridEh1: TDBGridEh;
    DsGods: TDataSource;
    CdsGods: TZQuery;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
    fndStr:string;
    procedure ReadFrom(DataSet:TDataSet);
    function EnCodeBarcode:string;
    procedure InitGrid;
    function DecodeBarcode(BarCode: string):integer;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
  protected
    procedure BarcodeFilterRecord(DataSet: TDataSet;var Accept: Boolean);
    procedure GodsInfoFilterRecord(DataSet: TDataSet;var Accept: Boolean);
  public
    { Public declarations }
    class function ShowDialog(AOwner:TForm;DataSet:TDataSet):boolean;
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
  if rs.Locate('GODS_ID;UNIT_ID;PROPERTY_01;PROPERTY_02',VarArrayOf([CdsGods.FieldbyName('GODS_ID').asString,CdsGods.FieldbyName('UNIT_ID').asString,CdsGods.FieldbyName('PROPERTY_01').asString,CdsGods.FieldbyName('PROPERTY_02').asString]),[]) then
     begin
       result :=  rs.FieldbyName('BARCODE').asString;
       Exit;
     end;
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO');
  if basInfo.Locate('GODS_ID',CdsGods.FieldbyName('GODS_ID').AsString,[]) then
     begin
       if (basInfo.FieldbyName('CALC_UNITS').asString=CdsGods.FieldbyName('UNIT_ID').asString)
       then
          b := basInfo.FieldbyName('BARCODE').asString
       else
          begin
            if rs.Locate('GODS_ID;UNIT_ID;PROPERTY_01;PROPERTY_02',VarArrayOf([CdsGods.FieldbyName('GODS_ID').asString,CdsGods.FieldbyName('UNIT_ID').asString,'#','#']),[]) then
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
        edtInput.SelectAll;
        s := trim(edtInput.Text);
        if s = '' then Exit;
        if ((length(s) in [1,2,3,4]) and FnString.IsNumberChar(s)) then
           begin
             if not cdsGods.IsEmpty then
                begin
                  cdsGods.Edit;
                  cdsGods.FieldByName('SCANAMOUNT').AsFloat := StrtoFloatDef(s,0);
                  cdsGods.Post;
                end
             else
                Raise Exception.Create('请先扫描码再输数量'); 
           end
        else
           case DecodeBarCode(trim(s)) of
             1:begin
                 //PostMessage(Handle,WM_DIALOG_PULL,FIND_GOODS_DIALOG,1);
               end;
             2:begin
                 MessageBox(Handle,'输入的条码无效..','友情提示...',MB_OK+MB_ICONQUESTION);//PostMessage(Handle,WM_DIALOG_PULL,FIND_GOODS_DIALOG,1);
               end;
             3:begin
                 edtInput.Text := '';
                 Exit;
               end;
           else
              edtInput.Text := '';
           end;
      end;

  finally
    if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
  end;
end;

procedure TfrmGodsComPare.FormShow(Sender: TObject);
begin
  inherited;
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
  Column.KeyList.Add('#');
  Column.PickList.Add('无');

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
  Column.KeyList.Add('#');
  Column.PickList.Add('无');
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

function TfrmGodsComPare.DecodeBarcode(BarCode: string):integer;
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
  result := 2;
  if BarCode='' then Exit;
  fndStr := BarCode;
  try
    rs := Global.GetZQueryFromName('PUB_BARCODE');
    rs.OnFilterRecord := BarcodeFilterRecord;
    rs.Filtered := true;

    if not assigned(rs) or (rs.IsEmpty) then
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
               result := 3;
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
                       result := 3;
                       Exit;
                     end
                  else
                     rs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
                finally
                  AObj.free;
                end;
             end;
            if result <> 3 then
             begin
               vgds := rs.FieldbyName('GODS_ID').AsString;
               vP1 := rs.FieldbyName('PROPERTY_01').AsString;
               vP2 := rs.FieldbyName('PROPERTY_02').AsString;
               if vP1='' then vP1 := '#';
               if vP2='' then vP2 := '#';
               uid := rs.FieldbyName('UNIT_ID').AsString;
               vBtNo := rs.FieldbyName('BATCH_NO').AsString;
       end;  end;
  finally
    if Assigned(rs) then
    begin
    rs.OnFilterRecord := nil;
    rs.filtered := false;
    end;
  end;

  AObj := TRecord_.Create;
  try
    result := 0;
    if CdsGods.Locate('GODS_ID,UNIT_ID,BATCH_NO,PROPERTY_01,PROPERTY_02',VarArrayOf([vgds,uid,vBtNo,vP1,vP2]),[]) then
    begin
       CdsGods.Edit;
       CdsGods.FieldByName('SCANAMOUNT').AsFloat := CdsGods.FieldByName('SCANAMOUNT').AsFloat + 1;
       CdsGods.Post;
    end
    else
    begin
       rs := Global.GetZQueryFromName('PUB_GOODSINFO');
       if rs.Locate('GODS_ID',vgds,[]) then
       begin         
         CdsGods.Append;
         CdsGods.FieldByName('SEQNO').AsInteger := CdsGods.RecordCount;
         CdsGods.FieldByName('GODS_ID').AsString := rs.FieldByName('GODS_ID').AsString;
         CdsGods.FieldByName('GODS_CODE').AsString := rs.FieldByName('GODS_CODE').AsString;
         CdsGods.FieldByName('GODS_NAME').AsString := rs.FieldByName('GODS_NAME').AsString;
         CdsGods.FieldByName('UNIT_ID').AsString := uid;
         CdsGods.FieldByName('BATCH_NO').AsString := vBtNo;
         CdsGods.FieldByName('PROPERTY_01').AsString := vP1;
         CdsGods.FieldByName('PROPERTY_02').AsString := vP2;
         CdsGods.FieldByName('BARCODE').AsString := EnCodeBarcode;
         CdsGods.FieldByName('AMOUNT').AsFloat := 0;
         CdsGods.FieldByName('SCANAMOUNT').AsFloat := 1;
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

procedure TfrmGodsComPare.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if CdsGods.FieldbyName('AMOUNT').asFloat=CdsGods.FieldbyName('SCANAMOUNT').asFloat then
     Background := RzStatusPane5.FillColor
  else
  if (CdsGods.FieldbyName('AMOUNT').asFloat<>CdsGods.FieldbyName('SCANAMOUNT').asFloat) and (CdsGods.FieldbyName('SCANAMOUNT').AsString<>'') then
     Background := RzStatusPane4.FillColor;

end;

end.
