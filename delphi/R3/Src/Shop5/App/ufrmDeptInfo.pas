unit ufrmDeptInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxMemo, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls,DB,ZDataset,zBase,
  ZAbstractRODataset, ZAbstractDataset;

type
  TfrmDeptInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label1: TLabel;
    edtDEPT_ID: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtDEPT_NAME: TcxTextEdit;
    Label4: TLabel;
    Label7: TLabel;
    edtDEPT_SPELL: TcxTextEdit;
    Label6: TLabel;
    Label9: TLabel;
    edtUPDEPT_ID: TzrComboBoxList;
    edtREMARK: TcxMemo;
    Label26: TLabel;
    cdsTable: TZQuery;
    Label5: TLabel;
    edtTELEPHONE: TcxTextEdit;
    Label8: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label10: TLabel;
    edtFAXES: TcxTextEdit;
    drpDept: TZQuery;
    edtDEPT_TYPE: TzrComboBoxList;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtDEPT_NAMEPropertiesChange(Sender: TObject);
    procedure edtUPDEPT_IDBeforeDropList(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtFAXESKeyPress(Sender: TObject; var Key: Char);
  private
    FDeptType: TZQuery;
    procedure SetDeptType;
    function  GetLevelID(oldLevelID: string): string;
    function  IsEdit(Aobj:TRecord_; cdsTable: TZQuery):Boolean; virtual; //判断是Aobj对象与与数据集Value是否改变
    procedure CheckDEPTNameIsExists;  //判断部门是否存在
  public
    AObj:TRecord_;
    Saved:Boolean;
    procedure Open(code:string);
    procedure WriteTo(Aobj:TRecord_);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure SetdbState(const Value: TDataSetState); override;
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
  end;


implementation
uses uShopUtil,uDsUtil,uFnUtil, uGlobal,uXDictFactory, uShopGlobal,
  ObjCommon;
{$R *.dfm}

{ TfrmDeptInfo }

procedure TfrmDeptInfo.Append;
var
  zQry: TZQuery;
begin
  Open('');
  dbState:=dsInsert;
  edtDEPT_ID.Text:=TSequence.GetMaxID(InttoStr(ShopGlobal.TENANT_ID),Factor,'DEPT_ID','CA_DEPT_INFO','000',' TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID)+' ');
  edtDEPT_TYPE.KeyValue:=trim(edtDEPT_TYPE.DataSet.fieldbyName('CODE_ID').AsString);
  edtDEPT_TYPE.Text:=trim(edtDEPT_TYPE.DataSet.fieldbyName('CODE_NAME').AsString);
end;

procedure TfrmDeptInfo.Edit(code: string);
begin
  Open(code);
  edtUPDEPT_ID.Enabled:=(AObj.FieldByName('DEPT_ID').AsString<>'000');
  dbState := dsEdit;
end;

procedure TfrmDeptInfo.Open(code: string);
var
  CurID: string;
  zQry: TZQuery;
  Params: TftParamList;
begin
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('DEPT_ID').AsString := code;
    Params.ParamByName('TENANT_ID').AsInteger := ShopGlobal.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TDEPTInfo',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    CurID:=trim(Aobj.FieldByName('LEVEL_ID').AsString);
    CurID:=Copy(CurID,1,Length(CurID)-3);
    zQry:=Global.GetZQueryFromName('CA_DEPT_INFO');
    if (zQry<>nil) and (zQry.Active) and (CurID<>'') then
    begin
      edtUPDEPT_ID.KeyValue:=CurID;
      edtUPDEPT_ID.Text:=TdsFind.GetNameByID(zQry,'LEVEL_ID','DEPT_NAME',CurID)
    end else
    begin
      edtUPDEPT_ID.KeyValue:='';
      edtUPDEPT_ID.Text:='';
    end;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;  
end;

procedure TfrmDeptInfo.Save;
  procedure UpdateToGlobal(AObj:TRecord_);
  var
    Temp:TZQuery;
    i: integer; IsFlag: Boolean;
    FName,OldID,NewID,CurID: string;
  begin
    Temp := Global.GetZQueryFromName('CA_DEPT_INFO');
    Temp.Filtered :=false;
    if not Temp.Locate('DEPT_ID',edtDEPT_ID.Text,[]) then
      Temp.Append
    else
      Temp.Edit;

    AObj.WriteToDataSet(Temp,False);
    {for i:=0 to AObj.Count-1 do
    begin
      FName:=trim(AObj.Fields[i].FieldName);
      if Temp.FindField(FName)<>nil then
        Temp.FieldByName(FName).Value:=AObj.Fields[i].AsValue;
    end;}
    Temp.Post;

    //修改LEVEL_ID值:
    NewID:=trim(AObj.FieldByName('LEVEL_ID').AsString);
    OldID:=trim(AObj.FieldByName('LEVEL_ID').AsOldString);
    if (NewID<>OldID) and (OldID<>'') then
    begin
      Temp.SortedFields := 'DEPT_ID';
      Temp.First;
      while not Temp.Eof do
      begin
        CurID:=trim(Temp.FieldByName('LEVEL_ID').AsString);
        IsFlag:=(Copy(CurID,1,length(OldID))=OldID);

        if (IsFlag) and (trim(CurID)<>trim(OldID)) then
        begin
          Temp.Edit;
          Temp.FieldByName('LEVEL_ID').AsString:=NewID+Copy(CurID,Length(OldID)+1,50);
          Temp.Post;
        end;
        Temp.Next;
      end;
      Temp.SortedFields:='LEVEL_ID';
    end;
  end;
var
  tmp:TZQuery;
  j:integer;
  TestObj: TRecord_;
begin
  TestObj:=TRecord_.Create;

  if trim(edtDEPT_NAME.Text)='' then
  begin
    if not edtDEPT_NAME.CanFocus then edtDEPT_NAME.SetFocus;
    Raise Exception.Create('名称不能为空！');
  end;
  if trim(edtDEPT_SPELL.Text)='' then
  begin
    if not edtDEPT_SPELL.CanFocus then edtDEPT_SPELL.SetFocus;
    Raise Exception.Create('拼音码不能为空！');
  end;
  if trim(edtDEPT_TYPE.Text)='' then
  begin
    if not edtDEPT_TYPE.CanFocus then edtDEPT_TYPE.SetFocus;
    Raise Exception.Create('部门类型不能为空！');
  end; 

  CheckDEPTNameIsExists; //判断部门是否存在

  WriteTo(Aobj);  //写入Obj记录对象
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then  Exit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  if Factor.UpdateBatch(cdsTable,'TDEPTInfo',nil) then
    UpdateToGlobal(Aobj);
  Saved:=True;
  dbState:=dsBrowse;
end;

procedure TfrmDeptInfo.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  SetDeptType; //设置部门DataSet
end;

procedure TfrmDeptInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmDeptInfo.btnOkClick(Sender: TObject);
var
  IsNew: Boolean;
begin
  inherited;
  Saved:=False;
  IsNew:=(dbState=dsInsert);
  Save;
  if Saved and Assigned(OnSave) then
  begin
    OnSave(AObj);     
    if (IsNew)and(MessageBox(Handle,'是否继续新增部门?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6) then
      Append
    else
      ModalResult := MROK;
  end else
    ModalResult := MROK;
end;

procedure TfrmDeptInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDeptInfo.edtDEPT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtDEPT_SPELL.Text := fnString.GetWordSpell(edtDEPT_NAME.Text,3);
end;

procedure TfrmDeptInfo.edtUPDEPT_IDBeforeDropList(Sender: TObject);
var
  PosIdx: integer;    
  DEPT_ID,Level_ID,Cnd: string;
begin
  if not cdsTable.Active then Exit;
  if dbState=dsBrowse then Exit;
  Cnd:='';
  if dbState=dsEdit then
  begin
    DEPT_ID:=trim(cdsTable.fieldbyName('DEPT_ID').AsString);
    if DEPT_ID<>'' then Cnd:=Cnd+' and (DEPT_ID<>:DEPT_ID) ';
    
    Level_ID:=trim(cdsTable.fieldbyName('LEVEL_ID').AsString);
    if Level_ID<>'' then
    begin
      PosIdx:=Length(Level_ID);
      Cnd:=Cnd+' and not(substr(LEVEL_ID,1,'+InttoStr(PosIdx)+')=:LEVEL_ID) ';
    end;
  end;
  Cnd:='select DEPT_NAME,DEPT_ID,DEPT_SPELL,LEVEL_ID from CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Cnd;
  Cnd:=ParseSQL(Factor.iDbType, Cnd);
  drpDept.Close;
  drpDept.SQL.Text:=Cnd;
  if drpDept.Params.FindParam('TENANT_ID')<>nil then drpDept.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  if drpDept.Params.FindParam('DEPT_ID')<>nil then drpDept.ParamByName('DEPT_ID').AsString:=DEPT_ID;
  if drpDept.Params.FindParam('Level_ID')<> nil then drpDept.ParamByName('Level_ID').AsString:=Level_ID;
  Factor.Open(drpDept);
end;

procedure TfrmDeptInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtDEPT_NAME.CanFocus then edtDEPT_NAME.SetFocus;
end;
procedure TfrmDeptInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label2.Visible:=True;
  Label4.Visible:=True;
  Label6.Visible:=True;
  btnOk.Visible := (Value<>dsBrowse);
  case dbState of
  dsInsert:Caption:='部门档案--(新增)';
  dsEdit:Caption:='部门档案--(修改)';
  else
    begin
      Caption:='部门档案';
      Label2.Visible:=False;
      Label4.Visible:=False;
      Label6.Visible:=False;
    end;
  end;
end;

procedure TfrmDeptInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtDEPT_NAME.Text)='')) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'部门档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmDeptInfo.WriteTo(Aobj: TRecord_);
begin
  WriteToObject(AObj,self);  
  Aobj.FieldByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
  Aobj.FieldByName('DEPT_ID').AsString:=edtDEPT_ID.Text;
  Aobj.FieldByName('LEVEL_ID').AsString:=GetLevelID(Aobj.FieldByName('LEVEL_ID').AsString);
end;

class function TfrmDeptInfo.EditDialog(Owner: TForm; id: string; var _AObj: TRecord_): boolean;
begin
  //新R3内ShopGlobal没有此方法:
  //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能修改部门!');
  if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改部门的权限,请和管理员联系.');
  with TfrmDEPTInfo.Create(Owner) do
  begin
    try
      Edit(id);
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end else
        result :=False;
    finally
      free;
    end;
  end;
end;

class function TfrmDeptInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_): boolean;
begin
   //新R3内ShopGlobal没有此方法:
   //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能新增部门!');
  if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增部门的权限,请和管理员联系.');
  with TfrmDEPTInfo.Create(Owner) do
  begin
    try
      Append;
      if ShowModal=MROK then
      begin
        AObj.CopyTo(_AObj);
        result :=True;
      end else
        result :=False;
    finally
      free;
    end
  end;
end;

function TfrmDeptInfo.IsEdit(Aobj: TRecord_; cdsTable: TZQuery): Boolean;
var
  i:integer;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if trim(AObj.Fields[i].AsString)<>trim(cdsTable.Fields[i].AsString) then
    begin
      Result:=True;
      break;
    end;
  end; 
end;

procedure TfrmDeptInfo.CheckDEPTNameIsExists;
var
  IsExist: Boolean;
  tmp: TZQuery;
begin
  if edtDEPT_NAME.Text<>cdsTable.FieldByName('DEPT_NAME').AsString  then
  begin
    IsExist:=False;
    tmp:=Global.GetZQueryFromName('CA_DEPT_INFO');
    tmp.Filtered:=False;
    tmp.First;
    while not tmp.Eof do
    begin
      if trim(tmp.FieldByName('DEPT_NAME').AsString)=trim(edtDEPT_NAME.Text) then
      begin
        if (dbState=dsEdit)and (tmp.FieldByName('DEPT_ID').AsString<>cdsTable.FieldByName('DEPT_ID').AsString) then IsExist:=true
        else if dbState=dsInsert then IsExist:=true;
        if IsExist then
        begin
          if edtDEPT_NAME.CanFocus then  edtDEPT_NAME.SetFocus;
          Raise Exception.Create('　　提示:部门名称已经存在！　'); 
          break;
        end;
      end;
      tmp.Next;
    end;
  end;
end;

function TfrmDeptInfo.GetLevelID(oldLevelID: string): string;
var
  zQry: TZQuery;
  LevelID,OldID: string;
begin
  Result:='';
  LevelID:='';
  //判断是否修改过CA_DEPT_INFO
  if edtUPDEPT_ID.KeyValue=null then LevelID:=''
  else LevelID:=trim(edtUPDEPT_ID.KeyValue);

  OldID:=trim(oldLevelID);
  OldID:=Copy(OldID,1,length(OldID)-3);   
  if (dbState=dsEdit) and (LevelID = OldID) then  //编辑状态里连个值相等则
  begin
    result:=oldLevelID;
    Exit;
  end;
  Result:=TSequence.GetMaxID(LevelID, Factor,'LEVEL_ID','CA_DEPT_INFO','000','TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID));
end;

procedure TfrmDeptInfo.edtFAXESKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key=#13 then edtREMARK.SetFocus;
end;

procedure TfrmDeptInfo.SetDeptType; //设置部门DataSet
var
  Rs: TZQuery;
  vData: OleVariant;
  i,allCount: integer;
begin
  try
    //设置部门类型
    FDeptType:=TZQuery.Create(self);
    FDeptType.Close;
    Rs:=Global.GetZQueryFromName('PUB_PARAMS');
    if Rs<>nil then
    begin
      vData:=Rs.Data;
      if VarIsArray(vData) then
      begin
        FDeptType.Data:=vData;
        if (FDeptType.Active) and (FDeptType.RecordCount>0) then
        begin
          allCount:=FDeptType.RecordCount;
          for i:=allCount downto 1 do
          begin
            FDeptType.RecNo:=i;
            if trim(FDeptType.FieldByName('TYPE_CODE').AsString)<>'DEPT_TYPE' then  
              FDeptType.Delete; 
          end;
        end;
      end;
    end;
    edtDEPT_TYPE.DataSet:=FDeptType;
  finally
  end;
end;

end.
