{   13200001	 0	交班结账  1	查看  2	结账  3	撤消  4	打印    }

unit ufrmCloseForDay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, cxControls, cxContainer, cxEdit, ZIntf,
  cxTextEdit, StdCtrls, ExtCtrls, RzPanel, RzButton, DB, ZBase, ObjCommon,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmCloseForDay = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel4: TRzPanel;
    Label5: TLabel;
    fndCLSE_DATE: TcxTextEdit;
    RzPanel3: TRzPanel;
    labPAY_A: TLabel;
    labPAY_B: TLabel;
    labPAY_C: TLabel;
    labPAY_D: TLabel;
    edtPAY_A: TcxTextEdit;
    edtPAY_B: TcxTextEdit;
    edtPAY_C: TcxTextEdit;
    edtPAY_D: TcxTextEdit;
    lblCASH: TLabel;
    labPAY_E: TLabel;
    labPAY_F: TLabel;
    labPAY_G: TLabel;
    labPAY_H: TLabel;
    edtPAY_E: TcxTextEdit;
    edtPAY_F: TcxTextEdit;
    edtPAY_G: TcxTextEdit;
    edtPAY_H: TcxTextEdit;
    labPAY_I: TLabel;
    labPAY_J: TLabel;
    edtPAY_I: TcxTextEdit;
    edtPAY_J: TcxTextEdit;
    Btn_Close: TRzBitBtn;
    Btn_Save: TRzBitBtn;
    Label12: TLabel;
    fndCREA_USER: TcxTextEdit;
    Bevel1: TBevel;
    edtRECV_MNY: TcxTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPAY_MNY: TcxTextEdit;
    labMNY: TLabel;
    RzButton1: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Is_Print: Boolean;
    MainRecord: TRecord_;
    procedure PrintTickt;
    procedure GetEverydayAcc(var Acc_Data:TZQuery;ThatDay:Integer);
    procedure Open;
    procedure Save;
    procedure InitForm;
    procedure ShowFee;
    class function ShowClDy(Owner:TForm):Integer;
  end;


implementation
uses uGlobal,uShopGlobal,uDsUtil,Math,uDevFactory,ufrmTicketPrint;

{$R *.dfm}

{ TfrmCloseForDay }

procedure TfrmCloseForDay.Open;
var
  rs: TZQuery;
  Str:string;
begin
  try
    rs := TZQuery.Create(nil);
    rs.SQL.Text := 'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CREA_DATE,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and SALES_DATE=:SALES_DATE '+
    ' group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    rs.ParamByName('CREA_USER').AsString := Global.UserID;
    rs.ParamByName('SALES_DATE').AsString := FormatDateTime('YYYYMMDD',Date());
    Factor.Open(rs);
    if rs.IsEmpty then Is_Print := False else Is_Print := True;
    MainRecord.ReadFromDataSet(rs);

    rs.Close;
    rs.SQL.Text := 'select sum(PAY_A) as PAY_A from SAL_IC_GLIDE A where IC_GLIDE_TYPE=''1'' and TENANT_ID='+IntToStr(Global.TENANT_ID)+
    ' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and CREA_USER='+QuotedStr(Global.UserID)+' and CREA_DATE='+FormatDateTime('YYYYMMDD',Date())+' ';
    Factor.Open(rs);
    if rs.IsEmpty then
      Is_Print := False
    else
      Is_Print := True;
    edtPAY_MNY.Text := rs.Fields[0].AsString;

    rs.Close;
    rs.SQL.Text := 'select sum(RECV_MNY) as RECV_MNY from VIW_RECVDATA A where PAYM_ID=''A'' and TENANT_ID='+IntToStr(Global.TENANT_ID)+
    ' and SHOP_ID='+QuotedStr(Global.SHOP_ID)+' and RECV_DATE='+FormatDateTime('YYYYMMDD',Date())+' and RECV_USER='+QuotedStr(Global.UserID)+' ';
    Factor.Open(rs);
    if rs.IsEmpty then
      Is_Print := False
    else
      Is_Print := True;
    edtRECV_MNY.Text := rs.Fields[0].AsString;

    ShowFee;
    rs.Close;
    Str :=
    'select isnull(j1.BALANCE,0)+isnull(j2.PAY_A,0) from '+
    '(select BALANCE from ACC_ACCOUNT_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+Global.SHOP_ID+' and PAYM_ID=''A'') j1,'+
    '(select sum(PAY_A) as PAY_A '+
    ' from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+Global.SHOP_ID+' and SALES_DATE <='+FormatDateTime('YYYYMMDD',Date())+
    ' and not exists('+
    ' select * from ACC_CLOSE_FORDAY where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.SALES_DATE)'+
    ') j2 ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,Str);
    {rs.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.FieldByName('SHOP_ID').AsString := Global.SHOP_ID;
    rs.FieldByName('CREA_USER').AsString := Global.UserID;
    rs.FieldByName('SALES_DATE').AsString := FormatDateTime('YYYYMMDD',Date())};
    Factor.Open(rs);
    labMNY.Caption := '店内金额:'+rs.Fields[0].AsString;
    lblCASH.Caption :='当日现金:'+FloatToStr(StrToFloatDef(edtPAY_A.Text,0.00)+StrToFloatDef(edtPAY_MNY.Text,0.00)+StrToFloatDef(edtRECV_MNY.Text,0.00));
  finally
    rs.Free;
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

procedure TfrmCloseForDay.InitForm;
var Tmp:TZQuery;
begin
  Tmp := Global.GetZQueryFromName('PUB_PAYMENT');
  Tmp.First;
  while not Tmp.Eof do
    begin
      if Tmp.FieldByName('CODE_ID').AsString = 'A' then
        begin
          labPAY_A.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_A.Caption) <= 4 then labPAY_A.Caption := labPAY_A.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'B' then
        begin
          labPAY_B.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_B.Caption) <= 4 then labPAY_B.Caption := labPAY_B.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'C' then
        begin
          labPAY_C.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_C.Caption) <= 4 then labPAY_C.Caption := labPAY_C.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'D' then
        begin
          labPAY_D.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_D.Caption) <= 4 then labPAY_D.Caption := labPAY_D.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'E' then
        begin
          labPAY_E.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_E.Caption) <= 4 then labPAY_E.Caption := labPAY_E.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'F' then
        begin
          labPAY_F.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_F.Caption) <= 4 then labPAY_F.Caption := labPAY_F.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'G' then
        begin
          labPAY_G.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_G.Caption) <= 4 then labPAY_G.Caption := labPAY_G.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'H' then
        begin
          labPAY_H.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_H.Caption) <= 4 then labPAY_H.Caption := labPAY_H.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'I' then
        begin
          labPAY_I.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_I.Caption) <= 4 then labPAY_I.Caption := labPAY_I.Caption + '支付';
        end;
      if Tmp.FieldByName('CODE_ID').AsString = 'J' then
        begin
          labPAY_J.Caption := Tmp.FieldByName('CODE_NAME').AsString;
          if Length(labPAY_J.Caption) <= 4 then labPAY_J.Caption := labPAY_J.Caption + '支付';
        end;
      Tmp.Next;
    end;
end;

class function TfrmCloseForDay.ShowClDy(Owner: TForm): Integer;
begin
  with TfrmCloseForDay.Create(Owner) do
    begin
      try
        case ShowModal of
          mrOk : Result := 1;
          mrIgnore : Result := 2;
        else
          Result := 0;
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

procedure TfrmCloseForDay.FormShow(Sender: TObject);
begin
  inherited;
  fndCREA_USER.Text := Global.UserName;
  fndCLSE_DATE.Text := FormatDateTime('YYYY-MM-DD',Date);
  Open;
end;

procedure TfrmCloseForDay.Save;
var 
    rs,sv: TZQuery;
    AObj:TRecord_;
begin
    rs := TZQuery.Create(nil);
    sv := TZQuery.Create(nil);
    AObj := TRecord_.Create;
    try
      GetEverydayAcc(rs,StrToInt(FormatDateTime('YYYYMMDD',Date())));
      if not rs.IsEmpty then
        begin
          sv.Delta := rs.Delta;
          rs.First;
          while not rs.Eof do
            begin
              sv.Append;
              AObj.ReadFromDataSet(rs);
              AObj.WriteToDataSet(sv,false);
              sv.Post; 
              rs.Next;
            end;
          Factor.UpdateBatch(sv,'TCloseForDay');
        end;
    finally
      AObj.Free;
      sv.Free;
      rs.Free;
    end;

end;

procedure TfrmCloseForDay.Btn_SaveClick(Sender: TObject);
var
  PrintRight: Boolean;
begin
  inherited;
  if not ShopGlobal.GetChkRight('13200001',2) then
    Raise Exception.Create('  您没有结账权限，请联系管理员！  ');

  Save;
  PrintRight:=ShopGlobal.GetChkRight('13200001',4);
  if Is_Print and PrintRight then
  begin
    if MessageBox(Handle,Pchar('是否打印小票'),Pchar(Caption),MB_OK+MB_ICONQUESTION)=1 then
      TfrmTicketPrint.ShowTicketPrint(Self,1,FormatDateTime('YYYYMMDD',Date()));
  end;
  ModalResult := mrOk;
end;

procedure TfrmCloseForDay.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmCloseForDay.PrintTickt;
var P_Width: Integer;
  function FormatStr(Text:String;W:Integer;LorR:Integer):String;
    var i,j:Integer;
    begin
      j := W-Length(Text);
      for i := 0 to j do
        Result := Result + ' ';
      if LorR = 0 then
        Result := Text + Result
      else
        Result := Result + Text;
    end;
  function FormatTitle(Name:String):String;
    var i,j:Integer;
    begin
      j := (P_Width-length(Name)) div 2;
      for i := 0 to j do
          Result := Result + ' ';
      Result := Result + Name;
    end;
  function FormatLine(Name:String;Num:String):String;
    begin
      Result := FormatStr(Name,10,1)+'                  '+FormatStr(Num,10,1);
    end;
begin
  P_Width := 38;
  try
    DevFactory.BeginPrint;
    DevFactory.WritePrint(FormatTitle('关账表单'));
    DevFactory.WritePrint('');
    DevFactory.WritePrint(FormatStr(Label12.Caption+':'+fndCREA_USER.Text,19,0)+FormatStr(Label5.Caption+':'+fndCLSE_DATE.Text,19,0));
    DevFactory.WritePrint('  ----------------------------------  ');
    if MainRecord.FieldByName('PAY_A').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_A.Caption,edtPAY_A.Text));
    if MainRecord.FieldByName('PAY_B').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_B.Caption,edtPAY_B.Text));
    if MainRecord.FieldByName('PAY_C').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_C.Caption,edtPAY_C.Text));
    if MainRecord.FieldByName('PAY_D').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_D.Caption,edtPAY_D.Text));
    if MainRecord.FieldByName('PAY_E').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_E.Caption,edtPAY_E.Text));
    if MainRecord.FieldByName('PAY_F').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_F.Caption,edtPAY_F.Text));
    if MainRecord.FieldByName('PAY_G').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_G.Caption,edtPAY_G.Text));
    if MainRecord.FieldByName('PAY_H').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_H.Caption,edtPAY_H.Text));
    if MainRecord.FieldByName('PAY_I').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_I.Caption,edtPAY_I.Text));
    if MainRecord.FieldByName('PAY_J').AsFloat <> 0 then
        DevFactory.WritePrint(FormatLine(labPAY_J.Caption,edtPAY_J.Text));

    DevFactory.WritePrint(FormatLine(Label2.Caption,edtPAY_MNY.Text));
    DevFactory.WritePrint(FormatLine(Label2.Caption,edtRECV_MNY.Text));
    DevFactory.WritePrint(FormatStr(lblCASH.Caption,38,1));
  finally
    DevFactory.EndPrint;
  end;
end;


procedure TfrmCloseForDay.GetEverydayAcc(var Acc_Data: TZQuery;ThatDay:Integer);
var Str:String;
begin

    Str :=
    'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and SALES_DATE <=:SALES_DATE '+
    ' and not exists('+
    'select * from ACC_CLOSE_FORDAY where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.SALES_DATE'+
    ') group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE';
    Acc_Data.Close;
    Acc_Data.SQL.Text := Str;
    Acc_Data.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Acc_Data.Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Acc_Data.Params.ParamByName('CREA_USER').AsString := Global.UserID;
    Acc_Data.Params.ParamByName('SALES_DATE').AsInteger := ThatDay;
    Factor.Open(Acc_Data);

end;

procedure TfrmCloseForDay.RzButton1Click(Sender: TObject);
var i: Integer;
begin
  inherited;
  if not ShopGlobal.GetChkRight('13200001',4) then
    Raise Exception.Create('  您没有打印小票权限，请联系管理员！  ');

  i := MessageBox(Handle,Pchar('是否打印小票'),Pchar(Caption),MB_OK+MB_ICONQUESTION);
  if i = 1 then
    TfrmTicketPrint.ShowTicketPrint(Self,1,'20110303');

end;

end.
