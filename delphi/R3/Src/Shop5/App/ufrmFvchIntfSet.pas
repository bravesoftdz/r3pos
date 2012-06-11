unit ufrmFvchIntfSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,RzButton,
  Grids, DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, RzLabel, DBGrids;

type
  TfrmFvchIntfSet = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsPriceLv: TDataSource;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    cdsPriceLv: TZQuery;
    CtrlAdd: TAction;
    CtrlDel: TAction;
    RzPanel1: TRzPanel;
    lblTypeName: TLabel;
    RzLabel23: TRzLabel;
    edtIntf_TYPE: TcxComboBox;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject;Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnExitClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsPriceLvAfterEdit(DataSet: TDataSet);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLVL_TYPEPropertiesEditValueChanged(Sender: TObject);
    procedure edtLVL_TYPEPropertiesChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
  private
    procedure SetdbState(const Value: TDataSetState);
    function CheckCanExport:boolean;
    procedure SetUpdateState();
    procedure SetBrowseState();
  public
    PriceObj: TRecord_;
    procedure Open;
    function  Save: boolean;
    class function ShowDialog(Owner:TForm):boolean;
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math,TypInfo,ObjCommon,ObjFvchIntfSet;
{$R *.dfm}

procedure TfrmFvchIntfSet.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmFvchIntfSet.Open;
var
  SQL: String;
begin
  inherited;
  try
     {
    SQL:='Select 1 as vTYPE,TENANT_ID,SHOP_ID,SHOP_NAME as CNAME,SUBJECT_NO From CA_SHOP_INFO where COMM not in (''02'',''12'')';
    SQL:=ParseSQL(Factor.iDbType,SQL); //函数匹配转换

    cdsPriceLv.Close;
    cdsPriceLv.SQL.Text:=SQL;
    Factor.Open(cdsPriceLv);
    }


  finally
  end;
end;




procedure TfrmFvchIntfSet.FormShow(Sender: TObject);
begin
  inherited;
  //Open; //打开数据
  btnSave.Enabled:=False;
  DBGridEh1.SetFocus;

  edtIntf_TYPE.ItemIndex:=0;
end;

procedure TfrmFvchIntfSet.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if ((Column.FieldName = 'SEQ_NO') and (cdsPriceLv.RecNo<>0)) then
    begin
      ARect := Rect;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsPriceLv.RecNo)),length(Inttostr(cdsPriceLv.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmFvchIntfSet.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
    Background := clBtnFace;
end;

procedure TfrmFvchIntfSet.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin
  inherited;
  if dbstate=dsEdit then
  begin
    i:=MessageBox(Handle,Pchar('接口代码有修改,是否要保存吗?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;
end;

procedure TfrmFvchIntfSet.cdsPriceLvAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;



procedure TfrmFvchIntfSet.DBGridEh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

class function TfrmFvchIntfSet.ShowDialog(Owner: TForm): boolean;
begin
  with TfrmFvchIntfSet.Create(Owner) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmFvchIntfSet.SetdbState(const Value: TDataSetState);
begin
   inherited;
end;

function TfrmFvchIntfSet.CheckCanExport: boolean;
begin
  //默认不设权限
  result:=true;
end;
 

procedure TfrmFvchIntfSet.SetUpdateState;
begin
  if dbstate=dsBrowse then
  begin
    dbstate:=dsEdit;
    btnSave.Enabled:=True;
  end;  
end;

procedure TfrmFvchIntfSet.SetBrowseState;
begin
  dbstate:=dsBrowse;
  btnSave.Enabled:=False;
end;

procedure TfrmFvchIntfSet.edtLVL_TYPEPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  SetUpdateState;
end;

procedure TfrmFvchIntfSet.edtLVL_TYPEPropertiesChange(Sender: TObject);
var
  SQL: String;
  Params:TftParamList;
  FindCol: TColumnEh;
begin
  inherited;
  FindCol:=self.FindDBColumn(self.DBGridEh1,'CNAME');
  if FindCol<>nil then
  begin
    case edtIntf_TYPE.ItemIndex  of
     0: FindCol.Title.Caption:='门店名称';
     1: FindCol.Title.Caption:='部门名称';
     2: FindCol.Title.Caption:='人员名称';
     3: FindCol.Title.Caption:='往来单位';
     4: FindCol.Title.Caption:='专项名称';
    end;
  end;
  if edtIntf_TYPE.ItemIndex<>4 then
     begin
      FindCol.ReadOnly:=True;
     end
  else
    begin
      FindCol.ReadOnly:=False;
    end;
  try
    Params:=TftParamList.Create(nil);
    Params.ParamByName('vType').AsInteger:=edtIntf_TYPE.ItemIndex;
    Params.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Factor.Open(cdsPriceLv,'TFvchIntfSet',Params); 
  finally
    Params.Free;
  end;

end;



function TfrmFvchIntfSet.Save: boolean;
begin
  result:=False;
  if cdsPriceLv.State<>dsEdit then cdsPriceLv.Edit;
  cdsPriceLv.Post;
  result:=Factor.UpdateBatch(cdsPriceLv,'TFvchIntfSet',nil);
end;

procedure TfrmFvchIntfSet.btnSaveClick(Sender: TObject);
begin
  inherited;
    if not cdsPriceLv.Active then Raise Exception.Create('没有数据！');
    if cdsPriceLv.IsEmpty then Raise Exception.Create('没有数据！');
    Save;
    ModalResult:=mrOk;
end;

procedure TfrmFvchIntfSet.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if cdsPriceLv.State<>dsEdit then cdsPriceLv.Edit;
  cdsPriceLv.Post;
  cdsPriceLv.Edit;
end;

end.
