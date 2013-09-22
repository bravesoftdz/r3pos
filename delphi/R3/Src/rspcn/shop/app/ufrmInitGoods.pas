unit ufrmInitGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,ZdbFactory,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms;

type
  TfrmInitGoods = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzBackground1: TRzBackground;
    RzLabel2: TRzLabel;
    RzBorder1: TRzBorder;
    RzLabel6: TRzLabel;
    RzLabel10: TRzLabel;
    edtGOODS_OPTION1: TcxRadioButton;
    edtGOODS_OPTION2: TcxRadioButton;
    TabSheet2: TRzTabSheet;
    RzBorder2: TRzBorder;
    RzBackground2: TRzBackground;
    RzLabel3: TRzLabel;
    RzLabel9: TRzLabel;
    edtMoreUnits: TcxCheckBox;
    edtSORT_ID1: TcxTextEdit;
    TabSheet3: TRzTabSheet;
    RzBorder3: TRzBorder;
    RzBackground3: TRzBackground;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    edtDefault1: TcxCheckBox;
    edtDefault2: TcxCheckBox;
    RzPanel4: TRzPanel;
    RzPanel7: TRzPanel;
    adv03: TImage;
    edtBK_Input: TRzPanel;
    RzPanel24: TRzPanel;
    RzLabel11: TRzLabel;
    edtInput: TcxTextEdit;
    RzPanel5: TRzPanel;
    RzPanel23: TRzPanel;
    RzLabel12: TRzLabel;
    btnNext: TRzBmpButton;
    btnPrev: TRzBmpButton;
    edtBK_BARCODE1: TRzPanel;
    RzPanel8: TRzPanel;
    RzLabel13: TRzLabel;
    edtBARCODE1: TcxTextEdit;
    edtBK_GODS_CODE: TRzPanel;
    RzPanel26: TRzPanel;
    RzLabel14: TRzLabel;
    edtGODS_CODE: TcxTextEdit;
    edtBK_GODS_NAME: TRzPanel;
    RzPanel27: TRzPanel;
    RzLabel15: TRzLabel;
    edtGODS_NAME: TcxTextEdit;
    edtBK_SORT_ID: TRzPanel;
    RzPanel28: TRzPanel;
    RzLabel16: TRzLabel;
    edtSORT_ID: TcxButtonEdit;
    edtBK_CALC_UNITS: TRzPanel;
    RzPanel29: TRzPanel;
    RzLabel17: TRzLabel;
    edtCALC_UNITS: TzrComboBoxList;
    edtBK_NEW_INPRICE: TRzPanel;
    RzPanel16: TRzPanel;
    RzLabel18: TRzLabel;
    edtNEW_INPRICE: TcxTextEdit;
    edtBK_NEW_OUTPRICE: TRzPanel;
    RzPanel31: TRzPanel;
    RzLabel19: TRzLabel;
    edtNEW_OUTPRICE: TcxTextEdit;
    edtBK_SHOP_NEW_OUTPRICE: TRzPanel;
    RzPanel18: TRzPanel;
    RzLabel20: TRzLabel;
    edtSHOP_NEW_OUTPRICE: TcxTextEdit;
    edtBK_SMALL_UNITS: TRzPanel;
    RzPanel33: TRzPanel;
    RzLabel21: TRzLabel;
    edtSMALL_UNITS: TzrComboBoxList;
    edtBK_BARCODE2: TRzPanel;
    RzPanel34: TRzPanel;
    RzLabel22: TRzLabel;
    edtBARCODE2: TcxTextEdit;
    edtBK_SMALLTO_CALC: TRzPanel;
    RzPanel35: TRzPanel;
    RzLabel23: TRzLabel;
    edtSMALLTO_CALC: TcxTextEdit;
    RzPanel13: TRzPanel;
    RzPanel36: TRzPanel;
    edtBK_BIG_UNITS: TRzPanel;
    RzPanel38: TRzPanel;
    RzLabel24: TRzLabel;
    edtBIG_UNITS: TzrComboBoxList;
    edtBK_BARCODE3: TRzPanel;
    RzPanel19: TRzPanel;
    RzLabel25: TRzLabel;
    edtBARCODE3: TcxTextEdit;
    RzPanel_SMALL: TRzLabel;
    RzPanel39: TRzPanel;
    RzPanel40: TRzPanel;
    RzPanel_BIG: TRzLabel;
    edtBK_BIGTO_CALC: TRzPanel;
    RzPanel42: TRzPanel;
    RzLabel27: TRzLabel;
    edtBIGTO_CALC: TcxTextEdit;
    cdsGoodsPrice: TZQuery;
    cdsGoodsInfo: TZQuery;
    cdsGoodsRelation: TZQuery;
    cdsBarCode: TZQuery;
    edtTable: TZQuery;
    RzLabel26: TRzLabel;
    red1: TLabel;
    red2: TLabel;
    red3: TLabel;
    red4: TLabel;
    red5: TLabel;
    cdsUnits: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure RzLabel11Click(Sender: TObject);
    procedure RzLabel12Click(Sender: TObject);
    procedure edtGOODS_OPTION1Click(Sender: TObject);
    procedure edtGOODS_OPTION2Click(Sender: TObject);
    procedure edtSORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtCALC_UNITSSaveValue(Sender: TObject);
    procedure edtCALC_UNITSPropertiesChange(Sender: TObject);
    procedure edtMoreUnitsPropertiesChange(Sender: TObject);
    procedure edtSMALL_UNITSSaveValue(Sender: TObject);
    procedure edtSMALL_UNITSPropertiesChange(Sender: TObject);
    procedure edtBIG_UNITSSaveValue(Sender: TObject);
    procedure edtBIG_UNITSPropertiesChange(Sender: TObject);
    procedure edtDefault1Click(Sender: TObject);
    procedure edtDefault2Click(Sender: TObject);
    procedure edtSORT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBARCODE1KeyPress(Sender: TObject; var Key: Char);
    procedure edtGODS_CODEKeyPress(Sender: TObject; var Key: Char);
    procedure edtGODS_NAMEKeyPress(Sender: TObject; var Key: Char);
    procedure edtSORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtCALC_UNITSKeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_INPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtNEW_OUTPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtSHOP_NEW_OUTPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtBIG_UNITSClearValue(Sender: TObject);
    procedure edtSMALL_UNITSClearValue(Sender: TObject);
    procedure edtSMALLTO_CALCKeyPress(Sender: TObject; var Key: Char);
    procedure edtBIGTO_CALCKeyPress(Sender: TObject; var Key: Char);
    procedure edtSMALL_UNITSKeyPress(Sender: TObject; var Key: Char);
    procedure edtBIG_UNITSKeyPress(Sender: TObject; var Key: Char);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtGOODS_OPTION1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtGOODS_OPTION1KeyPress(Sender: TObject; var Key: Char);
    procedure edtGOODS_OPTION2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function BarcodeFactory(rs:TZQuery;code:string):boolean;

    function  GetFinded:boolean;
    function  CanFocus(Control:TControl):Boolean;
    function  CheckUnit(unitName:string):string;
    procedure GetGoodsInfo;
    procedure UploadGoodsInfo;
    function  IsChinese(str:string):Boolean;
    procedure RefreshUnits;
    procedure RefreshUnitsList;
    procedure AddUnits(Sender: TObject);
    procedure SetLocalFinded(const Value: boolean);
    procedure SetRemoteFinded(const Value: boolean);
    procedure SetRspFinded(const Value: boolean);
    procedure HideGodsCode;
    procedure ShowGodsCode;
  public
    AObj:TRecord_;
    FLocalFinded:boolean;
    FRemoteFinded:boolean;
    FRspFinded:boolean;
    Simple:boolean;
    FY_RELATION_ID:string;
    FY_TENANT_ID:string;
    procedure OpenDataSet(tenantId,godsId:string);
    procedure PostDataSet;
    procedure ReadFromObject;
    procedure WriteToObject;
    procedure CheckInput1;
    procedure CheckInput2;
    procedure Save;
    procedure SetReadOnly;
    procedure CancelReadOnly;
    function  BarCodeSimpleInit(barcode:string):boolean;
    class function ShowDialog(Owner:TForm;barcode:string;var GodsId:string):boolean;
    property  LocalFinded:boolean read FLocalFinded write SetLocalFinded;
    property  RemoteFinded:boolean read FRemoteFinded write SetRemoteFinded;
    property  RspFinded:boolean read FRspFinded write SetRspFinded;
    property  Finded:boolean read GetFinded;
  end;

implementation

uses udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits,EncDec;

const
  FY_CREATOR_ID = '110000002'; //非烟供应链创建者,允许修改商品分类

{$R *.dfm}

procedure TfrmInitGoods.FormCreate(Sender: TObject);
var
  i: integer;
  rs: TZQuery;
begin
  inherited;
  Simple := false;
  AObj := TRecord_.Create;
  dbState := dsInsert;

  FY_RELATION_ID := '';
  FY_TENANT_ID := '';

  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
    begin
      if (rs.FieldByName('RELATION_ID').AsInteger = 1000008) and (rs.FieldByName('RELATION_TYPE').AsString = '1') then
        begin
          FY_RELATION_ID := rs.FieldByName('RELATION_ID').AsString;
          FY_TENANT_ID := rs.FieldByName('TENANT_ID').AsString;
          break;
        end;
      rs.Next;
    end;

  for i := 0 to rzPage.PageCount - 1 do
    begin
      rzPage.Pages[i].TabVisible := False;
    end;
  rzPage.ActivePageIndex := 0;
  btnPrev.Visible := false;
  btnNext.Visible := true;
  edtDefault1.Checked := false;
  edtDefault2.Checked := false;
  edtSORT_ID.Properties.ReadOnly := true;

  if (FY_TENANT_ID = '') or (FY_RELATION_ID = '') then
    begin
      btnNext.Enabled := false;
      Raise Exception.Create('当前企业尚未加盟非烟供应链！');
    end;
end;

procedure TfrmInitGoods.FormShow(Sender: TObject);
begin
  inherited;
  // CacheFactory.getAdvPngImage(adv03.Name,adv03.Picture);
  if CanFocus(edtInput) then edtInput.SetFocus
  else if CanFocus(edtGODS_CODE) then edtGODS_CODE.SetFocus;
end;

procedure TfrmInitGoods.btnNextClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 0 then
    begin
      LocalFinded := false;
      RemoteFinded := false;
      RspFinded := false;
      edtSORT_ID.Text := '';
      edtSHOP_NEW_OUTPRICE.Text := '';
      edtDefault1.Checked := false;
      edtDefault2.Checked := false;
      RefreshUnitsList;
      if edtGOODS_OPTION1.Checked then
        begin
          if dllApplication.mode = 'demo' then Raise Exception.Create('演示模式下不允许新增供应链商品！');
          GetGoodsInfo;
          edtBARCODE1.Text := '';
          edtBARCODE2.Text := '';
          edtBARCODE3.Text := '';
          edtBARCODE1.Properties.ReadOnly := false;
          edtBARCODE2.Properties.ReadOnly := false;
          edtBARCODE3.Properties.ReadOnly := false;
          SetEditStyle(dsInsert, edtBARCODE1.Style);
          SetEditStyle(dsInsert, edtBARCODE2.Style);
          SetEditStyle(dsInsert, edtBARCODE3.Style);
          edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
          edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
          edtBK_BARCODE3.Color := edtBARCODE3.Style.Color;
        end
      else
        begin
          OpenDataSet(token.tenantId, '');
          edtBARCODE1.Text := '自编条码...';
          edtBARCODE2.Text := '自编条码...';
          edtBARCODE3.Text := '自编条码...';
          edtBARCODE1.Properties.ReadOnly := true;
          edtBARCODE2.Properties.ReadOnly := true;
          edtBARCODE3.Properties.ReadOnly := true;
          SetEditStyle(dsBrowse, edtBARCODE1.Style);
          SetEditStyle(dsBrowse, edtBARCODE2.Style);
          SetEditStyle(dsBrowse, edtBARCODE3.Style);
          edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
          edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
          edtBK_BARCODE3.Color := edtBARCODE3.Style.Color;
        end;
      ReadFromObject;
      rzPage.ActivePageIndex := 1;
      btnPrev.Visible := True;
      btnNext.Visible := True;
      if edtGOODS_OPTION1.Checked then
         begin
           if CanFocus(edtGODS_NAME) then edtGODS_NAME.SetFocus;
         end
      else
         begin
           if CanFocus(edtGODS_CODE) then edtGODS_CODE.SetFocus;
         end;
    end
  else if rzPage.ActivePageIndex = 1 then
    begin
      CheckInput1;
      if edtMoreUnits.Checked then
        begin
          rzPage.ActivePageIndex := 2;
          btnPrev.Visible := True;
          btnNext.Visible := True;
          btnNext.Caption := '完成';
          if edtSMALL_UNITS.CanFocus then edtSMALL_UNITS.SetFocus; 
        end
      else
        begin
          WriteToObject;
          if (not Finded) and (edtGOODS_OPTION1.Checked) then UploadGoodsInfo;
          Save;
          if (not Simple) then MessageBox(Handle,'商品添加成功！','友情提示..',MB_OK) else ModalResult := MROK;
          rzPage.ActivePageIndex := 0;
          btnPrev.Visible := False;
          btnNext.Visible := True;
          btnNext.Caption := '下一步';
        end;
    end
  else if rzPage.ActivePageIndex = 2 then
    begin
      CheckInput2;
      WriteToObject;
      if (not Finded) and (edtGOODS_OPTION1.Checked) then UploadGoodsInfo;
      Save;
      if (not Simple) then MessageBox(Handle,'商品添加成功！','友情提示..',MB_OK) else ModalResult := MROK;
      rzPage.ActivePageIndex := 0;
      btnPrev.Visible := False;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end;
end;

procedure TfrmInitGoods.btnPrevClick(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 1 then
    begin
      rzPage.ActivePageIndex := 0;
      btnPrev.Visible := False;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end
  else if rzPage.ActivePageIndex = 2 then
    begin
      rzPage.ActivePageIndex := 1;
      btnPrev.Visible := True;
      btnNext.Visible := True;
      btnNext.Caption := '下一步';
    end;
end;

function TfrmInitGoods.GetFinded: boolean;
begin
  result := RspFinded or RemoteFinded or LocalFinded;
end;

function TfrmInitGoods.CanFocus(Control: TControl): Boolean;
begin
  result := false;
  if Control is TcxTextEdit then
    result := (self.Visible) and TcxTextEdit(Control).CanFocus;
  if Control is TzrComboBoxList then
    result := (self.Visible) and TzrComboBoxList(Control).CanFocus;
  if Control is TcxButtonEdit then
    result := (self.Visible) and TcxButtonEdit(Control).CanFocus;
end;

procedure TfrmInitGoods.GetGoodsInfo;
var
  barcode,godsId:string;
  hasGoods:TZQuery;
  tmpGoodsInfo,tmpBarCode,xxbarcode:TZQuery;
  Params:TftParamList;
  tmpObj:TRecord_;
  i:integer;
begin
  xxbarcode := nil;
  barcode := trim(edtInput.Text);
  if barcode = '' then
    begin
      if CanFocus(edtInput) then edtInput.SetFocus;
      Raise Exception.Create('请输入条形码！');
    end;
  if IsChinese(barcode) or (Length(barcode) <> 13) then
    begin
      if CanFocus(edtInput) then edtInput.SetFocus;
      Raise Exception.Create('条形码格式不合法！');
    end;

  // 查询自经营商品
  hasGoods := TZQuery.Create(nil);
  try
    hasGoods.SQL.Text := 'select GODS_ID from PUB_BARCODE where TENANT_ID = ' + FY_TENANT_ID + ' and BARCODE = '''+barcode+''' ';
    dataFactory.Open(hasGoods);
    if not hasGoods.IsEmpty then
      begin
        godsId := hasGoods.FieldByName('GODS_ID').AsString;
        hasGoods.Close;
        hasGoods.SQL.Text := 'select GODS_ID from PUB_GOODSINFO where TENANT_ID = ' + FY_TENANT_ID + ' and GODS_ID = ''' + godsId + '''';
        dataFactory.Open(hasGoods);
        if not hasGoods.IsEmpty then
          begin
            LocalFinded := true;
            godsId := hasGoods.FieldByName('GODS_ID').AsString;
          end
        else
          begin
            LocalFinded := false;
            godsId := '';
          end;
      end;
  finally
    hasGoods.Free;
  end;

  // 查询服务端商品
  {
  if (not Finded) and (dataFactory.iDbType = 5) then
    begin
      dataFactory.MoveToRemote;
      hasGoods := TZQuery.Create(nil);
      try
        hasGoods.SQL.Text := 'select GODS_ID from PUB_BARCODE where  TENANT_ID = ' + FY_TENANT_ID + ' and BARCODE = '''+barcode+''' ';
        dataFactory.Open(hasGoods);
        if not hasGoods.IsEmpty then
          begin
            godsId := hasGoods.FieldByName('GODS_ID').AsString;
            hasGoods.Close;
            hasGoods.SQL.Text := 'select GODS_ID from PUB_GOODSINFO where TENANT_ID = ' + FY_TENANT_ID + ' and GODS_ID = ''' + godsId + '''';
            dataFactory.Open(hasGoods);
            if not hasGoods.IsEmpty then
              begin
                RemoteFinded := true;
                godsId := hasGoods.FieldByName('GODS_ID').AsString;
              end
            else
              begin
                RemoteFinded := false;
                godsId := '';
              end;
          end;
      finally
        hasGoods.Free;
        dataFactory.MoveToDefault;
      end;
    end;
  }
  // 查询RSP商品
  if not Finded then
    begin
      try
        xxbarcode := TZQuery.Create(nil);
        RspFinded := barcodeFactory(xxbarcode,barcode);
      except
        on E:Exception do
           begin
             RspFinded := false;
             godsId := '';
             freeandnil(xxbarcode);
             Raise Exception.Create('查询商品信息失败，原因：'+E.Message);
           end;
      end;
    end;
 {
  if not Finded then
    begin
      try
        RspSyncFactory.downloadGoodsSort;
      except
        on E:Exception do
           Raise Exception.Create('下载商品分类失败，原因：'+E.Message);
      end;
    end;
  }
  OpenDataSet(FY_TENANT_ID, godsId);

  if LocalFinded then
    begin
      if cdsGoodsInfo.FieldByName('COMM').AsString[2] = '2' then
        begin
          cdsGoodsInfo.Edit;
          cdsGoodsInfo.Post;
        end;
      cdsBarCode.First;
      while not cdsBarCode.Eof do
        begin
          if cdsBarCode.FieldByName('COMM').AsString[2] = '2' then
            begin
              cdsBarCode.Edit;
              cdsBarCode.Post;
            end;
          cdsBarCode.Next;
        end;
      if cdsGoodsRelation.IsEmpty then
        begin
          cdsGoodsRelation.Append;
          cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          cdsGoodsRelation.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
          cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
          cdsGoodsRelation.FieldByName('NEW_INPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat;
          cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat;
          cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;
          cdsGoodsRelation.Post;
        end
      else
        begin
          if cdsGoodsRelation.FieldByName('COMM').AsString[2] = '2' then
            begin
              cdsGoodsRelation.Edit;
              cdsGoodsRelation.Post;
            end;
        end;
    end;
  {
  if RemoteFinded then
    begin
      tmpGoodsInfo := TZQuery.Create(nil);
      tmpBarCode := TZQuery.Create(nil);
      Params := TftParamList.Create(nil);
      dataFactory.MoveToRemote;
      try
        Params.ParamByName('TENANT_ID').AsInteger := strtoint(FY_TENANT_ID);
        Params.ParamByName('GODS_ID').AsString := godsId;
        dataFactory.Open(tmpGoodsInfo,'TGoodsInfoV60',Params);
        dataFactory.Open(tmpBarCode,'TBarCodeV60',Params);

        cdsGoodsInfo.Edit;
        tmpObj := TRecord_.Create;
        try
          tmpObj.ReadFromDataSet(tmpGoodsInfo);
          tmpObj.WriteToDataSet(cdsGoodsInfo);
        finally
          tmpObj.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if tmpBarCode.Locate('BARCODE_TYPE','0',[]) then
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','0',[]) then
                cdsBarCode.Edit
              else
                cdsBarCode.Append;
              tmpObj.ReadFromDataSet(tmpBarCode);
              tmpObj.WriteToDataSet(cdsBarCode);
            end
          else
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','0',[]) then
                cdsBarCode.Delete;
            end;

          if tmpBarCode.Locate('BARCODE_TYPE','1',[]) then
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','1',[]) then
                cdsBarCode.Edit
              else
                cdsBarCode.Append;
              tmpObj.ReadFromDataSet(tmpBarCode);
              tmpObj.WriteToDataSet(cdsBarCode);
            end
          else
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','1',[]) then
                cdsBarCode.Delete;
            end;

          if tmpBarCode.Locate('BARCODE_TYPE','2',[]) then
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','2',[]) then
                cdsBarCode.Edit
              else
                cdsBarCode.Append;
              tmpObj.ReadFromDataSet(tmpBarCode);
              tmpObj.WriteToDataSet(cdsBarCode);
            end
          else
            begin
              if cdsBarCode.Locate('BARCODE_TYPE','2',[]) then
                cdsBarCode.Delete;
            end;
        finally
          tmpObj.Free;
        end;
      finally
        dataFactory.MoveToDefault;
        tmpGoodsInfo.Free;
        tmpBarCode.Free;
        Params.Free;
      end;

      if cdsGoodsRelation.IsEmpty then
        begin
          cdsGoodsRelation.Append;
          cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
        end
      else
        cdsGoodsRelation.Edit;
      cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      cdsGoodsRelation.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
      cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
      cdsGoodsRelation.FieldByName('NEW_INPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;

      PostDataSet;

      DownloadUnits;
    end;
  }
  if RspFinded then
    begin
      if cdsGoodsInfo.IsEmpty then
        cdsGoodsInfo.Append
      else
        cdsGoodsInfo.Edit;
      cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := StrtoInt(FY_TENANT_ID);
      cdsGoodsInfo.FieldByName('GODS_ID').AsString := '00000000000000000000000' + xxBarcode.FieldbyName('BARCODE').AsString;
      cdsGoodsInfo.FieldByName('GODS_CODE').AsString := xxBarcode.FieldbyName('BARCODE').AsString;
      cdsGoodsInfo.FieldByName('GODS_NAME').AsString := xxBarcode.FieldbyName('NAME').AsString;
      cdsGoodsInfo.FieldByName('GODS_SPELL').AsString := xxBarcode.FieldbyName('SPELL').AsString;
      cdsGoodsInfo.FieldByName('GODS_TYPE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('SORT_ID1').AsString := '#';
      cdsGoodsInfo.FieldByName('UNIT_ID').AsString := CheckUnit(xxBarcode.FieldbyName('UNIT_NAME').AsString);
      cdsGoodsInfo.FieldByName('CALC_UNITS').AsString := cdsGoodsInfo.FieldByName('UNIT_ID').AsString;
      cdsGoodsInfo.FieldByName('BARCODE').AsString := xxBarcode.FieldbyName('BARCODE').AsString;
      cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString := '';
      cdsGoodsInfo.FieldByName('SMALLTO_CALC').AsFloat := 1;
      cdsGoodsInfo.FieldByName('BIG_UNITS').AsString := '';
      cdsGoodsInfo.FieldByName('BIGTO_CALC').AsFloat := 1;
      cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat := xxBarcode.FieldbyName('IN_PRICE').AsFloat;
      cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat := xxBarcode.FieldbyName('OUT_PRICE').AsFloat;
      cdsGoodsInfo.FieldByName('NEW_LOWPRICE').AsFloat := 0;
      cdsGoodsInfo.FieldByName('USING_PRICE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('HAS_INTEGRAL').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_BATCH_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_LOCUS_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger := 0;

      if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
        cdsBarCode.Edit
      else
      begin
        cdsBarCode.Append;
        cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      end;
      cdsBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldbyName('TENANT_ID').AsInteger;
      cdsBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldbyName('GODS_ID').AsString;
      cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
      cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
      cdsBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('CALC_UNITS').AsString;
      cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '0';
      cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
      cdsBarCode.FieldByName('BARCODE').AsString := cdsGoodsInfo.FieldbyName('BARCODE').AsString;


      if cdsGoodsRelation.IsEmpty then
      begin
        cdsGoodsRelation.Append;
        cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
        cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
      end
      else
        cdsGoodsRelation.Edit;
      cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      cdsGoodsRelation.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
      cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
      cdsGoodsRelation.FieldByName('NEW_INPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;

      PostDataSet;

     end;

  if Finded and (cdsGoodsInfo.FieldByName('TENANT_ID').AsString <> FY_CREATOR_ID) then
     Raise Exception.Create('卷烟商品不允许新增！'); 

  edtTable.Data := cdsGoodsInfo.Data;
end;

procedure TfrmInitGoods.OpenDataSet(tenantId, godsId: string);
var Params: TftParamList;
begin
  Params := TftParamList.Create(nil);
  cdsGoodsInfo.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    dataFactory.Open(cdsGoodsInfo,'TGoodsInfoV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsBarCode.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    dataFactory.Open(cdsBarCode,'TBarCodeV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsGoodsRelation.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
    dataFactory.Open(cdsGoodsRelation,'TGoodsRelationV60',Params);
  finally
    Params.Free;
  end;

  Params := TftParamList.Create(nil);
  cdsGoodsPrice.Close;
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('PRICE_ID').AsString := '#';
    dataFactory.Open(cdsGoodsPrice,'TGoodsPriceV60',Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmInitGoods.ReadFromObject;
 procedure InitSort(sortId:string);
 var rs:TZQuery;
 begin
   rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
   if rs.Locate('RELATION_ID,SORT_ID',VarArrayOf([0,sortId]),[]) then
      begin
        edtSORT_ID1.Text := rs.FieldByName('SORT_ID').AsString;
        edtSORT_ID.Text := rs.FieldByName('SORT_NAME').AsString;
      end
   else if rs.Locate('RELATION_ID,SORT_ID',VarArrayOf([FY_RELATION_ID,sortId]),[]) then
      begin
        if rs.Locate('RELATION_ID,SORT_NAME',VarArrayOf([0,rs.FieldByName('SORT_NAME').AsString]),[]) then
           begin
             edtSORT_ID1.Text := rs.FieldByName('SORT_ID').AsString;
             edtSORT_ID.Text := rs.FieldByName('SORT_NAME').AsString;
           end
        else
           begin
             edtSORT_ID1.Text := '#';
             edtSORT_ID.Text := '无 分 类';
           end;
      end
   else
      begin
        edtSORT_ID1.Text := '#';
        edtSORT_ID.Text := '无 分 类';
      end;
 end;
var rs:TZQuery;
begin
  if edtGOODS_OPTION1.Checked then
     HideGodsCode
  else
     ShowGodsCode;

  AObj.ReadFromDataSet(cdsGoodsInfo);
  udllShopUtil.ReadFromObject(AObj,self);

  if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
    edtBARCODE1.Text := cdsBarCode.FieldByName('BARCODE').AsString;

  if edtGOODS_OPTION1.Checked and (edtBARCODE1.Text = '') then
    edtBARCODE1.Text := edtInput.Text;

  if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
    begin
      if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
        edtBARCODE2.Text := cdsBarCode.FieldByName('BARCODE').AsString;
    end
  else edtSMALLTO_CALC.Text := '';
  if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
    begin
      if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
        edtBARCODE3.Text := cdsBarCode.FieldByName('BARCODE').AsString;
    end
  else edtBIGTO_CALC.Text := '';

  if (cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '') and
     (cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString) then
    edtDefault1.Checked := true
  else
  if (cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '') and
     (cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('BIG_UNITS').AsString) then
    edtDefault2.Checked := true;

  if Finded then
    begin
      SetReadOnly;

      if cdsGoodsInfo.FieldByName('TENANT_ID').AsString <> FY_CREATOR_ID then
        begin
          rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
          if rs.Locate('SORT_ID',cdsGoodsInfo.FieldByName('SORT_ID1').AsString,[]) then
             edtSORT_ID.Text := rs.FieldByName('SORT_NAME').AsString;
          edtSORT_ID1.Properties.ReadOnly := true;
          SetEditStyle(dsBrowse, edtSORT_ID.Style);
          edtBK_SORT_ID.Color := edtSORT_ID.Style.Color;
        end
      else
        begin
          edtSORT_ID1.Properties.ReadOnly := false;
          SetEditStyle(dsInsert, edtSORT_ID.Style);
          edtBK_SORT_ID.Color := edtSORT_ID.Style.Color;
          if Copy(cdsGoodsRelation.FieldByName('COMM').AsString,2,2) <> '2' then
            begin
              if cdsGoodsRelation.FieldByName('GODS_CODE').AsString <> '' then
                 edtGODS_CODE.Text :=  cdsGoodsRelation.FieldByName('GODS_CODE').AsString;
              if cdsGoodsRelation.FieldByName('GODS_NAME').AsString <> '' then
                 edtGODS_NAME.Text :=  cdsGoodsRelation.FieldByName('GODS_NAME').AsString;
              if cdsGoodsRelation.FieldByName('SORT_ID1').AsString <> '' then
                 edtSORT_ID1.Text := cdsGoodsRelation.FieldByName('SORT_ID1').AsString;
              if cdsGoodsRelation.FieldByName('NEW_INPRICE').AsString <> '' then
                 edtNEW_INPRICE.Text := cdsGoodsRelation.FieldByName('NEW_INPRICE').AsString;
              if cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsString <> '' then
                 edtNEW_OUTPRICE.Text := cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsString;

              if (cdsGoodsRelation.FieldByName('SORT_ID1').AsString = '')
                 or
                 (cdsGoodsRelation.FieldByName('SORT_ID1').AsString = '#')
                 then
                 InitSort(cdsGoodsInfo.FieldByName('SORT_ID1').AsString)
              else
                 InitSort(cdsGoodsRelation.FieldByName('SORT_ID1').AsString);
            end
          else
            begin
              InitSort(cdsGoodsInfo.FieldByName('SORT_ID1').AsString);
            end;
        end;

      if cdsGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
        begin
          if cdsGoodsPrice.FieldByName('COMM').AsString[2] <> '2' then
             edtSHOP_NEW_OUTPRICE.Text := cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsString
        end;

      if trim(edtSHOP_NEW_OUTPRICE.Text) = '' then
         edtSHOP_NEW_OUTPRICE.Text := edtNEW_OUTPRICE.Text;

      if (cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '') or (cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '') then
         begin
           edtMoreUnits.Checked := true;
           btnNext.Caption := '下一步';
         end
      else
         begin
           edtMoreUnits.Checked := false;
           btnNext.Caption := '完成';
         end;
    end
  else
    begin
      CancelReadOnly;
      edtMoreUnits.Checked := false;
      btnNext.Caption := '完成';
      edtSORT_ID1.Text := '';
      edtSORT_ID.Text := '';
      edtSORT_ID1.Properties.ReadOnly := false;
      SetEditStyle(dsInsert, edtSORT_ID.Style);
      edtBK_SORT_ID.Color := edtSORT_ID.Style.Color;
    end;

  if edtGOODS_OPTION1.Checked then
    begin
      if not Finded then
        begin
          edtBARCODE1.Properties.ReadOnly := false;
          edtBARCODE2.Properties.ReadOnly := false;
          edtBARCODE3.Properties.ReadOnly := false;
          SetEditStyle(dsInsert, edtBARCODE1.Style);
          SetEditStyle(dsInsert, edtBARCODE2.Style);
          SetEditStyle(dsInsert, edtBARCODE3.Style);
          edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
          edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
          edtBK_BARCODE3.Color := edtBARCODE3.Style.Color;
        end
      else
        begin
          edtBARCODE1.Properties.ReadOnly := true;
          edtBARCODE2.Properties.ReadOnly := true;
          edtBARCODE3.Properties.ReadOnly := true;
          SetEditStyle(dsBrowse, edtBARCODE1.Style);
          SetEditStyle(dsBrowse, edtBARCODE2.Style);
          SetEditStyle(dsBrowse, edtBARCODE3.Style);
          edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
          edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
          edtBK_BARCODE3.Color := edtBARCODE3.Style.Color;
        end
    end
  else
    begin
      edtBARCODE1.Properties.ReadOnly := true;
      edtBARCODE2.Properties.ReadOnly := true;
      edtBARCODE3.Properties.ReadOnly := true;
      SetEditStyle(dsBrowse, edtBARCODE1.Style);
      SetEditStyle(dsBrowse, edtBARCODE2.Style);
      SetEditStyle(dsBrowse, edtBARCODE3.Style);
      edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
      edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
      edtBK_BARCODE3.Color := edtBARCODE3.Style.Color;
    end;
end;

procedure TfrmInitGoods.CheckInput1;
  procedure CheckGodsMaxPrice(edtPrice: TcxTextEdit;MsgInfo: string);
    begin
      if StrToFloatDef(edtPrice.Text,0) > 999999999 then
        begin
          if CanFocus(edtPrice) then edtPrice.SetFocus;
          Raise Exception.Create('输入的〖'+MsgInfo+'〗数值过大，无效！');
        end;
    end;
var barcode:string;
begin
  if edtGOODS_OPTION1.Checked then //无条码商品不检测条形码
    begin
      if trim(edtBARCODE1.Text)='' then
        begin
          if CanFocus(edtBARCODE1) then edtBARCODE1.SetFocus;
          Raise Exception.Create('条码不能为空，请输入！');
        end;
    end;

  barcode := trim(edtBARCODE1.Text);
  if edtGOODS_OPTION1.Checked and (trim(edtGODS_CODE.Text) = '') then
     begin
       if trim(Copy(barcode,Length(barcode)-5,6)) <> '' then
          edtGODS_CODE.Text := trim(Copy(barcode,Length(barcode)-5,6))
       else
          edtGODS_CODE.Text := trim(barcode);
     end;

  if Length(edtGODS_CODE.Text) > 20 then edtGODS_CODE.Text := Copy(edtGODS_CODE.Text,1,20);

  if trim(edtGODS_NAME.Text)='' then
    begin
      if CanFocus(edtGODS_NAME) then edtGODS_NAME.SetFocus;
      Raise Exception.Create('商品名称不能为空！');
    end;

  if trim(edtSORT_ID1.Text)='' then
    begin
      if CanFocus(edtSORT_ID) then edtSORT_ID.SetFocus;
      Raise Exception.Create('商品分类不能为空！');
    end;

  if trim(edtCALC_UNITS.Text)='' then edtCALC_UNITS.KeyValue := null;

  if (trim(edtCALC_UNITS.AsString)='') or (trim(edtCALC_UNITS.Text)='') then
    begin
      if CanFocus(edtCALC_UNITS) then edtCALC_UNITS.SetFocus;
      Raise Exception.Create('计量单位不能为空！');
    end;

  if trim(edtNEW_INPRICE.Text)='' then
    begin
      edtNEW_INPRICE.Text := '0';
    end;
  if trim(edtNEW_OUTPRICE.Text)='' then
    begin
      if CanFocus(edtNEW_OUTPRICE) then edtNEW_OUTPRICE.SetFocus;
      Raise Exception.Create('零售价不能为空！');
    end;
  if trim(edtSHOP_NEW_OUTPRICE.Text)='' then
    begin
      edtSHOP_NEW_OUTPRICE.Text := edtNEW_OUTPRICE.Text;
    end;

  CheckGodsMaxPrice(edtNEW_INPRICE,'标准进价');
  CheckGodsMaxPrice(edtNEW_OUTPRICE,'标准售价');
  CheckGodsMaxPrice(edtSHOP_NEW_OUTPRICE,'店内售价');
end;

procedure TfrmInitGoods.CheckInput2;
begin
  if edtGOODS_OPTION1.Checked then //无条码商品不检测条形码
    begin
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBARCODE2.Text)='') then
        begin
          if CanFocus(edtSMALL_UNITS) then edtSMALL_UNITS.SetFocus;
          Raise Exception.Create('小包装条码不能为空！');
        end;
      if (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)='') then
        begin
          if CanFocus(edtBIG_UNITS) then edtBIG_UNITS.SetFocus;
          Raise Exception.Create('大包装条码不能为空！');
        end;
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBARCODE2.Text)=trim(edtBARCODE1.Text)) then
        begin
          if CanFocus(edtBARCODE2) then edtBARCODE2.SetFocus;
          Raise Exception.Create('小包装条码不能与计量单位条码相同！');
        end;
      if (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)=trim(edtBARCODE1.Text)) then
        begin
          if CanFocus(edtBARCODE3) then edtBARCODE3.SetFocus;
          Raise Exception.Create('大包装条码不能与计量单位条码相同！');
        end;
      if (trim(edtSMALL_UNITS.AsString)<>'') and (trim(edtBIG_UNITS.AsString)<>'') and (trim(edtBARCODE3.Text)=trim(edtBARCODE1.Text)) then
        begin
          if CanFocus(edtBARCODE3) then edtBARCODE3.SetFocus;
          Raise Exception.Create('大包装条码不能与小包装条码相同！');
        end;
    end;
  
  if (trim(edtSMALL_UNITS.AsString)<>'') and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
    begin
      if CanFocus(edtSMALLTO_CALC) then edtSMALLTO_CALC.SetFocus;
      Raise Exception.Create('小包装单位的换算系数不能小于等于0!');
    end;
  if (trim(edtBIG_UNITS.AsString)<>'') and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
    begin
      if CanFocus(edtBIGTO_CALC) then   edtBIGTO_CALC.SetFocus;
      Raise Exception.Create('大包装单位的换算系数不能小于等于0!');
    end;

  if trim(edtCALC_UNITS.AsString)=trim(edtSMALL_UNITS.AsString) then
    begin
      if CanFocus(edtSMALL_UNITS) then edtSMALL_UNITS.SetFocus;
      Raise Exception.Create('小包装单位不能和计量单位相同！');
    end;
  if trim(edtCALC_UNITS.AsString)=trim(edtBIG_UNITS.AsString) then
    begin
      if CanFocus(edtBIG_UNITS) then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位不能和计量单位相同！');
    end;
  if (trim(edtSMALL_UNITS.AsString)=trim(edtBIG_UNITS.AsString)) and (trim(edtSMALL_UNITS.AsString)<>'') then
    begin
      if CanFocus(edtBIG_UNITS) then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位不能和小包装单位相同！');
    end;

  if (edtDefault1.Checked) and (trim(edtSMALL_UNITS.AsString)='') then
    begin
      if CanFocus(edtSMALL_UNITS) then edtSMALL_UNITS.SetFocus;
      Raise Exception.Create('小包装单位设为默认单位不能为空');
    end;
  if (edtDefault1.Checked) and (StrToFloatDef(edtSMALLTO_CALC.Text,0)<=0) then
    begin
      if CanFocus(edtSMALLTO_CALC) then edtSMALLTO_CALC.SetFocus;
      Raise Exception.Create('小包装单位的换算系数不能小于等于0!');
    end;
  if (edtDefault2.Checked) and (trim(edtBIG_UNITS.AsString)='') then
    begin
      if CanFocus(edtBIG_UNITS) then edtBIG_UNITS.SetFocus;
      Raise Exception.Create('大包装单位设为默认单位不能为空');
    end;
  if (edtDefault2.Checked) and (StrToFloatDef(edtBIGTO_CALC.Text,0)<=0) then
    begin
      if CanFocus(edtBIGTO_CALC) then edtBIGTO_CALC.SetFocus;
      Raise Exception.Create('大包装单位的换算系数不能小于等于0!');
    end;
end;

procedure TfrmInitGoods.WriteToObject;
var rs:TZQuery;
begin
  if not edtMoreUnits.Checked then
    begin
      edtSMALL_UNITS.KeyValue := null;
      edtBIG_UNITS.KeyValue := null;
    end;

  if edtSMALL_UNITS.AsString = '' then edtSMALL_UNITS.KeyValue := null;
  if edtBIG_UNITS.AsString  = '' then edtBIG_UNITS.KeyValue := null;

  udllShopUtil.WriteToObject(AObj,self);
  AObj.FieldByName('BARCODE').AsString := edtBARCODE1.Text;
  AObj.WriteToDataSet(cdsGoodsInfo);

  if cdsGoodsRelation.IsEmpty then
    cdsGoodsRelation.Append
  else
    cdsGoodsRelation.Edit;

  if not Finded then
    begin
      if cdsGoodsInfo.IsEmpty then
        cdsGoodsInfo.Append
      else
        cdsGoodsInfo.Edit;
      if edtGOODS_OPTION1.Checked then //供应链商品
        begin
          cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := strtoint(FY_TENANT_ID);
          cdsGoodsInfo.FieldByName('BARCODE').AsString := edtBARCODE1.Text;
        end
      else //无条码商品,自编条码
        begin
          cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          cdsGoodsInfo.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
          if trim(edtGODS_CODE.Text) = '' then
             begin
               if trim(Copy(cdsGoodsInfo.FieldByName('BARCODE').AsString,2,6)) <> '' then
                  edtGODS_CODE.Text := trim(Copy(cdsGoodsInfo.FieldByName('BARCODE').AsString,2,6))
               else
                  edtGODS_CODE.Text := cdsGoodsInfo.FieldByName('BARCODE').AsString;
               cdsGoodsInfo.FieldByName('GODS_CODE').AsString := trim(edtGODS_CODE.Text);
             end;
        end;
      cdsGoodsInfo.FieldByName('GODS_ID').AsString := TSequence.NewId;
      cdsGoodsInfo.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(edtGODS_NAME.Text,3);
      cdsGoodsInfo.FieldByName('GODS_TYPE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_PRICE').AsInteger := 1;
      cdsGoodsInfo.FieldByName('HAS_INTEGRAL').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_BATCH_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger := 1;
      cdsGoodsInfo.FieldByName('USING_LOCUS_NO').AsInteger := 2;
      cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger := 0;

      if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
        cdsBarCode.Edit
      else
      begin
        cdsBarCode.Append;
        cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      end;
      cdsBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
      cdsBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
      cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
      cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
      cdsBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
      cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '0';
      cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
      cdsBarCode.FieldByName('BARCODE').AsString := cdsGoodsInfo.FieldByName('BARCODE').AsString;

      if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
        begin
          if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
            cdsBarCode.Edit
          else
          begin
            cdsBarCode.Append;
            cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          end;
          cdsBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          cdsBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString;
          cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '1';
          cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
          if edtGOODS_OPTION1.Checked then //供应链商品
            cdsBarCode.FieldByName('BARCODE').AsString := edtBARCODE2.Text
          else //无条码商品,自编条码
            cdsBarCode.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
        end;
      if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
        begin
          if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
            cdsBarCode.Edit
          else
          begin
            cdsBarCode.Append;
            cdsBarCode.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          end;
          cdsBarCode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          cdsBarCode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsBarCode.FieldByName('PROPERTY_01').AsString := '#';
          cdsBarCode.FieldByName('PROPERTY_02').AsString := '#';
          cdsBarCode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('BIG_UNITS').AsString;
          cdsBarCode.FieldByName('BARCODE_TYPE').AsString := '2';
          cdsBarCode.FieldByName('BATCH_NO').AsString := '#';
          if edtGOODS_OPTION1.Checked then //供应链商品
            cdsBarCode.FieldByName('BARCODE').AsString := edtBARCODE3.Text
          else //无条码商品,自编条码
            cdsBarCode.FieldByName('BARCODE').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',token.tenantId,'',6),'#','#');
        end;

      if edtGOODS_OPTION1.Checked then //供应链商品
        begin
          cdsGoodsRelation.FieldByName('ROWS_ID').AsString := TSequence.NewId;
          cdsGoodsRelation.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          cdsGoodsRelation.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger := strtoint(FY_RELATION_ID);
          cdsGoodsRelation.FieldByName('ZOOM_RATE').AsFloat := 1.000;
        end;

      // 管理单位
      if edtMoreUnits.Checked and edtDefault1.Checked then
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtSMALL_UNITS.AsString
      else if edtMoreUnits.Checked and edtDefault2.Checked then
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtBIG_UNITS.AsString
      else
        cdsGoodsInfo.FieldByName('UNIT_ID').AsString := edtCALC_UNITS.AsString;
    end;

  if edtGOODS_OPTION1.Checked then //供应链商品
    begin
      cdsGoodsRelation.FieldByName('GODS_CODE').AsString := cdsGoodsInfo.FieldByName('GODS_CODE').AsString;
      cdsGoodsRelation.FieldByName('GODS_NAME').AsString := cdsGoodsInfo.FieldByName('GODS_NAME').AsString;
      cdsGoodsRelation.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(cdsGoodsRelation.FieldByName('GODS_NAME').AsString,3);
      if Finded then
         cdsGoodsRelation.FieldByName('SORT_ID1').AsString := cdsGoodsInfo.FieldByName('SORT_ID1').AsString
      else
         begin
           rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
           if rs.Locate('RELATION_ID,SORT_ID',VarArrayOf([FY_RELATION_ID,cdsGoodsInfo.FieldByName('SORT_ID1').AsString]),[]) then
              begin
                if rs.Locate('RELATION_ID,SORT_NAME',VarArrayOf([0,rs.FieldByName('SORT_NAME').AsString]),[]) then
                   cdsGoodsRelation.FieldByName('SORT_ID1').AsString := rs.FieldByName('SORT_ID').AsString
                else
                   cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
              end
           else
              cdsGoodsRelation.FieldByName('SORT_ID1').AsString := '#';
         end;
      cdsGoodsRelation.FieldByName('NEW_INPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_INPRICE').AsFloat;
      cdsGoodsRelation.FieldByName('NEW_OUTPRICE').AsFloat := cdsGoodsInfo.FieldByName('NEW_OUTPRICE').AsFloat;
    end;

  // 多包装条码
  if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString = '' then
    begin
      if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
         cdsBarCode.Delete;
    end;
  if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString = '' then
    begin
      if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
         cdsBarCode.Delete;
    end;

  PostDataSet;

  if Finded then cdsGoodsInfo.Data := edtTable.Data;
end;

procedure TfrmInitGoods.UploadGoodsInfo;
begin
end;

procedure TfrmInitGoods.Save;
var
  tmpGoodsInfo,tmpBarCode,tmpGoodsRelation,tmpGoodsPrice: TZQuery;
  Params: TftParamList;
  tmpObj: TRecord_;
  isDel: boolean;
begin
  isDel := false;
  if FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0))=0 then
    begin
      isDel := false;
      if cdsGoodsPrice.Locate('SHOP_ID',token.tenantId+'0001',[]) and
         (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat)=0)
      then isDel := true;

      if cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) and (cdsGoodsPrice.RecordCount=1) then
        isDel := true;

      if IsDel and cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) then cdsGoodsPrice.Delete;
    end;
  if not isDel then
    begin
      if cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) then
        cdsGoodsPrice.Edit
      else
        cdsGoodsPrice.Append;
      cdsGoodsPrice.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      cdsGoodsPrice.FieldByName('PRICE_ID').AsString := '#';
      cdsGoodsPrice.FieldByName('SHOP_ID').AsString := token.shopId;
      cdsGoodsPrice.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldbyName('GODS_ID').AsString;
      cdsGoodsPrice.FieldByName('PRICE_METHOD').AsString := '1';
      cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
      cdsGoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*cdsGoodsInfo.FieldByName('SMALLTO_CALC').AsFloat;
      cdsGoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*cdsGoodsInfo.FieldByName('BIGTO_CALC').AsFloat;
      cdsGoodsPrice.Post;
    end;

  // 远程保存非烟商品
  {if RspFinded and (dataFactory.iDbType = 5) then
     begin
       tmpGoodsInfo := TZQuery.Create(nil);
       tmpBarCode := TZQuery.Create(nil);
       dataFactory.MoveToRemote;
       try
         Params := TftParamList.Create(nil);
         tmpGoodsInfo.Close;
         try
           Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
           Params.ParamByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
           dataFactory.Open(tmpGoodsInfo,'TGoodsInfoV60',Params);
         finally
           Params.Free;
         end;

         Params := TftParamList.Create(nil);
         tmpBarCode.Close;
         try
           Params.ParamByName('TENANT_ID').AsInteger := cdsBarCode.FieldByName('TENANT_ID').AsInteger;
           Params.ParamByName('GODS_ID').AsString := cdsBarCode.FieldByName('GODS_ID').AsString;
           dataFactory.Open(tmpBarCode,'TBarCodeV60',Params);
         finally
           Params.Free;
         end;

         tmpObj := TRecord_.Create;
         try
           if tmpGoodsInfo.IsEmpty then tmpGoodsInfo.Append
           else tmpGoodsInfo.Edit;
           tmpObj.ReadFromDataSet(cdsGoodsInfo);
           tmpObj.WriteToDataSet(tmpGoodsInfo, false);
         finally
           tmpObj.Free;
         end;

         tmpObj := TRecord_.Create;
         try
           if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
                 tmpBarCode.Edit
               else
                 tmpBarCode.Append;
               tmpObj.ReadFromDataSet(cdsBarCode);
               tmpObj.WriteToDataSet(tmpBarCode, false);
             end
           else
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
                 tmpBarCode.Delete;
             end;

           if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
                 tmpBarCode.Edit
               else
                 tmpBarCode.Append;
               tmpObj.ReadFromDataSet(cdsBarCode);
               tmpObj.WriteToDataSet(tmpBarCode, false);
             end
           else
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
                  tmpBarCode.Delete;
             end;

           if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
                 tmpBarCode.Edit
               else
                 tmpBarCode.Append;
               tmpObj.ReadFromDataSet(cdsBarCode);
               tmpObj.WriteToDataSet(tmpBarCode, false);
             end
           else
             begin
               if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
                 tmpBarCode.Delete;
             end;
         finally
           tmpObj.Free;
         end;

        dataFactory.BeginBatch;
         try
           dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
           dataFactory.AddBatch(tmpBarCode,'TBarCodeV60',nil);
           dataFactory.CommitBatch;
         except
           dataFactory.CancelBatch;
           Raise;
         end;
       finally
         dataFactory.MoveToDefault;
         tmpGoodsInfo.Free;
         tmpBarCode.Free;
       end;
     end;
  }
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',nil);
    dataFactory.AddBatch(cdsBarCode,'TBarCodeV60',nil);
    dataFactory.AddBatch(cdsGoodsPrice,'TGoodsPriceV60',nil);
    if edtGOODS_OPTION1.Checked then
      dataFactory.AddBatch(cdsGoodsRelation,'TGoodsRelationV60',nil);
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    Raise;
  end;

  // 本地保存
  if dataFactory.iDbType <> 5 then
    begin
      tmpGoodsInfo := TZQuery.Create(nil);
      tmpBarCode := TZQuery.Create(nil);
      tmpGoodsRelation := TZQuery.Create(nil);
      tmpGoodsPrice := TZQuery.Create(nil);
      dataFactory.MoveToSqlite;
      try
        Params := TftParamList.Create(nil);
        tmpGoodsInfo.Close;
        try
          Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          Params.ParamByName('RELATION_ID').AsInteger := cdsGoodsRelation.FieldByName('RELATION_ID').AsInteger;
          Params.ParamByName('SHOP_ID').AsString := cdsGoodsPrice.FieldByName('SHOP_ID').AsString;
          Params.ParamByName('PRICE_ID').AsString := cdsGoodsPrice.FieldByName('PRICE_ID').AsString;
          dataFactory.BeginBatch;
          try
            dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',Params);
            dataFactory.AddBatch(tmpBarCode,'TBarCodeV60',Params);
            dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',Params);
            dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',Params);
            dataFactory.OpenBatch;
          except
            dataFactory.CancelBatch;
            Raise;
          end;
        finally
          Params.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if tmpGoodsInfo.IsEmpty then tmpGoodsInfo.Append
          else tmpGoodsInfo.Edit;
          tmpObj.ReadFromDataSet(cdsGoodsInfo);
          tmpObj.WriteToDataSet(tmpGoodsInfo, false);
        finally
          tmpObj.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
                tmpBarCode.Edit
              else
                tmpBarCode.Append;
              tmpObj.ReadFromDataSet(cdsBarCode);
              tmpObj.WriteToDataSet(tmpBarCode, false);
            end
          else
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
                tmpBarCode.Delete;
            end;

          if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
                tmpBarCode.Edit
              else
                tmpBarCode.Append;
              tmpObj.ReadFromDataSet(cdsBarCode);
              tmpObj.WriteToDataSet(tmpBarCode, false);
            end
          else
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
                tmpBarCode.Delete;
            end;

          if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
                tmpBarCode.Edit
              else
                tmpBarCode.Append;
              tmpObj.ReadFromDataSet(cdsBarCode);
              tmpObj.WriteToDataSet(tmpBarCode, false);
            end
          else
            begin
              if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
                tmpBarCode.Delete;
            end;
        finally
          tmpObj.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Append
          else tmpGoodsRelation.Edit;
          tmpObj.ReadFromDataSet(cdsGoodsRelation);
          tmpObj.WriteToDataSet(tmpGoodsRelation, false);
        finally
          tmpObj.Free;
        end;

        tmpObj := TRecord_.Create;
        try
          if cdsGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
            begin
              if tmpGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
                tmpGoodsPrice.Edit
              else
                tmpGoodsPrice.Append;
              tmpObj.ReadFromDataSet(cdsGoodsPrice);
              tmpObj.WriteToDataSet(tmpGoodsPrice, false);
            end
          else
            begin
              if tmpGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
                tmpGoodsPrice.Delete;
            end;
        finally
          tmpObj.Free;
        end;

        if tmpGoodsInfo.State in [dsEdit,dsInsert] then
          tmpGoodsInfo.Post;
        if tmpBarCode.State in [dsEdit,dsInsert] then
          tmpBarCode.Post;
        if tmpGoodsRelation.State in [dsEdit,dsInsert] then
          tmpGoodsRelation.Post;
        if tmpGoodsPrice.State in [dsEdit,dsInsert] then
          tmpGoodsPrice.Post;

        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
          dataFactory.AddBatch(tmpBarCode,'TBarCodeV60',nil);
          dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',nil);
          if edtGOODS_OPTION1.Checked then
            dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',nil);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
        tmpGoodsInfo.Free;
        tmpBarCode.Free;
        tmpGoodsRelation.Free;
        tmpGoodsPrice.Free;
      end;
    end;
  LocalFinded := false;
  RemoteFinded := false;
  RspFinded := false;
  edtInput.Text := '';
  dllGlobal.Refresh('PUB_GOODSINFO');
  ModalResult := MROK;
end;

function TfrmInitGoods.IsChinese(str: string): Boolean;
var i:integer;
begin
  result:=false;
  for i:=0 to length(str)-1 do
  begin
    if str[i] in LeadBytes then
    begin
      result := true;
      break;
    end;
  end;
end;

procedure TfrmInitGoods.PostDataSet;
begin
  if cdsGoodsInfo.State in [dsEdit,dsInsert] then
     cdsGoodsInfo.Post;
  if cdsBarCode.State in [dsEdit,dsInsert] then
     cdsBarCode.Post;
  if cdsGoodsRelation.State in [dsEdit,dsInsert] then
     cdsGoodsRelation.Post;
end;

procedure TfrmInitGoods.RefreshUnits;
begin
  dllGlobal.Refresh('PUB_MEAUNITS');
  RefreshUnitsList;
end;

procedure TfrmInitGoods.AddUnits(Sender: TObject);
var AObj:TRecord_;
begin
  AObj := TRecord_.Create;
  try
    if TfrmMeaUnits.ShowDialog(self,'',AObj) then
       begin
         RefreshUnitsList;
         TzrComboBoxList(Sender).KeyValue := AObj.FieldByName('UNIT_ID').AsString;
         TzrComboBoxList(Sender).Text := AObj.FieldByName('UNIT_NAME').AsString;
         TzrComboBoxList(Sender).OnSaveValue(nil);
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmInitGoods.RefreshUnitsList;
var
  tmpObj:TRecord_;
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  if edtGOODS_OPTION1.Checked then
     begin
       edtCALC_UNITS.Buttons := [];
       edtSMALL_UNITS.Buttons := [zbClear];
       edtBIG_UNITS.Buttons := [zbClear];
       edtCALC_UNITS.OnAddClick := nil;
       edtSMALL_UNITS.OnAddClick := nil;
       edtBIG_UNITS.OnAddClick := nil;
       rs.Filtered := false;
       rs.Filter := 'RELATION_FLAG=1';
       rs.Filtered := true;
     end
  else
     begin
       edtCALC_UNITS.Buttons := [zbNew];
       edtSMALL_UNITS.Buttons := [zbNew,zbClear];
       edtBIG_UNITS.Buttons := [zbNew,zbClear];
       edtCALC_UNITS.OnAddClick := AddUnits;
       edtSMALL_UNITS.OnAddClick := AddUnits;
       edtBIG_UNITS.OnAddClick := AddUnits;
     end;

  cdsUnits.Close;
  cdsUnits.FieldDefs := rs.FieldDefs;
  cdsUnits.CreateDataSet;

  tmpObj := TRecord_.Create;
  try
    rs.First;
    while not rs.Eof do
    begin
      cdsUnits.Append;
      tmpObj.ReadFromDataSet(rs);
      tmpObj.WriteToDataSet(cdsUnits);
      rs.Next;
    end;
  finally
    tmpObj.Free;
  end;

  edtCALC_UNITS.DataSet := cdsUnits;
  edtSMALL_UNITS.DataSet := cdsUnits;
  edtBIG_UNITS.DataSet := cdsUnits;
end;

procedure TfrmInitGoods.SetReadOnly;
begin
  edtCALC_UNITS.Properties.ReadOnly := true;
  edtSMALL_UNITS.Properties.ReadOnly := true;
  edtSMALLTO_CALC.Properties.ReadOnly := true;
  edtBIG_UNITS.Properties.ReadOnly := true;
  edtBIGTO_CALC.Properties.ReadOnly := true;
  edtDEFAULT1.Properties.ReadOnly := true;
  edtDEFAULT2.Properties.ReadOnly := true;
  edtMoreUnits.Properties.ReadOnly := true;

  SetEditStyle(dsBrowse, edtCALC_UNITS.Style);
  SetEditStyle(dsBrowse, edtSMALL_UNITS.Style);
  SetEditStyle(dsBrowse, edtSMALLTO_CALC.Style);
  SetEditStyle(dsBrowse, edtBIG_UNITS.Style);
  SetEditStyle(dsBrowse, edtBIGTO_CALC.Style);

  edtBK_CALC_UNITS.Color := edtCALC_UNITS.Style.Color;
  edtBK_SMALL_UNITS.Color := edtSMALL_UNITS.Style.Color;
  edtBK_SMALLTO_CALC.Color := edtSMALLTO_CALC.Style.Color;
  edtBK_BIG_UNITS.Color := edtBIG_UNITS.Style.Color;
  edtBK_BIGTO_CALC.Color := edtBIGTO_CALC.Style.Color;
end;

procedure TfrmInitGoods.CancelReadOnly;
begin
  edtCALC_UNITS.Properties.ReadOnly := false;
  edtSMALL_UNITS.Properties.ReadOnly := false;
  edtSMALLTO_CALC.Properties.ReadOnly := false;
  edtBIG_UNITS.Properties.ReadOnly := false;
  edtBIGTO_CALC.Properties.ReadOnly := false;
  edtDEFAULT1.Properties.ReadOnly := false;
  edtDEFAULT2.Properties.ReadOnly := false;
  edtMoreUnits.Properties.ReadOnly := false;
 
  SetEditStyle(dsInsert, edtCALC_UNITS.Style);
  SetEditStyle(dsInsert, edtSMALL_UNITS.Style);
  SetEditStyle(dsInsert, edtSMALLTO_CALC.Style);
  SetEditStyle(dsInsert, edtBIG_UNITS.Style);
  SetEditStyle(dsInsert, edtBIGTO_CALC.Style);

  edtBK_CALC_UNITS.Color := edtCALC_UNITS.Style.Color;
  edtBK_SMALL_UNITS.Color := edtSMALL_UNITS.Style.Color;
  edtBK_SMALLTO_CALC.Color := edtSMALLTO_CALC.Style.Color;
  edtBK_BIG_UNITS.Color := edtBIG_UNITS.Style.Color;
  edtBK_BIGTO_CALC.Color := edtBIGTO_CALC.Style.Color;
end;

function TfrmInitGoods.BarCodeSimpleInit(barcode: string): boolean;
begin
  result := false;
  if not btnNext.Enabled then Exit;
  try
    Simple := true;
    edtGOODS_OPTION1.Checked := true;
    edtInput.Text := barcode;
    btnNext.Click;
    if Finded then
      begin
        ActiveControl := edtNEW_INPRICE;
        result := (ShowModal=MROK);
        //btnNext.Click;
        //if edtMoreUnits.Checked then
        //  btnNext.Click;
        //result := true;
      end;
  except
    on E:Exception do
       begin
         result := false;
         MessageBox(Handle,pchar(E.Message),'友情提示..',MB_OK);
       end;
  end;
  Simple := false;
end;

procedure TfrmInitGoods.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not edtGOODS_OPTION1.Checked then edtGOODS_OPTION1.Checked := true;
  if Key = #13 then
     if btnNext.Visible then btnNext.Click;
end;

procedure TfrmInitGoods.RzLabel11Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION1.Checked := true;
  if CanFocus(edtInput) then edtInput.SetFocus; 
end;

procedure TfrmInitGoods.RzLabel12Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION2.Checked := true;
end;

procedure TfrmInitGoods.edtGOODS_OPTION1Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION2.Checked := false;
  if CanFocus(edtInput) then edtInput.SetFocus;
end;

procedure TfrmInitGoods.edtGOODS_OPTION2Click(Sender: TObject);
begin
  inherited;
  edtGOODS_OPTION1.Checked := false;
end;

procedure TfrmInitGoods.edtSORT_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  if edtSORT_ID1.Properties.ReadOnly then Exit;
  Obj := TRecord_.Create;
  try
    if edtGOODS_OPTION1.Checked and (not Finded) then
      begin
        frmSortDropFrom.RelationId := FY_RELATION_ID;
        if frmSortDropFrom.DropForm(edtSORT_ID, Obj) then
          begin
            if Obj.Count > 0 then
            begin
              edtSORT_ID1.Text := Obj.FieldbyName('SORT_ID').AsString;
              edtSORT_ID.Text := Obj.FieldbyName('SORT_NAME').AsString;
            end
            else
            begin
              edtSORT_ID1.Text := '';
              edtSORT_ID.Text := '';
            end;
          end;
      end
    else
      begin
        frmSortDropFrom.ShowCgtSort := false;
        if frmSortDropFrom.DropForm(edtSORT_ID, Obj) then
          begin
            if Obj.Count > 0 then
            begin
              edtSORT_ID1.Text := Obj.FieldbyName('SORT_ID').AsString;
              edtSORT_ID.Text := Obj.FieldbyName('SORT_NAME').AsString;
            end
            else
            begin
              edtSORT_ID1.Text := '';
              edtSORT_ID.Text := '';
            end;
          end;
      end;
  finally
    Obj.Free;
  end;
end;

procedure TfrmInitGoods.edtCALC_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if edtSMALL_UNITS.AsString <> '' then
    RzPanel_SMALL.Caption := edtCALC_UNITS.Text + '=1' + edtSMALL_UNITS.Text;
  if edtBIG_UNITS.AsString <> '' then
    RzPanel_BIG.Caption := edtCALC_UNITS.Text + '=1' + edtBIG_UNITS.Text;
end;

procedure TfrmInitGoods.edtCALC_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtSMALL_UNITS.AsString = '' then
    RzPanel_SMALL.Caption := ''
  else
    RzPanel_SMALL.Caption := edtCALC_UNITS.Text + '=1' + edtSMALL_UNITS.Text;
end;

procedure TfrmInitGoods.edtMoreUnitsPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtMoreUnits.Checked then
    btnNext.Caption := '下一步'
  else
    btnNext.Caption := '完成';
end;

procedure TfrmInitGoods.edtSMALL_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if edtSMALL_UNITS.AsString = '' then
    RzPanel_SMALL.Caption := ''
  else
    RzPanel_SMALL.Caption := edtCALC_UNITS.Text + '=1' + edtSMALL_UNITS.Text;
end;

procedure TfrmInitGoods.edtSMALL_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtSMALL_UNITS.AsString = '' then
    RzPanel_SMALL.Caption := ''
  else
    RzPanel_SMALL.Caption := edtCALC_UNITS.Text + '=1' + edtSMALL_UNITS.Text;
end;

procedure TfrmInitGoods.edtBIG_UNITSSaveValue(Sender: TObject);
begin
  inherited;
  if edtBIG_UNITS.AsString = '' then
    RzPanel_BIG.Caption := ''
  else
    RzPanel_BIG.Caption := edtCALC_UNITS.Text + '=1' + edtBIG_UNITS.Text;
end;

procedure TfrmInitGoods.edtBIG_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtBIG_UNITS.AsString = '' then
    RzPanel_BIG.Caption := ''
  else
    RzPanel_BIG.Caption := edtCALC_UNITS.Text + '=1' + edtBIG_UNITS.Text;
end;

procedure TfrmInitGoods.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmInitGoods.edtDefault1Click(Sender: TObject);
begin
  inherited;
  if (edtDefault1.Checked) and (edtDefault2.Checked) then
    edtDefault2.Checked := false;
end;

procedure TfrmInitGoods.edtDefault2Click(Sender: TObject);
begin
  inherited;
  if (edtDefault2.Checked) and (edtDefault1.Checked) then
    edtDefault1.Checked := false;
end;

class function TfrmInitGoods.ShowDialog(Owner: TForm; barcode: string; var GodsId: string): boolean;
begin
  with TfrmInitGoods.Create(Owner) do
    begin
      try
        if barcode <> '' then
          begin
            if BarCodeSimpleInit(barcode) then
              begin
                result := true;
                GodsId := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
                Exit;
              end
            else
              begin
                result := (ShowModal=MROK);
                if result then GodsId := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
              end;
          end
        else
          begin
            result := (ShowModal = MROK);
            if result then GodsId := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmInitGoods.edtSORT_IDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DOWN then edtSORT_IDPropertiesButtonClick(nil, 0);
end;

procedure TfrmInitGoods.edtBARCODE1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtBARCODE1.Text) = '') then
     begin
       if CanFocus(edtBARCODE1) then edtBARCODE1.SetFocus;
       Key := #0;
     end;
end;

procedure TfrmInitGoods.edtGODS_CODEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtGODS_CODE.Text) = '') then
     begin
       if CanFocus(edtGODS_CODE) then edtGODS_CODE.SetFocus;
       Key := #0;
     end;
end;

procedure TfrmInitGoods.edtGODS_NAMEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtGODS_NAME.Text) = '') then
     begin
       if CanFocus(edtGODS_NAME) then edtGODS_NAME.SetFocus;
       Key := #0;
     end;
end;

procedure TfrmInitGoods.edtSORT_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtSORT_ID1.Text) = '') then
     begin
       if CanFocus(edtSORT_ID) then edtSORT_ID.SetFocus;
       Key := #0;
       edtSORT_IDPropertiesButtonClick(nil,0);
     end;
end;

procedure TfrmInitGoods.edtCALC_UNITSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtCALC_UNITS.Text) = '') then
     begin
       if CanFocus(edtCALC_UNITS) then edtCALC_UNITS.SetFocus;
       Key := #0;
     end
  else if Key <> #13 then Key := #0;
end;

procedure TfrmInitGoods.edtNEW_INPRICEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtNEW_INPRICE.Text) = '') then
     begin
       if CanFocus(edtNEW_INPRICE) then edtNEW_INPRICE.SetFocus;
       Key := #0;
     end
  else if not (Key in ['0'..'9','.',#8]) then Key := #0;
end;

procedure TfrmInitGoods.edtNEW_OUTPRICEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtNEW_OUTPRICE.Text) = '') then
     begin
       if CanFocus(edtNEW_OUTPRICE) then edtNEW_OUTPRICE.SetFocus;
       Key := #0;
     end
  else if not (Key in ['0'..'9','.',#8]) then Key := #0;
end;

procedure TfrmInitGoods.edtSHOP_NEW_OUTPRICEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (trim(edtSHOP_NEW_OUTPRICE.Text) = '') then
     begin
       if CanFocus(edtSHOP_NEW_OUTPRICE) then edtSHOP_NEW_OUTPRICE.SetFocus;
       Key := #0;
     end
  else if not (Key in ['0'..'9','.',#8]) then Key := #0;
end;

procedure TfrmInitGoods.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not btnNext.Focused then inherited;
end;

procedure TfrmInitGoods.SetLocalFinded(const Value: boolean);
begin
  FLocalFinded := Value;
end;

procedure TfrmInitGoods.SetRemoteFinded(const Value: boolean);
begin
  FRemoteFinded := Value;
end;

procedure TfrmInitGoods.SetRspFinded(const Value: boolean);
begin
  FRspFinded := Value;
end;

procedure TfrmInitGoods.HideGodsCode;
begin
  edtBK_GODS_CODE.Visible := false;
  edtBK_GODS_NAME.Top := 105;
  edtBK_SORT_ID.Top := 142;
  edtBK_CALC_UNITS.Top := 179;
  edtMoreUnits.Top := 183;
  edtBK_NEW_INPRICE.Top := 216;
  edtBK_NEW_OUTPRICE.Top := 253;
  edtBK_SHOP_NEW_OUTPRICE.Top := 290;
  red2.Top := 114;
  red3.Top := 151;
  red4.Top := 188;
  red5.Top := 262;
end;

procedure TfrmInitGoods.ShowGodsCode;
begin
  edtBK_GODS_CODE.Visible := true;
  edtBK_GODS_NAME.Top := 132;
  edtBK_SORT_ID.Top := 164;
  edtBK_CALC_UNITS.Top := 196;
  edtMoreUnits.Top := 200;
  edtBK_NEW_INPRICE.Top := 228;
  edtBK_NEW_OUTPRICE.Top := 260;
  edtBK_SHOP_NEW_OUTPRICE.Top := 292;
  red2.Top := 141;
  red3.Top := 173;
  red4.Top := 205;
  red5.Top := 269;
end;

procedure TfrmInitGoods.edtBIG_UNITSClearValue(Sender: TObject);
begin
  inherited;
  edtBIG_UNITS.KeyValue := null;
  edtBIG_UNITS.Text := '';
  if not edtBARCODE3.Properties.ReadOnly then edtBARCODE3.Text := '';
  edtBIGTO_CALC.Text := '';
end;

procedure TfrmInitGoods.edtSMALL_UNITSClearValue(Sender: TObject);
begin
  inherited;
  edtSMALL_UNITS.KeyValue := null;
  edtSMALL_UNITS.Text := '';
  if not edtBARCODE2.Properties.ReadOnly then edtBARCODE2.Text := '';
  edtSMALLTO_CALC.Text := '';
end;

procedure TfrmInitGoods.edtSMALLTO_CALCKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9','.',#8]) then Key := #0;
end;

procedure TfrmInitGoods.edtBIGTO_CALCKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9','.',#8]) then Key := #0;
end;

procedure TfrmInitGoods.edtSMALL_UNITSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key <> #13 then Key := #0;
end;

procedure TfrmInitGoods.edtBIG_UNITSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key <> #13 then Key := #0;
end;

function TfrmInitGoods.BarcodeFactory(rs: TZQuery;code:string): boolean;
var
  db:TdbFactory;
begin
  db := TdbFactory.Create;
  try
    db.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(ExtractFilePath(Application.ExeName))+'data\barcode.db');
    db.connect;
    rs.SQL.Text := 'select * from xx_barcode where barcode=:barcode';
    rs.ParamByName('barcode').AsString := code;
    db.Open(rs);
    result := not rs.IsEmpty;
  finally
    db.free;
  end;
end;

function TfrmInitGoods.CheckUnit(unitName: string): string;
var
  cdsUnits:TZQuery;
  id:string;
  i,w:integer;
begin
  cdsUnits := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  if cdsUnits.Locate('UNIT_NAME',unitName,[]) then
     begin
       result := cdsUnits.FieldByName('UNIT_ID').AsString;
       Exit;
     end;
  id := EncStr(unitName,ENC_KEY);
  w := 36-length(id);
  for i:=1 to w do id := '0'+id;
  result := id;
  cdsUnits := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    cdsUnits.Close;
    cdsUnits.SQL.Text := 'select * from PUB_MEAUNITS where TENANT_ID=:TENANT_ID and UNIT_ID=:UNIT_ID';
    cdsUnits.ParamByName('TENANT_ID').AsInteger := strtoint(FY_TENANT_ID);
    cdsUnits.ParamByName('UNIT_ID').AsString := id;
    dataFactory.Open(cdsUnits);
    cdsUnits.Append;
    cdsUnits.FieldByName('TENANT_ID').AsInteger := strtoint(FY_TENANT_ID);
    cdsUnits.FieldByName('UNIT_ID').AsString := id;
    cdsUnits.FieldByName('UNIT_NAME').AsString := unitName;
    cdsUnits.FieldByName('UNIT_SPELL').AsString := fnString.GetWordSpell(unitName,3);
    cdsUnits.FieldByName('SEQ_NO').AsInteger := 1;
    cdsUnits.Post;
    dataFactory.UpdateBatch(cdsUnits,'TMeaUnitsV60');
  finally
    cdsUnits.Free;
    dataFactory.MoveToDefault;
  end;
  RefreshUnits;
end;

procedure TfrmInitGoods.edtInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     begin
       edtGOODS_OPTION2.Checked := true;
       edtGOODS_OPTION2.SetFocus;
     end;

end;

procedure TfrmInitGoods.edtGOODS_OPTION1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     begin
       edtGOODS_OPTION2.Checked := true;
       edtGOODS_OPTION2.SetFocus;
     end;

end;

procedure TfrmInitGoods.edtGOODS_OPTION1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     if btnNext.Visible then btnNext.Click;

end;

procedure TfrmInitGoods.edtGOODS_OPTION2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=VK_UP then
     begin
       edtGOODS_OPTION1.Checked := true;
       edtInput.SetFocus;
     end;

end;

end.
