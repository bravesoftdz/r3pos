unit ufrmCodeScan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, DB, ZDataSet;

type
  TfrmCodeScan = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    RzPanel5: TRzPanel;
    lblInput: TRzLabel;
    shoplbl: TLabel;
    licenselbl: TLabel;
    godslbl: TLabel;
    apricelbl: TLabel;
    timelbl: TLabel;
    RzPanel4: TRzPanel;
    Cancel: TRzBmpButton;
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    barcode_input_line: TImage;
    edtInput: TcxTextEdit;
    procedure CancelClick(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
  public
    procedure CodeScan(code: string);
    class function ShowDialog(Owner:TForm):boolean;
  end;

implementation

uses udllGlobal,EncDec;

{$R *.dfm}

procedure TfrmCodeScan.CancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCodeScan.CodeScan(code: string);
var
  List:TStringList;
  GodsId,LinkMan,LicenseCode,BarCode,Aprice,PrintTime,GodsName:string;
  bs,gs:TZQuery;
begin
  List:=TStringList.Create;
  try
    List.Delimiter := '|';
    List.DelimitedText := code;
    if List.Count <> 5 then
      begin
        edtInput.Text := '';
        if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
        Raise Exception.Create('二维码格式不合法！');
      end;
    LinkMan := List[0];
    LicenseCode := List[1];
    BarCode := List[2];
    Aprice := List[3];
    PrintTime := List[4];

    bs := TZQuery.Create(nil);
    try
      bs.SQL.Text := 'select GODS_ID,UNIT_ID,PROPERTY_01,PROPERTY_02,BATCH_NO from PUB_BARCODE where TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+') and BARCODE=:BARCODE and COMM not in (''02'',''12'')';
      bs.ParamByName('BARCODE').AsString := BarCode;
      dllGlobal.OpenSqlite(bs);
      if not bs.IsEmpty then
         GodsId := trim(bs.FieldByName('GODS_ID').AsString);
    finally
      bs.Free;
    end;

    gs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    if GodsId <> '' then
      begin
        if gs.Locate('GODS_ID',GodsId,[]) then
          begin
            GodsName := gs.FieldByName('GODS_NAME').AsString;
          end
        else
          begin
            GodsName := '未知商品';
          end;
      end
    else
      begin
        GodsName := '未知商品';
      end;
  finally
    List.Free;
  end;
  shoplbl.Caption := '店主:'+DecStr(LinkMan,ENC_KEY);
  licenselbl.Caption := '许可证号:'+LicenseCode;
  godslbl.Caption := '卷烟:'+GodsName;
  apricelbl.Caption := '价格:'+Aprice+'元';
  timelbl.Caption := '时间:'+Copy(PrintTime,1,4)+'年'+Copy(PrintTime,5,2)+'月'+Copy(PrintTime,7,2)+'日'
                            +Copy(PrintTime,9,2)+'点'+Copy(PrintTime,11,2)+'分';
  shoplbl.Visible := true;
  licenselbl.Visible := true;
  godslbl.Visible := true;
  apricelbl.Visible := true;
  timelbl.Visible := true;
end;

procedure TfrmCodeScan.edtInputKeyPress(Sender: TObject; var Key: Char);
var s:string;
begin
  inherited;
  if Key=#13 then
    begin
      s := trim(edtInput.Text);
      if s <> '' then
        begin
          CodeScan(s);
          edtInput.Text := '';
        end;
    end;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

class function TfrmCodeScan.ShowDialog(Owner: TForm): boolean;
begin
  with TfrmCodeScan.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
