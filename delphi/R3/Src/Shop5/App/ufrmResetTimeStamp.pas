unit ufrmResetTimeStamp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzPanel, RzButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxCheckBox, StdCtrls, RzLabel;

type
  TfrmResetTimeStamp = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    edtPUB_GOODS_RELATION: TcxCheckBox;
    edtPUB_GOODSINFO: TcxCheckBox;
    edtCA_RELATIONS: TcxCheckBox;
    edtCA_TENANT: TcxCheckBox;
    edtCA_USERS: TcxCheckBox;
    RzLabel1: TRzLabel;
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
  private
    { Private declarations }
    Tenant_Id:String;
  public
    { Public declarations }
    procedure ExecuteTimeStamp;
    class function ShowDialog(Owner:TForm;TenantId:String):Boolean;
  end;


implementation
uses ObjCommon;
{$R *.dfm}

{ TfrmResetTimeStamp }

class function TfrmResetTimeStamp.ShowDialog(Owner: TForm;
  TenantId: String): Boolean;
begin
  with TfrmResetTimeStamp.Create(Owner) do
  begin
    try
      Tenant_Id := TenantId;
      if ShowModal = mrOk then
         Result := True
      else
         Result := False;
    finally
      Free;
    end;
  end;
end;

procedure TfrmResetTimeStamp.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmResetTimeStamp.ExecuteTimeStamp;
var i:Integer;
    Time_Stamp,Sql:String;
begin
  try
    Time_Stamp := GetTimeStamp(Factor.iDbType);
    Screen.Cursor := crSQLWait;
    Factor.BeginTrans();
    for i := 0 to ComponentCount-1 do
    begin
      if Components[i] is TcxCheckBox then
      begin
        if TcxCheckBox(Components[i]).Checked then
        begin
          Sql := 'update '+copy(Components[i].Name,4,50)+' set TIME_STAMP='+Time_Stamp+' where TENANT_ID='+Tenant_Id;
          Factor.ExecSQL(Sql);
        end;
      end;
    end;
    Factor.CommitTrans;
    Screen.Cursor := crDefault;
  except
    Factor.RollbackTrans;
    Screen.Cursor := crDefault;
    raise Exception.Create('所选"资料档案"时间戳重置失败！');
  end;
end;

procedure TfrmResetTimeStamp.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  ExecuteTimeStamp;
  ModalResult := mrOk;
end;

end.
