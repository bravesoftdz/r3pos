unit ufrmDefineStateInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,RzButton,
  Grids, DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

  
type
  TfrmDefineStateInfo = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsStateInfo: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    cdsStateInfo: TZQuery;
    procedure btnExitClick(Sender: TObject);
    procedure cdsStateInfoBeforePost(DataSet: TDataSet);
    procedure cdsStateInfoAfterEdit(DataSet: TDataSet);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject; var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject; var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CtrlUpExecute(Sender: TObject);
    procedure CtrlDownExecute(Sender: TObject);
    procedure CtrlHomeExecute(Sender: TObject);
    procedure CtrlEndExecute(Sender: TObject);
  private
    FIsChange: Boolean;
    RunResult: Boolean;
    SrcQry: TZQuery;
    procedure CheckRightBeforeSave(var ChangeCount: Integer); //保存前检查数据
    procedure CheckSaveBeforeClose; //关闭前检查是否保存
    procedure DefineStateSort;
    procedure UpdateGlobal(CdsState: TDataSet);
  protected
    function CheckCanExport:boolean;
  public
    procedure Open;
    procedure Save;
    class function ShowDialog(Owner:TForm):boolean;
  end;

implementation

uses
  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math;

{$R *.dfm}

procedure TfrmDefineStateInfo.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDefineStateInfo.Open;
var
  Idx: integer;
  Param: TftParamList;
begin
  try
    cdsStateInfo.Close;
    Param := TftParamList.Create;
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsStateInfo,'TDefineStateInfo',Param);

    if CdsStateInfo.Active then
    begin
      //设置SEQ_NO
      Idx:=0;
      CdsStateInfo.DisableControls;
      CdsStateInfo.First;
      while not CdsStateInfo.Eof do
      begin
        if (CdsStateInfo.FieldByName('SEQ_NO').AsInteger>0) and (Idx<CdsStateInfo.FieldByName('SEQ_NO').AsInteger) then
          Idx:=CdsStateInfo.FieldByName('SEQ_NO').AsInteger;
        CdsStateInfo.Next;
      end;

      CdsStateInfo.First;
      while not CdsStateInfo.Eof do
      begin
        if CdsStateInfo.FieldByName('SEQ_NO').AsInteger=0 then
        begin
          inc(Idx);
          CdsStateInfo.Edit;
          CdsStateInfo.FieldByName('SEQ_NO').AsInteger:=Idx;
          CdsStateInfo.Post;
        end;
        CdsStateInfo.Next;
      end;    
      SrcQry.Close;
      SrcQry.Data:=CdsStateInfo.Data;
    end;
  finally
    CdsStateInfo.First;
    CdsStateInfo.EnableControls;
    Param.Free;
  end;
  CdsStateInfo.IndexFieldNames:='SEQ_NO';
end;

procedure TfrmDefineStateInfo.Save;
begin
  if CdsStateInfo.State in [dsInsert,dsEdit] then
    CdsStateInfo.Post;
  //保存前重新对序号重新编号
  DefineStateSort;

  if Factor.UpdateBatch(cdsStateInfo,'TDefineStateInfo',nil) then
  begin
    UpdateGlobal(cdsStateInfo);
    btnSave.Enabled:=false;
    RunResult:=true;
    Close;
  end;
end;

procedure TfrmDefineStateInfo.cdsStateInfoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and (cdsStateInfo.FieldByName('CODE_ID').AsString='') then
  begin
    exit;
  end;
end;

procedure TfrmDefineStateInfo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;
  GridDs: TDataSet;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not(gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color :=clAqua;
  end;

  GridDs:=DBGridEh1.DataSource.DataSet;
  if (Column.FieldName='USEFLAG') and (GridDs.FieldByName('CODE_ID').AsInteger<9) then
  begin
    DBGridEh1.Canvas.Brush.Color := clBtnFace;
    DBGridEh1.Canvas.Font.Color := clBtnFace;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)),length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmDefineStateInfo.cdsStateInfoAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmDefineStateInfo.ShowDialog(Owner: TForm): boolean;
begin
  result :=False;
  with TfrmDefineStateInfo.Create(Owner) do
  begin
    try
      Open;
      ShowModal;
      result:=RunResult;
    finally
      free;
    end;
  end;
end;      

procedure TfrmDefineStateInfo.DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
  end;
end;

function TfrmDefineStateInfo.CheckCanExport: boolean;
begin
  //Result := ShopGlobal.GetChkRight('32200001',6);
end;

procedure TfrmDefineStateInfo.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

procedure TfrmDefineStateInfo.FormCreate(Sender: TObject);
begin
  inherited;
  RunResult:=false;
  FIsChange:=False;
  SrcQry:=TZQuery.Create(self);
end;

procedure TfrmDefineStateInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if not cdsStateInfo.Active then Exit;
  try
    cdsStateInfo.DisableControls;
    if not (cdsStateInfo.State in [dsInsert,dsEdit]) then
      cdsStateInfo.Edit;
    case cdsStateInfo.FieldByName('CODE_ID').AsInteger of
     1..8:
      begin
        Value:=1;
        Text:='1';
        cdsStateInfo.FieldByName('USEFLAG').AsInteger:=1;
      end;
     9..20:
      begin
        cdsStateInfo.FieldByName('USEFLAG').AsInteger:=Value;
      end;
    end;
    cdsStateInfo.Post;
  finally
    cdsStateInfo.EnableControls;
    cdsStateInfo.Edit;
  end;
end;

procedure TfrmDefineStateInfo.CheckRightBeforeSave(var ChangeCount: Integer); //保存前检查数据
var
  NewUseFlag,OldUseFlag: integer;
  CodeID,CodeName: string;
begin
  ChangeCount:=0;
  if cdsStateInfo.State=dsEdit then cdsStateInfo.Post;
  //保存前判断是否修改过：
  try
    cdsStateInfo.DisableControls;
    cdsStateInfo.First;
    while not CdsStateInfo.Eof do
    begin
      CodeID:=cdsStateInfo.FieldByName('CODE_ID').AsString;
      NewUseFlag:=cdsStateInfo.FieldByName('USEFLAG').AsInteger;
      CodeName:=cdsStateInfo.FieldByName('CODE_NAME').AsString;
      if SrcQry.Locate('CODE_ID',CodeID,[]) then //启用标记
      begin
        OldUseFlag:=SrcQry.FieldByName('USEFLAG').AsInteger;
        if NewUseFlag<>OldUseFlag then //新标记 与 原标记不相等
        begin
          case NewUseFlag of
           0: inc(ChangeCount); //由 打勾 --> 空白
           1:
            begin
              if (CodeName<>SrcQry.FieldByName('CODE_NAME').AsString) or
                 (cdsStateInfo.FieldByName('SEQ_NO').AsInteger<>SrcQry.FieldByName('SEQ_NO').AsInteger) then
                inc(ChangeCount);  //由 空白 --> 打勾
            end;
          end;
        end else
        if NewUseFlag=OldUseFlag then //新标记 与 原标记相等
        begin
          if CodeName<>SrcQry.FieldByName('CODE_NAME').AsString then
          begin
            if strtoInt(CodeID)<9 then inc(ChangeCount)
            else
            begin
              if (NewUseFlag=1) or
                 (cdsStateInfo.FieldByName('SEQ_NO').AsInteger<>SrcQry.FieldByName('SEQ_NO').AsInteger) then
                inc(ChangeCount);
            end;
          end;
        end;
      end;
      if ChangeCount>0 then Break; //检测到改变数量>0则退出 
      CdsStateInfo.Next;
    end;
  finally
    cdsStateInfo.EnableControls;
  end;
end;

procedure TfrmDefineStateInfo.btnSaveClick(Sender: TObject);
// var ChangeCount: integer;
begin
  inherited;
  {
   CheckRightBeforeSave(ChangeCount); //保存前检查数据
  if (ChangeCount=0) and (not FIsChange) then
     Raise Exception.Create('系统检测没有修改指标，不需要保存！');
  }

  Save;
  FIsChange:=False;
end;

procedure TfrmDefineStateInfo.CheckSaveBeforeClose;
var
  i:integer;
begin
  inherited;
  if btnSave.Enabled=True  then
  begin
    CheckRightBeforeSave(i);
    if (i>0) or (FIsChange) then
    begin
      i:=MessageBox(Handle,Pchar('定义商品指标有修改，是否保存？'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
      case i of
       2: abort;
       6: Save;
      end;
    end;
  end;
end;

procedure TfrmDefineStateInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CheckSaveBeforeClose;
end;

procedure TfrmDefineStateInfo.CtrlUpExecute(Sender: TObject);
var
  SEQ_NO,SEQ_NO1: integer;
  CODE_ID,CODE_ID1:string;
begin
  inherited;
  if cdsStateInfo.IsEmpty then exit;
  if cdsStateInfo.RecordCount=1 then exit;
  if cdsStateInfo.RecNo=1 then exit;
  if cdsStateInfo.State in [dsEdit,dsInsert] then cdsStateInfo.Post;
 
  SEQ_NO:=cdsStateInfo.FieldByName('SEQ_NO').AsInteger;
  CODE_ID:=cdsStateInfo.FieldByName('CODE_ID').AsString;
  cdsStateInfo.Prior;
  SEQ_NO1:=cdsStateInfo.FieldByName('SEQ_NO').AsInteger;
  CODE_ID1:=cdsStateInfo.FieldByName('CODE_ID').AsString;
  if cdsStateInfo.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsStateInfo.Edit;
    cdsStateInfo.FieldByName('SEQ_NO').AsInteger:=SEQ_NO;
    cdsStateInfo.Post;
  end;
  if cdsStateInfo.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsStateInfo.Edit;
    cdsStateInfo.FieldByName('SEQ_NO').AsInteger:=SEQ_NO1;
    cdsStateInfo.Post;
  end;
  cdsStateInfo.indexfieldnames:='SEQ_NO';
  FIsChange:=true;  
end;

procedure TfrmDefineStateInfo.CtrlDownExecute(Sender: TObject);
var
  SEQ_NO,SEQ_NO1: integer;
  CODE_ID,CODE_ID1:string;
begin
  inherited;
  if cdsStateInfo.IsEmpty then exit;
  if cdsStateInfo.RecordCount=1 then exit;
  if cdsStateInfo.RecNo=cdsStateInfo.RecordCount then exit;
  if cdsStateInfo.State in [dsEdit,dsInsert] then cdsStateInfo.Post;
  SEQ_NO:=cdsStateInfo.FieldByName('SEQ_NO').AsInteger;
  CODE_ID:=cdsStateInfo.FieldByName('CODE_ID').AsString;
  cdsStateInfo.Next;
  SEQ_NO1:=cdsStateInfo.FieldByName('SEQ_NO').AsInteger;
  CODE_ID1:=cdsStateInfo.FieldByName('CODE_ID').AsString;
  if cdsStateInfo.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsStateInfo.Edit;
    cdsStateInfo.FieldByName('SEQ_NO').AsInteger:=SEQ_NO;
    cdsStateInfo.Post;
  end;
  if cdsStateInfo.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsStateInfo.Edit;
    cdsStateInfo.FieldByName('SEQ_NO').AsInteger:=SEQ_NO1;
    cdsStateInfo.Post;
  end;
  cdsStateInfo.indexfieldnames:='SEQ_NO';
  FIsChange:=true;  
end;

procedure TfrmDefineStateInfo.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsStateInfo.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmDefineStateInfo.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsStateInfo.RecNo<cdsStateInfo.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmDefineStateInfo.DefineStateSort;
var
  CodeID: string;
  Qry:TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.Data:=cdsStateInfo.Data;
    Qry.IndexFieldNames:='SEQ_NO';
    cdsStateInfo.DisableControls;
    cdsStateInfo.First;
    while not cdsStateInfo.Eof do
    begin
      CodeID:=cdsStateInfo.fieldbyname('CODE_ID').AsString;
      if Qry.Locate('CODE_ID',CodeID,[]) then
      begin
        cdsStateInfo.Edit;
        cdsStateInfo.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        cdsStateInfo.FieldByName('CODE_SPELL').AsString:=Fnstring.GetWordSpell(cdsStateInfo.FieldByName('CODE_NAME').AsString,3);
        cdsStateInfo.FieldByName('SEQ_NO').AsInteger:=Qry.RecNo+10; //变成两位数排序
        cdsStateInfo.Post;  
      end;
      cdsStateInfo.Next;
    end;
  finally
    cdsStateInfo.EnableControls;
    Qry.Free;
  end;
end;

procedure TfrmDefineStateInfo.UpdateGlobal(CdsState: TDataSet);
var
  CodeID: string;
  Rs: TZQuery;
begin
  Rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
  try
    Rs.IndexFieldNames:='SEQ_NO';
    cdsStateInfo.DisableControls;
    cdsStateInfo.First;
    while not cdsStateInfo.Eof do
    begin
      CodeID:=cdsStateInfo.fieldbyName('Code_ID').AsString;
      if cdsStateInfo.FieldByName('USEFLAG').AsInteger=1 then
      begin
        if Rs.Locate('CODE_ID',CodeID,[]) then
        begin
          Rs.Edit;
          Rs.FieldByName('CODE_NAME').AsString:=cdsStateInfo.fieldbyName('CODE_NAME').AsString;
          if Rs.FindField('SEQ_NO')<>nil then
            Rs.FindField('SEQ_NO').AsInteger:=cdsStateInfo.fieldbyName('SEQ_NO').AsInteger;
          Rs.Post;
        end else
        begin
          Rs.Append;
          Rs.FieldByName('CODE_ID').AsString:=cdsStateInfo.fieldbyName('CODE_ID').AsString;
          Rs.FieldByName('CODE_NAME').AsString:=cdsStateInfo.fieldbyName('CODE_NAME').AsString;
          if Rs.FindField('SEQ_NO')<>nil then
            Rs.FindField('SEQ_NO').AsInteger:=cdsStateInfo.fieldbyName('SEQ_NO').AsInteger;          
          Rs.Post;
        end;
      end else
      begin
        if Rs.Locate('CODE_ID',CodeID,[]) then
        begin
          Rs.Delete;
          Rs.Edit;
          Rs.Post;
        end;
      end;
      cdsStateInfo.Next;
    end;
  finally
    cdsStateInfo.EnableControls;
  end;
end;

end.
