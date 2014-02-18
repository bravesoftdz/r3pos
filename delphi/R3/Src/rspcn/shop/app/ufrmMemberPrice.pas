unit ufrmMemberPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, RzButton, cxButtonEdit, Grids, DBGridEh, cxSpinEdit, cxMaskEdit,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxTextEdit, RzBckgnd,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, cxRadioGroup;

type
  TfrmMemberPrice = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    RzPanel2: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel14: TRzPanel;
    PNL_AGIO_TYPE_1: TRzPanel;
    RzPanel12: TRzPanel;
    RzPanel15: TRzPanel;
    RzBackground6: TRzBackground;
    RzLabel7: TRzLabel;
    RzPanel16: TRzPanel;
    RzPanel17: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel8: TRzLabel;
    edtAGIO_PERCENT: TcxSpinEdit;
    PNL_AGIO_TYPE_2: TRzPanel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzPanel3: TRzPanel;
    edtBK_GODS_CODE: TRzPanel;
    RzPanel42: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel11: TRzLabel;
    edtGODS_CODE: TcxTextEdit;
    PriceGrid: TDBGridEh;
    cdsMemberPrice: TZQuery;
    PriceDataSource: TDataSource;
    edtBK_GODS_NAME: TRzPanel;
    RzPanel5: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel2: TRzLabel;
    edtGODS_NAME: TcxTextEdit;
    RzPanel4: TRzPanel;
    RzPanel6: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel3: TRzLabel;
    rbUSING_BARTER2: TcxRadioButton;
    rbUSING_BARTER1: TcxRadioButton;
    edtBARTER_INTEGRAL1: TcxSpinEdit;
    rbUSING_BARTER3: TcxRadioButton;
    edtBARTER_INTEGRAL2: TcxSpinEdit;
    cdsGoods: TZQuery;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure PriceGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure PriceGridColumns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure PriceGridColumns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure PriceGridColumns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure PriceGridColumns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure rbUSING_BARTER1Click(Sender: TObject);
    procedure rbUSING_BARTER2Click(Sender: TObject);
    procedure rbUSING_BARTER3Click(Sender: TObject);
  private
    CarryRule,Deci:integer;
    GodsId,GodsCode,GodsName:string;
    RelationId,RelationType,UsingBarter,BarterIntegral:integer;
    procedure Open;
    procedure Save;
    procedure WriteMemberPrice;
    procedure CheckGoodPriceColumnVisible;
    function  GetColumnIdx(Gird:TDBGridEh;ColName:string): integer;
    function  ConvertToFight(value: Currency; deci: Integer): real;
    procedure CalcMemberProfitPrice(cdsMemberPrice:TZQuery;CalcType:integer;IsAll:Boolean=false);
    function  FindColumn(DBGrid: TDBGridEh; FieldName:string):TColumnEh;
  public
    class function ShowDialog(AOwner:TForm;SObj:TRecord_):boolean;
  end;

implementation

uses udataFactory,uTokenFactory,udllGlobal,udllShopUtil,uFnUtil,ObjCommon;

{$R *.dfm}

procedure TfrmMemberPrice.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMemberPrice.CheckGoodPriceColumnVisible;
var
  i:integer;
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',GodsId,[]) then Raise Exception.Create('经营商品中没有找到'+GodsName+'...');
  for i:=0 to PriceGrid.Columns.Count-1 do
  begin
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE' then
    begin
      if rs.FieldByName('CALC_UNITS').AsString = '' then
         PriceGrid.Columns[i].Visible:=false
      else
         PriceGrid.Columns[i].Visible:=true;
    end;
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE1' then
    begin
      if rs.FieldByName('SMALL_UNITS').AsString = '' then
         PriceGrid.Columns[i].Visible:=false
      else
         PriceGrid.Columns[i].Visible:=true;
    end;
    if trim(PriceGrid.Columns[i].FieldName)='NEW_OUTPRICE2' then
    begin
      if rs.FieldByName('BIG_UNITS').AsString = '' then
         PriceGrid.Columns[i].Visible:=false
      else
         PriceGrid.Columns[i].Visible:=true;
    end;
  end;
end;

procedure TfrmMemberPrice.Open;
var
  sql:string;
  Params:TftParamList;
begin
  sql := 'select  PROFIT_RATE,TENANT_ID,A.PRICE_ID as PRICE_ID,A.PRICE_NAME as PRICE_NAME,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2, '+
         '        case when B.PRICE_ID is null then ''insert'' else ''update'' end as STATE,B.COMM '+
         ' from   (select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE where TENANT_ID=:TENANT_ID and PRICE_ID<>''#'' and COMM not in (''02'',''12'')) A '+
         '        left join '+
         '        ( '+
         '          select P.*,(case when G.NEW_OUTPRICE>0 then cast(round((P.NEW_OUTPRICE*100)/(G.NEW_OUTPRICE*1.0),0) as integer) else null end) as PROFIT_RATE '+
         '          from PUB_GOODSPRICE P,VIW_GOODSPRICE G '+
         '          where P.TENANT_ID=G.TENANT_ID and P.GODS_ID=G.GODS_ID and P.SHOP_ID=G.SHOP_ID and P.TENANT_ID=:TENANT_ID and P.SHOP_ID=:SHOP_ID and P.GODS_ID=:GODS_ID '+
         '        ) B on A.PRICE_ID=B.PRICE_ID '+
         ' order by A.PRICE_ID';
  cdsMemberPrice.Close;
  cdsMemberPrice.SQL.Text := sql;
  cdsMemberPrice.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  cdsMemberPrice.ParamByName('SHOP_ID').AsString := token.shopId;
  cdsMemberPrice.ParamByName('GODS_ID').AsString := GodsId;
  dataFactory.Open(cdsMemberPrice);
  cdsMemberPrice.DisableControls;
  try
    cdsMemberPrice.First;
    while not cdsMemberPrice.Eof do
      begin
        if (cdsMemberPrice.FieldByName('COMM').AsString = '02') or (cdsMemberPrice.FieldByName('COMM').AsString = '12') then
           begin
             cdsMemberPrice.Edit;
             cdsMemberPrice.FieldByName('PROFIT_RATE').Value := null;
             cdsMemberPrice.FieldByName('NEW_OUTPRICE').Value := null;
             cdsMemberPrice.FieldByName('NEW_OUTPRICE1').Value := null;
             cdsMemberPrice.FieldByName('NEW_OUTPRICE2').Value := null;
             cdsMemberPrice.Post;
           end;
        cdsMemberPrice.Next;
      end;
  finally
    cdsMemberPrice.EnableControls;
  end;
  CheckGoodPriceColumnVisible;
end;

class function TfrmMemberPrice.ShowDialog(AOwner:TForm;SObj:TRecord_): boolean;
begin
  with TfrmMemberPrice.Create(AOwner) do
    begin
      try
        GodsId := SObj.FieldByName('GODS_ID').AsString;
        GodsCode := SObj.FieldByName('GODS_CODE').AsString;
        GodsName := SObj.FieldByName('GODS_NAME').AsString;
        RelationId := SObj.FieldByName('RELATION_ID').AsInteger;
        RelationType := SObj.FieldByName('RELATION_TYPE').AsInteger;
        UsingBarter := SObj.FieldByName('USING_BARTER').AsInteger;
        BarterIntegral := SObj.FieldByName('BARTER_INTEGRAL').AsInteger;
        result := (ShowModal = MROK);
        if result then
           begin
             SObj.FieldByName('USING_BARTER').AsInteger := UsingBarter;
             SObj.FieldByName('BARTER_INTEGRAL').AsInteger := BarterIntegral;
           end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmMemberPrice.FormShow(Sender: TObject);
begin
  inherited;
  edtGODS_NAME.Text := GodsName;
  edtGODS_NAME.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_NAME.Style);
  edtBK_GODS_NAME.Color := edtGODS_NAME.Style.Color;

  edtGODS_CODE.Text := GodsCode;
  edtGODS_CODE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_CODE.Style);
  edtBK_GODS_CODE.Color := edtGODS_CODE.Style.Color;

  RzPanel3.Height := 52;
  self.ClientHeight := 385;

  if (RelationId=0) or (RelationType=1) then
     begin
       RzPanel3.Height := 100;
       self.ClientHeight := 433;
       if UsingBarter = 2 then
          begin
            rbUSING_BARTER2.Checked := true;
            edtBARTER_INTEGRAL1.Value := BarterIntegral;
            edtBARTER_INTEGRAL1.Enabled := true;
            edtBARTER_INTEGRAL2.Enabled := false;
          end
       else if UsingBarter = 3 then
          begin
            rbUSING_BARTER3.Checked := true;
            edtBARTER_INTEGRAL2.Value := BarterIntegral;
            edtBARTER_INTEGRAL1.Enabled := false;
            edtBARTER_INTEGRAL2.Enabled := true;
          end
       else
          begin
            rbUSING_BARTER1.Checked := true;
            edtBARTER_INTEGRAL1.Enabled := false;
            edtBARTER_INTEGRAL2.Enabled := false;
          end
     end;
  Open;
end;

procedure TfrmMemberPrice.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMemberPrice.PriceGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
  br := TBrush.Create;
  br.Assign(PriceGrid.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(PriceGrid.Canvas.Pen);
  try
  if (Rect.Top = PriceGrid.CellRect(PriceGrid.Col, PriceGrid.Row).Top) and (not
    (gdFocused in State) or not PriceGrid.Focused) then
  begin
    PriceGrid.Canvas.Font.Color := clBlack;
    PriceGrid.Canvas.Brush.Color := clWhite;
  end;
  PriceGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      PriceGrid.canvas.Brush.Color := PriceGrid.FixedColor;
      PriceGrid.canvas.FillRect(ARect);
      DrawText(PriceGrid.Canvas.Handle,pchar(Inttostr(cdsMemberPrice.RecNo)),length(Inttostr(cdsMemberPrice.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    PriceGrid.Canvas.Brush.Assign(br);
    PriceGrid.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmMemberPrice.PriceGridColumns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r: Real; MsgStr: string;
begin
  inherited;
  MsgStr:='';
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);

    if r > 100 then MsgStr:='输入的折扣率不能大于100...';

    if (VarIsNull(Value)) then
      begin
        r:=0;
        Text:='0';
      end
    else
      r:=Value;

    if r > 100 then
      begin
        r:=100;
        Text:='100';
      end;

    if (PriceGrid.DataSource.DataSet.Active) and (Value<>cdsMemberPrice.FieldByName('PROFIT_RATE').AsVariant) then
    begin
      if not (cdsMemberPrice.State in [dsEdit,dsInsert]) then cdsMemberPrice.Edit;
      cdsMemberPrice.FieldByName('PROFIT_RATE').AsString:=FloattoStr(r);
      cdsMemberPrice.Post;
      CalcMemberProfitPrice(cdsMemberPrice,0);
      if not (cdsMemberPrice.State in [dsEdit,dsInsert]) then cdsMemberPrice.Edit;
    end;
    if MsgStr <> '' then  Raise Exception.Create(MsgStr);
  except

  end;
end;

procedure TfrmMemberPrice.CalcMemberProfitPrice(cdsMemberPrice:TZQuery;CalcType:integer;IsAll:Boolean=false);
var
  rs:TZQuery;
  CurObj: TRecord_;
  ColIdx: integer;
  NewOutPrice,ProfitRate,SmallToCalc,BigToCalc:real;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',GodsId,[]) then Raise Exception.Create('经营商品中没有找到'+GodsName+'...');
  NewOutPrice := rs.FieldByName('NEW_OUTPRICE').AsFloat;
  SmallToCalc := rs.FieldByName('SMALLTO_CALC').AsFloat;
  BigToCalc := rs.FieldByName('BIGTO_CALC').AsFloat;
  if cdsMemberPrice.State=dsEdit then cdsMemberPrice.Post;
  if NewOutPrice<=0 then Exit;
  if not cdsMemberPrice.Active then Exit;
  try
    CurObj:=TRecord_.Create;
    CurObj.ReadFromDataSet(cdsMemberPrice);
    case CalcType of  // 0:根据折扣率计算折扣价  1: 根据折扣价计算折扣率
     0:
      begin
        ProfitRate:=StrtoFloatDef(CurObj.FieldByName('PROFIT_RATE').asstring,0);
        ProfitRate:=ProfitRate*0.01;
        if ProfitRate > 1 then ProfitRate := 1;
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) then
           CurObj.FieldByName('NEW_OUTPRICE').AsFloat:=ConvertToFight(NewOutPrice*ProfitRate,Deci);
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE1');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) and (SmallToCalc > 0) then
           CurObj.FieldByName('NEW_OUTPRICE1').AsFloat:=ConvertToFight(NewOutPrice*ProfitRate*SmallToCalc,Deci);
        ColIdx:=GetColumnIdx(PriceGrid,'NEW_OUTPRICE2');
        if (ColIdx>0) and (PriceGrid.Columns[ColIdx].Visible) and (BigToCalc > 0) then
           CurObj.FieldByName('NEW_OUTPRICE2').AsFloat:=ConvertToFight(NewOutPrice*ProfitRate*BigToCalc,Deci);
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
    if cdsMemberPrice.State=dsEdit then cdsMemberPrice.Edit;
    CurOBj.WriteToDataSet(cdsMemberPrice);
    if cdsMemberPrice.State=dsEdit then cdsMemberPrice.Edit;
       cdsMemberPrice.Post;
  finally
    CurOBj.Free;
  end;
end;

function TfrmMemberPrice.GetColumnIdx(Gird: TDBGridEh; ColName: string): integer;
var i: integer;
begin
  result:=0;
  for i:=0 to Gird.Columns.Count-1 do
  begin
    if trim(Gird.Columns[i].FieldName)=trim(ColName) then
       result:=i;
  end;
end;

function TfrmMemberPrice.ConvertToFight(value: Currency; deci: Integer): real;
begin
  result := FnNumber.ConvertToFight(value,CarryRule,deci);
end;

procedure TfrmMemberPrice.FormCreate(Sender: TObject);
begin
  inherited;
  Deci := StrtoIntDef(dllGlobal.GetParameter('POSDIGHT'),2);
  CarryRule := StrtoIntDef(dllGlobal.GetParameter('CARRYRULE'),0);
end;

procedure TfrmMemberPrice.PriceGridColumns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r: Real;
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
        MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
        Exit;
      end;
  end;

  if abs(r)>999999999 then Raise Exception.Create('  输入的数值过大，无效...  ');
  if (PriceGrid.DataSource.DataSet.Active) and (r<>cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat) then
  begin
    if not (cdsMemberPrice.State in [dsEdit,dsInsert]) then cdsMemberPrice.Edit;
    cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsString:=FloattoStr(r);
    cdsMemberPrice.Post;
    CalcMemberProfitPrice(cdsMemberPrice,1);
    if not (cdsMemberPrice.State in [dsEdit,dsInsert]) then cdsMemberPrice.Edit;
  end;
end;

procedure TfrmMemberPrice.PriceGridColumns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r: Real;
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(PriceGrid,'NEW_OUTPRICE1');
  if SetCol.Visible then
  begin
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
        MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
        Exit;
      end;
    end;
    if abs(r)>999999999 then Raise Exception.Create('  输入的数值过大，无效...  ');
  end;
end;

function TfrmMemberPrice.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count -1 do
  begin
    if UpperCase(DBGrid.Columns[i].FieldName)=UpperCase(FieldName) then
    begin
      result := DBGrid.Columns[i];
      Exit;
    end;
  end;
end;

procedure TfrmMemberPrice.PriceGridColumns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r: Real;
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(PriceGrid,'NEW_OUTPRICE2');
  if setCol.Visible then
  begin
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
        MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
        Exit;
      end;
    end;
    if abs(r)>999999999 then Raise Exception.Create('  输入的数值过大，无效...  ');
  end;
end;

procedure TfrmMemberPrice.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmMemberPrice.Save;
var
  str:string;
  Params:TftParamList;
  saveMemberPrice,tmpMemberPrice:TZQuery;
begin
  if rbUSING_BARTER2.Checked then
     begin
       UsingBarter := 2;
       if edtBARTER_INTEGRAL1.Value = 0 then Raise Exception.Create('积分兑换关系的不能为0..');
       BarterIntegral := edtBARTER_INTEGRAL1.Value;
     end
  else if rbUSING_BARTER3.Checked then
     begin
       UsingBarter := 3;
       if edtBARTER_INTEGRAL2.Value = 0 then Raise Exception.Create('积分兑换关系的不能为0..');
       BarterIntegral := edtBARTER_INTEGRAL2.Value;
     end
  else
     begin
       UsingBarter := 1;
       BarterIntegral := 0;
     end;

  WriteMemberPrice;
  dataFactory.UpdateBatch(cdsMemberPrice,'TGoodsPriceV60');

  if RelationId=0 then
     begin
       str := 'update PUB_GOODSINFO set USING_BARTER='+inttostr(UsingBarter)+',BARTER_INTEGRAL='+inttostr(BarterIntegral)+',COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and GODS_ID='''+GodsId+'''';
       dataFactory.ExecSQL(str);
     end
  else if RelationType=1 then
     begin
       str := 'update PUB_GOODS_RELATION set USING_BARTER='+inttostr(UsingBarter)+',BARTER_INTEGRAL='+inttostr(BarterIntegral)+',COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and GODS_ID='''+GodsId+''' and RELATION_ID='+inttostr(RelationId);
       dataFactory.ExecSQL(str);
     end;

  if dataFactory.iDbType <> 5 then
     begin
       if RelationId=0 then
          begin
            str := 'update PUB_GOODSINFO set USING_BARTER='+inttostr(UsingBarter)+',BARTER_INTEGRAL='+inttostr(BarterIntegral)+' where TENANT_ID='+token.tenantId+' and GODS_ID='''+GodsId+'''';
            dataFactory.sqlite.ExecSQL(str);
          end
       else if RelationType=1 then
          begin
            str := 'update PUB_GOODS_RELATION set USING_BARTER='+inttostr(UsingBarter)+',BARTER_INTEGRAL='+inttostr(BarterIntegral)+' where TENANT_ID='+token.tenantId+' and GODS_ID='''+GodsId+''' and RELATION_ID='+inttostr(RelationId);
            dataFactory.sqlite.ExecSQL(str);
          end;
     end;

  if dataFactory.iDbType <> 5 then
     begin
       tmpMemberPrice := TZQuery.Create(nil);
       saveMemberPrice := TZQuery.Create(nil);
       Params := TftParamList.Create(nil);
       try
         tmpMemberPrice.SQL.Text := ' select TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP '+
                                    ' from   PUB_GOODSPRICE '+
                                    ' where  TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID and PRICE_ID <> ''#'' ';
         tmpMemberPrice.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
         tmpMemberPrice.ParamByName('SHOP_ID').AsString := token.shopId;
         tmpMemberPrice.ParamByName('GODS_ID').AsString := GodsId;
         dataFactory.Open(tmpMemberPrice);
         saveMemberPrice.SyncDelta := tmpMemberPrice.SyncDelta;
         dataFactory.MoveToSqlite;
         try
           Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSPRICE';
           Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
           dataFactory.UpdateBatch(saveMemberPrice,'TSyncSingleTableV60',Params);
         finally
           dataFactory.MoveToDefault;
         end;
       finally
         Params.Free;
         saveMemberPrice.Free;
         tmpMemberPrice.Free;
       end;
     end;
  ModalResult := MROK;
end;

procedure TfrmMemberPrice.WriteMemberPrice;
  procedure InitPrice(NewOutPrice,ProfitRate,SmallToCalc,BigToCalc:real);
  begin
    if not (cdsMemberPrice.State in [dsEdit,dsInsert]) then cdsMemberPrice.Edit;

    if (cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat = 0) and (ProfitRate > 0) and (NewOutPrice > 0)  then
       cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat := ConvertToFight(NewOutPrice*ProfitRate,Deci);

    if cdsMemberPrice.FieldByName('NEW_OUTPRICE1').AsFloat <= 0 then
       begin
         if (SmallToCalc > 0) and (cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat > 0) then
            cdsMemberPrice.FieldByName('NEW_OUTPRICE1').AsFloat := ConvertToFight(cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat*SmallToCalc,Deci);
       end;

    if cdsMemberPrice.FieldByName('NEW_OUTPRICE2').AsFloat <= 0 then
       begin
         if (BigToCalc > 0 ) and (cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat > 0) then
            cdsMemberPrice.FieldByName('NEW_OUTPRICE2').AsFloat := ConvertToFight(cdsMemberPrice.FieldByName('NEW_OUTPRICE').AsFloat*BigToCalc,Deci);
       end;

    cdsMemberPrice.Post;
  end;
var
  rs:TZQuery;
  recNo:integer;
  CurObj:TRecord_;
  NewOutPrice,ProfitRate,SmallToCalc,BigToCalc:real;
begin
  if not cdsMemberPrice.Active then Exit;
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',GodsId,[]) then Raise Exception.Create('经营商品中没有找到'+GodsName+'...');
  NewOutPrice := rs.FieldByName('NEW_OUTPRICE').AsFloat;
  SmallToCalc := rs.FieldByName('SMALLTO_CALC').AsFloat;
  BigToCalc := rs.FieldByName('BIGTO_CALC').AsFloat;
  try
    CurObj:=TRecord_.Create;

    cdsMemberPrice.First;
    while not cdsMemberPrice.Eof do
    begin
      ProfitRate:=cdsMemberPrice.FieldByName('PROFIT_RATE').AsFloat * 0.01;

      if cdsMemberPrice.FieldByName('STATE').AsString = 'insert' then
         begin
           if ProfitRate > 0 then
              begin
                CurObj.ReadFromDataSet(cdsMemberPrice);
                recNo := cdsMemberPrice.RecNo;
                cdsMemberPrice.Delete;
                cdsMemberPrice.Append;
                CurObj.FieldByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
                CurObj.FieldByName('SHOP_ID').AsString:=token.shopId;
                CurObj.FieldByName('GODS_ID').AsString:=GodsId;
                CurObj.FieldByName('PRICE_METHOD').AsString:='1';
                CurObj.WriteToDataSet(cdsMemberPrice);
                cdsMemberPrice.Post;
                InitPrice(NewOutPrice,ProfitRate,SmallToCalc,BigToCalc);
                cdsMemberPrice.Edit;
                cdsMemberPrice.FieldByName('STATE').AsString := '';
                cdsMemberPrice.Post;
                cdsMemberPrice.RecNo :=recNo;
              end
           else cdsMemberPrice.Delete;
         end
      else if cdsMemberPrice.FieldByName('STATE').AsString = 'update' then
         begin
           if ProfitRate > 0 then
              begin
                InitPrice(NewOutPrice,ProfitRate,SmallToCalc,BigToCalc);
                cdsMemberPrice.Edit;
                cdsMemberPrice.FieldByName('STATE').AsString := '';
                cdsMemberPrice.Post;
                cdsMemberPrice.Next;
              end
           else cdsMemberPrice.Delete;
         end
      else cdsMemberPrice.Next;
    end;
  finally
    CurObj.Free;
  end;
end;

procedure TfrmMemberPrice.rbUSING_BARTER1Click(Sender: TObject);
begin
  inherited;
  edtBARTER_INTEGRAL1.Value := 0;
  edtBARTER_INTEGRAL2.Value := 0;
  edtBARTER_INTEGRAL1.Enabled := false;
  edtBARTER_INTEGRAL2.Enabled := false;
end;

procedure TfrmMemberPrice.rbUSING_BARTER2Click(Sender: TObject);
begin
  inherited;
  edtBARTER_INTEGRAL1.Value := 0;
  edtBARTER_INTEGRAL2.Value := 0;
  edtBARTER_INTEGRAL1.Enabled := true;
  edtBARTER_INTEGRAL2.Enabled := false;
end;

procedure TfrmMemberPrice.rbUSING_BARTER3Click(Sender: TObject);
begin
  inherited;
  edtBARTER_INTEGRAL1.Value := 0;
  edtBARTER_INTEGRAL2.Value := 0;
  edtBARTER_INTEGRAL1.Enabled := false;
  edtBARTER_INTEGRAL2.Enabled := true;
end;

end.
