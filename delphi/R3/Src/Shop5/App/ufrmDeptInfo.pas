unit ufrmDeptInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxMemo, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls,DB,ZDataset,zBase, DBClient,
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtDEPT_NAMEPropertiesChange(Sender: TObject);
    procedure edtUPDEPT_IDBeforeDropList(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    UpIDParams: TftParamList;
    function  GetLevelID: string;
    function  IsEdit(Aobj:TRecord_; cdsTable: TZQuery):Boolean; virtual; //判断是Aobj对象与与数据集Value是否改变
    procedure CheckDEPTNameIsExists;  //判断职务是否存在
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
uses uShopUtil,uDsUtil,uFnUtil, uGlobal,uXDictFactory, uShopGlobal;
{$R *.dfm}

{ TfrmDeptInfo }

procedure TfrmDeptInfo.Append;
var
  zQry: TZQuery;
begin
  Open('');
  dbState:=dsInsert;
  edtDEPT_ID.Text:=TSequence.GetMaxID(InttoStr(ShopGlobal.TENANT_ID),Factor,'DEPT_ID','CA_DEPT_INFO','0000',' TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID)+' ');
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
      edtUPDEPT_ID.Text:=TdsFind.GetNameByID(zQry,'LEVEL_ID','DEPT_NAME',CurID)
    else
      edtUPDEPT_ID.Text:='';
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
    Raise Exception.Create('职务名称不能为空！'); 
  end;
  if trim(edtDEPT_SPELL.Text)='' then
  begin
    if not edtDEPT_SPELL.CanFocus then edtDEPT_SPELL.SetFocus;
    Raise Exception.Create('拼音码不能为空！');
  end;

  CheckDEPTNameIsExists; //判断职务是否存在

  WriteTo(Aobj);  //写入Obj记录对象
  Aobj.FieldByName('LEVEL_ID').AsString:=GetLevelID; 
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
  UpIDParams:=TftParamList.Create(nil); //创建选择上级部门的参数对象
  UpIDParams.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID; 
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmDeptInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  UpIDParams.Free;  //释放上级部门的参数对象
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
    if DEPT_ID<>'' then
    begin
      UpIDParams.ParamByName('DEPT_ID').AsString:=DEPT_ID;
      Cnd:=Cnd+' and (DEPT_ID<>:DEPT_ID) ';
    end;
    
    Level_ID:=trim(cdsTable.fieldbyName('LEVEL_ID').AsString);
    if Level_ID<>'' then
    begin
      UpIDParams.ParamByName('LEVEL_ID').AsString:=DEPT_ID;
      PosIdx:=Length(Level_ID);
      case Factor.iDbType of
       0: Cnd:=Cnd+' and not(substring(LEVEL_ID,1,'+InttoStr(PosIdx)+')=:LEVEL_ID) ';
       5: Cnd:=Cnd+' and not(substr(LEVEL_ID,1,'+InttoStr(PosIdx)+')=:LEVEL_ID) ';
      end;
    end;
  end;
  drpDept.Close;
  drpDept.SQL.Text:='select DEPT_NAME,DEPT_ID,DEPT_SPELL,LEVEL_ID from CA_DEPT_INFO '+
                    ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Cnd;
  drpDept.Params.AssignValues(UpIDParams);  //读取参数值 
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
  dsInsert:Caption:='职务档案--(新增)';
  dsEdit:Caption:='职务档案--(修改)';
  else
    begin
      Caption:='职务档案';
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
    i:=MessageBox(Handle,'职务档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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
end;

class function TfrmDeptInfo.EditDialog(Owner: TForm; id: string; var _AObj: TRecord_): boolean;
begin
  //新R3内ShopGlobal没有此方法:
  //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能修改职务!');
  if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改职务的权限,请和管理员联系.');
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
   //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能新增职务!');
  if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增职务的权限,请和管理员联系.');
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
  tmp: TZQuery;
begin
  if edtDEPT_NAME.Text<>cdsTable.FieldByName('DEPT_NAME').AsString  then
  begin
    if dbState=dsEdit then
    begin
      tmp:=Global.GetZQueryFromName('CA_DEPT_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if (tmp.FieldByName('DEPT_NAME').AsString=edtDEPT_NAME.Text) and (tmp.FieldByName('DEPT_ID').AsString<>cdsTable.FieldByName('DEPT_ID').AsString) then
        begin
          if edtDEPT_NAME.CanFocus then  edtDEPT_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:职务名称已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
    if dbState=dsInsert then
    begin
      tmp:=Global.GetZQueryFromName('CA_DEPT_INFO');
      tmp.Filtered:=False;
      tmp.First;
      while not tmp.Eof do
      begin
        if tmp.FieldByName('DEPT_NAME').AsString=edtDEPT_NAME.Text then
        begin
          if edtDEPT_NAME.CanFocus then edtDEPT_NAME.SetFocus;
          MessageBox(handle,Pchar('提示:职务名称已经存在!'),Pchar(Caption),MB_OK);
        end;
        tmp.Next;
      end;
    end;
  end;
end;

function TfrmDeptInfo.GetLevelID: string;
var
  ZQry:TZQuery; 
  CurID: string;
begin
  if trim(edtUPDEPT_ID.Text)='' then
    Result:=TSequence.GetMaxID('', Factor,'LEVEL_ID','CA_DEPT_INFO','000','TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID))
  else
  begin
    if edtUPDEPT_ID.DataSet.Active then
      CurID:=trim(edtUPDEPT_ID.DataSet.FieldbyName('LEVEL_ID').AsString)
    else
    begin
      CurID:=trim(edtUPDEPT_ID.AsString);
      ZQry:=ShopGlobal.GetZQueryFromName('CA_DEPT_INFO');
      if (ZQry<>nil) and (ZQry.Active) then
      begin
        if ZQry.Locate('DEPT_ID',CurID,[]) then
         CurID:=trim(ZQry.FieldbyName('LEVEL_ID').AsString)
        else
         CurID:='';
      end;  
    end;
    Result:=TSequence.GetMaxID(CurID, Factor,'LEVEL_ID','CA_DEPT_INFO','000','TENANT_ID='+InttoStr(ShopGlobal.TENANT_ID));
  end;
end;

end.
