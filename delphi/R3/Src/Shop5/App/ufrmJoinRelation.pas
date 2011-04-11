unit ufrmJoinRelation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, Grids,
  DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmJoinRelation = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    DBGridEh1: TDBGridEh;
    edtKey: TcxTextEdit;
    btnFilter: TRzBitBtn;
    Label8: TLabel;
    Cds_Relation: TZQuery;
    Ds_Telation: TDataSource;
    procedure btnCloseClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open;
    class function AddDialog(Owner:TForm):Boolean;
  end;

implementation
uses uGlobal, uShopGlobal, ufrmBasic, uCaFactory, ObjCommon;
{$R *.dfm}

{ TfrmJoinRelation }

class function TfrmJoinRelation.AddDialog(Owner: TForm): Boolean;
begin
  with TfrmJoinRelation.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmJoinRelation.Open;
var StrWhere:String;
begin
  if Trim(edtKey.Text) <> '' then
    StrWhere := ' and TENANT_ID='+IntToStr(Global.TENANT_ID);
  Cds_Relation.SQL.Text := 'select RELATION_ID,RELATION_NAME,TENANT_ID,RELATION_SPELL from CA_RELATION where COMM not in (''02'',''12'') '+StrWhere;
  Factor.Open(Cds_Relation);  
end;

procedure TfrmJoinRelation.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmJoinRelation.btnFilterClick(Sender: TObject);
var
  List:TList;
  i:integer;
begin
  inherited;
  if not ShopGlobal.GetChkRight('32700001',2) then Raise Exception.Create('你没有申请'+Caption+'的权限,请和管理员联系.');
  List := TList.Create;
  try
    if trim(edtKey.Text)=inttostr(Global.TENANT_ID) then Raise Exception.Create('不能申请自已创建的供应链...');
    CaFactory.queryServiceLines(StrtoInt(trim(edtKey.Text)),List);
    Cds_Relation.CreateDataSet;
    for i:=0 to List.Count-1 do
      begin
        cds_Relation.Append;
        cds_Relation.FieldByName('TENANT_ID').AsInteger := PServiceLine(List[i])^.TENANT_ID;
        cds_Relation.FieldByName('RELATION_ID').AsInteger := PServiceLine(List[i])^.RELATION_ID;
        cds_Relation.FieldByName('RELATION_NAME').AsString := PServiceLine(List[i])^.RELATION_NAME;
        cds_Relation.FieldByName('RELATION_SPELL').AsString := PServiceLine(List[i])^.RELATION_SPELL;
        cds_Relation.FieldByName('REMARK').AsString := PServiceLine(List[i])^.REMARK;
        cds_Relation.Post;
      end;
    if cds_Relation.IsEmpty then Raise Exception.Create('没找到可申请的供应链...');
  finally
    List.Free;
  end;
end;

procedure TfrmJoinRelation.btnOkClick(Sender: TObject);
var
  RelationInfo:TRelationInfo;
  r:integer;
begin
  inherited;
  if Cds_Relation.IsEmpty then Raise Exception.Create('请选择要加盟的供应链...');
  RelationInfo := CaFactory.applyRelation(
   StrtoInt(trim(edtKey.Text)),Cds_Relation.FieldbyName('RELATION_ID').AsInteger,Global.TENANT_ID,2
   );
  //需要加保存数据 并开始同步这条供应链上的所有信息
  r := Factor.ExecSQL('update CA_RELATIONS set RELATION_ID='+inttostr(RelationInfo.RELATION_ID)+',RELATION_TYPE='''+RelationInfo.RELATION_TYPE+''',LEVEL_ID='''+RelationInfo.LEVEL_ID+''',RELATION_STATUS='''+RelationInfo.RELATION_STATUS+''',CREA_DATE='''+RelationInfo.CREA_DATE+''',CHK_DATE='''+RelationInfo.CHK_DATE+''',RELATI_ID='+inttostr(RelationInfo.RELATI_ID)+',TENANT_ID='+inttostr(RelationInfo.TENANT_ID)+',COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where RELATIONS_ID='''+RelationInfo.RELATIONS_ID+'''');
  if r=0 then
     Factor.ExecSQL(
     'insert into CA_RELATIONS(RELATION_ID,RELATIONS_ID,RELATI_ID,TENANT_ID,RELATION_TYPE,LEVEL_ID,RELATION_STATUS,CREA_DATE,CHK_DATE,COMM,TIME_STAMP) '+
     'values('+inttostr(RelationInfo.RELATION_ID)+','''+RelationInfo.RELATIONS_ID+''','+inttostr(RelationInfo.RELATI_ID)+','+inttostr(RelationInfo.TENANT_ID)+','''+RelationInfo.RELATION_TYPE+''','''+RelationInfo.LEVEL_ID+''','''+RelationInfo.RELATION_STATUS+''','''+RelationInfo.CREA_DATE+''','''+RelationInfo.CHK_DATE+''',''00'','+GetTimeStamp(Factor.iDbType)+')');
  if MessageBox(Application.Handle,pchar('  是否立即下载供应链？  '),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
  begin
    CaFactory.SyncAll(2);
    ModalResult := MROK;
  end
end;

procedure TfrmJoinRelation.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

end.
