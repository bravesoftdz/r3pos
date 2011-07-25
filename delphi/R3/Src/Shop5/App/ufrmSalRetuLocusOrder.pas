unit ufrmSalRetuLocusOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,ufrmBasic;

type
  TfrmSalRetuLocusOrder = class(TframeOrderForm)
    N1: TMenuItem;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label4: TLabel;
    edtJH: TcxTextEdit;
    Label5: TLabel;
    edtSM: TcxTextEdit;
    Label6: TLabel;
    edtWT: TcxTextEdit;
    Label7: TLabel;
    edtPZJH: TcxTextEdit;
    Label10: TLabel;
    edtPZSM: TcxTextEdit;
    Label11: TLabel;
    edtPZWT: TcxTextEdit;
    cdsLocusNo: TZQuery;
    Shape2: TShape;
    Shape3: TShape;
    Label13: TLabel;
    Label14: TLabel;
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label40: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label18: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtSALES_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtGUIDE_USER: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtSEND_ADDR: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    edtLINKMAN: TcxTextEdit;
    edtSALE_STYLE: TzrComboBoxList;
    edtPLAN_DATE: TcxDateEdit;
    edtINDE_GLIDE_NO: TcxButtonEdit;
    edtDEPT_ID: TzrComboBoxList;
    Label1: TLabel;
    Label9: TLabel;
    edtLOCUS_CHK_DATE: TcxTextEdit;
    edtLOCUS_CHK_USER_TEXT: TcxTextEdit;
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsLocusNoFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
    function  CheckCanExport: boolean; override;
  protected
    function CheckInput:boolean;override;
    procedure SetInputFlag(const Value: integer);override;
    procedure SetdbState(const Value: TDataSetState); override;
  public
    { Public declarations }
    function  Calc:real;
    procedure ReadFrom(DataSet:TDataSet);override;
    function PriorLocusNo:boolean;
    function NextLocusNo(flag:integer=0):boolean;
    //输入跟踪号
    function GodsToLocusNo(id:string):boolean;override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
  end;

implementation
uses uGlobal,uShopUtil,uDsUtil,uFnUtil,uShopGlobal,ufrmLocusNoProperty;
{$R *.dfm}

procedure TfrmSalRetuLocusOrder.CancelOrder;
begin
  Open(oid);
end;

procedure TfrmSalRetuLocusOrder.DeleteOrder;
var
  bs:TZQuery;
begin
  inherited;
  if dbState = dsBrowse then Raise Exception.Create('不在收货状态不能操作此功能.');
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能再扫码.');
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
  if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
     begin
       MessageBox(Handle,'当前选中的商品没有启动物流跟踪码','友情提示..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  with TfrmLocusNoProperty.Create(self) do
     begin
       try
         cdsLocusNo.Filtered := false;
         cdsLocusNo.Filtered := true;
         dbState := self.dbState;
         DataSet := cdsLocusNo;
         Form := self;
         LocusNo(edtTable);
         ShowModal;
         if dbState <> dsBrowse then
            Calc;
       finally
         free;
       end;
     end;
end;

procedure TfrmSalRetuLocusOrder.EditOrder;
begin
  inherited;
end;

procedure TfrmSalRetuLocusOrder.NewOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if not IsAudit then Raise Exception.Create('没有审核的单据不能收货.');
  edtInput.Properties.ReadOnly := false;
  edtInput.Style.Color := clWhite;
  if Visible and edtInput.CanFocus then edtInput.SetFocus;
  if not NextLocusNo(-1) then
     begin
     end
  else
     begin
     end;
  dbState := dsEdit;
end;

procedure TfrmSalRetuLocusOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := cid;
    Params.ParamByName('SALES_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TSalRetuForLocusNoHeader',Params);
      Factor.AddBatch(cdsDetail,'TSalRetuData',Params);
      Factor.AddBatch(cdsLocusNo,'TSalRetuForLocusNo',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('LOCUS_CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('SALES_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    Calc;
    edtTable.First;
  finally
    Params.Free;
  end;
end;

procedure TfrmSalRetuLocusOrder.SaveOrder;
var
  r:integer;
  Params:TftParamList;
begin
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.Eof do
      begin
        if edtTable.FieldbyName('BAL_AMT').AsInteger <>0 then Raise Exception.Create('当前商品扫码数据不正确，请核对后再保存');
        edtTable.Next;
      end;
  finally
    edtTable.EnableControls;
  end;
  cdsLocusNo.Filtered := false;
  cdsLocusNo.First;
  r := 0;
  while not cdsLocusNo.Eof do
    begin
      cdsLocusNo.Edit;
      cdsLocusNo.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
      cdsLocusNo.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
      cdsLocusNo.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
      cdsLocusNo.FieldByName('LOCUS_DATE').asInteger := StrtoInt(formatDatetime('YYYYMMDD',date()));
      cdsLocusNo.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
      cdsLocusNo.FieldByName('CREA_USER').AsString := Global.UserId;
      inc(r);
      cdsLocusNo.FieldByName('SEQNO').AsInteger := r;
      cdsLocusNo.Next;
    end;
  cdsHeader.Edit;
  cdsHeader.FieldbyName('LOCUS_STATUS').AsString := '3';
  cdsHeader.FieldbyName('LOCUS_USER').AsString := Global.UserID;
  cdsHeader.FieldbyName('LOCUS_DATE').AsString := formatDatetime('YYYY-MM-DD',Date());
  cdsHeader.FieldbyName('LOCUS_AMT').AsInteger := r;
  cdsHeader.Post;
  Params := TftParamList.Create(nil);
  try
    Factor.BeginBatch;
    try
      Params.ParambyName('SALES_TYPE').asInteger := cdsHeader.FieldbyName('SALES_TYPE').asInteger;
      Factor.AddBatch(cdsHeader,'TSalRetuForLocusNoHeader',Params);
      Factor.AddBatch(cdsLocusNo,'TSalRetuForLocusNo',Params);
      Factor.CommitBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    Params.free;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

function TfrmSalRetuLocusOrder.Calc:real;
var
  r,amt:integer;
  pzjh:real;
  pzsm:real;
  pzwt:real;
  jh:real;
  sm:real;
  wt:real;
  convRate:real;
  bs:TZQuery;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    pzjh := 0;
    pzsm := 0;
    pzwt := 0;
    jh := 0;
    sm := 0;
    wt := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        if not bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'在经营商品中没有找到.');
        jh := jh + edtTable.FieldbyName('AMOUNT').AsFloat;
        pzjh := pzjh + 1;
        if (bs.FieldByName('USING_LOCUS_NO').AsString = '1') then
           begin
              cdsLocusNo.Filtered := false;
              cdsLocusNo.Filtered := true;
              amt := 0;
              cdsLocusNo.First;
              while not cdsLocusNo.Eof do
                begin
                  amt := amt + cdsLocusNo.FieldbyName('CALC_AMOUNT').AsInteger;
                  cdsLocusNo.Next;
                end;
              if bs.FieldByName('BIG_UNITS').AsString=edtTable.FieldbyName('UNIT_ID').AsString then
                 convRate := bs.FieldbyName('BIGTO_CALC').AsFloat
              else
              if bs.FieldByName('SMALL_UNITS').AsString=edtTable.FieldbyName('UNIT_ID').AsString then
                 convRate := bs.FieldbyName('SMALLTO_CALC').AsFloat
              else
                 convRate := 1;
              edtTable.Edit;
              edtTable.FieldByName('LOCUS_AMT').asFloat := amt / convRate;
              edtTable.FieldByName('BAL_AMT').asFloat := edtTable.FieldbyName('AMOUNT').AsFloat- edtTable.FieldbyName('LOCUS_AMT').AsFloat;
              edtTable.Post;
              if edtTable.FieldByName('BAL_AMT').asFloat=0 then
                 begin
                   pzsm := pzsm + 1
                 end else pzwt := pzwt+1;;
              sm := sm + edtTable.FieldbyName('LOCUS_AMT').AsFloat;
              wt := wt + edtTable.FieldbyName('BAL_AMT').AsFloat;
           end
        else
           begin
             edtTable.Edit;
             edtTable.FieldByName('BAL_AMT').asFloat := 0;
             edtTable.FieldByName('LOCUS_AMT').asFloat := 0;
             edtTable.Post;
           end;
        edtTable.Next;
      end;
    edtJH.Text := formatFloat('#0.0',jh);
    edtSM.Text := formatFloat('#0.0',sm);
    edtWT.Text := formatFloat('#0.0',wt);
    edtPZJH.Text := formatFloat('#0.0',pzjh);
    edtPZSM.Text := formatFloat('#0.0',pzsm);
    edtPZWT.Text := formatFloat('#0.0',pzwt);
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

procedure TfrmSalRetuLocusOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;

end;

procedure TfrmSalRetuLocusOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmSalRetuLocusOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
        edtTable.DisableControls;
        try
          edtTable.First;
          while not edtTable.Eof do
            begin
              if edtTable.FieldbyName('BAL_AMT').AsInteger <>0 then Raise Exception.Create('当前商品扫码数据不正确，请核对后再审核');
              edtTable.Next;
            end;
        finally
          edtTable.EnableControls;
        end;
       if cdsHeader.FieldByName('LOCUS_CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前退货单执行弃审');
       if MessageBox(Handle,'确认弃审当前退货单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if MessageBox(Handle,'确认审核当前退货单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SALES_ID').asString := cdsHeader.FieldbyName('SALES_ID').AsString;
      Params.ParamByName('LOCUS_CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('LOCUS_CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TSalRetuLocusNoAudit',Params)
      else
         Msg := Factor.ExecProc('TSalRetuLocusNoUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    IsAudit := not IsAudit;
    if IsAudit then
       begin
         edtLOCUS_CHK_DATE.Text := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         edtLOCUS_CHK_USER_TEXT.Text := Global.UserName;
         AObj.FieldByName('LOCUS_CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         AObj.FieldByName('LOCUS_CHK_USER').AsString := Global.UserID;
       end
    else
       begin
         edtLOCUS_CHK_DATE.Text := '';
         edtLOCUS_CHK_USER_TEXT.Text := '';
         AObj.FieldByName('LOCUS_CHK_DATE').AsString := '';
         AObj.FieldByName('LOCUS_CHK_USER').AsString := '';
       end;
    cdsHeader.Edit;
    cdsHeader.FieldByName('LOCUS_CHK_DATE').AsString := AObj.FieldByName('LOCUS_CHK_DATE').AsString;
    cdsHeader.FieldByName('LOCUS_CHK_USER').AsString := AObj.FieldByName('LOCUS_CHK_USER').AsString;
    cdsHeader.Post;
    cdsHeader.CommitUpdates;
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmSalRetuLocusOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

function TfrmSalRetuLocusOrder.GodsToLocusNo(id: string): boolean;
var
  rs,bs:TZQuery;
  AObj:TRecord_;
  r:boolean;
  sr:real;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
  if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then Raise Exception.Create('当前商品没有启用物流跟踪码...');
  if id = '' then Raise Exception.Create('输入的物流跟踪号无效');
  result := false;
  rs := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
    rs.SQL.Text :=
      'select distinct LOCUS_NO from STK_LOCUS_FORSTCK A where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.GODS_ID='''+edtTable.FieldbyName('GODS_ID').AsString+''' and A.SHOP_ID='''+cid+''' and A.LOCUS_NO='''+id+''' ';
    Factor.Open(rs);
    if rs.IsEmpty and (ShopGlobal.GetParameter('LOCUS_NO_MT')<>'1') then
       begin
         windows.beep(2000,500);
         lblHint.Caption := '无效的物流跟踪号:'+id;
         Exit;
       end;
    if rs.RecordCount =0 then
       begin
         //if MessageBox(Handle,'当前物流跟踪码没有入库，是否强制手工出库？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
         AObj.ReadFromDataSet(edtTable);
       end
    else
       begin
         AObj.ReadFromDataSet(edtTable);
       end;
     r := false;// cdsLocusNo.Locate('GODS_ID;BATCH_NO;UNIT_ID;PROPERTY_01,PROPERTY_02;LOCUS_NO',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,AObj.FieldbyName('BATCH_NO').AsString,AObj.FieldbyName('UNIT_ID').AsString,AObj.FieldbyName('PROPERTY_01').AsString,AObj.FieldbyName('PROPERTY_02').AsString,id]),[]);
     if not r then
     begin
        cdsLocusNo.Append;
        AObj.WriteToDataSet(cdsLocusNo,false);
        cdsLocusNo.FieldByName('AMOUNT').AsFloat := 1;
        if cdsLocusNo.FieldByName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').asString then
           sr := bs.FieldbyName('SMALLTO_CALC').AsFloat
        else
        if cdsLocusNo.FieldByName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').asString then
           sr := bs.FieldbyName('BIGTO_CALC').AsFloat
        else
           sr := 1;
        cdsLocusNo.FieldByName('CALC_AMOUNT').AsFloat := 1*sr;
        cdsLocusNo.FieldByName('LOCUS_NO').AsString := id;
        cdsLocusNo.Post;
        if edtTable.FieldbyName('BAL_AMT').asFloat<0 then
           begin
              windows.beep(2000,500);
              lblHint.Caption := '当前商品已经扫码完毕了。';
           end
        else
           begin
             lblHint.Caption := '扫码成功,数量:'+edtTable.FieldbyName('LOCUS_AMT').asString;
             MessageBeep(0);
           end;
     end else
        begin
          windows.beep(2000,500);
          lblHint.Caption := '当前物流跟踪号已经输入，不能重复输入,跟踪号为:'+id;
        end;
  finally
    AObj.Free;
    rs.Free;
  end;
end;

function TfrmSalRetuLocusOrder.CheckInput: boolean;
begin
  result := (pos(inttostr(InputFlag),'7')>0);
end;

function TfrmSalRetuLocusOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('11200001',7);
end;

procedure TfrmSalRetuLocusOrder.FormCreate(Sender: TObject);
begin
  inherited;
  InputFlag := 7;
  Shape2.Brush.Color := RowSelectColor;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '退货仓库';
    end;
end;

procedure TfrmSalRetuLocusOrder.ReadFrom(DataSet: TDataSet);
var
  i:integer;
  r:boolean;
begin
  edtTable.FindField('AMOUNT').Tag := 1;
  edtTable.FindField('CALC_AMOUNT').Tag := 1;
  edtTable.DisableControls;
  try
  edtProperty.Close;
  edtTable.Close;
  edtProperty.CreateDataSet;
  edtTable.CreateDataSet;
  RowID := 0;
  DataSet.First;
  while not DataSet.Eof do
    begin
      r := edtTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;PROPERTY_01;PROPERTY_02',
              VarArrayOf([DataSet.FieldbyName('GODS_ID').AsString,
                        DataSet.FieldbyName('BATCH_NO').AsString,
                        DataSet.FieldbyName('UNIT_ID').AsString,DataSet.FieldbyName('PROPERTY_01').AsString,DataSet.FieldbyName('PROPERTY_02').AsString]),[]);
      if r then
      begin
        edtTable.Edit;
        for i:=0 to edtTable.Fields.Count -1 do
          begin
            if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
            begin
              if CheckSumField(edtTable.Fields[i].FieldName) then
                edtTable.Fields[i].Value := edtTable.Fields[i].Value + DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value
              else
                edtTable.Fields[i].Value := DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
            end;
          end;
        edtTable.Post;
      end
      else
      begin
        edtTable.Append;
        for i:=0 to edtTable.Fields.Count -1 do
          begin
             if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
                edtTable.Fields[i].Value := DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
          end;
        inc(RowID);
        edtTable.FieldbyName('SEQNO').AsInteger := RowID;
        edtTable.FieldbyName('BARCODE').AsString := EnCodeBarcode;
        edtTable.Post;
      end;
      DataSet.Next;
    end;
    edtTable.SortedFields := 'SEQNO';
  finally
    edtTable.EnableControls;
  end;
end;

procedure TfrmSalRetuLocusOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if edtTable.FieldbyName('BAL_AMT').AsInteger =  0 then
     Background := Shape3.Brush.Color;
end;

procedure TfrmSalRetuLocusOrder.cdsLocusNoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept :=
    (DataSet.FieldByName('GODS_ID').AsString=edtTable.FieldbyName('GODS_ID').AsString)
    and
    (DataSet.FieldByName('BATCH_NO').AsString=edtTable.FieldbyName('BATCH_NO').AsString)
    and
    (DataSet.FieldByName('PROPERTY_01').AsString=edtTable.FieldbyName('PROPERTY_01').AsString)
    and
    (DataSet.FieldByName('PROPERTY_02').AsString=edtTable.FieldbyName('PROPERTY_02').AsString)
    and
    (DataSet.FieldByName('UNIT_ID').AsString=edtTable.FieldbyName('UNIT_ID').AsString);
end;

procedure TfrmSalRetuLocusOrder.edtInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  if Key=#13 then
    begin
      GodsToLocusNo(edtInput.Text);
      edtInput.Text := '';
      Key := #0;
    end;
end;

function TfrmSalRetuLocusOrder.NextLocusNo(flag:integer=0):boolean;
var
  bs:TZQuery;
begin
  result := false;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if flag=0 then edtTable.Next;
  while not edtTable.Eof do
    begin
      if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
      if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
         edtTable.Next else begin result := true;break;end;
    end;
end;

procedure TfrmSalRetuLocusOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  case Value of
    dsBrowse:lblState.Caption := '状态:浏览';
  else
    lblState.Caption := '状态:扫码';
  end;
  DBGridEh1.ReadOnly := true;
end;

procedure TfrmSalRetuLocusOrder.edtInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
  if Key = VK_UP then
     begin
       if PriorLocusNo then
          begin
            edtTable.Last;
            PriorLocusNo;
          end;
     end;
  if Key=VK_DOWN then
     begin
       if NextLocusNo then
          begin
            edtTable.First;
            NextLocusNo;
          end;
     end;
end;

procedure TfrmSalRetuLocusOrder.SetInputFlag(const Value: integer);
begin
  inherited SetInputFlag(7);

end;

procedure TfrmSalRetuLocusOrder.DBGridEh1DblClick(Sender: TObject);
begin
//  inherited;
  DeleteOrder;
end;

function TfrmSalRetuLocusOrder.PriorLocusNo: boolean;
var
  bs:TZQuery;
begin
  result := false;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtTable.Prior;
  while not edtTable.Eof do
    begin
      if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
      if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
         begin
           edtTable.Prior;
           if edtTable.Bof then Exit;
         end else begin result := true;break;end;
    end;
end;

end.
