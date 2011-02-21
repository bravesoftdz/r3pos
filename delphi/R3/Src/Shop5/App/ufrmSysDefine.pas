unit ufrmSysDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ExtCtrls, ComCtrls, ActnList, Menus, RzButton,
  StdCtrls, cxRadioGroup, cxControls, cxContainer, cxEdit, cxCheckBox,  cxSpinEdit,
  cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, DB, zBase, cxButtonEdit,
  ZAbstractRODataset,ZAbstractDataset, ZDataset;

type
  TfrmSysDefine = class(TfrmBasic)
    PageControl1: TPageControl;
    tabBasic: TTabSheet;
    tabStock: TTabSheet;
    Panel1: TPanel;
    acComfir: TAction;
    acCancel: TAction;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    Label5: TLabel;
    edtUSING_DATE: TcxDateEdit;
    edtZERO_OUT: TcxCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    BirthDayLb: TLabel;
    BirthDayLb1: TLabel;
    ContinuLb: TLabel;
    ContinuLb1: TLabel;
    Label15: TLabel;
    BirthDays: TcxSpinEdit;
    ContinuDays: TcxSpinEdit;
    IsBirthDay: TcxCheckBox;
    IsContinu: TcxCheckBox;
    IsStorage: TcxCheckBox;
    Bevel2: TBevel;
    edtAUDIT_HINT: TcxCheckBox;
    edtPLANDATE_HINT: TcxCheckBox;
    edtACCOUNT_HINT: TcxCheckBox;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtFlag: TcxTextEdit;
    edtDEC1: TcxTextEdit;
    edtDEC2: TcxTextEdit;
    RzBitBtn1: TRzBitBtn;
    edtID: TcxComboBox;
    edtID1: TcxComboBox;
    edtID2: TcxComboBox;
    edtLEN1: TcxComboBox;
    edtLEN2: TcxComboBox;
    Label16: TLabel;
    Label17: TLabel;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    chkCheckAudit: TCheckBox;
    TabSheet2: TTabSheet;
    Label21: TLabel;
    Label8: TLabel;
    Label22: TLabel;
    edtPosDight: TcxSpinEdit;
    edtCARRYRULE: TcxComboBox;
    Bevel3: TBevel;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label12: TLabel;
    edtRTL_RATE2: TcxSpinEdit;
    edtRTL_RATE3: TcxSpinEdit;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    edtIN_RATE2: TcxSpinEdit;
    edtIN_RATE3: TcxSpinEdit;
    Bevel4: TBevel;
    edtIN_INV_FLAG: TcxComboBox;
    Label3: TLabel;
    edtRTL_INV_FLAG: TcxComboBox;
    Label4: TLabel;
    chkSaveSalesPrint: TcxCheckBox;
    chkSaveStockPrint: TcxCheckBox;
    GroupBox5: TGroupBox;
    edtRECK_OPTION1: TcxRadioButton;
    edtRECK_OPTION2: TcxRadioButton;
    edtRECK_DAY: TcxSpinEdit;
    edtPOSCALCDIGHT: TcxComboBox;
    edtDUPBARCODE: TcxCheckBox;
    Bevel5: TBevel;
    edtCALC_FLAG: TcxComboBox;
    GroupBox6: TGroupBox;
    Label18: TLabel;
    edtINPUT_MODE: TcxComboBox;
    edtDECIAMOUNT: TcxCheckBox;
    edtGUIDE_USER: TcxCheckBox;
    GroupBox7: TGroupBox;
    edtOutLevel1: TcxRadioButton;
    edtOutLevel2: TcxRadioButton;
    GroupBox8: TGroupBox;
    edtInLevel1: TcxRadioButton;
    edtInLevel2: TcxRadioButton;
    cdsTable: TZQuery;
    procedure acComfirExecute(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IsBirthDayPropertiesChange(Sender: TObject);
    procedure IsContinuPropertiesChange(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ReadFromObject(AObj: TRecord_);
    procedure WriteToObject(AObj: TRecord_);
    procedure SetValue(DefineName, Value: string);
    procedure ClearDisplay;
    procedure ReadBarCodeRule;
    procedure WriteBarCodeRule;
  public
    { Public declarations }
  end;
implementation

uses uGlobal, uFnUtil, uDsUtil;


{$R *.dfm}

{ TfrmSysDefine }


procedure TfrmSysDefine.acComfirExecute(Sender: TObject);
begin
  inherited;
  WriteToObject(nil);
  try
    if not Factor.UpdateBatch(cdsTable, 'TSysDefine') then
      cdsTable.CancelUpdates
    else
      begin
        Global.RefreshTable('SYS_DEFINE');
        close;
      end;
  except
    on E: Exception do
    begin
      cdsTable.CancelUpdates;
      raise Exception.create('保存失败' + E.Message);
    end;
  end;
end;

procedure TfrmSysDefine.acCancelExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSysDefine.ReadFromObject(AObj: TRecord_);
var
  Define, Value: string;
begin
  inherited;
  ReadBarCodeRule;
  if cdsTable.IsEmpty then exit;
  cdsTable.First;
  while not cdsTable.Eof do
  begin
    Define := cdsTable.FieldByName('DEFINE').AsString;
    Value := cdsTable.FieldByName('VALUE').AsString;
    if Define = 'ZERO_OUT' then
    begin
      if Value = '1' then
        edtZERO_OUT.Checked := True
      else if (Value = '0') or (Value = '') then
        edtZERO_OUT.Checked := False
    end
    else if Define = 'RTL_RATE2' then
      begin
        edtRTL_RATE2.Text := Value;
        if Value='' then edtRTL_RATE2.Text := '0.05';
      end
    else if Define = 'RTL_RATE3' then
      begin
        edtRTL_RATE3.Text := Value;
        if Value='' then edtRTL_RATE3.Text := '0.17';
      end
    else if Define = 'IN_RATE2' then
      begin
        edtIN_RATE2.Text := Value;
        if Value='' then edtIN_RATE2.Text := '0.05';
      end
    else if Define = 'IN_RATE3' then
      begin
        edtIN_RATE3.Text := Value;
        if Value='' then edtIN_RATE3.Text := '0.17';
      end
    else if Define = 'RTL_INV_FLAG' then
      edtRTL_INV_FLAG.ItemIndex := StrtoIntDef(Value,1)-1
    else if Define = 'IN_INV_FLAG' then
      edtIN_INV_FLAG.ItemIndex := StrtoIntDef(Value,1)-1
    else if Define = 'USING_DATE' then
      edtUSING_DATE.Date := uFnUtil.FnTime.fnStrtoDate(Value)
    else if Define = 'BIRTHDAY' then
      begin
        if StrToInt(Value) < 0 then
          begin
            IsBirthDay.Checked := False;
            BirthDays.Value := -1;
          end
        else if StrToInt(Value) >= 0 then
          begin
            IsBirthDay.Checked := True;
            BirthDays.Value := StrToIntDef(Value, 0);
          end;
      end;
    if Define = 'CUSTCONTINU' then
    begin
      if StrToInt(Value) < 0 then
      begin
        IsContinu.Checked := False;
        ContinuDays.Value := -1;
      end
      else if StrToInt(Value) >= 0 then
      begin
        IsContinu.Checked := True;
        ContinuDays.Value := StrToIntDef(Value, 0);
      end;
    end;
    if Define = 'STORAGE' then
    begin
      if Value = '0' then
        IsStorage.Checked := False
      else if Value = '1' then
        IsStorage.Checked := True;
    end;
    if Define = 'DUPBARCODE' then
    begin
      if Value = '0' then
        edtDUPBARCODE.Checked := False
      else if Value = '1' then
        edtDUPBARCODE.Checked := True;
    end;
    if Define = 'RECK_OPTION' then
    begin
      if Value = '2' then
         edtRECK_OPTION2.Checked := true
      else
         edtRECK_OPTION1.Checked := true;
    end;
    if Define = 'RECK_DAY' then
    begin
      if Value = '' then
         edtRECK_DAY.Value := 28
      else
         edtRECK_DAY.Value := StrtoIntDef(Value,28);
    end;
    if Define = 'CHECKAUDIT' then
    begin
      if Value = '0' then
        chkCheckAudit.Checked := False
      else if Value = '1' then
        chkCheckAudit.Checked := True;
    end;
    if Define = 'SAVE_SALES_PRINT' then
    begin
      if Value = '0' then
        chkSaveSalesPrint.Checked := False
      else if Value = '1' then
        chkSaveSalesPrint.Checked := True;
    end;
    if Define = 'SAVE_STOCK_PRINT' then
    begin
      if Value = '0' then
        chkSaveStockPrint.Checked := False
      else if Value = '1' then
        chkSaveStockPrint.Checked := True;
    end;
    if Define = 'AUDIT_HINT' then
    begin
      if Value = '0' then
        edtAUDIT_HINT.Checked := False
      else if Value = '1' then
        edtAUDIT_HINT.Checked := True;
    end;
    if Define = 'PLANDATE_HINT' then
    begin
      if Value = '0' then
        edtPLANDATE_HINT.Checked := False
      else if Value = '1' then
        edtPLANDATE_HINT.Checked := True;
    end;
    if Define = 'ACCOUNT_HINT' then
    begin
      if Value = '0' then
        edtACCOUNT_HINT.Checked := False
      else if Value = '1' then
        edtACCOUNT_HINT.Checked := True;
    end;

    if Define = 'POSDIGHT' then
    begin
      edtPosDight.Value := StrtoIntDef(Value,0);
    end;

    if Define = 'POSCALCDIGHT' then
    begin
      edtPosCalcDight.ItemIndex := StrtoIntDef(Value,0)+2;
    end;

    if Define = 'CARRYRULE' then
    begin
      edtCARRYRULE.ItemIndex := StrtoIntDef(value,0)
    end;

    if Define = 'CALC_FLAG' then
    begin
      edtCALC_FLAG.ItemIndex := StrtoIntDef(value,2)-1;
    end;

    if Define = 'INPUT_MODE' then
    begin
      edtINPUT_MODE.ItemIndex := StrtoIntDef(value,0);
    end;

    if Define= 'GUIDE_USER' then
    begin
      if Value = '0' then
        edtGUIDE_USER.Checked := False
      else if Value = '1' then
        edtGUIDE_USER.Checked := True;
    end;
    if Define = 'OutLevel' then
    begin
      if Value = '2' then
         edtOutLevel2.Checked := true
      else
         edtOutLevel1.Checked := true;
    end;
    if Define = 'InLevel' then
    begin
      if Value = '2' then
         edtInLevel2.Checked := true
      else
         edtInLevel1.Checked := true;
    end;
    cdsTable.Next;
  end;

end;

procedure TfrmSysDefine.WriteToObject(AObj: TRecord_);
var
  Str: string;
begin
  inherited;
  SetValue('USING_DATE', FormatDateTime('YYYY-MM-DD', edtUSING_DATE.Date));
  if edtZERO_OUT.Checked then
    SetValue('ZERO_OUT', '1')
  else
    SetValue('ZERO_OUT', '0');
  if edtGUIDE_USER.Checked then
    SetValue('GUIDE_USER', '1')
  else
    SetValue('GUIDE_USER', '0');
  //成本核算算法
  SetValue('RTL_RATE2', edtRTL_RATE2.Text);
  SetValue('RTL_RATE3', edtRTL_RATE3.Text);
  SetValue('IN_RATE2', edtIN_RATE2.Text);
  SetValue('IN_RATE3', edtIN_RATE3.Text);
  SetValue('RTL_INV_FLAG', inttostr(edtRTL_INV_FLAG.ItemIndex+1));
  SetValue('IN_INV_FLAG', inttostr(edtIN_INV_FLAG.ItemIndex+1));
  //
  if edtRECK_OPTION1.Checked then
    SetValue('RECK_OPTION', '1')
  else
    SetValue('RECK_OPTION', '2');
  if edtDUPBARCODE.Checked then
    SetValue('DUPBARCODE', '1')
  else
    SetValue('DUPBARCODE', '0');
  SetValue('RECK_DAY', edtRECK_DAY.Text);
  if IsBirthDay.Checked then
    SetValue('BIRTHDAY', BirthDays.Value)
  else
    SetValue('BIRTHDAY', '-1');

  if chkCheckAudit.Checked then
    SetValue('CHECKAUDIT', '1')
  else
    SetValue('CHECKAUDIT', '0');

  if IsStorage.Checked then
    SetValue('STORAGE', '1')
  else
    SetValue('STORAGE', '0');

  if chkSaveSalesPrint.Checked then
    SetValue('SAVE_SALES_PRINT', '1')
  else
    SetValue('SAVE_SALES_PRINT', '0');

  if chkSaveStockPrint.Checked then
    SetValue('SAVE_STOCK_PRINT', '1')
  else
    SetValue('SAVE_STOCK_PRINT', '0');


  SetValue('POSDIGHT', inttostr(edtPosDight.value));
  SetValue('POSCALCDIGHT', inttostr(edtPosCalcDight.ItemIndex-2));
  SetValue('CALC_FLAG', inttostr(edtCALC_FLAG.ItemIndex+1));
  if edtCARRYRULE.ItemIndex = -1 then
     SetValue('CARRYRULE', inttostr(0))
  else
     SetValue('CARRYRULE', inttostr(edtCARRYRULE.ItemIndex));
  if edtINPUT_MODE.ItemIndex = -1 then
     SetValue('INPUT_MODE', inttostr(0))
  else
     SetValue('INPUT_MODE', inttostr(edtINPUT_MODE.ItemIndex));
  if edtAUDIT_HINT.Checked then
    SetValue('AUDIT_HINT', '1')
  else
    SetValue('AUDIT_HINT', '0');
  if edtPLANDATE_HINT.Checked then
    SetValue('PLANDATE_HINT', '1')
  else
    SetValue('PLANDATE_HINT', '0');
  if edtACCOUNT_HINT.Checked then
    SetValue('ACCOUNT_HINT', '1')
  else
    SetValue('ACCOUNT_HINT', '0');
  if edtOutLevel1.Checked then
    SetValue('OutLevel', '1')
  else if  edtOutLevel2.Checked then
    SetValue('OutLevel', '2');
  if edtInLevel1.Checked then
    SetValue('InLevel', '1')
  else if  edtInLevel2.Checked then
    SetValue('InLevel', '2');
  WriteBarCodeRule;
end;

procedure TfrmSysDefine.FormShow(Sender: TObject);
var
  ObjRecord: TZFactory;
  IsTrue:Boolean;
begin
  inherited;
  //btnOk.Enabled := IsTrue; 
  ObjRecord := TZFactory.create;
  try
    ObjRecord.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsTable, 'TSysDefine', ObjRecord.Params);
    ClearDisplay;
    ReadFromObject(nil);
    PageControl1.ActivePage := tabBasic;
  finally
    ObjRecord.Free;
  end;
//  edtDefaultPos.Text := POSGlobal.POSName;
end;


procedure TfrmSysDefine.ClearDisplay;
begin
end;

procedure TfrmSysDefine.SetValue(DefineName, Value: string);
begin
  if cdsTable.Locate('DEFINE', DefineName, []) then
    cdsTable.Edit
  else
    cdsTable.Append;
  cdsTable.FieldByName('DEFINE').AsString := DefineName;
  cdsTable.FieldByName('TENANT_ID').AsString := IntToStr(Global.TENANT_ID);
  cdsTable.FieldByName('VALUE').AsString := Value;
  cdsTable.FieldByName('VALUE_TYPE').AsString := '0';
  cdsTable.Post;
end;

procedure TfrmSysDefine.IsBirthDayPropertiesChange(Sender: TObject);
begin
  inherited;
  if IsBirthDay.Checked then
  begin
    BirthDayLb.Visible := True;
    BirthDayLb1.Visible := True;
    BirthDays.Visible := True;
  end
  else
  begin
    BirthDayLb.Visible := False;
    BirthDayLb1.Visible := False;
    BirthDays.Visible := False;
  end;
end;

procedure TfrmSysDefine.IsContinuPropertiesChange(Sender: TObject);
begin
  inherited;
  if IsContinu.Checked then
  begin
    ContinuLb.Visible := True;
    ContinuLb1.Visible := True;
    ContinuDays.Visible := True;
  end
  else
  begin
    ContinuLb.Visible := False;
    ContinuLb1.Visible := False;
    ContinuDays.Visible := False;
  end;
end;

procedure TfrmSysDefine.ReadBarCodeRule;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from SYS_DEFINE where TENANT_ID='''+IntToStr(Global.TENANT_ID)+''' and DEFINE like ''BUIK%''';
    Factor.Open(rs);
    if rs.Locate('DEFINE','BUIK_FLAG',[]) then
       edtFlag.Text := rs.FieldbyName('VALUE').asString
    else
       edtFlag.Text := '';
    if rs.Locate('DEFINE','BUIK_ID',[]) then
       edtID.ItemIndex := StrtoIntDef(rs.FieldbyName('VALUE').asString,-1)
    else
       edtID.ItemIndex := -1;
    if rs.Locate('DEFINE','BUIK_ID1',[]) then
       edtID1.ItemIndex := StrtoIntDef(rs.FieldbyName('VALUE').asString,-1)
    else
       edtID1.ItemIndex := -1;
    if rs.Locate('DEFINE','BUIK_ID2',[]) then
       edtID2.ItemIndex := StrtoIntDef(rs.FieldbyName('VALUE').asString,-1)
    else
       edtID2.ItemIndex := -1;
    if rs.Locate('DEFINE','BUIK_LEN1',[]) then
       edtLEN1.ItemIndex := StrtoIntDef(rs.FieldbyName('VALUE').asString,-1)
    else
       edtLEN1.ItemIndex := -1;
    if rs.Locate('DEFINE','BUIK_LEN2',[]) then
       edtLEN2.ItemIndex := StrtoIntDef(rs.FieldbyName('VALUE').asString,-1)
    else
       edtLEN2.ItemIndex := -1;
    if rs.Locate('DEFINE','BUIK_DEC1',[]) then
       edtDEC1.Text := rs.FieldbyName('VALUE').asString
    else
       edtDEC1.Text := '';
    if rs.Locate('DEFINE','BUIK_DEC2',[]) then
       edtDEC2.Text := rs.FieldbyName('VALUE').asString
    else
       edtDEC2.Text := '';
  finally
    rs.Free;
  end;
end;

procedure TfrmSysDefine.WriteBarCodeRule;
begin
  SetValue('BUIK_FLAG',trim(edtFlag.Text));
  SetValue('BUIK_ID',inttostr(edtID.ItemIndex));
  SetValue('BUIK_ID1',inttostr(edtID1.ItemIndex));
  SetValue('BUIK_ID2',inttostr(edtID2.ItemIndex));
  SetValue('BUIK_LEN1',inttostr(edtLEN1.ItemIndex));
  SetValue('BUIK_LEN2',inttostr(edtLEN2.ItemIndex));
  SetValue('BUIK_DEC1',trim(edtDEC1.Text));
  SetValue('BUIK_DEC2',trim(edtDEC2.Text));
end;

procedure TfrmSysDefine.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  edtFlag.Text := '2';
  edtID.ItemIndex := 5;
  edtID1.ItemIndex := 2;
  edtID2.ItemIndex := 0;
  edtLEN1.ItemIndex := 4;
  edtLEN2.ItemIndex := -1;
  edtDEC1.Text := '2';
  edtDEC2.Text := '2';
end;

procedure TfrmSysDefine.FormCreate(Sender: TObject);
begin
  inherited;
  edtCALC_FLAG.ItemIndex := 1;
  edtRTL_INV_FLAG.ItemIndex := 0;
  edtIN_INV_FLAG.ItemIndex := 0;
  edtCARRYRULE.ItemIndex := 0;
  edtRTL_RATE2.Value := 0.05;
  edtRTL_RATE3.Value := 0.17;
  edtIN_RATE2.Value := 0.05;
  edtIN_RATE3.Value := 0.17;
  edtPosCalcDight.ItemIndex := 0;
  edtINPUT_MODE.ItemIndex := 0;
  edtGUIDE_USER.Checked := true;
end;

end.

