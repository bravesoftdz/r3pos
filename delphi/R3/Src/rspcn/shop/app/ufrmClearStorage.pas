unit ufrmClearStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxCheckBox, ZBase, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DB;

type
  TfrmClearStorage = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    Cancel: TRzBmpButton;
    Save: TRzBmpButton;
    chkContinue: TcxCheckBox;
    edtBK_INDUSTRY_TYPE: TRzPanel;
    RzPanel81: TRzPanel;
    RzLabel50: TRzLabel;
    sortDrop: TcxButtonEdit;
    procedure SaveClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkContinuePropertiesChange(Sender: TObject);
    procedure RzLabel4Click(Sender: TObject);
    procedure sortDropExit(Sender: TObject);
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FSortId:string;
  public
    class function ShowDialog(AOwner:TForm;var SObj:TRecord_):boolean;
  end;

implementation

uses ufrmSortDropFrom;

{$R *.dfm}

class function TfrmClearStorage.ShowDialog(AOwner: TForm;var SObj:TRecord_): boolean;
begin
  with TfrmClearStorage.Create(AOwner) do
    begin
      try
        result := (ShowModal = MROK);
        if result then SObj.AddField('SORT_ID',FSortId,ftString);
      finally
        Free;
      end;
    end;
end;

procedure TfrmClearStorage.SaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := MROK;
end;

procedure TfrmClearStorage.CancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClearStorage.FormShow(Sender: TObject);
begin
  inherited;
  chkContinue.Checked := false;
  Save.Enabled := false;
end;

procedure TfrmClearStorage.chkContinuePropertiesChange(Sender: TObject);
begin
  inherited;
  if chkContinue.Checked then
     Save.Enabled := true
  else
     Save.Enabled := false;
end;

procedure TfrmClearStorage.RzLabel4Click(Sender: TObject);
begin
  inherited;
  if chkContinue.Checked then
     chkContinue.Checked := false
  else
     chkContinue.Checked := true;
end;

procedure TfrmClearStorage.sortDropExit(Sender: TObject);
begin
  inherited;
  if trim(sortDrop.Text)='' then
     begin
       FSortId := '';
       sortDrop.Text := '全部分类';
     end;
end;

procedure TfrmClearStorage.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    frmSortDropFrom.SelectRootOrLeaf := true;
    if frmSortDropFrom.DropForm(sortDrop,Obj) then
    begin
      if Obj.Count>0 then
         begin
            FSortId := Obj.FieldbyName('SORT_ID').AsString;
            sortDrop.Text := Obj.FieldbyName('SORT_NAME').AsString;
         end
      else
         begin
            FSortId := '';
            sortDrop.Text := '全部分类';
         end;
    end;
  finally
    Obj.Free;
  end;
end;

end.
