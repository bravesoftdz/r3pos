unit ufrmMeaUnits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  StdCtrls, RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset ,ZBase,
  RzLabel, RzBckgnd;

type
  TfrmMeaUnits = class(TfrmWebDialog)
    Label1: TLabel;
    cdsUnits: TZQuery;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzBackground1: TRzBackground;
    edtUNIT_NAME: TcxTextEdit;
    btnSave: TRzBmpButton;
    RzLabel26: TRzLabel;
    btnCancel: TRzBmpButton;
    RzLabel9: TRzLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    procedure Open(id:string);
    procedure Save;
    class function ShowDialog(AOwner:TForm;uid:string;AObj:TRecord_):boolean;
  end;

implementation

uses ufrmSortDropFrom,udataFactory,uTokenFactory,udllDsUtil,uFnUtil,udllGlobal,udllShopUtil;

{$R *.dfm}

procedure TfrmMeaUnits.Open(id: string);
var Params:TftParamList;
begin
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('UNIT_ID').AsString := id;
    dataFactory.Open(cdsUnits,'TMeaUnitsV60',Params);
  finally
    Params.Free;
  end;

  if not cdsUnits.IsEmpty then
     dbState := dsEdit
  else
     dbState := dsInsert;
end;

procedure TfrmMeaUnits.Save;
  function GetSeqNo(tenantId:string):integer;
  var rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select MAX(SEQ_NO) from PUB_MEAUNITS where TENANT_ID='+tenantId;
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
  rs:TZQuery;
  Params:TftParamList;
  tmpUnits:TZQuery;
  tmpObj:TRecord_;
begin
  if trim(edtUNIT_NAME.Text) = '' then
     begin
       Raise Exception.Create('请输入单位名称...');
     end;

  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  if dbState = dsInsert then
     begin
       if rs.Locate('UNIT_NAME',trim(edtUNIT_NAME.Text),[]) then
          Raise Exception.Create('商品单位名称不能重复...');
     end
  else if dbState = dsEdit then
     begin
       rs.Filtered := false;
       rs.Filter := 'UNIT_NAME='''+trim(edtUNIT_NAME.Text)+''' and UNIT_ID <> '''+cdsUnits.FieldByName('UNIT_ID').AsString+'''';
       rs.Filtered := true;
       if rs.RecordCount > 0 then
          Raise Exception.Create('商品单位名称不能重复...');
     end;

  if cdsUnits.IsEmpty then
     begin
       cdsUnits.Append;
       cdsUnits.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
       cdsUnits.FieldByName('UNIT_ID').AsString := TSequence.NewId;
       cdsUnits.FieldByName('SEQ_NO').AsInteger := GetSeqNo(cdsUnits.FieldByName('TENANT_ID').AsString);
     end
  else cdsUnits.Edit;
  cdsUnits.FieldByName('UNIT_NAME').AsString := trim(edtUNIT_NAME.Text);
  cdsUnits.FieldByName('UNIT_SPELL').AsString := fnString.GetWordSpell(cdsUnits.FieldByName('UNIT_NAME').AsString,3);
  cdsUnits.Post;

  dataFactory.UpdateBatch(cdsUnits,'TMeaUnitsV60');

  // 本地保存
  if dataFactory.iDbType <> 5 then
  begin
     dataFactory.MoveToSqlite;
     tmpUnits := TZQuery.Create(nil);
     Params := TftParamList.Create(nil);
     tmpObj := TRecord_.Create;
     try
       Params.ParamByName('TENANT_ID').AsInteger := cdsUnits.FieldByName('TENANT_ID').AsInteger;
       Params.ParamByName('UNIT_ID').AsString := cdsUnits.FieldByName('UNIT_ID').AsString;
       dataFactory.Open(tmpUnits,'TMeaUnitsV60',Params);

       if tmpUnits.IsEmpty then tmpUnits.Append else tmpUnits.Edit;

       tmpObj.ReadFromDataSet(cdsUnits);
       tmpObj.WriteToDataSet(tmpUnits);

       dataFactory.UpdateBatch(tmpUnits,'TMeaUnitsV60');
     finally
       dataFactory.MoveToDefault;
       tmpUnits.Free;
       Params.Free;
       tmpObj.Free;
     end;
  end;

  dllGlobal.GetZQueryFromName('PUB_MEAUNITS').Close;
  ModalResult := MROK;
end;

class function TfrmMeaUnits.ShowDialog(AOwner:TForm;uid:string;AObj:TRecord_): boolean;
begin
  with TfrmMeaUnits.Create(AOwner) do
    begin
      try
        Open(uid);
        edtUNIT_NAME.Text := cdsUnits.FieldByName('UNIT_NAME').AsString;
        result := (ShowModal = MROK);
        if result then AObj.ReadFromDataSet(cdsUnits);
      finally
        Free;
      end;
    end;
end;

procedure TfrmMeaUnits.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMeaUnits.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmMeaUnits.FormShow(Sender: TObject);
begin
  inherited;
  if edtUNIT_NAME.CanFocus then edtUNIT_NAME.SetFocus;
end;

end.
