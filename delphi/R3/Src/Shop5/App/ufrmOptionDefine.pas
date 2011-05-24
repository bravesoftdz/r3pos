unit ufrmOptionDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, Grids, DBGridEh, RzButton, ExtCtrls,
  ComCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, zBase,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, StdCtrls;

type
  TfrmOptionDefine = class(TfrmBasic)
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    GroupBox9: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSAFE_DAY: TcxSpinEdit;
    edtDAY_SALE_STAND: TcxSpinEdit;
    edtREAS_DAY: TcxSpinEdit;
    edtSMT_RATE: TcxComboBox;
    CdsTable: TZQuery;
    CdsIndex: TZQuery;
    DsIndex: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSMT_RATEPropertiesChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadFrom;
    procedure GridFromCds;
    procedure WriteTo;
    procedure SetValue(FieldName:String;Value:String);
    function FormatStr(i:Integer):String;
  public
    { Public declarations }
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    function Judge:Boolean;
  end;

implementation
uses uGlobal, uFnUtil, uDsUtil;
{$R *.dfm}

{ TfrmBasic1 }

procedure TfrmOptionDefine.ReadFrom;
var Define, Value, LValue:String;
    vList:TStringList;
begin
  if CdsTable.IsEmpty then Exit;
  
  CdsIndex.Close;
  CdsIndex.CreateDataSet;
  vList := TStringList.Create;
  try
    CdsTable.First;
    while not CdsTable.Eof do
      begin
        Define := CdsTable.FieldByName('DEFINE').AsString;
        Value := CdsTable.FieldByName('VALUE').AsString;

        if Define = 'SAFE_DAY' then
          begin
            edtSAFE_DAY.Value := StrToIntDef(Value, 7);
          end;
        if Define = 'REAS_DAY' then
          begin
            edtREAS_DAY.Value := StrToIntDef(Value, 14);
          end;
        if Define = 'DAY_SALE_STAND' then
          begin
            edtDAY_SALE_STAND.Value := StrToIntDef(Value, 90);
          end;

        if Define = 'SMT_RATE' then
        begin
          edtSMT_RATE.ItemIndex := TdsItems.FindItems(edtSMT_RATE.Properties.Items,'CODE_ID',Value);
        end;

        CdsTable.Next;
      end;
  finally
    vList.Free;
  end;
end;

procedure TfrmOptionDefine.WriteTo;
var i:Integer;
begin
  i := 0;
  SetValue('SAFE_DAY', edtSAFE_DAY.Value);
  SetValue('REAS_DAY', edtREAS_DAY.Value);
  SetValue('DAY_SALE_STAND', edtDAY_SALE_STAND.Value);

  if edtSMT_RATE.ItemIndex = -1 then
    SetValue('SMT_RATE', '')
  else
    SetValue('SMT_RATE',TRecord_(edtSMT_RATE.Properties.Items.Objects[edtSMT_RATE.ItemIndex]).FieldbyName('CODE_ID').AsString);

  CdsTable.First;
  while not CdsTable.Eof do
    begin
      if Pos('SMT_RATE_',CdsTable.FieldByName('DEFINE').AsString) > 0 then
        CdsTable.Delete
      else
        CdsTable.Next;
    end;

  CdsIndex.First;
  while not CdsIndex.Eof do
    begin
      Inc(i);
      SetValue('SMT_RATE_'+FormatStr(i),CdsIndex.FieldByName('SORT_ID').AsString+'='+CdsIndex.FieldByName('LowerLimit').AsString+'-'+CdsIndex.FieldByName('TopLimit').AsString);
      CdsIndex.Next;
    end;
end;

procedure TfrmOptionDefine.FormShow(Sender: TObject);
var
  ObjRecord: TZFactory;
begin
  inherited;
  ObjRecord := TZFactory.create;
  try
    ObjRecord.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsTable, 'TSysDefine', ObjRecord.Params);
    PageControl1.ActivePageIndex := 0;
  finally
    ObjRecord.Free;
  end;
  ReadFrom;
end;

procedure TfrmOptionDefine.FormCreate(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  rs := Global.GetZQueryFromName('PUB_STAT_INFO');
  TdsItems.AddDataSetToItems(rs,edtSMT_RATE.Properties.Items,'CODE_NAME');
  InitGrid;
end;

procedure TfrmOptionDefine.SetValue(FieldName, Value: String);
begin
  if CdsTable.Locate('DEFINE',FieldName,[]) then
    CdsTable.Edit
  else
    CdsTable.Append;
  cdsTable.FieldByName('DEFINE').AsString := FieldName;
  cdsTable.FieldByName('TENANT_ID').AsString := IntToStr(Global.TENANT_ID);
  cdsTable.FieldByName('VALUE').AsString := Value;
  cdsTable.FieldByName('VALUE_TYPE').AsString := '0';
  CdsTable.Post;
end;

procedure TfrmOptionDefine.edtSMT_RATEPropertiesChange(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  CdsIndex.Close;
  CdsIndex.CreateDataSet;
  rs := Global.GetZQueryFromName('PUB_GOODS_INDEXS');
  rs.Filtered := False;
  rs.Filter := ' SORT_TYPE='+TRecord_(edtSMT_RATE.Properties.Items.Objects[edtSMT_RATE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  rs.Filtered := True;

  rs.First;
  while not rs.Eof do
    begin
      CdsIndex.Append;
      CdsIndex.FieldByName('SORT_ID').AsString := rs.FieldByName('SORT_ID').AsString;
      CdsIndex.FieldByName('LowerLimit').AsFloat := 0;
      CdsIndex.FieldByName('TopLimit').AsFloat := 0;
      CdsIndex.Post;
      rs.Next;
    end;
  rs.Filtered := False;
  GridFromCds;
  PageControl1.ActivePageIndex := 1;
end;

function TfrmOptionDefine.FindColumn(DBGrid:TDBGridEh;FieldName: String): TColumnEh;
var i:Integer;
begin
  for i := 0 to DBGrid.Columns.Count - 1 do
    begin
      if DBGrid.Columns[i].FieldName = FieldName then
        begin
          Result := DBGrid.Columns[i];
          Exit;
        end;
    end;
end;

function TfrmOptionDefine.FormatStr(i: Integer): String;
begin
  case Length(IntToStr(i)) of
    1:Result := '00'+IntToStr(i);
    2:Result := '0'+IntToStr(i);
  else
    Result := IntToStr(i);
  end;
end;

procedure TfrmOptionDefine.InitGrid;
var rs:TZQuery;
    GridCol:TColumnEh;
begin
  GridCol := FindColumn(DBGridEh1,'SORT_ID');
  if GridCol = nil then Exit;
  rs := Global.GetZQueryFromName('PUB_GOODS_INDEXS');

  if not rs.Active then Exit;
  GridCol.KeyList.Clear;
  GridCol.PickList.Clear;

  rs.First;
  while not rs.Eof do
    begin
      GridCol.KeyList.Add(rs.FieldByName('SORT_ID').AsString);
      GridCol.PickList.Add(rs.FieldByName('SORT_NAME').AsString);
      rs.Next;
    end;
end;

function TfrmOptionDefine.Judge: Boolean;
begin
  Result := False;
  CdsIndex.First;
  while not CdsIndex.Eof do
    begin
      if CdsIndex.FieldByName('LowerLimit').AsFloat > CdsIndex.FieldByName('TopLimit').AsFloat then
        begin
          PageControl1.ActivePageIndex := 1;
          Result := True;
          Exit;
        end;
      CdsIndex.Next;
    end;
end;

procedure TfrmOptionDefine.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close; 
end;

procedure TfrmOptionDefine.btnOKClick(Sender: TObject);
begin
  inherited;
  if Judge then
    Raise Exception.Create('该记录中下限不能高于上限！');
  WriteTo;
  if Factor.UpdateBatch(CdsTable,'TSysDefine',nil) then
    Close;
end;

procedure TfrmOptionDefine.GridFromCds;
var vList:TStringList;
    LValue,Define,Value:String;
begin
  if CdsIndex.IsEmpty then Exit;

  vList := TStringList.Create;
  try
    CdsTable.First;
    while not CdsTable.Eof do
      begin
        Define := CdsTable.FieldByName('DEFINE').AsString;
        Value := CdsTable.FieldByName('VALUE').AsString;

        if Pos('SMT_RATE_',Define) > 0 then
        begin
          vList.CommaText := Value;
          if CdsIndex.Locate('SORT_ID',vList.Names[0],[]) then
            begin
              CdsIndex.Edit;
              //CdsIndex.FieldByName('SORT_ID').AsString := vList.Names[0];
              LValue := vList.ValueFromIndex[0];
              CdsIndex.FieldByName('LowerLimit').AsFloat := StrToFloat(COPY(LValue,1,AnsiPos('-',LValue)-1));
              CdsIndex.FieldByName('TopLimit').AsFloat := StrToFloat(COPY(LValue,AnsiPos('-',LValue)+1,length(LValue)));
              CdsIndex.Post;
            end;
        end;
        CdsTable.Next;
      end;
  finally
    vList.Free;
  end;
end;

end.
