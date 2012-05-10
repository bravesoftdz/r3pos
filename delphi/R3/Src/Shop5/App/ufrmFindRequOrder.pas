unit ufrmFindRequOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, RzButton, cxTextEdit, cxControls, ObjCommon,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls,
  RzLabel, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmFindRequOrder = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    Label1: TLabel;
    RzLabel4: TRzLabel;
    Label40: TLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    fndGLIDE_NO: TcxTextEdit;
    btnFind: TRzBitBtn;
    fndCLIENT_ID: TzrComboBoxList;
    fndSHOP_ID: TzrComboBoxList;
    DBGridEh1: TDBGridEh;
    cdsList: TZQuery;
    dsList: TDataSource;
    btnOK: TRzBitBtn;
    btnExit: TRzBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    Fflag: integer;
    procedure Setflag(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    class function FindDialog(AOwner:TForm;cid:string;var RText,UId,UText:String):string;
    property flag:integer read Fflag write Setflag;
  end;

implementation
uses uGlobal,uShopUtil, uShopGlobal;
{$R *.dfm}

{ TfrmFindRequOrder }

function TfrmFindRequOrder.EncodeSQL(id: string): string;
var w,w1,JoinStr:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.REQU_TYPE=''1'' and A.REQU_DATE>=:D1 and A.REQU_DATE<=:D2 and A.CHK_DATE is not null ';
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if trim(fndGLIDE_NO.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndGLIDE_NO.Text)+'''';

  if id<>'' then
     w := w +' and A.REQU_ID>'''+id+'''';

  result := 'select A.REQU_ID,B.SHOP_NAME as SHOP_ID_TEXT,C.DEPT_NAME as DEPT_ID_TEXT,A.REQU_TYPE,A.GLIDE_NO,'+
  'A.REQU_DATE,A.CLIENT_ID,D.CLIENT_NAME as CLIENT_ID_TEXT,A.REQU_USER,E.USER_NAME as REQU_USER_TEXT,A.BUDG_MNY,A.REMARK '+
  ' from MKT_REQUORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.REQU_USER=E.USER_ID '+w+ShopGlobal.GetDataRight('A.SHOP_ID',1)+ShopGlobal.GetDataRight('A.DEPT_ID',2)+' ';

  Result := ParseSQL(Factor.iDbType,Result);
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by REQU_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by REQU_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by REQU_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by REQU_ID limit 600';
  else
    result := 'select * from ('+result+') j order by REQU_ID';
  end;
end;

class function TfrmFindRequOrder.FindDialog(AOwner: TForm; cid: string;var RText,UId,UText:String): string;
begin
  with TfrmFindRequOrder.Create(AOwner) do
    begin
      try
        if cid<>'' then
           begin
             if fndCLIENT_ID.DataSet.Locate('CLIENT_ID',cid,[]) then
                begin
                  fndCLIENT_ID.KeyValue := cid;
                  fndCLIENT_ID.Text := fndCLIENT_ID.DataSet.FieldbyName('CLIENT_NAME').AsString;
                end;
           end;
        Open('');
        if ShowModal=MROK then
        begin
           result := cdsList.FieldbyName('REQU_ID').AsString;
           RText :=cdsList.FieldbyName('GLIDE_NO').AsString;
           UId := cdsList.FieldbyName('REQU_USER').AsString;
           UText := cdsList.FieldbyName('REQU_USER_TEXT').AsString;
        end
        else
           result := '';
      finally
        free;
      end;
    end;
end;

procedure TfrmFindRequOrder.Open(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('REQU_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsList.LoadFromStream(sm);  
       cdsList.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmFindRequOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then
     begin
       Raise Exception.Create('没有选中你要查询的单据...');
     end;
  self.ModalResult := MROK;
end;

procedure TfrmFindRequOrder.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFindRequOrder.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  D1.Date := date();
  D2.Date := date();
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '所属仓库';
    end;
end;

procedure TfrmFindRequOrder.btnFindClick(Sender: TObject);
begin
  inherited;
  Open('');
  DBGridEh1.SetFocus;
end;

procedure TfrmFindRequOrder.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  btnOKClick(nil);
end;

procedure TfrmFindRequOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmFindRequOrder.Setflag(const Value: integer);
begin
  Fflag := Value;
end;

end.
