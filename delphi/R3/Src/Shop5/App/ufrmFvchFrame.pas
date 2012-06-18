unit ufrmFvchFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ObjCommon,
  ZDataset;

type
  TfrmFvchFrame = class(TframeDialogForm)
    btnClose: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    CdsFrame: TZQuery;
    DsFrame: TDataSource;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    function EncodeSql:String;
  public
    { Public declarations }
    procedure Open;
    class function ShowFvchFrame:Boolean;
  end;

implementation
uses ufrmBasic, uGlobal, uShopGlobal, ufrmFvchFrameInfo;

{$R *.dfm}

procedure TfrmFvchFrame.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(CdsFrame.RecNo)),length(Inttostr(CdsFrame.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'EDIT_INFO' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(DBGridEh1.Canvas.Font);
      try
        DBGridEh1.canvas.FillRect(ARect);
        DBGridEh1.Canvas.Font.Color := clBlue;
        DBGridEh1.Canvas.Font.Style := [fsUnderline];
        DrawText(DBGridEh1.Canvas.Handle,pchar('编辑'),length('编辑'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER);
      finally
        DBGridEh1.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
end;

function TfrmFvchFrame.EncodeSql: String;
var sql:String;
begin
  sql := 'select 0 as SEQ_NO,A.CODE_ID,A.CODE_NAME as FVCH_GTYPE_NAME,case when isnull(B.SUM_FVCH_GTYPE,0) > 0 then 1 else 0 end as SUM_FVCH_GTYPE '+
         ' from PUB_PARAMS A left join (select FVCH_GTYPE,count(SEQNO) as SUM_FVCH_GTYPE from ACC_FVCHFRAME where TENANT_ID=:TENANT_ID group by FVCH_GTYPE) B '+
         ' on A.CODE_ID = B.FVCH_GTYPE where A.TYPE_CODE=''BILL_NAME'' order by A.CODE_ID ';
  Result := sql;
end;

procedure TfrmFvchFrame.Open;
begin
  CdsFrame.Close;
  CdsFrame.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql);
  CdsFrame.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(CdsFrame);
end;

procedure TfrmFvchFrame.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName = 'EDIT_INFO' then
  begin
     if not ShopGlobal.GetChkRight('100002404',1) then Raise Exception.Create('你没有查询的权限,请和管理员联系.');
     with TfrmFvchFrameInfo.Create(Self) do
     begin
        try
          FVCH_GTYPE := CdsFrame.FieldByName('CODE_ID').AsString;
          if ShowModal = mrOk then
          begin
             CdsFrame.Edit;
             if cdsFvchFrame.RecordCount > 0 then
                CdsFrame.FieldByName('SUM_FVCH_GTYPE').AsInteger := 1
             else
                CdsFrame.FieldByName('SUM_FVCH_GTYPE').AsInteger := 0;
             CdsFrame.Post;
          end;
        finally
          Free;
        end;
     end;
     DBGridEh1.Col := 0;  
  end;
end;

procedure TfrmFvchFrame.FormShow(Sender: TObject);
begin
  inherited;
  Open;
end;

class function TfrmFvchFrame.ShowFvchFrame: Boolean;
begin
  with TfrmFvchFrame.Create(Application.MainForm) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmFvchFrame.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
