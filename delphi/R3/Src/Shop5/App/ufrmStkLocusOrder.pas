unit ufrmStkLocusOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,ufrmBasic;

type
  TfrmStkLocusOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtSTOCK_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtGUIDE_USER: TzrComboBoxList;
    N1: TMenuItem;
    edtCLIENT_ID: TzrComboBoxList;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label12: TLabel;
    edtINDE_GLIDE_NO: TcxButtonEdit;
    Label3: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
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
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1Columns6EditButtonClick(Sender: TObject;
      var Handled: Boolean);
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
    //������ٺ�
    function GodsToLocusNo(id:string):boolean;
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

procedure TfrmStkLocusOrder.CancelOrder;
begin
  Open(oid);
end;

procedure TfrmStkLocusOrder.DeleteOrder;
var
  bs:TZQuery;
begin
  inherited;
  if dbState = dsBrowse then Raise Exception.Create('����ɨ��״̬���ܲ����˹���.');

  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ�����ĵ��ݲ����ظ�����');
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('�ھ�ӪƷ����û�ҵ�.');
  if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then MessageBox(Handle,'��ǰѡ�е���Ʒû����������������','������ʾ..',MB_OK+MB_ICONINFORMATION);
  if MessageBox(Handle,'�Ƿ������ǰ��Ʒ��ɨ�����룿','������ʾ...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  cdsLocusNo.Filtered := false;
  cdsLocusNo.Filtered := true;
  cdsLocusNo.First;
  while not cdsLocusNo.Eof do cdsLocusNo.Delete;
  Calc;
end;

procedure TfrmStkLocusOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ�����ĵ��ݲ����ظ�����');
  edtInput.Properties.ReadOnly := false;
  edtInput.Style.Color := clWhite;
  if Visible and edtInput.CanFocus then edtInput.SetFocus;
  if not NextLocusNo then MessageBox(Handle,'��ǰѡ�еĵ���û����Ҫɨ�����Ʒ','������ʾ...',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmStkLocusOrder.NewOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ�����ɨ����');
  edtInput.Properties.ReadOnly := false;
  edtInput.Style.Color := clWhite;
  if Visible and edtInput.CanFocus then edtInput.SetFocus;
  if not NextLocusNo(-1) then MessageBox(Handle,'��ǰѡ�еĵ���û����Ҫɨ�����Ʒ','������ʾ...',MB_OK+MB_ICONINFORMATION);
  dbState := dsEdit;
end;

procedure TfrmStkLocusOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := cid;
    Params.ParamByName('STOCK_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TStockOrder',Params);
      Factor.AddBatch(cdsDetail,'TStockData',Params);
      Factor.AddBatch(cdsLocusNo,'TStockForLocusNo',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 �ᵽReadFromObject֮ǰ
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('STOCK_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    Calc;
    edtTable.First;
  finally
    Params.Free;
  end;
end;

procedure TfrmStkLocusOrder.SaveOrder;
var
  r:integer;
begin
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.Eof do
      begin
        if edtTable.FieldbyName('BAL_AMT').AsInteger <>0 then Raise Exception.Create('��ǰ��Ʒɨ�����ݲ���ȷ����˶Ժ��ٱ���');
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
      cdsLocusNo.FieldByName('STOCK_ID').AsString := cdsHeader.FieldbyName('STOCK_ID').AsString;
      cdsLocusNo.FieldByName('LOCUS_DATE').asInteger := StrtoInt(formatDatetime('YYYYMMDD',date()));
      cdsLocusNo.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
      cdsLocusNo.FieldByName('CREA_USER').AsString := Global.UserId;
      inc(r);
      cdsLocusNo.FieldByName('SEQNO').AsInteger := r;
      cdsLocusNo.Next;
    end;
  Factor.UpdateBatch(cdsLocusNo,'TStockForLocusNo');
  dbState := dsBrowse;
end;

function TfrmStkLocusOrder.Calc:real;
var
  r,amt:integer;
  pzjh:real;
  pzsm:real;
  pzwt:real;
  jh:real;
  sm:real;
  wt:real;
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
        if not bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'�ھ�Ӫ��Ʒ��û���ҵ�.');
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
                  amt := amt + cdsLocusNo.FieldbyName('AMOUNT').AsInteger;
                  cdsLocusNo.Next;
                end;
              sm := sm + amt;
              wt := wt + amt;
              edtTable.Edit;
              edtTable.FieldByName('BAL_AMT').asFloat := edtTable.FieldbyName('AMOUNT').AsFloat-amt;
              edtTable.FieldByName('LOCUS_AMT').asFloat := amt;
              edtTable.Post;
           end
        else
           begin
             pzwt := pzwt+1;
             wt := wt + edtTable.FieldbyName('AMOUNT').AsFloat;
             sm := sm + edtTable.FieldbyName('AMOUNT').AsFloat;
             edtTable.Edit;
             edtTable.FieldByName('BAL_AMT').asFloat := 0;
             edtTable.FieldByName('LOCUS_AMT').asFloat := 0;
             edtTable.Post;
           end;
        edtTable.Next;
      end;
    edtJH.Text := formatFloat('#0.0',jh);
    edtSM.Text := formatFloat('#0.0',sm);
    edtWT.Text := formatFloat('#0.0',jh-wt);
    edtPZJH.Text := formatFloat('#0.0',pzjh);
    edtPZSM.Text := formatFloat('#0.0',pzsm);
    edtPZWT.Text := formatFloat('#0.0',pzjh-pzwt);
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

procedure TfrmStkLocusOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;

end;

procedure TfrmStkLocusOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmStkLocusOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('������˿յ���');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ������ִ������');
       if MessageBox(Handle,'ȷ������ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
       if MessageBox(Handle,'ȷ����˵�ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('STOCK_ID').asString := cdsHeader.FieldbyName('STOCK_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TStockOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TStockOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    IsAudit := not IsAudit;
    if IsAudit then
       begin
         edtCHK_DATE.Text := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         edtCHK_USER_TEXT.Text := Global.UserName;
         AObj.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         AObj.FieldByName('CHK_USER').AsString := Global.UserID;
       end
    else
       begin
         edtCHK_DATE.Text := '';
         edtCHK_USER_TEXT.Text := '';
         AObj.FieldByName('CHK_DATE').AsString := '';
         AObj.FieldByName('CHK_USER').AsString := '';
       end;
    cdsHeader.Edit;
    cdsHeader.FieldByName('CHK_DATE').AsString := AObj.FieldByName('CHK_DATE').AsString;
    cdsHeader.FieldByName('CHK_USER').AsString := AObj.FieldByName('CHK_USER').AsString;
    cdsHeader.Post;
    cdsHeader.CommitUpdates;
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
end;

procedure TfrmStkLocusOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

function TfrmStkLocusOrder.GodsToLocusNo(id: string): boolean;
var
  rs,bs:TZQuery;
  AObj:TRecord_;
  r:boolean;
  sr:real;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('�ھ�ӪƷ����û�ҵ�.');
  if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then Raise Exception.Create('��ǰ��Ʒû����������������...');
  if id = '' then Raise Exception.Create('������������ٺ���Ч');
  result := false;
  rs := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
     AObj.ReadFromDataSet(edtTable);
     r := cdsLocusNo.Locate('GODS_ID;BATCH_NO;UNIT_ID;PROPERTY_01,PROPERTY_02;LOCUS_NO',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,AObj.FieldbyName('BATCH_NO').AsString,AObj.FieldbyName('UNIT_ID').AsString,AObj.FieldbyName('PROPERTY_01').AsString,AObj.FieldbyName('PROPERTY_02').AsString,id]),[]);
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
        MessageBeep(0);
        Calc;
        lblHint.Caption := 'ɨ��ɹ�,����:'+edtTable.FieldbyName('LOCUS_AMT').asString;
     end else
        begin
          windows.beep(2000,500);
          lblHint.Caption := '��ǰ�������ٺ��Ѿ����룬�����ظ�����,���ٺ�Ϊ:'+id;
        end;
  finally
    AObj.Free;
    rs.Free;
  end;
end;

function TfrmStkLocusOrder.CheckInput: boolean;
begin
  result := (pos(inttostr(InputFlag),'7')>0);
end;

function TfrmStkLocusOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('11200001',7);
end;

procedure TfrmStkLocusOrder.FormCreate(Sender: TObject);
begin
  inherited;
  InputFlag := 7;
  Shape2.Brush.Color := RowSelectColor;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '�����ֿ�';
    end;
end;

procedure TfrmStkLocusOrder.ReadFrom(DataSet: TDataSet);
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
              case edtTable.Fields[i].Tag of
              1:edtTable.Fields[i].Value := edtTable.Fields[i].Value + DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
              else
                edtTable.Fields[i].Value := DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
              end;
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

procedure TfrmStkLocusOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if edtTable.FieldbyName('BAL_AMT').AsInteger =  0 then
     Background := Shape3.Brush.Color;
end;

procedure TfrmStkLocusOrder.cdsLocusNoFilterRecord(DataSet: TDataSet;
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

procedure TfrmStkLocusOrder.edtInputKeyPress(Sender: TObject;
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

procedure TfrmStkLocusOrder.DBGridEh1CellClick(Column: TColumnEh);
begin
//  inherited;
  if Column.FieldName='LOCUS_AMT' then
     begin
       with TfrmLocusNoProperty.Create(self) do
         begin
           try
             cdsLocusNo.Filtered := false;
             cdsLocusNo.Filtered := true;
             dbState := self.dbState;
             DataSet := cdsLocusNo;
             ShowModal;
             if dbState <> dsBrowse then
                Calc;
           finally
             free;
           end;
         end;
     end;
end;

function TfrmStkLocusOrder.NextLocusNo(flag:integer=0):boolean;
var
  bs:TZQuery;
begin
  result := false;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if flag=0 then edtTable.Next;
  while not edtTable.Eof do
    begin
      if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('�ھ�ӪƷ����û�ҵ�.');
      if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
         edtTable.Next else begin result := true;break;end;
    end;
end;

procedure TfrmStkLocusOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  case Value of
    dsBrowse:lblState.Caption := '״̬:���';
  else
    lblState.Caption := '״̬:ɨ��';
  end;
  DBGridEh1.ReadOnly := true;
end;

procedure TfrmStkLocusOrder.edtInputKeyDown(Sender: TObject; var Key: Word;
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
  if Key = VK_DOWN then
     begin
       if NextLocusNo then
          begin
            edtTable.First;
            NextLocusNo;
          end;
     end;
end;

procedure TfrmStkLocusOrder.DBGridEh1Columns6EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
  DBGridEh1CellClick(DBGridEh1.FieldColumns['LOCUS_AMT']);
end;

procedure TfrmStkLocusOrder.SetInputFlag(const Value: integer);
begin
  inherited SetInputFlag(7);

end;

procedure TfrmStkLocusOrder.DBGridEh1DblClick(Sender: TObject);
begin
//  inherited;

end;

function TfrmStkLocusOrder.PriorLocusNo: boolean;
var
  bs:TZQuery;
begin
  result := false;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtTable.Prior;
  while not edtTable.Eof do
    begin
      if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('�ھ�ӪƷ����û�ҵ�.');
      if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
         begin
           edtTable.Prior;
           if edtTable.Bof then Exit;
         end else begin result := true;break;end;
    end;
end;

end.
