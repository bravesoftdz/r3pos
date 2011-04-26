unit ufrmCustomerExt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls, uShopUtil,
  RzPanel, RzRadGrp, RzEdit, StdCtrls, Mask, RzCmboBx, RzLabel, cxControls, strutils,
  cxContainer, cxEdit, cxTextEdit, cxSpinEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxRadioGroup;

type
  TfrmCustomerExt = class(TFrame)
    bg: TRzPanel;
  private
    { Private declarations }
    Top_Value:Integer;
    FList:TList;
    FUnionID: string;
    FDataSet: TDataSet;
    FDataState: TDataSetState;
    procedure CreateLabel(UNION_ID,LblName:string);
    procedure CreateRaido(UNION_ID,OPTION,In_Value:String);
    procedure CreateCmb(UNION_ID,OPTION,In_Value:String);
    procedure CreateNum(UNION_ID,OPTION,In_Value:String);
    procedure CreateDateTime(UNION_ID,OPTION,In_Value:String);
    procedure ControlFree;
    procedure SetUnionID(const Value: string);
    procedure SetDataSet(const Value: TDataSet);
    procedure SetDataState(const Value: TDataSetState);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitControl;
    procedure ReadFrom;
    procedure WriteTo;
    property UnionID:string read FUnionID write SetUnionID;
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property DataState:TDataSetState read FDataState write SetDataState;
  end;

implementation
uses ZBase, ufrmBasic, uFnUtil, uShopGlobal, uGlobal;
{$R *.dfm}

{ TfrmCustomerExt }

procedure TfrmCustomerExt.ControlFree;
var i:integer;
begin
  Freeframe(self);
  for i:=0 to FList.Count -1 do
    TObject(FList[i]).Free;
  FList.Clear;
end;

constructor TfrmCustomerExt.Create(AOwner: TComponent);
begin
  FList := TList.Create;
  Top_Value := 0;
  inherited;
end;

procedure TfrmCustomerExt.CreateCmb(UNION_ID,OPTION,In_Value:String);
var Cmb:TcxComboBox;
    Aobj:TRecord_;
    rs:TZQuery;
    VList:TStringList;
begin
  Cmb := TcxComboBox.Create(nil);
  Cmb.Parent := bg;
  Cmb.Name := 'cmd_'+AnsiReplaceText(UNION_ID,'-','_');
  Cmb.Properties.DropDownListStyle := lsFixedList;
  Cmb.Text := '';
  Cmb.Left := 96;
  Cmb.Top := 8+Top_Value;
  Cmb.Height := 21;
  Cmb.Width := 121;
  Aobj := TRecord_.Create;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := OPTION;
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        Aobj := TRecord_.Create;
        Aobj.ReadFromDataSet(rs);
        Cmb.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
  if In_Value <> '' then
    Cmb.Text := In_Value;
  if DataState in [dsBrowse,dsInactive] then
    begin
      Cmb.Properties.ReadOnly := True;
      Cmb.Style.Color := clBtnFace;
    end;
  FList.Add(Cmb);
  Top_Value := Top_Value+29;
end;

procedure TfrmCustomerExt.CreateDateTime(UNION_ID,OPTION,In_Value: String);
var Date_Time:TcxDateEdit;
begin
  Date_Time := TcxDateEdit.Create(Self);
  Date_Time.Parent := bg;
  Date_Time.Left := 96;
  Date_Time.Top := 8+Top_Value;
  Date_Time.Height := 21;
  Date_Time.Width := 121;
  Date_Time.Name := 'dte_'+AnsiReplaceText(UNION_ID,'-','_');
  if DataState in [dsBrowse,dsInactive] then
    begin
      Date_Time.Properties.ReadOnly := True;
      Date_Time.Style.Color := clBtnFace;
    end;
  if In_Value <> '' then
    Date_Time.Text := In_Value; 
  FList.Add(Date_Time);
  Top_Value := Top_Value+29;
end;

procedure TfrmCustomerExt.CreateLabel(UNION_ID,LblName:string);
var Lab:TRzLabel;
begin
  Lab := TRzLabel.Create(Self);
  Lab.Parent := bg;
  Lab.Name := 'lbl_'+AnsiReplaceText(UNION_ID,'-','_');
  Lab.Alignment := taRightJustify;
  Lab.Left := 7;
  Lab.Top := 12+Top_Value;
  Lab.Height := 12;
  Lab.Width := 80;

  Lab.Caption := LblName;
  FList.Add(Lab);
end;

procedure TfrmCustomerExt.CreateNum(UNION_ID,OPTION,In_Value:String);
var Num_Text:TcxSpinEdit;
begin
  Num_Text := TcxSpinEdit.Create(Self);
  Num_Text.Parent := bg;
  Num_Text.Name := 'num_'+ AnsiReplaceText(UNION_ID,'-','_');
  Num_Text.Left := 96;
  Num_Text.Top := 8+Top_Value;
  Num_Text.Height := 21;
  Num_Text.Width := 121;
  if DataState in [dsBrowse,dsInactive] then
    begin
      Num_Text.Properties.ReadOnly := True;
      Num_Text.Style.Color := clBtnFace;
    end;
  if In_Value <> '' then
    Num_Text.Text := In_Value;
  FList.Add(Num_Text);
  Top_Value := Top_Value + 29;
end;

procedure TfrmCustomerExt.CreateRaido(UNION_ID,OPTION,In_Value:String);
var Radio:TcxComboBox;
    vList:TStringList;
    i,Height_Value:Integer;
    Str_Value:String;
    rs:TRecord_;
begin
  Radio := TcxComboBox.Create(Self);
  Radio.Parent := bg;
  Radio.Name := 'rdo_'+AnsiReplaceText(UNION_ID,'-','_');
  Radio.Properties.DropDownListStyle := lsFixedList;
  Radio.Text := '';
  Radio.Left := 96;
  Radio.Height := 21;
  Radio.Width := 121;
  Radio.Top := 8+Top_Value;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.DelimitedText := OPTION;
    for i := 0 to vList.Count - 1 do
      begin
        rs := TRecord_.Create;
        rs.AddField('CODE_ID',vList.Names[i],ftString);
        rs.AddField('CODE_NAME',vList.ValueFromIndex[i],ftString);
        Radio.Properties.Items.AddObject(rs.FieldbyName('CODE_NAME').AsString,rs);
      end;
  finally
    vList.Free;
  end;
  if In_Value <> '' then
    Radio.Text := In_Value;
  if DataState in [dsBrowse,dsInactive] then
    begin
      Radio.Properties.ReadOnly := True;
      Radio.Style.Color := clBtnFace;
    end;
  FList.Add(Radio);
  Top_Value := Top_Value+29;
end;

procedure TfrmCustomerExt.ReadFrom;
begin
  InitControl;
end;

destructor TfrmCustomerExt.Destroy;
begin
  ControlFree;
  FList.Free;
  inherited;
end;

procedure TfrmCustomerExt.WriteTo;
begin

end;

procedure TfrmCustomerExt.InitControl;
var cdsUnionIndex:TZQuery;
    Index_Id:String;
begin
  ControlFree;
  cdsUnionIndex := TZQuery.Create(nil);
  try
  cdsUnionIndex.SQL.Text :=
  'select INDEX_ID,INDEX_NAME,INDEX_SPELL,INDEX_TYPE,INDEX_OPTION,INDEX_ISNULL from PUB_UNION_INDEX where UNION_ID=:UNION_ID and TENANT_ID=:TENANT_ID';
  cdsUnionIndex.Params.ParamByName('UNION_ID').AsString := UnionID;
  cdsUnionIndex.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(cdsUnionIndex);
  cdsUnionIndex.First;
  while not cdsUnionIndex.Eof do
    begin
      if DataSet.Locate('INDEX_ID',cdsUnionIndex.FieldbyName('INDEX_ID').AsString,[]) then
        Index_Id := DataSet.FieldByName('INDEX_VALUE').AsString
      else
        Index_Id := DataSet.FieldByName('INDEX_VALUE').AsString;
      CreateLabel(cdsUnionIndex.FieldbyName('INDEX_ID').asString,cdsUnionIndex.FieldbyName('INDEX_NAME').asString);
      if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '1' then
        begin
          CreateRaido(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Index_Id);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '2' then
        begin
          CreateCmb(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Index_Id);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '3' then
        begin
          CreateNum(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Index_Id);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '4' then
        begin
          CreateDateTime(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Index_Id);
        end;
      cdsUnionIndex.Next;
    end;
  finally
    cdsUnionIndex.Free;
  end;
end;

procedure TfrmCustomerExt.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TfrmCustomerExt.SetUnionID(const Value: string);
begin
  FUnionID := Value;
end;

procedure TfrmCustomerExt.SetDataState(const Value: TDataSetState);
begin
  FDataState := Value;
end;

end.
