unit ufrmImplementionTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, cxTextEdit, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, ZDataset,
  zrComboBoxList, RzButton, DB, ZAbstractRODataset, ZAbstractDataset;

type
  TfrmImplementionTool = class(TframeToolForm)
    Panel2: TPanel;
    Label21: TLabel;
    Label12: TLabel;
    btnOk: TRzBitBtn;
    edtREGION_ID: TzrComboBoxList;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    Grid: TDBGridEh;
    edtKey: TcxTextEdit;
    cdsTenant: TDataSource;
    dsTenant: TZQuery;
    Label2: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    actUnlock: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actUnlockExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function EncodeSql:String;
  end;


implementation
uses uGlobal, uShopGlobal, ufrmBasic, ufrmPwdViewer, ufrmResetTimeStamp;
{$R *.dfm}

procedure TfrmImplementionTool.FormCreate(Sender: TObject);
begin
  inherited;
  edtREGION_ID.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
end;

procedure TfrmImplementionTool.actFindExecute(Sender: TObject);
begin
  inherited;
  dsTenant.DisableControls;
  try
    dsTenant.SQL.Text := EncodeSql;
    Factor.Open(dsTenant);
  finally
    dsTenant.EnableControls;
  end;
end;

function TfrmImplementionTool.EncodeSql: String;
var rs:TZQuery;
    Wh_Str,Wh_Str1:String;
begin
  rs := TZQuery.Create(nil);
  Wh_Str := '';
  try
    rs.SQL.Text := 'select LEVEL_ID from CA_RELATIONS where TENANT_ID='+IntToStr(Global.TENANT_ID);
    Factor.Open(rs);
    if rs.IsEmpty then
      Wh_Str := 'LEVEL_ID = ''000000'' '
    else
    begin
      rs.First;
      while not rs.Eof do
        begin
          if Wh_Str = '' then
            Wh_Str := ' LEVEL_ID like '''+rs.FieldbyName('LEVEL_ID').AsString+'%'' '
          else
            Wh_Str := Wh_Str + ' or LEVEL_ID like '''+rs.FieldbyName('LEVEL_ID').AsString+'%'' ';
          rs.Next;
        end;
    end;
    if edtREGION_ID.AsString <> '' then
      Wh_Str1 := ' and REGION_ID='+QuotedStr(edtREGION_ID.AsString);
    if Trim(edtKey.Text) <> '' then
      Wh_Str1 := Wh_Str1 + ' and (TENANT_NAME like ''%'+Trim(edtKey.Text)+'%'' or TENANT_SPELL like ''%'+Trim(edtKey.Text)+'%'' or '+
                 ' LOGIN_NAME like ''%'+Trim(edtKey.Text)+'%'' or LICENSE_CODE like ''%'+Trim(edtKey.Text)+'%'' )';
    Result := ' select TENANT_ID,LOGIN_NAME,LICENSE_CODE,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,HOMEPAGE,'+
              'ADDRESS,QQ,MSN,POSTALCODE,REMARK,REGION_ID,SRVR_ID,AUDIT_STATUS,PROD_ID,DB_ID,CREA_DATE from CA_TENANT where TENANT_ID in ( '+
              ' select RELATI_ID from CA_RELATIONS where RELATION_STATUS = ''2'' and COMM not in (''02'',''12'') and (' + Wh_Str + ') ) ' + Wh_Str1;
    Result := ' select ja.*,a.CODE_NAME as TENANT_TYPE_NAME from (' + Result + ')ja left join PUB_PARAMS a on ja.TENANT_TYPE=a.CODE_ID where a.TYPE_CODE = ''TENANT_TYPE'' ';
    Result := ' select jb.*,b.CODE_NAME as REGION_ID_NAME from (' + Result + ')jb left join PUB_CODE_INFO b on jb.REGION_ID=b.CODE_ID ';
  finally
    rs.Free;
  end;
end;

procedure TfrmImplementionTool.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = Grid.CellRect(Grid.Col, Grid.Row).Top) and (not
    (gdFocused in State) or not Grid.Focused) then
  begin
    Grid.Canvas.Brush.Color := clAqua;
  end;
  
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      Grid.canvas.FillRect(ARect);
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(dsTenant.RecNo)),length(Inttostr(dsTenant.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmImplementionTool.actUnlockExecute(Sender: TObject);
var ExeSql:String;
begin
  inherited;
  if dsTenant.IsEmpty then Exit;
  if MessageBox(Handle,'是否确认对当前企业进行解锁？','友情提示...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  ExeSql := 'update SYS_DEFINE set VALUE='''' where TENANT_ID='+dsTenant.FieldbyName('TENANT_ID').AsString+' and DEFINE like ''DBKEY_%'' ';
  if Factor.ExecSQL(ExeSql) = 0 then
    MessageBox(Handle,pchar('当前企业没有锁定!'),pchar('友情提示...'),MB_OK+MB_ICONINFORMATION)
  else
    MessageBox(Handle,pchar('当前企业已经解锁!'),pchar('友情提示...'),MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmImplementionTool.actInfoExecute(Sender: TObject);
begin
  inherited;
  TfrmPwdViewer.FindDialog(Self,IntToStr(Global.TENANT_ID));
end;

procedure TfrmImplementionTool.actEditExecute(Sender: TObject);
begin
  inherited;
  if dsTenant.IsEmpty then Exit;
  if TfrmResetTimeStamp.ShowDialog(Self,dsTenant.FieldbyName('TENANT_ID').AsString) then
     MessageBox(Handle,pchar('当前企业所选"资料档案"时间戳重置成功!'),pchar('友情提示...'),MB_OK+MB_ICONINFORMATION);

end;

end.
