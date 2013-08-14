unit ufrmCloseForDay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms,
  Grids, DBGridEh, RzEdit, RzStatus,ComObj,IniFiles, Menus,
  RzPrgres;

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
    btnCloseDay: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
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
    edtHIS_MNY: TcxTextEdit;
    edtPrintTicket: TCheckBox;
    RzPanel15: TRzPanel;
    lblCaption: TRzLabel;
    RzLable1: TRzLabel;
    RzLabel6: TRzLabel;
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
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseDayClick(Sender: TObject);
    procedure RzPanel13Resize(Sender: TObject);
  private
    FprintDate: TDate;
    procedure SetprintDate(const Value: TDate);
    { Private declarations }
  public
    { Public declarations }
    DateArr:array of Integer;
    printFlag:integer;
    Balance:Double;
    LastTime:integer;
    Is_Print: Boolean;
    MainRecord: TRecord_;
    function reckDate:TDate;
    function CheckStatus:boolean;
    //检查是否有离线数据，必须上传后才能结账
    procedure CheckOffData;
    procedure GetEverydayAcc(var Acc_Data:TZQuery;ThatDay:Integer);
    procedure GetLastDate;
    function  GetBalance:Boolean;
    procedure Open;
    procedure Save;
    procedure InitForm;
    procedure ShowFee;
    class function ShowClDy(Owner:TForm):Integer;
    property printDate:TDate read FprintDate write SetprintDate;
  end;

implementation

uses
  uTokenFactory,udllGlobal,udataFactory,uFnUtil,uDsUtil,uDevFactory,uSyncFactory;

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
    rs.Params.ParamByName('TENANT_ID').AsInteger := StrToIntDef(Token.tenantId,0);
    rs.Params.ParamByName('SHOP_ID').asString := Token.shopId;
    rs.Params.ParamByName('CLSE_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',reckDate));
    dataFactory.Open(rs);
    result := not rs.IsEmpty;
  finally
    rs.free;
  end;
end;

function TfrmCloseForDay.GetBalance: Boolean;
var toDay:integer;
begin
  toDay := StrToInt(FormatDateTime('YYYYMMDD',reckDate));
  GetEverydayAcc(cdsTable,toDay); //合并操作，当它只是打开一次即可
  result := cdsTable.IsEmpty;
  Balance := 0;
  cdsTable.First;
  while not cdsTable.Eof do
    begin
      if cdsTable.FieldByName('CLSE_DATE').AsInteger < toDay then
         Balance := Balance + cdsTable.FieldByName('PAY_A').AsFloat;
      cdsTable.Next;
    end;
  edtHIS_MNY.Text := formatfloat('#0.00',Balance);
  result := true;
end;

procedure TfrmCloseForDay.GetEverydayAcc(var Acc_Data: TZQuery; ThatDay: Integer);
var Str:String;
begin
  Str :=
    'select TENANT_ID,SHOP_ID,SALES_DATE as CLSE_DATE,''1'' as CLSE_TYPE,'+
      'sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
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
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and SALES_DATE>:LAST_SALES_DATE and SALES_DATE<=:SALES_DATE '+
    ' group by TENANT_ID,SHOP_ID,SALES_DATE';
  Str :=
    'select A.*,'''+Token.userId+''' as CREA_USER from ('+Str+') A where CLSE_DATE=:SALES_DATE or '+
    ' not exists(select * from ACC_CLOSE_FORDAY where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CLSE_DATE=A.CLSE_DATE'+
    ')';
  Acc_Data.Close;
  Acc_Data.SQL.Text := Str;
  Acc_Data.Params.ParamByName('TENANT_ID').AsInteger := StrToIntDef(Token.tenantId,0);
  Acc_Data.Params.ParamByName('SHOP_ID').AsString := Token.shopId;
  Acc_Data.Params.ParamByName('SALES_DATE').AsInteger := ThatDay;
  if LastTime=ThatDay then
     Acc_Data.Params.ParamByName('LAST_SALES_DATE').AsInteger := LastTime-1
  else
     Acc_Data.Params.ParamByName('LAST_SALES_DATE').AsInteger := LastTime;
  dataFactory.Open(Acc_Data);
end;

procedure TfrmCloseForDay.GetLastDate;
var rs:TZQuery;
begin
  try
    rs := TZQuery.Create(nil);
    rs.Close;
    rs.SQL.Text := 'select Max(END_DATE) from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := StrToIntDef(Token.tenantId,0);
    dataFactory.Open(rs);
    if rs.Fields[0].AsString='' then   //获得当前收银员最近的结账日期
      LastTime := 0
    else
      LastTime := strtoint(formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(rs.Fields[0].asString)));
  finally
    rs.Free;
  end;
end;

procedure TfrmCloseForDay.InitForm;
var Tmp:TZQuery;
begin
  Tmp := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
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

procedure TfrmCloseForDay.Open;
var rs: TZQuery;
    Str:string;
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
  if printFlag=0 then
     begin
      if dllGlobal.sysDate = (date()-1) then
         result := dllGlobal.SysDate
      else
         result := Date();
     end
  else
     result := printDate;
end;

procedure TfrmCloseForDay.Save;
var
  i:Integer;
  rs,sv: TZQuery;
  AObj:TRecord_;
begin
  rs := cdsTable;
  sv := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
    begin
      //把未结账日期值 赋给 动态数组
      SetLength(DateArr,rs.RecordCount+1);
      i:=0;
      sv.Delta := rs.Delta;
      rs.First;
      while not rs.Eof do
      begin
        sv.Append;
        AObj.ReadFromDataSet(rs);
        AObj.WriteToDataSet(sv,false);
        sv.Post;
        DateArr[i]:=rs.FieldbyName('CLSE_DATE').AsInteger;
        Inc(i);
        rs.Next;
      end;
      if not sv.Locate('CLSE_DATE',strtoint(formatDatetime('YYYYMMDD',reckDate)),[]) then //如果当前没有数据补结0记录
      begin
        DateArr[i]:=strtoint(formatDatetime('YYYYMMDD',reckDate));
        sv.Append;
        sv.FieldByName('TENANT_ID').AsInteger := StrToIntDef(Token.tenantId,0);
        sv.FieldByName('CLSE_DATE').AsInteger := strtoint(formatDatetime('YYYYMMDD',reckDate));
        sv.FieldByName('SHOP_ID').AsString := Token.shopId;
        sv.FieldbyName('CREA_USER').AsString := Token.userId;
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
    end;
  finally
    AObj.Free;
    sv.Free;
  end;
end;

procedure TfrmCloseForDay.SetprintDate(const Value: TDate);
begin
  FprintDate := Value;
end;

class function TfrmCloseForDay.ShowClDy(Owner: TForm): Integer;
begin
  Result := 2;
  with TfrmCloseForDay.Create(Owner) do
  begin
    try
      printFlag := 0;
      GetLastDate;
      GetBalance;
      Open;
      if CheckStatus then  //检查按钮的状态(交班、打印)
      begin
        btnCloseDay.Caption := '打印小票';
        btnCloseDay.Tag := 1;
      end;
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

procedure TfrmCloseForDay.FormCreate(Sender: TObject);
begin
  inherited;
  MainRecord := TRecord_.Create;
  InitForm;
  edtPrintTicket.Enabled:=dllGlobal.GetChkRight('13200001',5);
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
end;

procedure TfrmCloseForDay.btnCloseDayClick(Sender: TObject);
 function CheckUpdateStatus:boolean;
 begin
   result := (dataFactory.sqlite.ExecProc('TGetLastUpdateStatus')='1');
 end;
var
 i:Integer;
 VerName:string;
begin
  inherited;
  if btnCloseDay.Tag = 0 then
    begin
      VerName:=dllGlobal.GetServiceInfo;
      if ((VerName='.NET') or (VerName='.ONL')) and (token.online=False) then Raise Exception.Create('连锁版不允许离线结账!');
      if (VerName='.NET') then
      begin
        //SyncFactory.;  //改为只上报销售  SyncFactory.SyncAll; //连锁版结账前都必须同步脱机数据...
      end;
      CheckOffData;
      if not dllGlobal.GetChkRight('13200001',2) then Raise Exception.Create('您没有交班结账权限,请联系管理员!');
      if not Is_Print and (MessageBox(Handle,'你今天没有营业数据是否继续结账？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
      if MessageBox(Handle,pchar('结账后【'+fndCLSE_DATE.Text+'】你将不能进行销售开单了，是否确认继续结账？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
      Save;
      btnCloseDay.Caption := '打印小票';
      btnCloseDay.Tag := 1;
      if edtPrintTicket.Checked then
      begin
        for i:=low(DateArr) to High(DateArr) do
        begin
          {f DateArr[i]>0 then
            TfrmTicketPrint.ShowTicketPrint(Self,1,IntToStr(DateArr[i]));
           }
        end;
      end;
      ModalResult := mrOk;
    end
  else if btnCloseDay.Tag = 1 then
    begin
      //if MessageBox(Handle,Pchar('是否打印小票!'),Pchar(Caption),MB_YESNO+MB_ICONQUESTION)=6 then
      //   TfrmTicketPrint.ShowTicketPrint(Self,1,FormatDateTime('YYYYMMDD',reckDate));
      ModalResult := mrOk;
    end;
end;

procedure TfrmCloseForDay.RzPanel13Resize(Sender: TObject);
begin
  inherited;
  edtPrintTicket.Top:=RzPanel13.Height-50;
end;

end.
