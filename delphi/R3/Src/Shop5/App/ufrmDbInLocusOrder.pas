unit ufrmDbInLocusOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,ufrmBasic;

type
  TfrmDbInLocusOrder = class(TframeOrderForm)
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
    Label9: TLabel;
    Label12: TLabel;
    edtLOCUS_CHK_DATE: TcxTextEdit;
    edtLOCUS_CHK_USER_TEXT: TcxTextEdit;
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label40: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtSALES_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtGUIDE_USER: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtPLAN_DATE: TcxDateEdit;
    edtSTOCK_USER: TzrComboBoxList;
    edtCLIENT_ID: TzrComboBoxList;
    edtSEND_ADDR: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    edtLINKMAN: TcxTextEdit;
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

procedure TfrmDbInLocusOrder.CancelOrder;
begin
  Open(oid);
end;

procedure TfrmDbInLocusOrder.DeleteOrder;
var
  bs:TZQuery;
begin
  inherited;
  if dbState = dsBrowse then Raise Exception.Create('���ڷ���״̬���ܲ����˹���.');
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ�����ɨ��.');
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('�ھ�ӪƷ����û�ҵ�.');
  if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then
     begin
       MessageBox(Handle,'��ǰѡ�е���Ʒû����������������','������ʾ..',MB_OK+MB_ICONINFORMATION);
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

procedure TfrmDbInLocusOrder.EditOrder;
begin
  inherited;
end;

procedure TfrmDbInLocusOrder.NewOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ����ٷ���.');
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

procedure TfrmDbInLocusOrder.Open(id: string);
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
      Factor.AddBatch(cdsHeader,'TDbForInLocusNoHeader',Params);
      Factor.AddBatch(cdsDetail,'TDbData',Params);
      Factor.AddBatch(cdsLocusNo,'TDbForLocusNo',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 �ᵽReadFromObject֮ǰ
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

procedure TfrmDbInLocusOrder.SaveOrder;
var
  r:integer;
  Params:TftParamList;
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
      cdsLocusNo.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
      cdsLocusNo.FieldByName('LOCUS_DATE').asInteger := StrtoInt(formatDatetime('YYYYMMDD',date()));
      cdsLocusNo.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
      cdsLocusNo.FieldByName('CREA_USER').AsString := Global.UserId;
      inc(r);
      cdsLocusNo.FieldByName('SEQNO').AsInteger := r;
      cdsLocusNo.Next;
    end;
  cdsHeader.Edit;
  if AObj.FieldbyName('PLAN_DATE').AsString='' then
     begin
       cdsHeader.FieldbyName('PLAN_DATE').AsString := formatDatetime('YYYY-MM-DD',Date());
       cdsHeader.FieldbyName('STOCK_USER').AsString := Global.UserID;
     end;
  cdsHeader.FieldbyName('LOCUS_STATUS').AsString := '3';
  cdsHeader.FieldbyName('LOCUS_USER').AsString := Global.UserID;
  cdsHeader.FieldbyName('LOCUS_DATE').AsString := formatDatetime('YYYY-MM-DD',Date());
  cdsHeader.FieldbyName('LOCUS_AMT').AsInteger := r;
  cdsHeader.Post;

  if AObj.FieldbyName('PLAN_DATE').AsString='' then
     begin
        cdsDetail.First;
        while not cdsDetail.Eof do
           begin
             cdsDetail.Edit;
             cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
             cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
             cdsDetail.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
             cdsDetail.FieldByName('PLAN_DATE').AsString := cdsHeader.FieldbyName('PLAN_DATE').AsString;
             cdsDetail.FieldByName('CLIENT_ID').AsString := cdsHeader.FieldbyName('CLIENT_ID').AsString;
             cdsDetail.Post;
             cdsDetail.Next;
           end;
     end;
  Params := TftParamList.Create(nil);
  try
    Factor.BeginBatch;
    try
      Params.ParambyName('SALES_TYPE').asInteger := cdsHeader.FieldbyName('SALES_TYPE').asInteger;
      Factor.AddBatch(cdsHeader,'TDbForInLocusNoHeader',Params);
      if AObj.FieldbyName('PLAN_DATE').AsString='' then
         Factor.AddBatch(cdsDetail,'TDbData',Params);
      Factor.AddBatch(cdsLocusNo,'TDbForLocusNo',Params);
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

function TfrmDbInLocusOrder.Calc:real;
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
              edtTable.FieldByName('BAL_AMT').asFloat := edtTable.FieldbyName('AMOUNT').AsFloat-edtTable.FieldbyName('LOCUS_AMT').AsFloat;
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

procedure TfrmDbInLocusOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;

end;

procedure TfrmDbInLocusOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmDbInLocusOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('������˿յ���');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
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
       if cdsHeader.FieldByName('LOCUS_CHK_USER').AsString<>Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ������ִ������');
       if MessageBox(Handle,'ȷ������ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if MessageBox(Handle,'ȷ����˵�ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SALES_ID').asString := cdsHeader.FieldbyName('SALES_ID').AsString;
      Params.ParamByName('LOCUS_CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('LOCUS_CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TDbInLocusNoAudit',Params)
      else
         Msg := Factor.ExecProc('TDbInLocusNoUnAudit',Params) ;
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

procedure TfrmDbInLocusOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

function TfrmDbInLocusOrder.CheckInput: boolean;
begin
  result := (pos(inttostr(InputFlag),'7')>0);
end;

function TfrmDbInLocusOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('11200001',7);
end;

procedure TfrmDbInLocusOrder.FormCreate(Sender: TObject);
begin
  inherited;
  InputFlag := 7;
  Shape2.Brush.Color := RowSelectColor;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      lblCLIENT_ID.Caption := '����ֿ�';
      Label40.Caption := '�ֿ����';
    end;
end;

procedure TfrmDbInLocusOrder.ReadFrom(DataSet: TDataSet);
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

procedure TfrmDbInLocusOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if edtTable.FieldbyName('BAL_AMT').AsInteger =  0 then
     Background := Shape3.Brush.Color;
end;

procedure TfrmDbInLocusOrder.cdsLocusNoFilterRecord(DataSet: TDataSet;
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

procedure TfrmDbInLocusOrder.edtInputKeyPress(Sender: TObject;
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

function TfrmDbInLocusOrder.NextLocusNo(flag:integer=0):boolean;
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

procedure TfrmDbInLocusOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  case Value of
    dsBrowse:lblState.Caption := '״̬:���';
  else
    lblState.Caption := '״̬:ɨ��';
  end;
  DBGridEh1.ReadOnly := true;
end;

procedure TfrmDbInLocusOrder.edtInputKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmDbInLocusOrder.SetInputFlag(const Value: integer);
begin
  inherited SetInputFlag(7);

end;

procedure TfrmDbInLocusOrder.DBGridEh1DblClick(Sender: TObject);
begin
//  inherited;
  DeleteOrder;
end;

function TfrmDbInLocusOrder.PriorLocusNo: boolean;
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