unit ufrmCustomerExt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls, uShopUtil,
  RzPanel, RzRadGrp, RzEdit, StdCtrls, Mask, RzCmboBx, RzLabel, cxControls, strutils,
  cxContainer, cxEdit, cxTextEdit, cxSpinEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  ZBase, cxRadioGroup, cxButtonEdit, zrComboBoxList, DBGridEh;

type
  TfrmCustomerExt = class(TFrame)
    bg: TRzPanel;
  private
    { Private declarations }
    Top_Value,Row_Num:Integer;
    FList:TList;
    FUnionID: string;
    FDataSet: TDataSet;
    FDataState: TDataSetState;
    FCust_Id: String;
    FIsRecordChange: Boolean;
    FUnionName: String;
    procedure CreateLabel(UNION_ID,LblName:string);
    procedure CreateStarLabel(UNION_ID:String);
    procedure CreateRaido(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
    procedure CreateCmb(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
    procedure CreateNum(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
    procedure CreateDateTime(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
    procedure ControlFree;
    procedure SetUnionID(const Value: string);
    procedure SetDataSet(const Value: TDataSet);
    procedure SetDataState(const Value: TDataSetState);
    procedure SetCust_Id(const Value: String);
    procedure SetIsRecordChange(const Value: Boolean);
    procedure SetUnionName(const Value: String);
  public
    { Public declarations }
    Aobj:TRecord_;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitControl;
    procedure ReadFrom;
    procedure WriteTo;
    property UnionName:String read FUnionName write SetUnionName;
    property UnionID:string read FUnionID write SetUnionID;
    property Cust_Id:String read FCust_Id write SetCust_Id;
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property DataState:TDataSetState read FDataState write SetDataState;
    property IsRecordChange:Boolean read FIsRecordChange write SetIsRecordChange;
  end;

implementation
uses ufrmBasic, uFnUtil, uShopGlobal, uGlobal, uDsUtil;
{$R *.dfm}

{ TfrmCustomerExt }

procedure TfrmCustomerExt.ControlFree;
var i:integer;
begin
  Freeframe(self);
  for i:=0 to FList.Count-1 do
    begin
      if TObject(FList[i]) is TzrComboBoxList then TzrComboBoxList(FList[i]).DataSet.Free;
      TObject(FList[i]).Free;
    end;
  FList.Clear;
end;

constructor TfrmCustomerExt.Create(AOwner: TComponent);
begin
  FList := TList.Create;
  Aobj := TRecord_.Create;
  Top_Value := 0;
  inherited;
end;

procedure TfrmCustomerExt.CreateCmb(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
var Cmb:TzrComboBoxList;
    Column:TColumnEh;
    rs:TZQuery;
begin
  Cmb := TzrComboBoxList.Create(nil);
  Cmb.Parent := bg;
  Cmb.Name := 'cmd_'+AnsiReplaceText(UNION_ID,'-','_');
  Cmb.Properties.ReadOnly := False;
  Cmb.DropListStyle := lsFixed;
  Cmb.FilterFields := 'CODE_ID;CODE_NAME;CODE_SPELL';
  Cmb.KeyField := 'CODE_ID';
  Cmb.ListField := 'CODE_NAME';
  Cmb.Text := '';
  if Row_Num mod 2 = 0 then
    Cmb.Left := 332
  else
    Cmb.Left := 96;
  Cmb.Top := 8+Top_Value;
  Cmb.Height := 21;
  Cmb.Width := 121;
  Cmb.Tag := Is_Null;
  Column := Cmb.Columns.Add;
  Column.FieldName := 'CODE_NAME';
  Column.Title.Caption := '名称';
  Column.Width := 90;
  Column := Cmb.Columns.Add;
  Column.FieldName := 'CODE_SPELL';
  Column.Title.Caption := '拼音码';
  Column.Width := 50;
  Cmb.DropWidth := 200;
  Cmb.ShowButton := False;
  rs := TZQuery.Create(nil);
  Cmb.DataSet := rs;
  try
    rs.SQL.Text := StringReplace(OPTION,':TENANT_ID',inttostr(Global.TENANT_ID),[rfReplaceAll]);
    Factor.Open(rs);
    {rs.First;
    while not rs.Eof do
      begin
        Aobj := TRecord_.Create;
        Aobj.ReadFromDataSet(rs);
        Cmb.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj);
        rs.Next;
      end;}
  finally
    //rs.Free;
  end;
  if In_Value <> '' then
  begin
    Cmb.KeyValue := In_Value;
    Cmb.Text := TdsFind.GetNameByID(Cmb.DataSet,Cmb.KeyField,Cmb.ListField,In_Value);
  end;
  if DataState in [dsBrowse,dsInactive] then
    begin
      Cmb.Properties.ReadOnly := True;
      Cmb.Style.Color := clBtnFace;
    end;
  if Is_Null = 1 then CreateStarLabel(UNION_ID);    
  FList.Add(Cmb);
  if Row_Num mod 2 = 0 then
    Top_Value := Top_Value+29;
end;

procedure TfrmCustomerExt.CreateDateTime(UNION_ID,OPTION,In_Value: String;Is_Null:Integer);
var Date_Time:TcxDateEdit;
begin
  Date_Time := TcxDateEdit.Create(Self);
  Date_Time.Parent := bg;
  Date_Time.Name := 'dte_'+AnsiReplaceText(UNION_ID,'-','_');
  Date_Time.Tag := Is_Null;
  if Row_Num mod 2 = 0 then
    Date_Time.Left := 332
  else
    Date_Time.Left := 96;
  Date_Time.Top := 8+Top_Value;
  Date_Time.Height := 21;
  Date_Time.Width := 121;
  if DataState in [dsBrowse,dsInactive] then
    begin
      Date_Time.Properties.ReadOnly := True;
      Date_Time.Style.Color := clBtnFace;
    end;
  if In_Value <> '' then
    Date_Time.Date := FnTime.fnStrtoDate(In_Value)
  else
    Date_Time.EditValue := null;
  if Is_Null = 1 then CreateStarLabel(UNION_ID);
  FList.Add(Date_Time);
  if Row_Num mod 2 = 0 then
    Top_Value := Top_Value+29;
end;

procedure TfrmCustomerExt.CreateLabel(UNION_ID,LblName:string);
var Lab:TRzLabel;
begin
  Lab := TRzLabel.Create(Self);
  Lab.Parent := bg;
  Lab.Name := 'lab_'+AnsiReplaceText(UNION_ID,'-','_');
  Lab.Alignment := taRightJustify;
  if Row_Num mod 2 = 0 then
    Lab.Left := 244
  else
    Lab.Left := 7;
  Lab.Top := 12+Top_Value;
  Lab.Height := 12;
  Lab.Width := 80;

  Lab.Caption := LblName;
  //FList.Add(Lab);
end;

procedure TfrmCustomerExt.CreateNum(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
var Num_Text:TcxSpinEdit;
begin
  Num_Text := TcxSpinEdit.Create(Self);
  Num_Text.Parent := bg;
  Num_Text.Name := 'num_'+ AnsiReplaceText(UNION_ID,'-','_');
  if Row_Num mod 2 = 0 then
    Num_Text.Left := 332
  else
    Num_Text.Left := 96;
  Num_Text.Top := 8+Top_Value;
  Num_Text.Height := 21;
  Num_Text.Width := 121;
  Num_Text.Tag := Is_Null;
  if In_Value <> '' then
    Num_Text.Value := StrtoIntDef(In_Value,0);
  if DataState in [dsBrowse,dsInactive] then
    begin
      Num_Text.Properties.ReadOnly := True;
      Num_Text.Style.Color := clBtnFace;
    end;
  if Is_Null = 1 then CreateStarLabel(UNION_ID);
  FList.Add(Num_Text);
  if Row_Num mod 2 = 0 then
    Top_Value := Top_Value + 29;
end;

procedure TfrmCustomerExt.CreateRaido(UNION_ID,OPTION,In_Value:String;Is_Null:Integer);
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
  if Row_Num mod 2 = 0 then
    Radio.Left := 332
  else
    Radio.Left := 96;
  Radio.Height := 21;
  Radio.Width := 121;
  Radio.Top := 8+Top_Value;
  Radio.Tag := Is_Null;
  vList := TStringList.Create;
  try
    vList.CommaText := OPTION;
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
    Radio.ItemIndex := TdsItems.FindItems(Radio.Properties.Items,'CODE_ID',In_Value);
  if DataState in [dsBrowse,dsInactive] then
    begin
      Radio.Properties.ReadOnly := True;
      Radio.Style.Color := clBtnFace;
    end;
  if Is_Null = 1 then CreateStarLabel(UNION_ID);
  FList.Add(Radio);
  if Row_Num mod 2 = 0 then
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
  Aobj.Free;
  inherited;
end;

procedure TfrmCustomerExt.WriteTo;
var i:Integer;
    Index_Id:String;
begin
  for i := 0 to FList.Count - 1 do
    begin
      if Tobject(FList[i]) is TcxComboBox then
        begin
          if (TcxComboBox(FList[i]).Tag = 1) and (Trim(TcxComboBox(FList[i]).Text) = '') then
            raise Exception.Create('"'+UnionName+'"分页中有必填项没有填写!');
          Index_Id := copy(TcxComboBox(FList[i]).Name,5,50);
          Index_Id := AnsiReplaceText(Index_Id,'_','-');
          if DataSet.Locate('INDEX_ID',Index_Id,[]) then
            begin
              DataSet.Edit;
              if TcxComboBox(FList[i]).ItemIndex = -1 then
                DataSet.FieldByName('INDEX_VALUE').AsString := ''
              else
                DataSet.FieldByName('INDEX_VALUE').AsString := TRecord_(TcxComboBox(FList[i]).Properties.Items.Objects[TcxComboBox(FList[i]).ItemIndex]).FieldbyName('CODE_ID').AsString;
              DataSet.Post;
            end;
        end
      else if Tobject(FList[i]) is TcxSpinEdit then
        begin
          if (TcxSpinEdit(FList[i]).Tag = 1) and (Trim(TcxSpinEdit(FList[i]).Text) = '') then
            raise Exception.Create('"'+UnionName+'"中有必填项没有填写!');
          Index_Id := AnsiReplaceText(copy(TcxSpinEdit(FList[i]).Name,5,50),'_','-');
          if DataSet.Locate('INDEX_ID',Index_Id,[]) then
            begin
              DataSet.Edit;
              DataSet.FieldByName('INDEX_VALUE').AsString := TcxSpinEdit(FList[i]).Value;
              DataSet.Post;
            end;
        end
      else if Tobject(FList[i]) is TcxDateEdit then
        begin
          if (TcxDateEdit(FList[i]).Tag = 1) and (TcxDateEdit(FList[i]).EditValue = null) then
            raise Exception.Create('"'+UnionName+'"中有必填项没有填写!');
          Index_Id := AnsiReplaceText(copy(TcxDateEdit(FList[i]).Name,5,50),'_','-');
          if DataSet.Locate('INDEX_ID',Index_Id,[]) then
            begin
              DataSet.Edit;
              if TcxDateEdit(FList[i]).EditValue = null then
                DataSet.FieldByName('INDEX_VALUE').AsString := ''
              else
                DataSet.FieldByName('INDEX_VALUE').AsString := FormatDateTime('YYYY-MM-DD',TcxDateEdit(FList[i]).Date);
              DataSet.Post;
            end;
        end
      else if TObject(FList[i]) is TzrComboBoxList then
        begin
          if (TzrComboBoxList(FList[i]).Tag = 1) and (Trim(TzrComboBoxList(FList[i]).Text) = '') then
            raise Exception.Create('"'+UnionName+'"中有必填项没有填写!');
          Index_Id := copy(TzrComboBoxList(FList[i]).Name,5,50);
          Index_Id := AnsiReplaceText(Index_Id,'_','-');
          if DataSet.Locate('INDEX_ID',Index_Id,[]) then
            begin
              DataSet.Edit;
              DataSet.FieldByName('INDEX_VALUE').AsString := TzrComboBoxList(FList[i]).AsString;
              DataSet.Post;
            end;
        end;
    end;
end;

procedure TfrmCustomerExt.InitControl;
var Select_Answer:String;
    cdsUnionIndex:TZQuery;
begin
  ControlFree;
  cdsUnionIndex := TZQuery.Create(nil);
  try
    cdsUnionIndex.SQL.Text :=
    'select UNION_ID,INDEX_ID,INDEX_NAME,INDEX_SPELL,INDEX_TYPE,INDEX_OPTION,INDEX_ISNULL from PUB_UNION_INDEX where UNION_ID=:UNION_ID';// and TENANT_ID=:TENANT_ID';
    cdsUnionIndex.Params.ParamByName('UNION_ID').AsString := UnionID;
//    cdsUnionIndex.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsUnionIndex);
    Aobj.ReadFromDataSet(cdsUnionIndex);

    cdsUnionIndex.First;
    while not cdsUnionIndex.Eof do
      begin
        inc(Row_Num);
        if not DataSet.Locate('INDEX_ID;UNION_ID',VarArrayOf([cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('UNION_ID').AsString]),[]) then
          begin
            DataSet.Append;
            DataSet.FieldByName('ROWS_ID').AsString := TSequence.NewId;
            DataSet.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            DataSet.FieldByName('UNION_ID').AsString := cdsUnionIndex.FieldbyName('UNION_ID').AsString;
            DataSet.FieldByName('INDEX_ID').AsString := cdsUnionIndex.FieldbyName('INDEX_ID').AsString;
            DataSet.FieldByName('INDEX_NAME').AsString := cdsUnionIndex.FieldbyName('INDEX_NAME').AsString;
            DataSet.FieldByName('INDEX_TYPE').AsString := cdsUnionIndex.FieldbyName('INDEX_TYPE').AsString;
            DataSet.FieldByName('CUST_ID').AsString := Cust_Id;
            DataSet.Post;
            Select_Answer := '';
          end
        else
          Select_Answer := DataSet.FieldByName('INDEX_VALUE').AsString;
        
        CreateLabel(cdsUnionIndex.FieldbyName('INDEX_ID').asString,cdsUnionIndex.FieldbyName('INDEX_NAME').asString);
        if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '1' then
          begin
            CreateRaido(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Select_Answer,cdsUnionIndex.FieldbyName('INDEX_ISNULL').AsInteger);
          end
        else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '2' then
          begin
            CreateCmb(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Select_Answer,cdsUnionIndex.FieldbyName('INDEX_ISNULL').AsInteger);
          end
        else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '3' then
          begin
            CreateNum(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Select_Answer,cdsUnionIndex.FieldbyName('INDEX_ISNULL').AsInteger);
          end
        else if cdsUnionIndex.FieldByName('INDEX_TYPE').AsString = '4' then
          begin
            CreateDateTime(cdsUnionIndex.FieldbyName('INDEX_ID').AsString,cdsUnionIndex.FieldbyName('INDEX_OPTION').AsString,Select_Answer,cdsUnionIndex.FieldbyName('INDEX_ISNULL').AsInteger);
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

procedure TfrmCustomerExt.CreateStarLabel(UNION_ID:String);
var Lbl:TRzLabel;
begin
  Lbl := TRzLabel.Create(Self);
  Lbl.Parent := bg;
  Lbl.Name := 'lbl_'+AnsiReplaceText(UNION_ID,'-','_');
  Lbl.Alignment := taRightJustify;
  if Row_Num mod 2 = 0 then
    Lbl.Left := 455
  else
    Lbl.Left := 220;
  Lbl.Top := 12+Top_Value;
  Lbl.Height := 12;
  Lbl.Width := 6;
  Lbl.Caption := '*';
  Lbl.Font.Color := clMaroon;
  //FList.Add(Lbl);
end;

procedure TfrmCustomerExt.SetCust_Id(const Value: String);
begin
  FCust_Id := Value;
end;

procedure TfrmCustomerExt.SetIsRecordChange(const Value: Boolean);
begin
  FIsRecordChange := Value;
end;

procedure TfrmCustomerExt.SetUnionName(const Value: String);
begin
  FUnionName := Value;
end;

end.
