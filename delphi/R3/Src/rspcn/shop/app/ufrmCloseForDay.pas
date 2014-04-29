unit ufrmCloseForDay;

interface

uses
  Windows, SysUtils, Variants, Forms, ufrmWebDialog, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, ExtCtrls, cxDropDownEdit, Grids,
  DBGridEh, cxTextEdit, pngimage, cxCheckBox, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxSpinEdit, RzStatus, RzBckgnd, RzTabs, RzBmpBtn,
  RzForms, RzLabel, Graphics, Controls, Classes, RzPanel, ZBase;

type
  TfrmCloseForDay = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzBackground1: TRzBackground;
    RzLabel2: TRzLabel;
    TabSheet2: TRzTabSheet;
    RzBackground2: TRzBackground;
    TabSheet3: TRzTabSheet;
    RzBackground3: TRzBackground;
    RzPanel4: TRzPanel;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzBackground6: TRzBackground;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzPanel8: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    DBGridEh2: TDBGridEh;
    cdsDropColumn: TcxComboBox;
    TabSheet6: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel12: TRzLabel;
    DBGridEh3: TDBGridEh;
    RzStatus1: TRzStatusPane;
    RzStatus2: TRzStatusPane;
    RzPanel12: TRzPanel;
    RzPanel5: TRzPanel;
    RzLabel8: TRzLabel;
    edtNum: TcxSpinEdit;
    chkHeader: TcxCheckBox;
    RzPanel7: TRzPanel;
    RzStatus: TRzStatusPane;
    Image4: TImage;
    RzLabel7: TRzLabel;
    RzPanel70: TRzPanel;
    RzPanel71: TRzPanel;
    RzBackground33: TRzBackground;
    RzLabel41: TRzLabel;
    edtFileName: TcxTextEdit;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    RzLabel17: TRzLabel;
    RzPanel14: TRzPanel;
    Image6: TImage;
    RzLabel11: TRzLabel;
    RzPanel11: TRzPanel;
    fndCLSE_DATE: TcxTextEdit;
    RzPanel13: TRzPanel;
    lblCASH: TLabel;
    Bevel1: TBevel;
    edtPAY_A: TcxTextEdit;
    edtPAY_B: TcxTextEdit;
    edtPAY_C: TcxTextEdit;
    edtPAY_D: TcxTextEdit;
    edtPAY_E: TcxTextEdit;
    edtPAY_F: TcxTextEdit;
    edtPAY_G: TcxTextEdit;
    edtPAY_H: TcxTextEdit;
    edtPAY_I: TcxTextEdit;
    edtPAY_J: TcxTextEdit;
    edtPrintTicket: TCheckBox;
    RzPanel15: TRzPanel;
    lblCaption: TRzLabel;
    RzLable1: TRzLabel;
    labPAY_A: TRzLabel;
    labPAY_B: TRzLabel;
    labPAY_C: TRzLabel;
    labPAY_D: TRzLabel;
    labPAY_E: TRzLabel;
    labPAY_F: TRzLabel;
    labPAY_G: TRzLabel;
    labPAY_H: TRzLabel;
    RzLabel22: TRzLabel;
    RzLabel23: TRzLabel;
    labPAY_I: TRzLabel;
    labPAY_J: TRzLabel;
    cdsTable: TZQuery;
    RzLabel26: TRzLabel;
    btnCloseDay: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzLabel13: TRzLabel;
    fndCREA_USER: TcxTextEdit;
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseDayClick(Sender: TObject);
    procedure RzPanel13Resize(Sender: TObject);
  private
    FPrintDate: TDate;
    procedure SetPrintDate(const Value: TDate);
  public
    PrintFlag: integer;
    Is_Print: Boolean;
    MainRecord: TRecord_;
    function  reckDate:TDate;
    procedure GetCloseForDay;
    function  CheckStatus:boolean;
    procedure CheckOffData; //检查是否有离线数据，必须上传后才能结账
    procedure Open;
    procedure Save;
    procedure InitForm;
    procedure ShowFee;
    class function ShowClDy(Owner:TForm):Integer;
    property PrintDate:TDate read FPrintDate write SetPrintDate;
  end;

implementation

uses uTokenFactory,udllGlobal,udataFactory,uFnUtil,uDsUtil,uDevFactory,
     uSyncFactory,ufrmSyncData;

{$R *.dfm}

procedure TfrmCloseForDay.btnCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmCloseForDay.CheckOffData;
begin

end;

function TfrmCloseForDay.CheckStatus: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CLSE_DATE from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE=:CLSE_DATE';
    rs.Params.ParamByName('TENANT_ID').AsInteger := StrToIntDef(token.tenantId,0);
    rs.Params.ParamByName('SHOP_ID').asString := token.shopId;
    rs.Params.ParamByName('CLSE_DATE').AsInteger := StrtoInt(FormatDatetime('YYYYMMDD',reckDate));
    dataFactory.Open(rs);
    result := not rs.IsEmpty;
  finally
    rs.free;
  end;
end;

procedure TfrmCloseForDay.InitForm;
var rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  rs.First;
  while not rs.Eof do
    begin
      if rs.FieldByName('CODE_ID').AsString = 'A' then
         begin
           labPAY_A.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_A.Caption) <= 4 then labPAY_A.Caption := labPAY_A.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'B' then
         begin
           labPAY_B.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_B.Caption) <= 4 then labPAY_B.Caption := labPAY_B.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'C' then
         begin
           labPAY_C.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_C.Caption) <= 4 then labPAY_C.Caption := labPAY_C.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'D' then
         begin
           labPAY_D.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_D.Caption) <= 4 then labPAY_D.Caption := labPAY_D.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'E' then
         begin
           labPAY_E.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_E.Caption) <= 4 then labPAY_E.Caption := labPAY_E.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'F' then
         begin
           labPAY_F.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_F.Caption) <= 4 then labPAY_F.Caption := labPAY_F.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'G' then
         begin
           labPAY_G.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_G.Caption) <= 4 then labPAY_G.Caption := labPAY_G.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'H' then
         begin
           labPAY_H.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_H.Caption) <= 4 then labPAY_H.Caption := labPAY_H.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'I' then
         begin
           labPAY_I.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_I.Caption) <= 4 then labPAY_I.Caption := labPAY_I.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'J' then
         begin
           labPAY_J.Caption := rs.FieldByName('CODE_NAME').AsString;
           if Length(labPAY_J.Caption) <= 4 then labPAY_J.Caption := labPAY_J.Caption + '支付';
         end;
      rs.Next;
    end;
end;

procedure TfrmCloseForDay.Open;
var
  rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    Is_Print := cdsTable.Locate('CLSE_DATE;CLSE_TYPE',VarArrayOf([StrtoInt(FormatDateTime('YYYYMMDD',reckDate)),'1']),[]);
    if Is_Print then
       MainRecord.ReadFromDataSet(cdsTable)
    else
       MainRecord.ReadField(cdsTable);
    ShowFee;
    lblCASH.Caption :='当日现金:'+formatFloat('#0.0#',StrToFloatDef(edtPAY_A.Text,0.00));
  finally
    rs.Free;
  end;
end;

function TfrmCloseForDay.reckDate: TDate;
begin
  if PrintFlag = 0 then
     result := dllGlobal.sysDate
  else
     result := PrintDate;
end;

procedure TfrmCloseForDay.Save;
var
  sv: TZQuery;
  AObj: TRecord_;
begin
  AObj := TRecord_.Create;
  sv := TZQuery.Create(nil);
  try
    sv.FieldDefs.Assign(cdsTable.FieldDefs);
    sv.CreateDataSet;
    if not cdsTable.IsEmpty then
       begin
         sv.Append;
         AObj.ReadFromDataSet(cdsTable);
         AObj.WriteToDataSet(sv,false);
         sv.Post;
       end;
    if not sv.Locate('CLSE_DATE',StrtoInt(FormatDatetime('YYYYMMDD',reckDate)),[]) then //如果当前没有数据补结0记录
       begin
         sv.Append;
         sv.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
         sv.FieldByName('CLSE_DATE').AsInteger := StrtoInt(FormatDatetime('YYYYMMDD',reckDate));
         sv.FieldByName('SHOP_ID').AsString := token.shopId;
         sv.FieldbyName('CREA_USER').AsString := token.userId;
         sv.FieldbyName('CLSE_MNY').AsFloat := 0;
         sv.FieldbyName('CLSE_TYPE').AsString := '1';
         sv.FieldbyName('PAY_A').AsFloat := 0;
         sv.FieldbyName('PAY_B').AsFloat := 0;
         sv.FieldbyName('PAY_C').AsFloat := 0;
         sv.FieldbyName('PAY_D').AsFloat := 0;
         sv.FieldbyName('PAY_E').AsFloat := 0;
         sv.FieldbyName('PAY_F').AsFloat := 0;
         sv.FieldbyName('PAY_G').AsFloat := 0;
         sv.FieldbyName('PAY_H').AsFloat := 0;
         sv.FieldbyName('PAY_I').AsFloat := 0;
         sv.FieldbyName('PAY_J').AsFloat := 0;
         sv.Post;
       end;
    dataFactory.UpdateBatch(sv,'TCloseForDayV60');
  finally
    AObj.Free;
    sv.Free;
  end;
end;

class function TfrmCloseForDay.ShowClDy(Owner: TForm): Integer;
begin
  result := 2;
  with TfrmCloseForDay.Create(Owner) do
    begin
      try
        PrintFlag := 0;
        GetCloseForDay;
        Open;
        if CheckStatus then //检查按钮的状态(交班、打印)
           begin
             btnCloseDay.Caption := '打印小票';
             btnCloseDay.Tag := 1;
           end;
        case ShowModal of
          mrOk : result := 1;
          mrIgnore : result := 2;
          else result := 0;
        end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmCloseForDay.ShowFee;
  procedure ShowInfo(N:Integer;Money:Currency);
  begin
    case N of
      1:begin
          edtPAY_A.Text := FormatFloat('#0.0##',Money);
        end;
      2:begin
          edtPAY_B.Text := FormatFloat('#0.0##',Money);
        end;
      3:begin
          edtPAY_C.Text := FormatFloat('#0.0##',Money);
        end;
      4:begin
          edtPAY_D.Text := FormatFloat('#0.0##',Money);
        end;
      5:begin
          edtPAY_E.Text := FormatFloat('#0.0##',Money);
        end;
      6:begin
          edtPAY_F.Text := FormatFloat('#0.0##',Money);
        end;
      7:begin
          edtPAY_G.Text := FormatFloat('#0.0##',Money);
        end;
      8:begin
          edtPAY_H.Text := FormatFloat('#0.0##',Money);
        end;
      9:begin
          edtPAY_I.Text := FormatFloat('#0.0##',Money);
        end;
     10:begin
          edtPAY_J.Text := FormatFloat('#0.0##',Money);
        end;
    end;
  end;
var row: Integer;
begin
  row := -1;
  if MainRecord.FieldByName('PAY_A').AsFloat <> 0 then
     begin
       ShowInfo(1,MainRecord.FieldByName('PAY_A').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_B').AsFloat <> 0 then
     begin
       ShowInfo(2,MainRecord.FieldByName('PAY_B').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_C').AsFloat <> 0 then
     begin
       ShowInfo(3,MainRecord.FieldByName('PAY_C').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_D').AsFloat <> 0 then
     begin
       ShowInfo(4,MainRecord.FieldByName('PAY_D').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_E').AsFloat <> 0 then
     begin
       ShowInfo(5,MainRecord.FieldByName('PAY_E').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_F').AsFloat <> 0 then
     begin
       ShowInfo(6,MainRecord.FieldByName('PAY_F').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_G').AsFloat <> 0 then
     begin
       ShowInfo(7,MainRecord.FieldByName('PAY_G').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_H').AsFloat <> 0 then
     begin
       ShowInfo(8,MainRecord.FieldByName('PAY_H').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_I').AsFloat <> 0 then
     begin
       ShowInfo(9,MainRecord.FieldByName('PAY_I').AsFloat);
       Inc(row);
     end;
  if MainRecord.FieldByName('PAY_J').AsFloat <> 0 then
     begin
       ShowInfo(10,MainRecord.FieldByName('PAY_J').AsFloat);
       Inc(row);
     end;
  if row > 5 then
     begin
       Height := Height+(row-5)*25;
       Bevel1.Height := Bevel1.Height+(row-5)*25;
     end;
end;

procedure TfrmCloseForDay.FormCreate(Sender: TObject);
begin
  inherited;
  MainRecord := TRecord_.Create;
  InitForm;
end;

procedure TfrmCloseForDay.FormDestroy(Sender: TObject);
begin
  inherited;
  MainRecord.Free;
end;

procedure TfrmCloseForDay.FormShow(Sender: TObject);
begin
  inherited;
  fndCLSE_DATE.Text := FormatDateTime('YYYY-MM-DD',reckDate());
  fndCREA_USER.Text := token.username;
end;

procedure TfrmCloseForDay.btnCloseDayClick(Sender: TObject);
var
  VerName:string;
begin
  inherited;
  if btnCloseDay.Tag = 0 then
     begin
       VerName := dllGlobal.GetSFVersion;
       if not token.online and ((VerName = '.NET') or (VerName = '.ONL')) then Raise Exception.Create('连锁版不允许离线结账!');
       if VerName = '.NET' then
          begin
            SyncFactory.CloseForDaySync(self.Handle);
          end;
       CheckOffData;
       if not Is_Print and (MessageBox(Handle,'你今天没有营业数据是否继续结账？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
       if MessageBox(Handle,pchar('结账后【'+fndCLSE_DATE.Text+'】你将不能进行销售开单了，是否确认继续结账？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       Save;
       btnCloseDay.Caption := '打印小票';
       btnCloseDay.Tag := 1;
       if edtPrintTicket.Checked then
          begin
            DevFactory.PrintCloseForDay(1, FormatDateTime('YYYYMMDD',reckDate), self.Font);
          end;
       ModalResult := mrOk;
     end
  else if btnCloseDay.Tag = 1 then
     begin
       DevFactory.PrintCloseForDay(1, FormatDateTime('YYYYMMDD',reckDate), self.Font);
       ModalResult := mrOk;
     end;
end;

procedure TfrmCloseForDay.RzPanel13Resize(Sender: TObject);
begin
  inherited;
  edtPrintTicket.Top := RzPanel13.Height - 50;
end;

procedure TfrmCloseForDay.SetPrintDate(const Value: TDate);
begin
  FPrintDate := Value;
end;

procedure TfrmCloseForDay.GetCloseForDay;
var Str:String;
begin
  Str :=
  'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,''1'' as CLSE_TYPE,'+
  ' sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
  ' sum(PAY_A) as PAY_A,'+
  ' sum(PAY_B) as PAY_B,'+
  ' sum(PAY_C) as PAY_C,'+
  ' sum(PAY_D) as PAY_D,'+
  ' sum(PAY_E) as PAY_E,'+
  ' sum(PAY_F) as PAY_F,'+
  ' sum(PAY_G) as PAY_G,'+
  ' sum(PAY_H) as PAY_H,'+
  ' sum(PAY_I) as PAY_I,'+
  ' sum(PAY_J) as PAY_J '+
  ' from SAL_SALESORDER A'+
  ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and SALES_DATE=:SALES_DATE '+
  ' group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE ';
  cdsTable.Close;
  cdsTable.SQL.Text := Str;
  cdsTable.Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsTable.Params.ParamByName('SHOP_ID').AsString := token.shopId;
  cdsTable.Params.ParamByName('CREA_USER').AsString := token.userId;
  cdsTable.Params.ParamByName('SALES_DATE').AsInteger := StrtoInt(FormatDateTime('YYYYMMDD',reckDate));
  dataFactory.Open(cdsTable);
end;

end.
