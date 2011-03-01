unit ufrmCheckTaskDelete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, zDataSet;

type
  TfrmCheckTaskDelete = class(TfrmBasic)
    RzBitBtn5: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    CB_Delete: TCheckBox;
    procedure RzBitBtn5Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    FcDate: TDate;
    FSHOP_ID: string;
    procedure SetcDate(const Value: TDate);
    function  GetSHOP_ID: string;
    procedure SetSHOP_ID(const Value: string);
  public
    procedure Prepare;
    class function DeleteTask(vcid:string=''):boolean;
    property cDate:TDate read FcDate write SetcDate;
    property SHOP_ID:string read GetSHOP_ID write SetSHOP_ID;
  end;

implementation

uses
  uFnUtil, uGlobal, uShopGlobal;

{$R *.dfm}

procedure TfrmCheckTaskDelete.RzBitBtn5Click(Sender: TObject);
var
  Temp: TZQuery;
  B,Cnd:string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('600038') then Raise Exception.Create('你没有撤消盘点的权限,请和管理员联系.');
  Temp := TZQuery.Create(nil);
  try
    Temp.SQL.Text :='select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and  SHOP_ID=:SHOP_ID ';
    if Temp.Params.ParamByName('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if Temp.Params.ParamByName('SHOP_ID')<>nil then Temp.ParamByName('SHOP_ID').AsString:=SHOP_ID;
    Factor.Open(Temp);
    if Temp.Fields[0].AsString = '' then
    begin
      Temp.close;
      Temp.SQL.Text:= 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE ';
      if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
      if Temp.Params.FindParam('DEFINE')<>nil then Temp.ParamByName('DEFINE').AsString:='USING_DATE';
      Factor.Open(Temp);
      if Temp.IsEmpty then
        B := FormatDatetime('YYYY-MM-DD',Date()-1)
      else
        B := FormatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(Temp.Fields[0].AsString)-1);
      if not (formatDatetime('YYYY-MM-DD',date())>B) then Raise Exception.Create('系统已经结帐到'+b+'号，不能再删除了');
    end else
    begin
      B := Temp.Fields[0].AsString;
      if not (formatDatetime('YYYY-MM-DD',date())>B) then Raise Exception.Create('系统检测到'+b+'号小于当前日期，不能再删除了');
    end;
    
    if not CB_Delete.Checked then
    begin
      temp.close;
      temp.SQL.Text:= 'select count(*) as Resum from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_ID='''+formatDatetime('YYYYMMDD',cDate)+'''';
      if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
      if Temp.Params.ParamByName('SHOP_ID')<>nil then Temp.ParamByName('SHOP_ID').AsString:=SHOP_ID;
      Factor.Open(temp);
      if temp.Fields[0].AsInteger >0 then Raise Exception.Create('已经盘点录入了，不能再撤消盘点了...');
    end;
  finally
    Temp.Free;
  end;

  if MessageBox(Handle,pchar('确认删除'+formatdatetime('YYYY-MM-DD',cDate)+'的盘点任务及所有录入的盘点单？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  Factor.BeginTrans(1800);
  try
    B:=trim(formatDatetime('YYYYMMDD',cDate));
    Cnd:=' where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' and PRINT_ID='+B+' ';
    Factor.ExecSQL('delete from STO_PRINTORDER '+Cnd);
    Factor.ExecSQL('delete from STO_PRINTDATA '+Cnd);
    Factor.ExecSQL('delete from STO_CHECKDATA '+Cnd);
    Factor.CommitTrans;
  except
    Factor.RollbackTrans;
    Raise;
  end;
  ModalResult := MROK;
end;

class function TfrmCheckTaskDelete.DeleteTask(vcid:string=''): boolean;
begin
  with TfrmCheckTaskDelete.Create(Application.MainForm) do
    begin
      try
        FSHOP_ID := vcid;
        Prepare;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmCheckTaskDelete.Prepare;
var
  s:string;
  rs: TZQuery;
begin
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:='select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHECK_STATUS<3';
    if rs.Params.ParamByName('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.ParamByName('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=SHOP_ID;
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
    begin
      cDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
      RzLabel1.Caption := format('盘点日期:%s',[formatDatetime('YYYY-MM-DD',cDate)]);
    end else
    begin
      cDate := date();
      RzBitBtn5.Enabled := false;
      RzBitBtn5.Caption := '无任务...';
      RzLabel1.Caption := format('盘点日期:%s',['没有未完成的任务']);
    end;
  finally
    rs.free;
  end;
end;

procedure TfrmCheckTaskDelete.SetcDate(const Value: TDate);
begin
  FcDate := Value;
end;

procedure TfrmCheckTaskDelete.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmCheckTaskDelete.GetSHOP_ID: string;
begin
  if trim(FSHOP_ID)<>'' then
    result:=FSHOP_ID
  else
    result:=Global.SHOP_ID;
end;

procedure TfrmCheckTaskDelete.SetSHOP_ID(const Value: string);
begin
  FSHOP_ID := Value;
end;

end.
