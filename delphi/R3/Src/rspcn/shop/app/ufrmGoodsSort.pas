unit ufrmGoodsSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  StdCtrls, RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset ,ZBase,
  RzLabel, RzBckgnd;

type
  TfrmGoodsSort = class(TfrmWebDialog)
    Label1: TLabel;
    cdsSort: TZQuery;
    edtBK_SUP_SORT_ID: TRzPanel;
    RzPanel46: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel15: TRzLabel;
    edtSUP_SORT_ID: TcxButtonEdit;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzBackground1: TRzBackground;
    edtSORT_NAME: TcxTextEdit;
    btnSave: TRzBmpButton;
    RzLabel26: TRzLabel;
    procedure edtSUP_SORT_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtSUP_SORT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtSUP_SORT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    SUP_SORT_ID:string;
    SUP_LEVEL_ID:string;
  public
    procedure Open(id:string);
    procedure Save;
    class function ShowDialog(AOwner:TForm;sid:string;AObj:TRecord_;SupObj:TRecord_=nil):boolean;
  end;

implementation

uses ufrmSortDropFrom,udataFactory,uTokenFactory,udllDsUtil,uFnUtil,udllGlobal,udllShopUtil;

{$R *.dfm}

procedure TfrmGoodsSort.Open(id: string);
var
  rs:TZQuery;
  Params:TftParamList;
  levelId:string;
begin
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SORT_TYPE').AsInteger := 1;
    Params.ParamByName('SORT_ID').AsString := id;
    dataFactory.Open(cdsSort,'TGoodsSortV60',Params);
  finally
    Params.Free;
  end;

  if not cdsSort.IsEmpty then
     begin
       dbState := dsEdit;
       SetEditStyle(dsBrowse,edtSUP_SORT_ID.Style);
       edtBK_SUP_SORT_ID.Color := edtSUP_SORT_ID.Style.Color;
       rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
       edtSORT_NAME.Text := cdsSort.FieldByName('SORT_NAME').AsString;
       levelId := cdsSort.FieldByName('LEVEL_ID').AsString;
       if Length(levelId) <= 4 then
          edtSUP_SORT_ID.Text := '自主经营'
       else
          if rs.Locate('RELATION_ID;LEVEL_ID',VarArrayOf([0,Copy(levelId,1,Length(levelId)-4)]),[]) then
             edtSUP_SORT_ID.Text := rs.FieldByName('SORT_NAME').AsString;
     end
  else
     begin
       dbState := dsInsert;
     end;
end;

procedure TfrmGoodsSort.Save;
  function GetSeqNo(tenantId:string;sortType:string;supLevelId:string):integer;
  var rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select MAX(SEQ_NO) from PUB_GOODSSORT where TENANT_ID='+tenantId+' and SORT_TYPE='+sortType+' and LEVEL_ID like '''+supLevelId+'____''';
      dataFactory.Open(rs);
      if rs.Fields[0].AsString = '' then
         result := 1
      else
         result := rs.Fields[0].AsInteger + 1;
    finally
      rs.Free;
    end;
  end;
var
  Params:TftParamList;
  tmpSort:TZQuery;
  tmpObj:TRecord_;
begin
  if (dbState = dsInsert) and (trim(edtSUP_SORT_ID.Text) = '') then
     begin
       if edtSUP_SORT_ID.CanFocus then edtSUP_SORT_ID.SetFocus;
       Raise Exception.Create('请选择上级分类...');
     end;
  if trim(edtSORT_NAME.Text) = '' then
     begin
       if edtSORT_NAME.CanFocus then edtSORT_NAME.SetFocus;
       Raise Exception.Create('请输入分类名称...');
     end;

  if cdsSort.IsEmpty then
     begin
       cdsSort.Append;
       cdsSort.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
       cdsSort.FieldByName('SORT_TYPE').AsInteger := 1;
       cdsSort.FieldByName('SORT_ID').AsString := TSequence.NewId;
       cdsSort.FieldByName('SEQ_NO').AsInteger := GetSeqNo(cdsSort.FieldByName('TENANT_ID').AsString,cdsSort.FieldByName('SORT_TYPE').AsString,SUP_LEVEL_ID);
       cdsSort.FieldByName('LEVEL_ID').AsString := SUP_LEVEL_ID + FormatFloat('0000',cdsSort.FieldByName('SEQ_NO').AsInteger);
     end
  else cdsSort.Edit;
  cdsSort.FieldByName('SORT_NAME').AsString := trim(edtSORT_NAME.Text);
  cdsSort.FieldByName('SORT_SPELL').AsString := fnString.GetWordSpell(cdsSort.FieldByName('SORT_NAME').AsString,3);
  cdsSort.Post;

  dataFactory.UpdateBatch(cdsSort,'TGoodsSortV60');

  // 本地保存
  if dataFactory.iDbType <> 5 then
  begin
     dataFactory.MoveToSqlite;
     tmpSort := TZQuery.Create(nil);
     Params := TftParamList.Create(nil);
     tmpObj := TRecord_.Create;
     try
       Params.ParamByName('TENANT_ID').AsInteger := cdsSort.FieldByName('TENANT_ID').AsInteger;
       Params.ParamByName('SORT_TYPE').AsInteger := cdsSort.FieldByName('SORT_TYPE').AsInteger;
       Params.ParamByName('SORT_ID').AsString := cdsSort.FieldByName('SORT_ID').AsString;
       dataFactory.Open(tmpSort,'TGoodsSortV60',Params);

       if tmpSort.IsEmpty then tmpSort.Append else tmpSort.Edit;

       tmpObj.ReadFromDataSet(cdsSort);
       tmpObj.WriteToDataSet(tmpSort);

       dataFactory.UpdateBatch(tmpSort,'TGoodsSortV60');
     finally
       dataFactory.MoveToDefault;
       tmpSort.Free;
       Params.Free;
       tmpObj.Free;
     end;
  end;

  dllGlobal.GetZQueryFromName('PUB_GOODSSORT').Close;
  ModalResult := MROK;
end;

class function TfrmGoodsSort.ShowDialog(AOwner: TForm;sid:string;AObj:TRecord_;SupObj:TRecord_=nil): boolean;
begin
  with TfrmGoodsSort.Create(AOwner) do
    begin
      try
        Open(sid);
        if SupObj <> nil then
           begin
             SUP_SORT_ID := SupObj.FieldByName('SORT_ID').AsString;
             SUP_LEVEL_ID := SupObj.FieldByName('LEVEL_ID').AsString;
             edtSUP_SORT_ID.Text := SupObj.FieldByName('SORT_NAME').AsString;
           end;
        result := (ShowModal = MROK);
        if result then AObj.ReadFromDataSet(cdsSort);
      finally
        Free;
      end;
    end;
end;

procedure TfrmGoodsSort.edtSUP_SORT_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  if dbState <> dsInsert then Exit;
  Obj := TRecord_.Create;
  try
    frmSortDropFrom.RelationId := '0';
    frmSortDropFrom.SelectAll := true;
    frmSortDropFrom.SelfRoot := true;
    if frmSortDropFrom.DropForm(edtSUP_SORT_ID, Obj) then
       begin
         if Obj.Count > 0 then
            begin
              if Length(Obj.FieldByName('LEVEL_ID').AsString) > 16 then
                 begin
                   SUP_SORT_ID := '';
                   SUP_LEVEL_ID := '';
                   edtSUP_SORT_ID.Text := '';
                   Raise Exception.Create('分类不能超过5级...');
                 end;
              SUP_SORT_ID := Obj.FieldbyName('SORT_ID').AsString;
              SUP_LEVEL_ID := Obj.FieldByName('LEVEL_ID').AsString;
              edtSUP_SORT_ID.Text := Obj.FieldbyName('SORT_NAME').AsString;
            end
         else
            begin
              SUP_SORT_ID := '';
              SUP_LEVEL_ID := '';
              edtSUP_SORT_ID.Text := '';
            end;
       end;
  finally
    Obj.Free;
  end;
end;

procedure TfrmGoodsSort.edtSUP_SORT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key<>#13) and (Key<>#27) and (Key<>#8) then
     begin
       Key := #0;
       edtSUP_SORT_IDPropertiesButtonClick(nil,0);
     end;
end;

procedure TfrmGoodsSort.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGoodsSort.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmGoodsSort.edtSUP_SORT_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DOWN then edtSUP_SORT_IDPropertiesButtonClick(nil, 0);
end;

procedure TfrmGoodsSort.FormShow(Sender: TObject);
begin
  inherited;
  if dbState = dsInsert then
    begin
      if trim(edtSUP_SORT_ID.Text) = '' then
         begin
           if edtSUP_SORT_ID.CanFocus then edtSUP_SORT_ID.SetFocus;
         end
      else
         if edtSORT_NAME.CanFocus then edtSORT_NAME.SetFocus;
    end;
  if dbState = dsEdit then
    if edtSORT_NAME.CanFocus then edtSORT_NAME.SetFocus;
end;

end.
