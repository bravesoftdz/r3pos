unit uframeFindDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, RzTabs, ExtCtrls, RzPanel,
  Grids, DBGridEh, DB, ADODB;

type
  TframeFindDialog = class(TfrmBasic)
    bgPanel: TRzPanel;
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel2: TRzPanel;
    btPanel: TRzPanel;
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    cdsFind: TADODataSet;
    DataSource1: TDataSource;
    cdsFindFieldName: TStringField;
    cdsFindFileTitle: TStringField;
    cdsFindFieldValue: TStringField;
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowFields(s:string);
    function Encode:string;
    class function FindDialog(Owner:TForm;Fields:string;_DataSet:TDataSet):boolean;
  end;
function MyFindNext(_DataSet:TDataSet):boolean;
implementation
var
  DataSet:TDataSet;
  W:string;
function MyFindNext(_DataSet:TDataSet):boolean;
var
  row,i:integer;
  vList:TStringList;
  v:boolean;
begin
  result := false;
  if DataSet<>_DataSet then Exit;
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  DataSet.DisableControls;
  vList := TStringList.Create;
  try
    row := DataSet.RecNo;
    while true do
      begin
        DataSet.Next;
        if DataSet.Eof then
           begin
             if row>1 then DataSet.First;
           end;
        v := true;
        for i:=0 to vList.Count -1 do
          begin
            v :=v and (DataSet.FieldByName(vList.Names[i]).AsString = DataSet.FieldByName(vList.ValueFromIndex[i]).AsString);
          end;
        result := v;
        if result then Exit;
        if (DataSet.RecNo=(row-1)) then Exit;
      end;
  finally
    vList.Free;
    DataSet.EnableControls;
  end;
end;
{$R *.dfm}   
procedure TframeFindDialog.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.Index <0 then Background := clBtnFace;
end;

function TframeFindDialog.Encode: string;
begin
  result := '';
  cdsFind.First;
  while not cdsFind.Eof do
    begin
      if trim(cdsFind.FieldByName('FieldValue').AsString) <> '' then
         begin
           if result <> '' then result := result + ',';
           result := cdsFind.FieldbyName('FieldName').AsString+'="'+trim(cdsFind.FieldByName('FieldValue').AsString)+'"';
         end;
      cdsFind.Next;
    end;
end;

class function TframeFindDialog.FindDialog(Owner: TForm; Fields: string;
  _DataSet: TDataSet): boolean;
begin
  with TframeFindDialog.Create(Owner) do
    begin
      try
        ShowFields(Fields);
        DataSet := _DataSet;
        w := '';
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TframeFindDialog.ShowFields(s: string);
var
  List:TStringList;
  i:integer;
begin
  List := TStringList.Create;
  try
    List.CommaText := s;
    cdsFind.CreateDataSet;
    for i:=0 to List.Count -1 do
      begin
        cdsFind.Append;
        cdsFind.FieldByName('FieldName').AsString := List.Names[i];
        cdsFind.FieldByName('FieldTitle').AsString := List.ValueFromIndex[i];
        cdsFind.Post;
      end;
  finally
    List.Free;
  end;
end;

procedure TframeFindDialog.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeFindDialog.btnOkClick(Sender: TObject);
begin
  inherited;
  w := Encode;
  if w='' then Raise Exception.Create('请输入查找条件');
  if not MyFindNext(DataSet) then Raise Exception.Create('没找符合条件的记录'); 
  ModalResult := MROK; 
end;

end.
