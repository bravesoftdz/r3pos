unit ufrmFieldSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  RzButton;

type
  TfrmFieldSort = class(TframeDialogForm)
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsFieldSort: TDataSource;
    PopupMenu1: TPopupMenu;
    cdsFieldSort: TZQuery;
    DBGridEh1: TDBGridEh;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    CtrUp: TAction;
    CtrDown: TAction;
    CtrHome: TAction;
    CtrEnd: TAction;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure CtrUpExecute(Sender: TObject);
    procedure CtrDownExecute(Sender: TObject);
    procedure CtrHomeExecute(Sender: TObject);
    procedure CtrEndExecute(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function ShowSort(Owner:TForm;var Field_Id,Field_Name:String):Boolean;
  end;

implementation

{$R *.dfm}

procedure TfrmFieldSort.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

class function TfrmFieldSort.ShowSort(Owner:TForm;var Field_Id,
  Field_Name: String): Boolean;
var VId,VName:TStringList;
    Sort_Id,Sort_Name:String;
    i:Integer;
begin
  with TfrmFieldSort.Create(Owner) do
    begin
      try
        VId := TStringList.Create;
        VName := TStringList.Create;
        try
          VId.CommaText := Field_Id;
          VName.CommaText := Field_Name;
          cdsFieldSort.Close;
          cdsFieldSort.CreateDataSet;
          cdsFieldSort.DisableControls;
          for i := 0 to VId.Count - 1 do
            begin
              cdsFieldSort.Append;
              cdsFieldSort.FieldByName('SEQ_NO').AsString := IntToStr(i+1);
              cdsFieldSort.FieldByName('CODE_ID').AsString := VId[i];
              cdsFieldSort.FieldByName('CODE_NAME').AsString := VName[i];
              cdsFieldSort.Post;
            end;
        finally
          cdsFieldSort.First;
          cdsFieldSort.EnableControls;
          VId.Free;
          VName.Free;
        end;
        Result := (ShowModal = mrOk);
        if Result then
          begin
            cdsFieldSort.First;
            while not cdsFieldSort.Eof do
              begin
                if Sort_Id = '' then
                  Sort_Id := cdsFieldSort.FieldByName('CODE_ID').AsString
                else
                  Sort_Id := Sort_Id + ',' + cdsFieldSort.FieldByName('CODE_ID').AsString;
                if Sort_Name = '' then
                  Sort_Name := cdsFieldSort.FieldByName('CODE_NAME').AsString
                else
                  Sort_Name := Sort_Name + ',' +  cdsFieldSort.FieldByName('CODE_NAME').AsString;
                cdsFieldSort.Next;
              end;
            Field_Id := Sort_Id;
            Field_Name := Sort_Name;
          end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmFieldSort.CtrUpExecute(Sender: TObject);
var SEQ_NO,SEQ_NO1,CODE_ID,CODE_ID1,CODE_NAME,CODE_NAME1:String;
begin
  inherited;
  if cdsFieldSort.IsEmpty then Exit;
  if cdsFieldSort.RecordCount = 1 then Exit;
  if cdsFieldSort.RecNo = 1 then Exit;
  if cdsFieldSort.State in [dsEdit,dsInsert] then cdsFieldSort.Post;
  SEQ_NO := cdsFieldSort.FieldByName('SEQ_NO').AsString;
  CODE_ID := cdsFieldSort.FieldByName('CODE_ID').AsString;
  CODE_NAME := cdsFieldSort.FieldByName('CODE_NAME').AsString;
  cdsFieldSort.Prior;
  SEQ_NO1 := cdsFieldSort.FieldByName('SEQ_NO').AsString;
  CODE_ID1 := cdsFieldSort.FieldByName('CODE_ID').AsString;
  CODE_NAME1 := cdsFieldSort.FieldByName('CODE_NAME').AsString;
  if cdsFieldSort.Locate('SEQ_NO',SEQ_NO,[]) then
    begin
      cdsFieldSort.Edit;
      cdsFieldSort.FieldByName('CODE_ID').AsString := CODE_ID1;
      cdsFieldSort.FieldByName('CODE_NAME').AsString := CODE_NAME1;
      cdsFieldSort.Post;
    end;
  if cdsFieldSort.Locate('SEQ_NO',SEQ_NO1,[]) then
    begin
      cdsFieldSort.Edit;
      cdsFieldSort.FieldByName('CODE_ID').AsString := CODE_ID;
      cdsFieldSort.FieldByName('CODE_NAME').AsString := CODE_NAME;
      cdsFieldSort.Post;
    end;
  cdsFieldSort.IndexFieldNames := 'SEQ_NO';
end;

procedure TfrmFieldSort.CtrDownExecute(Sender: TObject);
var SEQ_NO,SEQ_NO1,CODE_ID,CODE_ID1,CODE_NAME,CODE_NAME1:String;
begin
  inherited;
  if cdsFieldSort.IsEmpty then Exit;
  if cdsFieldSort.RecordCount = 1 then Exit;
  if cdsFieldSort.RecNo = cdsFieldSort.RecordCount then Exit;
  if cdsFieldSort.State in [dsEdit,dsInsert] then cdsFieldSort.Post;
  SEQ_NO := cdsFieldSort.FieldByName('SEQ_NO').AsString;
  CODE_ID := cdsFieldSort.FieldByName('CODE_ID').AsString;
  CODE_NAME := cdsFieldSort.FieldByName('CODE_NAME').AsString;
  cdsFieldSort.Next;
  SEQ_NO1 := cdsFieldSort.FieldByName('SEQ_NO').AsString;
  CODE_ID1 := cdsFieldSort.FieldByName('CODE_ID').AsString;
  CODE_NAME1 := cdsFieldSort.FieldByName('CODE_NAME').AsString;
  if cdsFieldSort.Locate('SEQ_NO',SEQ_NO,[]) then
    begin
      cdsFieldSort.Edit;
      cdsFieldSort.FieldByName('CODE_ID').AsString := CODE_ID1;
      cdsFieldSort.FieldByName('CODE_NAME').AsString := CODE_NAME1;
      cdsFieldSort.Post;
    end;
  if cdsFieldSort.Locate('SEQ_NO',SEQ_NO1,[]) then
    begin
      cdsFieldSort.Edit;
      cdsFieldSort.FieldByName('CODE_ID').AsString := CODE_ID;
      cdsFieldSort.FieldByName('CODE_NAME').AsString := CODE_NAME;
      cdsFieldSort.Post;
    end;
  cdsFieldSort.IndexFieldNames := 'SEQ_NO';
end;

procedure TfrmFieldSort.CtrHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsFieldSort.RecNo > 1 do
    CtrUpExecute(Sender);
end;

procedure TfrmFieldSort.CtrEndExecute(Sender: TObject);
begin
  inherited;
  while cdsFieldSort.RecordCount > cdsFieldSort.RecNo do
    CtrDownExecute(Sender);
end;

procedure TfrmFieldSort.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFieldSort.btnSaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

end.
