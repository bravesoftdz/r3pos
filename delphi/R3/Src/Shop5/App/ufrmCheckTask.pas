unit ufrmCheckTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zBase;

type
  TfrmCheckTask = class(TfrmBasic)
    RzBitBtn5: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    Label40: TLabel;
    edtCHECK_TYPE: TGroupBox;
    RB_Single: TRadioButton;
    RB_Multi: TRadioButton;
    procedure RzBitBtn5Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    FcDate: TDate;
    FSHOP_ID: string;
    procedure SetcDate(const Value: TDate);
    function  GetSHOP_ID: string;
    procedure SetSHOP_ID(const Value: string);
    function  CheckExistsIsPrintBill: Boolean;
  public
    { Public declarations }
    procedure dt_Reck(id:string;mdate:TDate);
    procedure Prepare;
    class function StartTask(vcid:string=''):boolean;
    property cDate:TDate read FcDate write SetcDate;
    property SHOP_ID: string read GetSHOP_ID write SetSHOP_ID;
  end;

implementation

uses
  uFnUtil, uGlobal, uShopGlobal, ObjCommon, uDsUtil;

{$R *.dfm}

procedure TfrmCheckTask.RzBitBtn5Click(Sender: TObject);
var
  Temp: TZQuery;
  B:string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('14400001',2) then Raise Exception.Create('��û�п�ʼ�̵��Ȩ��,��͹���Ա��ϵ.');
  Temp := TZQuery.Create(nil);
  try
     //�жϵ�ǰ���ڷ����̵�:
     Temp.Close;
     Temp.SQL.Text := 'select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE ';
     if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
     if Temp.Params.FindParam('SHOP_ID')<>nil then Temp.ParamByName('SHOP_ID').AsString:=SHOP_ID;
     if Temp.Params.FindParam('PRINT_DATE')<>nil then Temp.ParamByName('PRINT_DATE').AsInteger:=StrtoIntDef(formatDatetime('YYYYMMDD',date()),0);
     Factor.Open(Temp);
     if not Temp.IsEmpty then Raise Exception.Create('�����Ѿ��̵��ˣ������ظ��̵�...');
       
     //�жϽ�����н���:             
     Temp.Close;
     Temp.SQL.Text:='select max(CREA_DATE) as PRINT_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';  //'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';     
     if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
     if Temp.Params.FindParam('SHOP_ID')<>nil then Temp.ParamByName('SHOP_ID').AsString:=SHOP_ID;
     Factor.Open(Temp);
     if Temp.Fields[0].AsString = '' then
     begin
       Temp.close;
       Temp.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE ';
       if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
       if Temp.Params.FindParam('DEFINE')<>nil then Temp.ParamByName('DEFINE').AsString:='USING_DATE';    
       Factor.Open(Temp);
       if Temp.IsEmpty then B := FormatDatetime('YYYY-MM-DD',Date()-1)
       else B := FormatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(Temp.Fields[0].AsString)-1);
       if not (formatDatetime('YYYY-MM-DD',date())>B) then Raise Exception.Create('ϵͳ�Ѿ����ʵ�'+b+'�ţ��������̵���');
     end else
     begin
       B := Temp.Fields[0].AsString;
       if (formatDatetime('YYYYMMDD',date())<=B) then Raise Exception.Create('ϵͳ�Ѿ����ʵ�'+b+'�ţ��������̵���');
     end;

     //����ж��Ƿ���ڽ����ҵ�񵥾�
     Temp.Close;
     Temp.SQL.Text:='select sum(Resum) as Resum From '+
       '(select count(*) as Resum from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and SALES_DATE>:BillDate '+
       'union all '+
       'select count(*) as Resum from STK_STOCKORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and STOCK_DATE>:BillDate '+
       'union all '+
       'select count(*) as Resum from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and  CHANGE_DATE>:BillDate)tmp';
     if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
     if Temp.Params.FindParam('SHOP_ID')<>nil then Temp.ParamByName('SHOP_ID').AsString:=SHOP_ID;
     if Temp.Params.FindParam('BillDate')<>nil then Temp.ParamByName('BillDate').AsInteger:=StrToInt(formatDatetime('YYYYMMDD',date()));
     Factor.Open(Temp);
     if Temp.Fields[0].AsInteger>0 then
     begin
       if MessageBox(Handle,pchar('ϵͳ��⵽���ڴ��ڽ����ҵ�񵥾ݣ���ǰ�̵�������沢���ǽ���Ľ�����,'+#13+'�Ƿ�����̵㣿'),'������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end; 
  finally
    Temp.Free;
  end;

  //�����̵�����
  dt_Reck(SHOP_ID,date());

  ModalResult := MROK;
end;

class function TfrmCheckTask.StartTask(vcid:string=''): boolean;
begin
  with TfrmCheckTask.Create(Application.MainForm) do
  begin
    try
      SHOP_ID:=vcid;
      Prepare;
      result := (ShowModal=MROK);
    finally
      free;
    end;
  end;
end;

procedure TfrmCheckTask.Prepare;
var
  s:string;
  rs:TZQuery;
begin
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHECK_STATUS<2 ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=SHOP_ID;
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
    begin
      cDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
      RzBitBtn5.Caption := '�̵���...';
      RzBitBtn5.Enabled := false;
      RB_Single.Enabled:=False;
      RB_Multi.Enabled:=False; 
    end else
      cDate := Date();
    RzLabel1.Caption := format('�̵�����:%s',[formatDatetime('YYYY-MM-DD',cDate)]);
  finally
    rs.free;
  end;
end;

procedure TfrmCheckTask.SetcDate(const Value: TDate);
begin
  FcDate := Value;
end;

procedure TfrmCheckTask.dt_Reck(id: string; mdate: TDate);
var
  rs: TZQuery;
  AObj: TRecord_;
  Str,CurDate,CurDateTime,Check_Type: string;
  Rows_ID,GODS_ID,BatchNo,PROPERTY_01,PROPERTY_02: string;
begin
  CurDate:=formatdatetime('YYYYMMDD',mdate);  //��ǰ����
  CurDateTime:=formatdatetime('YYYY-MM-DD',mdate)+' '+formatdatetime('HH:MM:SS',Now());    //��ǰʱ��
  if RB_Single.Checked then Check_Type:='1' else Check_Type:='2';  //�̵㷽ʽ: 1���̵�; 2�����̵�
  rs:=TZQuery.Create(nil);
  try
    Str:='select A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,A.AMOUNT from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and A.SHOP_ID='''+Global.SHOP_ID+''' and B.COMM not in (''02'',''12'') ';  //���˵��Ѿ�ɾ����Ʒ���ҿ��Ϊ0��Ʒ
    rs.SQL.Text:=Str;
    Factor.Open(rs);
    Factor.BeginTrans(3000); 
    try
      //���ɽ��ʱ�ͷ
      Str:='insert into STO_PRINTORDER (TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values '+
           '('+InttoStr(Global.TENANT_ID)+','''+Global.SHOP_ID+''','+CurDate+',1,'+Check_Type+','''+CurDateTime+''','''+Global.UserID+''',''00'','+GetTimeStamp(Factor.iDbType)+')';
      Factor.ExecSQL(Str);
      rs.first;
      while not rs.Eof do
      begin
        Rows_ID:=TSequence.NewId();
        GODS_ID:=rs.fieldbyName('GODS_ID').AsString;
        BatchNo:=rs.fieldbyName('BATCH_NO').AsString;
        PROPERTY_01:=rs.fieldbyName('PROPERTY_01').AsString;
        PROPERTY_02:=rs.fieldbyName('PROPERTY_02').AsString;
        //���ɽ�������
        Str:='insert into STO_PRINTDATA(ROWS_ID,TENANT_ID,SHOP_ID,PRINT_DATE,BATCH_NO,LOCUS_NO,BOM_ID,GODS_ID,PROPERTY_01,PROPERTY_02,RCK_AMOUNT,CHK_AMOUNT,CHECK_STATUS) '+
             ' values ('''+Rows_ID+''','+InttoStr(Global.TENANT_ID)+','''+Global.SHOP_ID+''','+CurDate+','''+BatchNo+''',null,null,'''+GODS_ID+''','''+PROPERTY_01+''','''+PROPERTY_02+''','+FloatToStr(rs.fieldbyName('AMOUNT').AsFloat)+',0,''1'')';
        Factor.ExecSQL(Str);
        rs.Next;
      end;
      Factor.CommitTrans;
    except
      Factor.RollbackTrans;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmCheckTask.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmCheckTask.GetSHOP_ID: string;
begin
  if trim(FSHOP_ID)<>'' then
    result:=FSHOP_ID
  else
    result:=Global.SHOP_ID;
end;

procedure TfrmCheckTask.SetSHOP_ID(const Value: string);
begin
  FSHOP_ID := Value;
end;

function TfrmCheckTask.CheckExistsIsPrintBill: Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text := 'select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE ';
    if Rs.Params.FindParam('TENANT_ID')<>nil then Rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if Rs.Params.FindParam('SHOP_ID')<>nil then Rs.ParamByName('SHOP_ID').AsString:=self.SHOP_ID;
    if Rs.Params.FindParam('PRINT_DATE')<>nil then Rs.ParamByName('PRINT_DATE').AsInteger:=StrtoIntDef(FormatDatetime('YYYYMMDD',date()),0);
    Factor.Open(Rs);
    result:=(not Rs.IsEmpty);
  finally
    Rs.Free;
  end;
end;

end.
