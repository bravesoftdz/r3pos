unit ufrmDbOkDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, RzButton, cxButtonEdit,
  zrComboBoxList, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmDbOkDialog = class(TfrmBasic)
    Label1: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    edtPLAN_DATE: TcxDateEdit;
    edtSTOCK_USER: TzrComboBoxList;
    btnOk: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function DBOkDialog(Owner:TForm;var OkDate:TDate;var OkUser:string):boolean;
  end;

implementation
uses uDsUtil,uGlobal;
{$R *.dfm}

{ TfrmDbOkDialog }

class function TfrmDbOkDialog.DBOkDialog(Owner: TForm; var OkDate: TDate;
  var OkUser: string): boolean;
begin
  with TfrmDbOkDialog.Create(Owner) do
    begin
      try
        edtPLAN_DATE.Date := OkDate;
        edtSTOCK_USER.KeyValue := OkUser;
        edtSTOCK_USER.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',OkUser);
        if edtSTOCK_USER.AsString = '' then
           begin
             edtSTOCK_USER.KeyValue := Global.UserID;
             edtSTOCK_USER.Text := Global.UserName;
           end;
        if edtPLAN_DATE.EditValue = null then edtPLAN_DATE.Date := Date();
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmDbOkDialog.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDbOkDialog.btnOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := MROK;
end;

end.
 