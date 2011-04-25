unit ufrmCustomerExt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls, uShopUtil, 
  RzPanel, RzRadGrp, RzEdit, StdCtrls, Mask, RzCmboBx, RzLabel, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxSpinEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmCustomerExt = class(TFrame)
    bg: TRzPanel;
    RzLabel6: TRzLabel;
  private
    { Private declarations }
    FList:TList;
    FUnionID: string;
    FDataSet: TDataSet;
    procedure CreateLabel(UNION_ID,LblName:string;seqno:Integer);
    procedure CreateRaido(UNION_ID,OPTION:String;seqno:Integer);
    procedure CreateCmb(UNION_ID,OPTION:String;seqno:Integer);
    procedure CreateNum(UNION_ID,OPTION:String;seqno:Integer);
    procedure CreateDateTime(UNION_ID,OPTION:String;seqno:Integer);
    procedure ControlFree;
    procedure SetUnionID(const Value: string);
    procedure SetDataSet(const Value: TDataSet);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitControl;
    procedure ReadFrom;
    procedure WriteTo;
    property UnionID:string read FUnionID write SetUnionID;
    property DataSet:TDataSet read FDataSet write SetDataSet;
  end;

implementation
uses ZBase, ufrmBasic, uFnUtil, uShopGlobal, uGlobal;
{$R *.dfm}

{ TfrmCustomerExt }

procedure TfrmCustomerExt.ControlFree;
var
  i:integer;
begin
  Freeframe(self);
  for i:=0 to FList.Count -1 do
    TObject(FList[i]).Free;
  FList.Clear;
end;

constructor TfrmCustomerExt.Create(AOwner: TComponent);
begin
  FList := TList.Create;
  inherited;

end;

procedure TfrmCustomerExt.CreateCmb(UNION_ID,OPTION: String;seqno:Integer);
var Cmb:TcxComboBox;
    Aobj:TRecord_;
    rs:TZQuery;
    VList:TStringList;
begin
//  CreateLable(UNION_ID,i);
  Cmb := TcxComboBox.Create(nil);
  Cmb.Parent := bg;
  if (seqno mod 2) = 1 then
    Cmb.Left := 109
  else
    Cmb.Left := 348;
  Cmb.Top := 8+(seqno*21);
  Cmb.Height := 21;
  Cmb.Width := 121;
  Aobj := TRecord_.Create;
  VList := TStringList.Create;
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
  Cmb.Name := 'cmd'+UNION_ID;
  FList.Add(Cmb);
end;

procedure TfrmCustomerExt.CreateDateTime(UNION_ID,OPTION: String;seqno:Integer);
var Date_Time:TcxDateEdit;
begin
  Date_Time := TcxDateEdit.Create(Self);
  Date_Time.Parent := bg;
//  CreateLable(UNION_ID,i);
  if (seqno mod 2) = 1 then
    Date_Time.Left := 109
  else
    Date_Time.Left := 348;
  Date_Time.Top := 8+(seqno*21);
  Date_Time.Height := 21;
  Date_Time.Width := 121;
  Date_Time.Name := 'dte'+UNION_ID;
  FList.Add(Date_Time);
end;

procedure TfrmCustomerExt.CreateLabel(UNION_ID,LblName:string;seqno: Integer);
var Lab:TRzLabel;
begin
  Lab := TRzLabel.Create(Self);
  Lab.Parent := bg;
  Lab.Parent := Self;
  if (seqno mod 2) = 1 then
    Lab.Left := 3
  else
    Lab.Left := 241;

  Lab.Top := 12+(seqno*12);
  Lab.Height := 12;
  Lab.Width := 100;
  Lab.Name := 'lbl_'+UNION_ID;
  Lab.Alignment := taRightJustify;
  Lab.Caption := LblName;
  FList.Add(Lab);
end;

procedure TfrmCustomerExt.CreateNum(UNION_ID,OPTION: String;seqno:Integer);
var Num_Text:TcxSpinEdit;
begin
  Num_Text := TcxSpinEdit.Create(Self);
  Num_Text.Parent := bg;
  if (seqno mod 2) = 1 then
    Num_Text.Left := 109
  else
    Num_Text.Left := 348;
  Num_Text.Top := 8+(seqno*21);
  Num_Text.Height := 21;
  Num_Text.Width := 121;
  Num_Text.Name := 'num'+ UNION_ID;
  FList.Add(Num_Text);
end;

procedure TfrmCustomerExt.CreateRaido(UNION_ID,OPTION: String;seqno:Integer);
var Radio:TcxComboBox;
    vList:TStringList;
    i:Integer;
    Str_Value:String;
    rs:TRecord_;
begin
  Radio := TcxComboBox.Create(Self);
  Radio.Parent := bg;
  Radio.Name := 'rdo'+UNION_ID;
  if (seqno mod 2) = 1 then
    Radio.Left := 109
  else
    Radio.Left := 348;
  Radio.Top := 8+(seqno*21);
  Radio.Height := 21;
  Radio.Width := 121;
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
  FList.Add(Radio);
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
var
  cdsUnionIndex:TZQuery;
begin
  ControlFree;
  cdsUnionIndex := TZQuery.Create(nil);
  try
  cdsUnionIndex.SQL.Text :=
  ' select INDEX_ID,INDEX_NAME,INDEX_SPELL,INDEX_TYPE,INDEX_OPTION,INDEX_ISNULL from PUB_UNION_INDEX where UNION_ID=:UNION_ID ';
  cdsUnionIndex.FieldByName('UNION_ID').AsString := UnionId;
  Factor.Open(cdsUnionIndex);
  cdsUnionIndex.First;
  while not cdsUnionIndex.Eof do
    begin
      CreateLabel(cdsUnionIndex.FieldbyName('INDEX_ID').asString,cdsUnionIndex.FieldbyName('INDEX_NAME').asString,cdsUnionIndex.RecNo);
      if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '1' then
        begin
          CreateRaido(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,cdsUnionIndex.RecNo);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '2' then
        begin
          CreateCmb(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,cdsUnionIndex.RecNo);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '3' then
        begin
          CreateNum(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,cdsUnionIndex.RecNo);
        end
      else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '4' then
        begin
          CreateDateTime(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,cdsUnionIndex.RecNo);
        end;
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

end.
