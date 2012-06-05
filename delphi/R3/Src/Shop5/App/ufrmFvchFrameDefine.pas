unit ufrmFvchFrameDefine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxCheckBox, StdCtrls, DBGridEh,
  zrComboBoxList, RzLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, ZBase,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, cxButtonEdit, ObjCommon,
  ComCtrls, RzTreeVw, cxRadioGroup;

type
  TfrmFvchFrameDefine = class(TframeDialogForm)
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    edtDATAFLAG_1: TcxCheckBox;
    edtDATAFLAG_3: TcxCheckBox;
    edtDATAFLAG_2: TcxCheckBox;
    edtDATAFLAG_4: TcxCheckBox;
    edtDATAFLAG_5: TcxCheckBox;
    edtDATAFLAG_7: TcxCheckBox;
    edtDATAFLAG_6: TcxCheckBox;
    edtDATAFLAG_8: TcxCheckBox;
    Label16: TLabel;
    edtSORT_ID: TcxComboBox;
    RzPanel4: TRzPanel;
    DataTree: TRzCheckTree;
    edtIn: TcxRadioButton;
    edtNotIn: TcxRadioButton;
    procedure edtSORT_IDPropertiesChange(Sender: TObject);
    procedure DataTreeStateChange(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Locked:Boolean;
    FDataFlag: String;
    FFvchType: String;
    FSubjectNo: String;
    FDataSet_Swhere: TZQuery;
    FsWhere: String;
    //****************************************//
    //****************************************//
    procedure EncodeDataFlag;
    function DecodeDataFlag:String;
    procedure SetDataFlag(const Value: String);
    procedure SetFvchType(const Value: String);
    procedure SetSubjectNo(const Value: String);
    procedure ReadFvchSwhere;
    procedure WriteFvchSwhere;
    procedure InitTree(TreeType:String);
    function GetTreeSql(TreeType:String):String;
    function GetListSql(FvchType:Integer):String;
    procedure SetDataSet_Swhere(const Value: TZQuery);
    procedure SetsWhere(const Value: String);
    function IsIntStr(const s:String):Boolean;
  public
    { Public declarations }
    procedure Save;
    property DataFlag:String read FDataFlag write SetDataFlag;
    property FvchType:String read FFvchType write SetFvchType;
    property sWhere:String read FsWhere write SetsWhere;
    property SubjectNo:String read FSubjectNo write SetSubjectNo;
    property DataSet_Swhere:TZQuery read FDataSet_Swhere write SetDataSet_Swhere;
  end;

implementation
uses ufrmBasic, uFnUtil, uShopGlobal, uGlobal, uDsUtil, uShopUtil, uTreeUtil,
  Math;
{$R *.dfm}

{ TfrmFvchFrameDefine }

function TfrmFvchFrameDefine.DecodeDataFlag: String;
var StrData:String;
begin
  Result := '00000000';
  StrData := ''; 
  if edtDATAFLAG_1.Checked then StrData := '1' else  StrData := '0';
  if edtDATAFLAG_2.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_3.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_4.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_5.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_6.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_7.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  if edtDATAFLAG_8.Checked then StrData := StrData+'1' else  StrData := StrData+'0';
  Result := StrData;
end;

procedure TfrmFvchFrameDefine.EncodeDataFlag;
var StrData:String;
begin
  StrData := DataFlag;
  if Trim(StrData) <> '' then
  begin
     edtDATAFLAG_1.Checked := StrToInt(Copy(StrData,1,1))=1;
     edtDATAFLAG_2.Checked := StrToInt(Copy(StrData,2,1))=1;
     edtDATAFLAG_3.Checked := StrToInt(Copy(StrData,3,1))=1;
     edtDATAFLAG_4.Checked := StrToInt(Copy(StrData,4,1))=1;
     edtDATAFLAG_5.Checked := StrToInt(Copy(StrData,5,1))=1;
     edtDATAFLAG_6.Checked := StrToInt(Copy(StrData,6,1))=1;
     edtDATAFLAG_7.Checked := StrToInt(Copy(StrData,7,1))=1;
     edtDATAFLAG_8.Checked := StrToInt(Copy(StrData,8,1))=1;
  end;
end;

procedure TfrmFvchFrameDefine.InitTree(TreeType: String);
var rs:TZQuery;
    Sql_Str:String;
begin
  ClearTree(DataTree);
  rs := TZQuery.Create(nil);
  try
    Sql_Str := GetTreeSql(TreeType);
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType,Sql_Str);
    if rs.Params.FindParam('TENANT_ID') <> nil then rs.Params.FindParam('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('SORT_TYPE') <> nil then rs.Params.FindParam('SORT_TYPE').AsString := TreeType;
    if rs.Params.FindParam('TYPE_CODE') <> nil then rs.Params.FindParam('TYPE_CODE').AsString := TreeType;

    Factor.Open(rs);
    CreateLevelTree(rs,DataTree,'44','DATA_OBJECT','DATA_NAME','LEVEL_ID');
    if DataTree.Items.Count>0 then DataTree.TopItem.Selected:=True;
  finally
    rs.Free;
  end;
end;

procedure TfrmFvchFrameDefine.Save;
begin
  DataFlag := DecodeDataFlag;
  WriteFvchSwhere;
end;

procedure TfrmFvchFrameDefine.SetDataFlag(const Value: String);
begin
  FDataFlag := Value;
  EncodeDataFlag;
end;

procedure TfrmFvchFrameDefine.SetFvchType(const Value: String);
var rs:TZQuery;
begin
  FFvchType := Value;
  try
    rs := TZQuery.Create(nil);
    rs.Close;
    rs.SQL.Text := GetListSql(StrToInt(Value));
    rs.Params.ParamByName('TYPE_CODE').AsString := 'FVCH_WHERE_'+Value;
    if rs.Params.FindParam('TENANT_ID') <> nil then rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    AddCbxPickList(edtSORT_ID,'',rs);
  finally
    rs.Free;
  end;
end;

procedure TfrmFvchFrameDefine.SetSubjectNo(const Value: String);
begin
  FSubjectNo := Value;
  TabSheet1.Caption := '科目"' + Value + '"选项';
end;

procedure TfrmFvchFrameDefine.edtSORT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtSORT_ID.Properties.Items.Count = 0 then Exit;
  ReadFvchSwhere;
end;

function TfrmFvchFrameDefine.GetTreeSql(TreeType: String): String;
var Sql:String;
begin
  if TreeType = '1' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and length(LEVEL_ID)<9 and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '2' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '3' then
     Sql := 'select CLIENT_ID as DATA_OBJECT,CLIENT_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_CLIENTINFO '+
     ' where COMM not in (''02'',''12'')  and CLIENT_TYPE=''1'' and TENANT_ID=:TENANT_ID order by CLIENT_CODE '
  else if TreeType = '4' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '5' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '6' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '7' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '8' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '9' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = '10' then
     Sql := 'select SORT_ID as DATA_OBJECT,SORT_NAME as DATA_NAME,LEVEL_ID from VIW_GOODSSORT '+
     'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and COMM not in (''02'',''12'') order by LEVEL_ID,SEQ_NO'
  else if TreeType = 'DEPT_ID' then
     Sql := 'select  DEPT_ID as DATA_OBJECT,DEPT_NAME as DATA_NAME,LEVEL_ID '+
     'from CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') order by LEVEL_ID '
  else if TreeType = 'SHOP_ID' then
     Sql := 'select SHOP_ID as DATA_OBJECT,SHOP_NAME as DATA_NAME,''0001'' as LEVEL_ID from CA_SHOP_INFO where TENANT_ID=:TENANT_ID '+
     ' and COMM not in (''02'',''12'') order by SEQ_NO'
  else if TreeType = 'CLIENT_ID' then
  begin
    case StrToInt(FvchType) of
      1,2,3,10,14:
        Sql := 'select CLIENT_ID as DATA_OBJECT,CLIENT_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_CLIENTINFO '+
        ' where COMM not in (''02'',''12'')  and CLIENT_TYPE=''1'' and TENANT_ID=:TENANT_ID order by CLIENT_CODE ';
      4,5,6,9,11,13:
        Sql := 'select CLIENT_ID as DATA_OBJECT,CLIENT_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_CUSTOMER '+
        ' where COMM not in (''02'',''12'')  and CLIENT_TYPE=''2'' and TENANT_ID=:TENANT_ID order by CLIENT_CODE ';
    end;
  end
  else if TreeType = 'GUIDE_USER' then
     Sql := 'select USER_ID as DATA_OBJECT,USER_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_USERS where COMM not in (''02'',''12'') '+
     ' and TENANT_ID=:TENANT_ID and USER_ID<>''system'' order by ACCOUNT '
  else if TreeType = 'DUTY_USER' then
     Sql := 'select USER_ID as DATA_OBJECT,USER_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_USERS where COMM not in (''02'',''12'') '+
     ' and TENANT_ID=:TENANT_ID and USER_ID<>''system'' order by ACCOUNT '
  else if TreeType = 'IORO_USER' then
     Sql := 'select USER_ID as DATA_OBJECT,USER_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_USERS where COMM not in (''02'',''12'') '+
     ' and TENANT_ID=:TENANT_ID and USER_ID<>''system'' order by ACCOUNT '
  else if TreeType = 'TRANS_USER' then
     Sql := 'select USER_ID as DATA_OBJECT,USER_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_USERS where COMM not in (''02'',''12'') '+
     ' and TENANT_ID=:TENANT_ID and USER_ID<>''system'' order by ACCOUNT '
  else if TreeType = 'INVOICE_FLAG' then
     Sql := 'select CODE_ID as DATA_OBJECT,CODE_NAME as DATA_NAME,''0001'' as LEVEL_ID from PUB_PARAMS where TYPE_CODE=:TYPE_CODE '
  else if TreeType = 'IS_PRESENT' then
     Sql := 'select CODE_ID as DATA_OBJECT,CODE_NAME as DATA_NAME,''0001'' as LEVEL_ID from PUB_PARAMS where TYPE_CODE=:TYPE_CODE '
  else if TreeType = 'ITEM_ID' then
     Sql := 'select CODE_ID as DATA_OBJECT,CODE_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_ITEM_INFO '+
     ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '
  else if TreeType = 'PAYM_ID' then
  begin
     Sql := 'select ''PAY_''||CODE_ID as DATA_OBJECT,CODE_NAME as DATA_NAME,''0001'' as LEVEL_ID from VIW_PAYMENT where TENANT_ID=:TENANT_ID  ';
     Sql := ParseSQL(Factor.iDbType,Sql);
  end
  else if TreeType = 'SALES_STYLE' then
     Sql := 'select CODE_ID as DATA_OBJECT,CODE_NAME as DATA_NAME,''0001'' as LEVEL_ID  from PUB_CODE_INFO where TENANT_ID=:TENANT_ID and CODE_TYPE=''2'' and COMM not in (''02'',''12'')';
  Result := Sql;
end;

function TfrmFvchFrameDefine.GetListSql(FvchType: Integer): String;
var Sql:String;
begin
  case FvchType of
    0,1,2,3,4,5,6,7,8,11:
      Sql := 'select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=:TYPE_CODE and CODE_ID<>''SORT_ID'' '+
      ' union all '+
      'select CODE_ID,CODE_NAME from ( '+
      'select j.CODE_ID,case when b.CODE_NAME is null then j.CODE_NAME else b.CODE_NAME end as CODE_NAME,'+
      'case when b.SEQ_NO is null then 0 else b.SEQ_NO end as SEQ_NO from PUB_PARAMS j left outer join '+
      '(select CODE_ID,CODE_NAME,SEQ_NO from PUB_CODE_INFO where TENANT_ID=:TENANT_ID and CODE_TYPE=''16'') '+
      ' b on j.CODE_ID=b.CODE_ID where j.TYPE_CODE=''SORT_TYPE'') '+
      ' g where not(CODE_NAME like ''自定义%'') ';
    9,10,12,13,14,15:
      Sql := 'select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=:TYPE_CODE ';
  end;
  Result := Sql;
end;

procedure TfrmFvchFrameDefine.ReadFvchSwhere;
var i,r:Integer;
    SId,sName,sValue,sCodeId:String;
begin
  //ClearTree(DataTree);
  if edtSORT_ID.Properties.Items.Count < 0 then Exit;
  if edtSORT_ID.ItemIndex<0 then Exit;
  sCodeId := TRecord_(edtSORT_ID.Properties.Items.Objects[edtSORT_ID.ItemIndex]).FieldByName('CODE_ID').AsString;
  InitTree(sCodeId);
  if IsIntStr(sCodeId) then sName := 'SORT_ID'+sCodeId else sName := sCodeId;
  locked := true;
  try
  if DataSet_Swhere.Locate('SWHERE,FIELD_NAME',VarArrayOf([sWhere,sName]),[]) then
    begin
      if DataSet_Swhere.FieldByName('FIELD_EQUE').AsString = 'in' then
         edtIn.Checked := True
      else
         edtNotIn.Checked := True;
      for i := 0 to DataTree.Items.Count - 1 do
        begin
          SId := TRecord_(DataTree.Items[i].Data).FieldbyName('DATA_OBJECT').AsString;
          if DataSet_Swhere.Locate('SWHERE,FIELD_NAME;FIELD_VALUE',varArrayOf([sWhere,sName,SId]),[]) then
             DataTree.ItemState[i] := csChecked;
        end;
    end
  else
    begin
      edtIn.Checked := True;
      {for i := 0 to DataTree.Items.Count - 1 do
        DataTree.ItemState[i] := csUnchecked; }
    end;
  finally
    locked := false;
  end;
end;

procedure TfrmFvchFrameDefine.WriteFvchSwhere;
var i,r:Integer;
    sName,sValue,sCodeId:String;
begin
  if edtSORT_ID.Properties.Items.Count < 0 then Exit;
  if edtSORT_ID.ItemIndex<0 then Exit;
  sCodeId := TRecord_(edtSORT_ID.Properties.Items.Objects[edtSORT_ID.ItemIndex]).FieldByName('CODE_ID').AsString;
  if IsIntStr(sCodeId) then sName := 'SORT_ID'+sCodeId else sName := sCodeId;
  sValue := '';

  for i := 0 to DataTree.Items.Count - 1 do
    begin
      //if DataTree.Items[i].hasChildren then continue;
      sValue := TRecord_(DataTree.Items[i].Data).FieldByName('DATA_OBJECT').AsString;
      if DataTree.ItemState[i] in [csChecked] then
        begin
          if DataTree.Items[i].Parent <> nil then
          begin
             if DataTree.Items[i].Parent.Selected then
             begin
                if DataSet_Swhere.Locate('SWHERE,FIELD_NAME,FIELD_VALUE',VarArrayOf([sWhere,sName,sValue]),[]) then
                   DataSet_Swhere.Delete;
                Continue;
             end;
          end;
          if not DataSet_Swhere.Locate('SWHERE,FIELD_NAME,FIELD_VALUE',VarArrayOf([sWhere,sName,sValue]),[]) then
            begin
              DataSet_Swhere.Append;
              DataSet_Swhere.FieldByName('SROW_ID').AsString := TSequence.NewId;
              DataSet_Swhere.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
              DataSet_Swhere.FieldByName('SWHERE').AsString := Swhere;
              DataSet_Swhere.FieldByName('FIELD_NAME').AsString := sName;
              if edtIn.Checked then
                 DataSet_Swhere.FieldByName('FIELD_EQUE').AsString := 'in'
              else
                 DataSet_Swhere.FieldByName('FIELD_EQUE').AsString := 'not in';
              DataSet_Swhere.FieldByName('FIELD_VALUE').AsString := sValue;
              DataSet_Swhere.Post;
            end
          else
            begin
              DataSet_Swhere.Edit;
              if edtIn.Checked then
                 DataSet_Swhere.FieldByName('FIELD_EQUE').AsString := 'in'
              else
                 DataSet_Swhere.FieldByName('FIELD_EQUE').AsString := 'not in';
              DataSet_Swhere.Post;
            end;
        end
      else
        begin
          if DataSet_Swhere.Locate('SWHERE,FIELD_NAME,FIELD_VALUE',VarArrayOf([sWhere,sName,sValue]),[]) then
             DataSet_Swhere.Delete;
        end;
    end;
end;

procedure TfrmFvchFrameDefine.DataTreeStateChange(Sender: TObject;
  Node: TTreeNode; NewState: TRzCheckState);
begin
  inherited;
  if Locked then Exit;
  WriteFvchSwhere;
end;

procedure TfrmFvchFrameDefine.btnSaveClick(Sender: TObject);
begin
  inherited;
  try
    Save;
    ModalResult := mrOk;
  except
    Raise;
    ModalResult := mrIgnore;
  end;
end;

procedure TfrmFvchFrameDefine.btnExitClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmFvchFrameDefine.SetDataSet_Swhere(const Value: TZQuery);
begin
  FDataSet_Swhere := Value;
end;

procedure TfrmFvchFrameDefine.SetsWhere(const Value: String);
begin
  FsWhere := Value;
end;

procedure TfrmFvchFrameDefine.FormShow(Sender: TObject);
begin
  inherited;
  if edtSORT_ID.Properties.Items.Count > 0 then edtSORT_ID.ItemIndex := 0;
end;

function TfrmFvchFrameDefine.IsIntStr(const s: String): Boolean;
begin
  Result := StrToIntDef(s,0)=StrToIntDef(s,1);
end;

end.

