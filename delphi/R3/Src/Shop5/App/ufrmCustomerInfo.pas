unit ufrmCustomerInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton,
  cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxMaskEdit, DB, cxCalendar, zBase,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMemo, StdCtrls, RzLabel, uShopUtil,
  cxRadioGroup, Grids, DBGridEh,ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ufrmCustomerExt;

type
  TfrmCustomerInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    labCUST_CODE: TRzLabel;
    RzLabel1: TRzLabel;
    labCUST_NAME: TRzLabel;
    RzLabel2: TRzLabel;
    labCUST_SPELL: TRzLabel;
    RzLabel4: TRzLabel;
    labIC_CARDNO: TRzLabel;
    RzLabel5: TRzLabel;
    RzPanel1: TRzPanel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel13: TRzLabel;
    cmbCUST_CODE: TcxTextEdit;
    cmbCUST_NAME: TcxTextEdit;
    cmbCUST_SPELL: TcxTextEdit;
    RzLabel14: TRzLabel;
    cmbPRICE_ID: TzrComboBoxList;
    RzLabel15: TRzLabel;
    cmbBIRTHDAY: TcxDateEdit;
    RzLabel16: TRzLabel;
    cmbMOVE_TELE: TcxTextEdit;
    RzLabel3: TRzLabel;
    RzLabel18: TRzLabel;
    cmbID_NUMBER: TcxTextEdit;
    RzLabel20: TRzLabel;
    cmbBALANCE: TcxTextEdit;
    RzLabel21: TRzLabel;
    cmbRULE_INTEGRAL: TcxTextEdit;
    RzLabel24: TRzLabel;
    cmbSND_DATE: TcxDateEdit;
    RzLabel27: TRzLabel;
    cmbEND_DATE: TcxDateEdit;
    RzLabel28: TRzLabel;
    cmbCON_DATE: TcxDateEdit;
    cmbREMARK: TcxMemo;
    labHOMEPAGE: TRzLabel;
    cmbSEX: TRadioGroup;
    TabSheet2: TRzTabSheet;
    dsUnionCard: TDataSource;
    DBGridEh1: TDBGridEh;
    edtSORT_ID: TzrComboBoxList;
    RzLabel29: TRzLabel;
    RzLabel30: TRzLabel;
    cdsUnionCard: TZQuery;
    cdsTable: TZQuery;
    labIDN_TYPE: TRzLabel;
    edtIDN_TYPE: TcxComboBox;
    cmbSHOP_ID: TzrComboBoxList;
    RzLabel22: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel23: TRzLabel;
    RzLabel25: TRzLabel;
    cmbINTEGRAL: TcxTextEdit;
    RzLabel17: TRzLabel;
    TabSheet6: TRzTabSheet;
    RzPanel3: TRzPanel;
    RzLabel19: TRzLabel;
    cmbOFFI_TELE: TcxTextEdit;
    cmbFAMI_ADDR: TcxTextEdit;
    labADDRESS: TRzLabel;
    edtREGION_ID: TzrComboBoxList;
    RzLabel26: TRzLabel;
    edtPOSTALCODE: TcxTextEdit;
    labPOSTALCODE: TRzLabel;
    labTELEPHONE2: TRzLabel;
    labMSN: TRzLabel;
    edtQQ: TcxTextEdit;
    edtMSN: TcxTextEdit;
    labEMAIL: TRzLabel;
    edtEMAIL: TcxTextEdit;
    edtFAMI_TELE: TcxTextEdit;
    RzLabel31: TRzLabel;
    labDEGREES: TRzLabel;
    edtDEGREES: TcxComboBox;
    RzLabel32: TRzLabel;
    edtMONTH_PAY: TcxComboBox;
    edtOCCUPATION: TcxComboBox;
    labOCCUPATION: TRzLabel;
    edtJOBUNIT: TcxTextEdit;
    labJOBUNIT: TRzLabel;
    edtACCU_INTEGRAL: TcxTextEdit;
    RzLabel12: TRzLabel;
    RzLabel33: TRzLabel;
    cdsCustomerExt: TZQuery;
    RzLabel34: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure edtCUST_NAMEPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmbPRICE_IDAddClick(Sender: TObject);
    procedure cmbPRICE_IDSaveValue(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure cmbID_NUMBERKeyPress(Sender: TObject; var Key: Char);
    procedure cmbOFFI_TELEKeyPress(Sender: TObject; var Key: Char);
    procedure cmbRULE_INTEGRALKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBALANCEKeyPress(Sender: TObject; var Key: Char);
    procedure cmbINTEGRALKeyPress(Sender: TObject; var Key: Char);
    procedure cmbMOVE_TELEKeyPress(Sender: TObject; var Key: Char);
    procedure edtSORT_IDAddClick(Sender: TObject);
    procedure cmbSHOP_IDAddClick(Sender: TObject);
    procedure edtREGION_IDAddClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure cmbCUST_CODEPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    function GetCheckNo:string;
    function FindColumn(Grid:TDBGridEh;ColumnName:String):TColumnEh;
    procedure InitGrid;
  public
    { Public declarations }
    Aobj:TRecord_;
    Saved,IsExtChange:Boolean;
    FList:TList;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure ReadFrom;
    procedure AddFrom;
    procedure WriteTo(AObj:TRecord_);
    procedure Open(code:string);
    procedure OpenCard;
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断会员档案是否有修改
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:String):Boolean;
  end;


implementation
uses uDsUtil, uGlobal, uFnUtil,uShopGlobal,ufrmCodeInfo,ufrmPriceGradeInfo,ufrmshopinfo,ufrmNewCard,
  Math, EncDec, ufrmBasic;

{$R *.dfm}

{ TfrmCustomerInfo }

procedure TfrmCustomerInfo.Append;
var rs:TZQuery;
begin
  dbState := dsInsert;
  Open('');
  dbState := dsInsert;
  cmbCUST_CODE.Text := '自动编号..';
  cmbBIRTHDAY.Date := FnTime.fnStrtoDate(FormatDateTime('1900-01-01',Date));
  cmbSND_DATE.Date := Date;
  cmbSEX.ItemIndex := 0;
  cmbSHOP_ID.KeyValue := Global.SHOP_ID;
  cmbSHOP_ID.Text := Global.SHOP_NAME;
  edtREGION_ID.KeyValue := '#';
  edtREGION_ID.Text := '无区域';
  edtSORT_ID.KeyValue:='#';
  edtSORT_ID.Text:='无';
  rs:=Global.GetZQueryFromName('PUB_PRICEGRADE');
  if (rs.RecordCount>0) and (rs.Locate('PRICE_NAME','普通会员',[])) then
  begin
    cmbPRICE_ID.KeyValue := rs.FieldByName('PRICE_ID').AsString;
    cmbPRICE_ID.Text := rs.FieldByName('PRICE_NAME').AsString;
  end;
  //TabSheet2.TabVisible := False;
  if cmbCUST_NAME.CanFocus and Visible then cmbCUST_NAME.SetFocus;
end;

procedure TfrmCustomerInfo.Edit(code: string);
begin
  dbState := dsEdit;
  Open(code);
  dbState := dsEdit;
end;

procedure TfrmCustomerInfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CUST_ID').asString := code;
    Params.ParamByName('UNION_ID').AsString := '#';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;

    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsTable,'TCustomer',Params);
      Factor.AddBatch(cdsCustomerExt,'TCustomerExt',Params);
      Factor.AddBatch(cdsUnionCard,'TPubIcInfo',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      raise;
    end;
    //Factor.Open(cdsTable,'TCustomer',Params);              
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    ReadFrom;
    cmbSHOP_ID.KeyValue := Aobj.FieldbyName('SHOP_ID').AsString;
    cmbSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',Aobj.FieldbyName('SHOP_ID').AsString);
    if Aobj.FieldByName('REGION_ID').AsString = '#' then
      begin
        edtREGION_ID.KeyValue := '#';
        edtREGION_ID.Text := '无区域';
      end
    else
      begin
        edtREGION_ID.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_REGION_INFO'),'CODE_ID','CODE_NAME',Aobj.FieldByName('REGION_ID').AsString);
        edtREGION_ID.KeyValue := Aobj.FieldByName('REGION_ID').AsString;
      end;
    cmbPRICE_ID.KeyValue := Aobj.FieldByName('PRICE_ID').AsString;
    cmbPRICE_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PRICEGRADE'),'PRICE_ID','PRICE_NAME',Aobj.FieldByName('PRICE_ID').AsString);
    edtSORT_ID.KeyValue := Aobj.FieldbyName('SORT_ID').AsString;
    edtSORT_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_CLIENTSORT'),'CODE_ID','CODE_NAME',Aobj.FieldbyName('SORT_ID').AsString);
    cmbSEX.ItemIndex:=AObj.FieldByName('SEX').AsInteger;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomerInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   var Temp:TZQuery;
   begin
    Temp := Global.GetZQueryFromName('PUB_CUSTOMER');
    Temp.Filtered := false;
    if not Temp.Locate('CLIENT_ID',AObj.FieldByName('CUST_ID').AsString,[]) then
       Temp.Append
    else
       Temp.Edit;
    Temp.FieldByName('CLIENT_ID').AsString := AObj.FieldbyName('CUST_ID').AsString;
    Temp.FieldByName('LICENSE_CODE').AsString := AObj.FieldbyName('ID_NUMBER').AsString;
    Temp.FieldByName('CLIENT_CODE').AsString := AObj.FieldbyName('CUST_CODE').AsString;
    Temp.FieldByName('CLIENT_NAME').AsString := AObj.FieldbyName('CUST_NAME').AsString;
    Temp.FieldByName('LINKMAN').AsString := AObj.FieldbyName('CUST_NAME').AsString;
    Temp.FieldByName('CLIENT_SPELL').AsString := AObj.FieldbyName('CUST_SPELL').AsString;
    Temp.FieldByName('ADDRESS').AsString := AObj.FieldbyName('FAMI_ADDR').AsString;
    Temp.FieldByName('TELEPHONE2').AsString := AObj.FieldbyName('MOVE_TELE').AsString;
    Temp.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('CUST_CODE').AsString;
    Temp.FieldByName('SETTLE_CODE').AsString := '#';
    Temp.FieldByName('INVOICE_FLAG').AsString := '0';
    Temp.FieldByName('TAX_RATE').AsString := '0';
    Temp.FieldByName('PRICE_ID').AsString := AObj.FieldbyName('PRICE_ID').AsString;
    Temp.Post;
   end;
var tmp,temp,temp1,tmp1,rs:TZQuery;
    j:integer;
begin
  if trim(cmbCUST_CODE.Text)='' then
  begin
    if cmbCUST_CODE.CanFocus then cmbCUST_CODE.SetFocus;
    raise Exception.Create('会员号不能为空！');
  end;
  if trim(cmbCUST_NAME.Text)='' then
  begin
    if cmbCUST_NAME.CanFocus then cmbCUST_NAME.SetFocus;
    raise Exception.Create('会员姓名不能为空！');
  end;
  if trim(cmbCUST_SPELL.Text)='' then
  begin
    if cmbCUST_SPELL.CanFocus then cmbCUST_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空！');
  end;
  if trim(cmbSHOP_ID.AsString)='' then
  begin
    if cmbSHOP_ID.CanFocus then cmbSHOP_ID.SetFocus;
    raise Exception.Create('入会门店不能为空！');
  end;
  if cmbPRICE_ID.AsString='' then
  begin
    if cmbPRICE_ID.CanFocus then cmbPRICE_ID.SetFocus;
    raise Exception.Create('会员等级不能为空！');
  end;
  if Trim(cmbMOVE_TELE.Text)='' then
  begin
    if cmbMOVE_TELE.CanFocus then cmbMOVE_TELE.SetFocus;
    raise Exception.Create('移动电话不能为空！');
  end;
  if Trim(cmbBIRTHDAY.Text)='' then
  begin
    if cmbBIRTHDAY.CanFocus then cmbBIRTHDAY.SetFocus;
    raise Exception.Create('会员生日不能为空！');
  end;
  if Trim(edtREGION_ID.Text)='' then
  begin
    if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
    raise Exception.Create('所在地区不能为空！');
  end;

  //会员检测开始
 if dbState = dsInsert then
  begin
     temp := Global.GetZQueryFromName('PUB_CUSTOMER');
     if temp.Locate('CLIENT_CODE',Trim(cmbCUST_CODE.Text),[]) then
       begin
          if cmbCUST_CODE.CanFocus then cmbCUST_CODE.SetFocus;
          raise Exception.Create('此会员号已经存在，不能重复！');
       end;
  end;

  if dbState = dsEdit then
  begin
    temp1:=Global.GetZQueryFromName('PUB_CUSTOMER');
    if temp1.Locate('CLIENT_CODE',Trim(cmbCUST_CODE.Text),[]) then
      begin
        if temp1.FieldByName('CLIENT_ID').AsString <> Aobj.FieldByName('CUST_ID').AsString then
          Raise Exception.Create('此会员号已经存在,不能重复!');
      end;
  end;
  tmp1:=TZQuery.Create(nil);
  try
    tmp1.Close;
    case Factor.iDbType of
      0:tmp1.SQL.Text:='select top 1 PRICE_ID from PUB_PRICEGRADE where COMM not in (''12'',''02'') and INTEGRAL<='+FloatToStr(StrToFloatDef(edtACCU_INTEGRAL.Text,0))+' and INTEGRAL>=0 order by INTEGRAL desc ';
      1:tmp1.SQL.Text:='select * from (select PRICE_ID from PUB_PRICEGRADE where COMM not in (''12'',''02'') and INTEGRAL<='+FloatToStr(StrToFloatDef(edtACCU_INTEGRAL.Text,0))+' and INTEGRAL>=0 order by INTEGRAL desc) where ROWNUM<2 ';
      4:tmp1.SQL.Text := 'select PRICE_ID from PUB_PRICEGRADE where COMM not in (''12'',''02'') and INTEGRAL<='+FloatToStr(StrToFloatDef(edtACCU_INTEGRAL.Text,0))+' and INTEGRAL>=0 order by INTEGRAL desc fetch first 600 rows only';
      5:tmp1.SQL.Text:='select PRICE_ID from PUB_PRICEGRADE where COMM not in (''12'',''02'') and INTEGRAL<='+FloatToStr(StrToFloatDef(edtACCU_INTEGRAL.Text,0))+' and INTEGRAL>=0 order by INTEGRAL desc limit 1';
    end;
    Factor.Open(tmp1);
    if (not tmp1.IsEmpty) and (cmbPRICE_ID.AsString<>tmp1.FieldByName('PRICE_ID').AsString) then
    begin
      if MessageBox(Handle,'累计积分与等级标准不符，是否继续保存？',pchar(Application.Title),MB_YESNO+MB_DEFBUTTON1+MB_ICONINFORMATION) <>6 then
        Exit;
    end;
  finally
    tmp1.Free;
  end;
  if cmbCUST_NAME.Text<>cdsTable.FieldByName('CUST_NAME').AsString then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('PUB_CUSTOMER');
      if tmp.Locate('CLIENT_NAME',Trim(cmbCUST_NAME.Text),[]) then
        begin
          if tmp.FieldByName('CLIENT_ID').AsString <> cdsTable.FieldByName('CUST_ID').AsString then
            begin
              if cmbCUST_NAME.CanFocus then cmbCUST_NAME.SetFocus;
              MessageBox(handle,Pchar('提示:会员名称已经存在!'),Pchar(Caption),MB_OK);
            end;
        end;
    end;
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('PUB_CUSTOMER');
      if tmp.Locate('CLIENT_NAME',Trim(cmbCUST_NAME.Text),[]) then
        begin
          if cmbCUST_NAME.CanFocus then cmbCUST_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:会员姓名已经存在!'),Pchar(Caption),MB_OK);
        end;
    end;
  end;
  //会员检测结束

  WriteTo(Aobj);
  //if not IsEdit(Aobj,cdsTable) then exit;
  if dbState = dsInsert then
     begin
       AObj.FieldbyName('CUST_ID').AsString := TSequence.NewId;
       Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
       Aobj.FieldByName('CREA_USER').AsString := Global.UserID;
       Aobj.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Global.SysDate);
       Aobj.FieldByName('IC_INFO').AsString := '企业卡';
       Aobj.FieldByName('UNION_ID').AsString := '#';
       Aobj.FieldByName('IC_STATUS').AsString := '0';
       Aobj.FieldByName('IC_TYPE').AsString := '0';
     end;
  if (AObj.FieldbyName('CUST_CODE').AsString='') or (AObj.FieldbyName('CUST_CODE').AsString='自动编号..') then
     AObj.FieldbyName('CUST_CODE').AsString := FnString.GetCodeFlag(inttostr(strtoint(fnString.TrimRight(Global.SHOP_ID,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));
  Aobj.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('CUST_CODE').AsString;
  cdsCustomerExt.First;
  while not cdsCustomerExt.Eof do
     begin
       cdsCustomerExt.Edit;
       cdsCustomerExt.FieldByName('TENANT_ID').AsString := AObj.FieldbyName('TENANT_ID').AsString;
       cdsCustomerExt.FieldByName('CUST_ID').AsString := AObj.FieldbyName('CUST_ID').AsString;
       cdsCustomerExt.Post;
       cdsCustomerExt.Next;
     end;
  cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;

  cdsUnionCard.First;
  while not cdsUnionCard.Eof do
     begin
       cdsUnionCard.Edit;
       cdsUnionCard.FieldByName('TENANT_ID').AsString := AObj.FieldbyName('TENANT_ID').AsString;
       cdsUnionCard.FieldByName('CLIENT_ID').AsString := AObj.FieldbyName('CUST_ID').AsString;
       cdsUnionCard.Post;
       cdsUnionCard.Next;
     end;

  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsTable,'TCustomer');
    Factor.AddBatch(cdsUnionCard,'TPubIcInfo');
    Factor.AddBatch(cdsCustomerExt,'TCustomerExt');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  //if Factor.UpdateBatch(cdsTable,'TCustomer') then
  UpdateToGlobal(Aobj);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmCustomerInfo.FormCreate(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  cmbSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  cmbPRICE_ID.DataSet := Global.GetZQueryFromName('PUB_PRICEGRADE');
  edtSORT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTSORT');
  edtREGION_ID.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
  AddCbxPickList(edtIDN_TYPE,'',Global.GetZQueryFromName('PUB_IDNTYPE_INFO'));
  AddCbxPickList(edtDEGREES,'',Global.GetZQueryFromName('PUB_DEGREES_INFO'));
  AddCbxPickList(edtMONTH_PAY,'',Global.GetZQueryFromName('PUB_MONTH_PAY_INFO'));
  AddCbxPickList(edtOCCUPATION,'',Global.GetZQueryFromName('PUB_OCCUPATION_INFO'));
  Aobj := TRecord_.Create;
  FList := TList.Create;
end;

procedure TfrmCustomerInfo.FormDestroy(Sender: TObject);
var i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  inherited;
  Aobj.Free;
end;

procedure TfrmCustomerInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCustomerInfo.Btn_SaveClick(Sender: TObject);
var bl:Boolean;
    PRICE_ID,PRICE_NAME:string;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增会员?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
    begin
      PRICE_ID:=cmbPRICE_ID.AsString;
      PRICE_NAME:=cmbPRICE_ID.Text;
      Append;
      cmbPRICE_ID.KeyValue:=PRICE_ID;
      cmbPRICE_ID.Text:=PRICE_NAME;
    end
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmCustomerInfo.edtCUST_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  cmbCUST_SPELL.Text := FnString.GetWordSpell(cmbCUST_NAME.Text);
end;

procedure TfrmCustomerInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  RzLabel3.Visible:=True;
  RzLabel7.Visible:=True;
  RzLabel9.Visible:=True;
  RzLabel11.Visible:=True;
  RzLabel30.Visible:=True;
  Btn_Save.Visible := (value<>dsBrowse);
  cmbSEX.Enabled:=True;
  case dbState of
  dsInsert:Caption:='会员档案--(新增)';
  dsEdit:Caption:='会员档案--(修改)';
  else
    begin
      Caption:='会员档案';
      RzLabel3.Visible:=False;
      RzLabel7.Visible:=False;
      RzLabel9.Visible:=False;
      RzLabel11.Visible:=False;
      cmbSEX.Enabled:=False;
      RzLabel30.Visible:=False;
      //cdsUnionCard.ReadOnly := True;   
    end;
  end;
end;

procedure TfrmCustomerInfo.FormShow(Sender: TObject);
begin
  inherited;
  cmbCUST_CODE.SelectAll;
  RzPage.ActivePageIndex := 0;
  if cmbCUST_CODE.CanFocus then cmbCUST_CODE.SetFocus;
end;

function TfrmCustomerInfo.IsEdit(Aobj: TRecord_;
  cdsTable:TZQuery): Boolean;
var i:integer;
    IsChang:Boolean;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if AObj.Fields[i].AsString<>cdsTable.Fields[i].AsString then
      IsChang := True;
  end;
  Result := IsChang;
end;
procedure TfrmCustomerInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if Application.Terminated then Exit;
  try
   if not((dbState = dsInsert) and (trim(cmbCUST_NAME.Text)='')) then
   begin
    //WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'会员档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
    if i=6 then
       begin
         Save;
         if Saved and Assigned(OnSave) then OnSave(AObj);
       end;
    if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

procedure TfrmCustomerInfo.WriteTo(AObj: TRecord_);
var
  i:integer;
begin
  WriteToObject(Aobj,self);
  for i:=0 to FList.Count -1 do
    begin
      TfrmCustomerExt(FList[i]).WriteTo;
    end;
  if Trim(cmbINTEGRAL.Text)='' then AObj.FieldByName('INTEGRAL').AsString:='0';
  if Trim(edtACCU_INTEGRAL.Text)='' then AObj.FieldByName('ACCU_INTEGRAL').AsString:='0';
  if Trim(cmbRULE_INTEGRAL.Text)='' then AObj.FieldByName('RULE_INTEGRAL').AsString:='0';
  AObj.FieldByName('SEX').AsInteger:=cmbSEX.ItemIndex;
  if Trim(edtREGION_ID.Text)='' then AObj.FieldByName('REGION_ID').AsString := '#';
  Aobj.FieldByName('CUST_CODE').AsString := GetCheckNo;
  if Aobj.FieldByName('PASSWRD').AsString = '' then Aobj.FieldByName('PASSWRD').AsString := EncStr('1234',ENC_KEY);
end;

class function TfrmCustomerInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增会员的权限,请和管理员联系.');
  with TfrmCustomerInfo.Create(Owner) do
  begin
    try
      Append;
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end
      else
        result :=False;
    finally
      free;
    end;
  end;
end;

class function TfrmCustomerInfo.EditDialog(Owner: TForm; id: string;
  var _AObj: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('33400001',3) then Raise Exception.Create('你没有修改会员的权限,请和管理员联系.');
  with TfrmCustomerInfo.Create(Owner) do
  begin
    try
      Edit(id);
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end
      else
        result :=False;
    finally
      free;
    end;
  end;
end;

procedure TfrmCustomerInfo.cmbPRICE_IDAddClick(Sender: TObject);
var AObj_1:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj_1 := TRecord_.Create;
  try
    if TfrmPriceGradeInfo.AddDialog(self,AObj_1) then
       begin
         cmbPRICE_ID.KeyValue := AObj_1.FieldbyName('PRICE_ID').asString;
         cmbPRICE_ID.Text := AObj_1.FieldbyName('PRICE_NAME').asString;
       end;
  finally
    AObj_1.Free;
  end;
end;

procedure TfrmCustomerInfo.cmbPRICE_IDSaveValue(Sender: TObject);
begin
  inherited;
  if (cmbPRICE_ID.AsString='') then
  begin
    if MessageBox(Handle,'没找到你想查找的会员等级是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    cmbPRICE_ID.OnAddClick(nil);
    Exit;
  end;

  if (Trim(cmbPRICE_ID.Text) <> '') and (Trim(cmbCUST_CODE.Text) <> '自动编号..') then
    begin
      if cmbPRICE_ID.DataSet.FieldByName('PRICE_TYPE').AsString = '2' then
        begin
          if cdsUnionCard.Locate('UNION_ID',cmbPRICE_ID.DataSet.FieldByName('PRICE_ID').AsString,[]) then
            begin
              if cdsUnionCard.FieldByName('IC_CARDNO').AsString = '' then
                DBGridEh1CellClick(DBGridEh1.FieldColumns['IC_CARDNO']);
            end;
        end;
    end;
end;

procedure TfrmCustomerInfo.RzPageChange(Sender: TObject);
var Params:TftParamList;
begin
  inherited;
  if RzPage.ActivePageIndex=2 then
  begin

  end;

end;

procedure TfrmCustomerInfo.cmbID_NUMBERKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;  
end;

procedure TfrmCustomerInfo.cmbOFFI_TELEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;
end;

procedure TfrmCustomerInfo.cmbRULE_INTEGRALKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;
end;

procedure TfrmCustomerInfo.cmbBALANCEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;
end;

procedure TfrmCustomerInfo.cmbINTEGRALKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;
end;

procedure TfrmCustomerInfo.cmbMOVE_TELEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key>=#160 then Key:= #0;
end;

procedure TfrmCustomerInfo.edtSORT_IDAddClick(Sender: TObject);
var Aobj_2:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  Aobj_2 := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,Aobj_2) then
       begin
         edtSORT_ID.KeyValue := Aobj_2.FieldbyName('CODE_ID').asString;
         edtSORT_ID.Text := Aobj_2.FieldbyName('CODE_NAME').asString;
       end;
  finally
    Aobj_2.Free;
  end;
end;

procedure TfrmCustomerInfo.cmbSHOP_IDAddClick(Sender: TObject);
var AObj_3:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj_3 := TRecord_.Create;
  try
    if TfrmShopInfo.AddDialog(self,AObj_3) then
       begin
         cmbSHOP_ID.KeyValue := AObj_3.FieldbyName('SHOP_ID').asString;
         cmbSHOP_ID.Text := AObj_3.FieldbyName('SHOP_NAME').asString;
       end;
  finally
    AObj_3.Free;
  end;
end;

procedure TfrmCustomerInfo.edtREGION_IDAddClick(Sender: TObject);
var AObj_5:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  AObj_5 := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,AObj_5,8) then
       begin
         edtREGION_ID.KeyValue := AObj_5.FieldbyName('CODE_ID').asString;
         edtREGION_ID.Text := AObj_5.FieldbyName('CODE_NAME').asString;
       end;
  finally
    AObj_5.Free;
  end;
end;

procedure TfrmCustomerInfo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := $00FDF6EB;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'IC_CARDNO' then
    begin
      if (cdsUnionCard.FieldByName('IC_CARDNO').AsString = '') then
        begin
          ARect := Rect;
          AFont := TFont.Create;
          AFont.Assign(DBGridEh1.Canvas.Font);
          try
            DBGridEh1.canvas.FillRect(ARect);
            DBGridEh1.Canvas.Font.Color := clBlue;
            DBGridEh1.Canvas.Font.Style := [fsUnderline];
            DrawText(DBGridEh1.Canvas.Handle,pchar('申请'),length('申请'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
          finally
            DBGridEh1.Canvas.Font.Assign(AFont);
            AFont.Free;
          end;
        end
      else if (cdsUnionCard.FieldByName('IC_CARDNO').AsString <> '')
        and
         (cdsUnionCard.FieldByName('UNION_ID').AsString <> '#')
        and
         (cdsUnionCard.FieldByName('IC_STATUS').AsInteger in [2,9])
      then
        begin
          ARect := Rect;
          AFont := TFont.Create;
          AFont.Assign(DBGridEh1.Canvas.Font);
          try
            DBGridEh1.canvas.FillRect(ARect);
            DBGridEh1.Canvas.Font.Color := clBlue;
            DBGridEh1.Canvas.Font.Style := [fsUnderline];
            if (cdsUnionCard.FieldByName('IC_STATUS').AsString = '2') then
              DrawText(DBGridEh1.Canvas.Handle,pchar('补卡'),length('补卡'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER)
            else
              DrawText(DBGridEh1.Canvas.Handle,pchar('申请'),length('申请'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
          finally
            DBGridEh1.Canvas.Font.Assign(AFont);
            AFont.Free;
          end;
        end;
    end;
end;

procedure TfrmCustomerInfo.DBGridEh1CellClick(Column: TColumnEh);
var Params:TftParamList;
    CardNo,Pwd,UnionID:String;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if cdsUnionCard.IsEmpty then Exit;

  if Column.FieldName = 'IC_CARDNO' then
    begin
      if cdsUnionCard.FieldbyName('IC_CARDNO').AsString = '' then
        begin
          UnionID := cdsUnionCard.FieldbyName('UNION_ID').AsString;
          if TfrmNewCard.GetSendCard(Self,cdsUnionCard.FieldbyName('CLIENT_ID').AsString,UnionID,cmbCUST_NAME.Text,cmbCUST_CODE.Text,CardNo,Pwd,0) then
            begin
              if cdsUnionCard.Locate('UNION_ID',UnionID,[]) then
                begin
                  cdsUnionCard.Edit;
                  cdsUnionCard.FieldByName('IC_CARDNO').AsString := CardNo;
                  cdsUnionCard.FieldByName('PASSWRD').AsString := Pwd;
                  cdsUnionCard.FieldByName('IC_STATUS').AsString := '0';
                  cdsUnionCard.FieldByName('CREA_USER').AsString := Global.UserID;
                  cdsUnionCard.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Global.SysDate);
                  cdsUnionCard.FieldByName('IC_INFO').AsString := cdsUnionCard.FieldByName('UNION_NAME').AsString;
                  cdsUnionCard.FieldByName('IC_TYPE').AsString := '0';
                  cdsUnionCard.Post;
                end;
              if UnionID = '#' then
                begin
                  cmbCUST_CODE.Text := CardNo;
                  Aobj.FieldByName('PASSWRD').AsString := Pwd;
                end;
              AddFrom;
            end;
        end
      else if (cdsUnionCard.FieldByName('IC_CARDNO').AsString <> '')
        and
         (cdsUnionCard.FieldByName('UNION_ID').AsString <> '#')
        and
         (cdsUnionCard.FieldByName('IC_STATUS').AsString <> '1')
      then
        begin
          UnionID := cdsUnionCard.FieldbyName('UNION_ID').AsString;
          if TfrmNewCard.GetSendCard(Self,cdsUnionCard.FieldbyName('CLIENT_ID').AsString,UnionID,cmbCUST_NAME.Text,cmbCUST_CODE.Text,CardNo,Pwd,0) then
            begin
              if cdsUnionCard.Locate('UNION_ID',UnionID,[]) then
                begin
                  cdsUnionCard.Edit;
                  cdsUnionCard.FieldByName('IC_CARDNO').AsString := CardNo;
                  cdsUnionCard.FieldByName('PASSWRD').AsString := Pwd;
                  if cdsUnionCard.FieldByName('IC_STATUS').AsString = '9' then
                    cdsUnionCard.FieldByName('IC_STATUS').AsString := '0'
                  else if cdsUnionCard.FieldByName('IC_STATUS').AsString = '2' then
                    cdsUnionCard.FieldByName('IC_STATUS').AsString := '1';
                  cdsUnionCard.FieldByName('CREA_USER').AsString := Global.UserID;
                  cdsUnionCard.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Global.SysDate);
                  //cdsUnionCard.FieldByName('IC_INFO').AsString := cdsUnionCard.FieldByName('UNION_NAME').AsString;
                  //cdsUnionCard.FieldByName('IC_TYPE').AsString := '0';
                  cdsUnionCard.Post;
                end;
            end;
        end;
    end;
end;

procedure TfrmCustomerInfo.ReadFrom;
var
  tab:TrzTabSheet;
  Instance: TWinControl;
  frame:TfrmCustomerExt;
  i,j:integer;
  rs:TZQuery;
begin
  for i:=0 to FList.Count -1 do
    begin
      for j:=0 to RzPage.PageCount-1 do
        begin
          if RzPage.Pages[j].Caption = TRzTabSheet(TfrmCustomerExt(FList[i]).Parent).Caption then
            begin
              TObject(FList[i]).Free;
              RzPage.Pages[j].Free;
              Break;
            end;
        end;
    end;
  FList.Clear;
  rs := TZQuery.Create(nil);
  try
  cdsUnionCard.First;
  while not cdsUnionCard.Eof do
    begin
      if (cdsUnionCard.FieldbyName('UNION_ID').AsString<>'#')
          and
         (cdsUnionCard.FieldbyName('IC_CARDNO').AsString<>'')
      then
         begin
           rs.Close;
           rs.SQL.Text := 'select INDEX_FLAG from PUB_UNION_INFO where UNION_ID='''+cdsUnionCard.FieldbyName('UNION_ID').AsString+'''';
           Factor.Open(rs);
           if rs.Fields[0].AsString = '1' then
           begin
             tab := TrzTabSheet.Create(RzPage);
             tab.PageControl := RzPage;
             tab.Caption :=  cdsUnionCard.FieldbyName('UNION_NAME').AsString;
             frame := TfrmCustomerExt.Create(tab);
             FList.Add(frame);
             frame.Parent:=tab;
             frame.DataSet := cdsCustomerExt;
             frame.IsRecordChange := IsExtChange;
             frame.UnionID := cdsUnionCard.FieldbyName('UNION_ID').AsString;
             frame.Cust_Id := cdsUnionCard.FieldbyName('CLIENT_ID').AsString;
             frame.UnionName := cdsUnionCard.FieldbyName('UNION_NAME').AsString;
             frame.DataState := dbState;
             frame.ReadFrom;
           end;
         end;
      cdsUnionCard.Next;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmCustomerInfo.cmbCUST_CODEPropertiesChange(Sender: TObject);
begin
  inherited;
  if cdsUnionCard.Locate('UNION_ID','#',[]) then
    begin
      if not FnString.IsCodeString(Trim(cmbCUST_CODE.Text)) then Exit;
      cdsUnionCard.Edit;
      cdsUnionCard.FieldByName('IC_CARDNO').AsString := Trim(cmbCUST_CODE.Text);
      cdsUnionCard.Post;
    end;
end;

procedure TfrmCustomerInfo.AddFrom;
var
  tab:TrzTabSheet;
  frame:TfrmCustomerExt;
  i,j:integer;
begin
  if (cdsUnionCard.FieldbyName('UNION_ID').AsString<>'#')
      and
     (cdsUnionCard.FieldbyName('IC_CARDNO').AsString<>'')
  then
    begin
      tab := TrzTabSheet.Create(RzPage);
      tab.PageControl := RzPage;
      tab.Caption :=  cdsUnionCard.FieldbyName('UNION_NAME').AsString;
      frame := TfrmCustomerExt.Create(tab);
      FList.Add(frame);
      frame.Parent:=tab;
      frame.DataSet := cdsCustomerExt;
      frame.IsRecordChange := IsExtChange;
      frame.UnionID := cdsUnionCard.FieldbyName('UNION_ID').AsString;
      frame.Cust_Id := cdsUnionCard.FieldbyName('CLIENT_ID').AsString;
      frame.DataState := dbState;
      frame.ReadFrom;
    end;
end;

function TfrmCustomerInfo.GetCheckNo: string;
begin
  result := trim(cmbCUST_CODE.Text);
  if cmbCUST_CODE.Properties.EchoMode <> eemPassword then
     begin
       if pos('=',result)>0 then
          begin
            result := copy(result,1,pos('=',result)-1);
          end;
     end;
end;

procedure TfrmCustomerInfo.InitGrid;
var rs:TZQuery;
    Col:TColumnEh;
begin
  Col := FindColumn(DBGridEh1,'IC_STATUS');
  if Col = nil then Exit;

  rs := Global.GetZQueryFromName('PUB_PARAMS');
  if not rs.Active then Exit;
  rs.Filtered := False;
  rs.Filter := ' TYPE_CODE=''IC_STATUS'' ';
  rs.Filtered := True;

  Col.KeyList.Clear;
  Col.PickList.Clear;
  rs.First;
  while not rs.Eof do
    begin
      Col.KeyList.Add(rs.FieldbyName('CODE_ID ').AsString);
      Col.PickList.Add(rs.FieldbyName('CODE_NAME').AsString);
      rs.Next;
    end;
end;

procedure TfrmCustomerInfo.OpenCard;
begin

end;

function TfrmCustomerInfo.FindColumn(Grid: TDBGridEh;
  ColumnName: String): TColumnEh;
var i:Integer;
begin
  Result := nil;
  for i := 0 to Grid.Columns.Count - 1 do
    begin
      if Grid.Columns[i].FieldName = ColumnName then
        begin
          Result := Grid.Columns[i];
          Exit;
        end;
    end;
end;

class function TfrmCustomerInfo.ShowDialog(Owner: TForm;
  id: String): Boolean;
begin
  with TfrmCustomerInfo.Create(Owner) do
    begin
      try
        Open(id);
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

end.
