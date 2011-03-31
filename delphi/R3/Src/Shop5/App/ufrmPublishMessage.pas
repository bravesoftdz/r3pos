unit ufrmPublishMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, RzButton, DB, zBase, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmPublishMessage = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    ShopList: TDataSource;
    cdsShop: TZQuery;
    N1: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnOkClick(Sender: TObject);
  private
    MSG_ID:String;
    procedure AddNewShopInfo(CdsList: TDataSet; Aobj: TRecord_);
  public
    procedure Open;
    class function PrcCompList(Owner:TForm; ID: String):boolean;
  end;

implementation

uses uGlobal,uDsUtil, uShopGlobal,ObjCommon,uframeSelectCompany, ufrmBasic;

{$R *.dfm}

{ TfrmPublishMessage }
class function TfrmPublishMessage.PrcCompList(Owner:TForm; ID:String): boolean;
begin
  with TfrmPublishMessage.Create(Owner) do
    begin
      try
        MSG_ID := ID;
        Open;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmPublishMessage.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPublishMessage.FormCreate(Sender: TObject);
function FindColumn(FieldName:string):TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if DBGridEh1.Columns[i].FieldName = FieldName then
         begin
           result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;
var
  tmp: TZQuery;
  Column:TColumnEh;
begin
  //门店所属企业:
  Column := FindColumn('TENANT_ID');
  if Column<>nil then
  begin
    Column.PickList.Clear;
    Column.KeyList.Clear;
    Column.KeyList.Add(InttoStr(Global.TENANT_ID));
    Column.PickList.Add(Global.TENANT_NAME);
  end;
  //门店类型:
  Column := FindColumn('SHOP_TYPE');
  tmp := Global.GetZQueryFromName('PUB_SHOP_TYPE');
  if (Column<>nil) and (tmp<>nil) then
  begin
    Column.PickList.Clear;
    Column.KeyList.Clear;
    tmp.First;
    while not tmp.Eof do
    begin
      Column.KeyList.Add(tmp.fieldbyName('CODE_ID').AsString);
      Column.PickList.Add(tmp.fieldbyName('CODE_NAME').AsString);  
      tmp.Next;
    end;
  end;

  tmp := Global.GetZQueryFromName('PUB_REGION_INFO');
  Column := FindColumn('REGION_ID');
  if (Column<>nil) and (tmp<>nil) and (tmp.Active) and (not tmp.IsEmpty) then
  begin
    Column.PickList.Clear;
    Column.KeyList.Clear;
    tmp.First;
    while not tmp.Eof do
    begin
      Column.KeyList.Add(tmp.Fields[0].asstring);
      Column.PickList.Add(tmp.Fields[1].asstring);
      tmp.Next;
    end;
  end;
  //判断权限，
//  btnOk.Enabled:=ShopGlobal.GetChkRight('500014');
//  RzBitBtn1.Enabled:=btnOk.Enabled;
end;

procedure TfrmPublishMessage.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if cdsShop.IsEmpty then Exit;
  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsShop.RecNo)),length(Inttostr(cdsShop.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmPublishMessage.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = 'SEQ_NO') then
     Background := clBtnFace;

end;

procedure TfrmPublishMessage.AddNewShopInfo(CdsList: TDataSet; Aobj: TRecord_);
begin
  CdsList.Append;
  CdsList.FieldByName('MSG_ID').AsString:= MSG_ID;
  CdsList.FieldByName('SHOP_ID').AsString:=Aobj.fieldbyName('SHOP_ID').AsString; //门号店
  CdsList.FieldByName('TENANT_ID').AsString:=Aobj.fieldbyName('TENANT_ID').AsString;
  CdsList.FieldByName('SHOP_NAME').AsString:=Aobj.FieldByName('SHOP_NAME').AsString;
  CdsList.FieldByName('SHOP_SPELL').AsString:=Aobj.FieldByName('SHOP_SPELL').AsString;
  CdsList.FieldByName('SHOP_TYPE').AsString:=Aobj.FieldByName('SHOP_TYPE').AsString;
  CdsList.FieldByName('REGION_ID').AsString:=Aobj.FieldByName('REGION_ID').AsString;
  CdsList.FieldByName('LINKMAN').AsString:=Aobj.FieldByName('LINKMAN').AsString;
  CdsList.FieldByName('TELEPHONE').AsString:=Aobj.FieldByName('TELEPHONE').AsString;
  CdsList.FieldByName('FAXES').AsString:=Aobj.FieldByName('ADDRESS').AsString;
  CdsList.FieldByName('POSTALCODE').AsString:=Aobj.FieldByName('POSTALCODE').AsString;
  CdsList.FieldByName('REMARK').AsString:=Aobj.FieldByName('REMARK').AsString;
  CdsList.FieldByName('SEQ_NO').AsString:=Aobj.FieldByName('SEQ_NO').AsString;
  CdsList.Post;
end;

procedure TfrmPublishMessage.Open;
begin
  cdsShop.SQL.Text :=
  'select a.TENANT_ID,a.MSG_ID,b.SHOP_ID,b.SHOP_NAME,b.SHOP_SPELL,b.SHOP_TYPE,b.REGION_ID,b.LINKMAN,b.TELEPHONE,b.FAXES,'+
  'b.POSTALCODE,b.REMARK,b.SEQ_NO from MSC_MESSAGE_LIST a left join CA_SHOP_INFO b on a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID='+InttoStr(Global.TENANT_ID)+' and a.MSG_ID='+QuotedStr(MSG_ID);
  Factor.Open(cdsShop);

end;

procedure TfrmPublishMessage.btnOkClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('500015') then Raise Exception.Create('只有拥有促销单编辑权限才能删除门店,请和管理员联系.');
  if cdsShop.IsEmpty then Exit;
  if MessageBox(Handle,pchar('是否删除'+cdsShop.FieldbyName('SHOP_NAME').AsString),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsShop.Delete;

  try
    Factor.UpdateBatch(cdsShop,'TPublishMessage');
  Except
    Raise Exception.Create('修改失败!');
  end;
end;

end.
