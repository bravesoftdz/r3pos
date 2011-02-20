unit ufrmPrcCompList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, RzButton, DB, ADODB, zBase, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmPrcCompList = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    ShopList: TDataSource;
    BtnDel: TRzBitBtn;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure BtnDelClick(Sender: TObject);
  private
    Foid: string;
    CdsList: TDataSet;
    procedure Setoid(const Value: string);
    procedure AddNewShopInfo(CdsList: TDataSet; Aobj: TRecord_);
  public
    procedure Open(id:string);
    class function PrcCompList(Owner:TForm; CdsShopList: TDataSet; id:string; dbState:TDataSetState):boolean;
    property oid:string read Foid write Setoid;
  end;

implementation

uses uGlobal,uDsUtil, uShopGlobal,ObjCommon,uframeSelectCompany;

{$R *.dfm}

{ TfrmPrcCompList }

procedure TfrmPrcCompList.Open(id: string);
begin
 {
  cdsList.Close;
  cdList.SQL.Text :='select A.* from '+
    '(select SHOP_ID,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,SEQ_NO  from CA_SHOP_INFO where TENANT_ID=:TENANT_ID) A,'+
    '(select TENANT_ID,SHOP_ID from SAL_PROM_SHOP where TENANT_ID=:TENANT_ID and PROM_ID='''+id+''') B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID order by A.SEQ_NO ';
  Factor.Open(cdsList);
  }
end;

class function TfrmPrcCompList.PrcCompList(Owner:TForm; CdsShopList: TDataSet;
  id:string; dbState:TDataSetState): boolean;
begin
  with TfrmPrcCompList.Create(Owner) do
    begin
      try
        BtnDel.Enabled:=(dbState<>dsBrowse);
        BtnOk.Enabled:=(dbState<>dsBrowse);
        CdsList:=CdsShopList;
        ShopList.DataSet:=CdsList;
        //Open(id);
        oid := id;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmPrcCompList.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPrcCompList.FormCreate(Sender: TObject);
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
  Column := FindColumn('TENANT_ID');
  Column.PickList.Clear;
  Column.KeyList.Clear;
  Column.KeyList.Add(InttoStr(Global.TENANT_ID));
  Column.PickList.Add(Global.TENANT_NAME);
  //门店上级是 企业
 {tmp := Global.GetZQueryFromName('CA_COMPANY');
  tmp.First;
  while not tmp.Eof do
  begin
    Column.KeyList.Add(tmp.Fields[0].asstring);
    Column.PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end; }

  tmp := Global.GetZQueryFromName('PUB_REGION_INFO');
  Column := FindColumn('REGION_ID');
  Column.PickList.Clear;
  Column.KeyList.Clear;
  tmp.First;
  while not tmp.Eof do
  begin
    Column.KeyList.Add(tmp.Fields[0].asstring);
    Column.PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;

  //判断权限，
//  btnOk.Enabled:=ShopGlobal.GetChkRight('500014');
//  RzBitBtn1.Enabled:=btnOk.Enabled;
end;

procedure TfrmPrcCompList.btnOkClick(Sender: TObject);
var
  i:integer;
  curID: string;
  rs:TRecordList;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('500014') then Raise Exception.Create('只有拥有促销单添加权限才能添加门店,请和管理员联系.');
  rs := TRecordList.Create;
  try
    if TframeSelectCompany.PrcCompList(self,true,rs) then
    begin
      for i:=0 to rs.Count -1 do
      begin
        curID:=trim(rs.Records[i].fieldbyName('SHOP_ID').AsString);
        if not CdsList.Locate('SHOP_ID',curID,[]) then   //还没加入直接加入
        begin
          AddNewShopInfo(CdsList, rs.Records[i]);  //
        end;
      end;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmPrcCompList.Setoid(const Value: string);
begin
  Foid := Value;
end;

procedure TfrmPrcCompList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if cdsList.IsEmpty then Exit;
  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmPrcCompList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = 'SEQ_NO') then
     Background := clBtnFace;

end;

procedure TfrmPrcCompList.BtnDelClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('500015') then Raise Exception.Create('只有拥有促销单编辑权限才能删除门店,请和管理员联系.');
  if cdsList.IsEmpty then Exit;
  if MessageBox(Handle,pchar('是否删除'+cdsList.FieldbyName('SHOP_NAME').AsString),'友情提示...',MB_OK+MB_ICONQUESTION)<>6 then Exit;
  cdsList.Delete;  
end;

procedure TfrmPrcCompList.AddNewShopInfo(CdsList: TDataSet; Aobj: TRecord_);
begin
  CdsList.Append;
  CdsList.FieldByName('ROWS_ID').AsString:=TSequence.NewId(); //单号码
  CdsList.FieldByName('SHOP_ID').AsString:=Aobj.fieldbyName('SHOP_ID').AsString; //门号店
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

end.
