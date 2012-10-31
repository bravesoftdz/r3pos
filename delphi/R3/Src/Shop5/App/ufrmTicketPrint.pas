unit ufrmTicketPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ZDataset, uGlobal,uShopGlobal, uDevFactory,
  ComCtrls,ObjCommon;

type
  TfrmTicketPrint = class(TfrmBasic)
  private
    FSHOP_ID: string;
    FSHOP_NAME: string;
    FUSER_ID: string;
    FUSER_NAME: string;
    procedure SetSHOP_ID(const Value: string);
    procedure SetSHOP_NAME(const Value: string);
    procedure SetUSER_ID(const Value: string);
    procedure SetUSER_NAME(const Value: string);
    { Private declarations }

  public
    { Public declarations }
    function GetTicketGodsName(DataSet:TZQuery):string;
    function GetPayText(Pay_Code:String):String;
    function FormatText(Text_Content:String;Text_Width:Integer;Left:Boolean=True):String;
    function FormatTitle(Title:String):String;
    function RepeatCharacter(Str:char;L:Integer):String;
    procedure FormatGoodsAndMoney(Goods,Num,Unit_Name,Money:String);
    function DoPrintDetail(QueryType:Integer;QueryDate:String):Boolean;
    class function ShowTicketPrint(Owner:TForm;SelectType:Integer;WhichDay:String;MyShopId:string='';myShopName:string='';myUserId:string='';myUserName:string=''):Boolean;
    property SHOP_ID:string read FSHOP_ID write SetSHOP_ID;
    property SHOP_NAME:string read FSHOP_NAME write SetSHOP_NAME;
    property USER_ID:string read FUSER_ID write SetUSER_ID;
    property USER_NAME:string read FUSER_NAME write SetUSER_NAME;
  end;


implementation

uses DB;

{$R *.dfm}

{ TfrmTicketPrint }

function TfrmTicketPrint.DoPrintDetail(QueryType:Integer;QueryDate:String):Boolean;
var rs,ForDay_rs:TZQuery;
    WhereStr:String;
    i:Integer;
    Sum_Goods,Sum_Money:Double;
begin
  if DevFactory.LPT < 0 then Exit;

  ForDay_rs := TZQuery.Create(nil);
  try
    case QueryType of
        1:WhereStr := ' TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER  ';
        2:WhereStr := ' TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by SHOP_ID ';
      else
        WhereStr := ' TENANT_ID=:TENANT_ID group by TENANT_ID ';
    end;
    ForDay_rs.SQL.Text :=
    'select sum(PAY_A) as PAY_A,sum(PAY_B) as PAY_B,sum(PAY_C) as PAY_C,sum(PAY_D) as PAY_D,sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,sum(PAY_G) as PAY_G,sum(PAY_H) as PAY_H,sum(PAY_I) as PAY_I,sum(PAY_J) as PAY_J '+
    ' from ACC_CLOSE_FORDAY where CLSE_DATE=:CLSE_DATE and '+WhereStr;
    case QueryType of
      1:begin
        ForDay_rs.ParamByName('CLSE_DATE').AsInteger := StrToInt(QueryDate);
        ForDay_rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        ForDay_rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
        ForDay_rs.ParamByName('CREA_USER').AsString := USER_ID;
      end;
      2:begin
        ForDay_rs.ParamByName('CLSE_DATE').AsInteger := StrToInt(QueryDate);
        ForDay_rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        ForDay_rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
      end;
      else begin
        ForDay_rs.ParamByName('CLSE_DATE').AsInteger := StrToInt(QueryDate);
        ForDay_rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      end;
    end;

    Factor.Open(ForDay_rs);

    //开始打印小票
    DevFactory.BeginPrint;
    DevFactory.WritePrint(FormatTitle(DevFactory.Title));
    case QueryType of
      1:begin
      DevFactory.WritePrint('');
      DevFactory.WritePrint('店名:'+SHOP_NAME);
      DevFactory.WritePrint(FormatText('收银:'+USER_NAME,DevFactory.Width-17)+' 日期:'+Copy(QueryDate,1,4)+'-'+Copy(QueryDate,5,2)+'-'+Copy(QueryDate,7,2));
      WhereStr := ' B.TENANT_ID=:TENANT_ID and B.SHOP_ID=:SHOP_ID and B.CREA_USER=:CREA_USER ';
      end;
      2:begin
      DevFactory.WritePrint('');
      DevFactory.WritePrint('店名:'+SHOP_NAME);
      DevFactory.WritePrint('日期:'+Copy(QueryDate,1,4)+'-'+Copy(QueryDate,5,2)+'-'+Copy(QueryDate,7,2));
      WhereStr := ' B.TENANT_ID=:TENANT_ID and B.SHOP_ID=:SHOP_ID ';
      end;
      else begin
      DevFactory.WritePrint('');
      DevFactory.WritePrint('日期:'+Copy(QueryDate,1,4)+'-'+Copy(QueryDate,5,2)+'-'+Copy(QueryDate,7,2));
      WhereStr := ' B.TENANT_ID=:TENANT_ID ';
      end;
    end;
    DevFactory.WritePrint(RepeatCharacter('-',DevFactory.Width-1));

    if DevFactory.CloseDayPrintFlag = 1 then
      begin
        rs := TZQuery.Create(nil);
        rs.SQL.Text :=
        ParseSQL(Factor.iDbType,
        'select je.*,isnull(e.BARCODE,je.CALC_BARCODE) as BARCODE from ('+
        'select jd.*,d.COLOR_NAME as PROPERTY_02_TEXT from ('+
        'select jc.*,c.SIZE_NAME as PROPERTY_01_TEXT from ('+
        'select jb.*,b.GODS_NAME,b.GODS_CODE,b.BARCODE as CALC_BARCODE from('+
        'select ja.*,a.UNIT_NAME from('+
        'select A.TENANT_ID,A.GODS_ID,A.UNIT_ID,A.PROPERTY_01,A.PROPERTY_02,sum(A.AMOUNT) as AMOUNT,sum(A.CALC_MONEY) as CALC_MONEY '+
        'from SAL_SALESDATA A,SAL_SALESORDER B where A.SALES_ID=B.SALES_ID and A.TENANT_ID=B.TENANT_ID '+
        'and B.SALES_TYPE=4 and SALES_DATE=:SALES_DATE and '+WhereStr+' group by A.TENANT_ID,A.GODS_ID,A.UNIT_ID,A.PROPERTY_01,A.PROPERTY_02) ja '+
        'left outer join VIW_MEAUNITS a on a.UNIT_ID=ja.UNIT_ID and a.TENANT_ID=ja.TENANT_ID) jb '+
        'left outer join VIW_GOODSINFO b on  jb.GODS_ID=b.GODS_ID  and jb.TENANT_ID=b.TENANT_ID) jc '+
        'left outer join VIW_SIZE_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.PROPERTY_01=c.SIZE_ID) jd '+
        'left outer join VIW_COLOR_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.PROPERTY_02=d.COLOR_ID ) je '+
        'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) e on je.TENANT_ID=e.TENANT_ID and je.PROPERTY_02=e.PROPERTY_02 and je.PROPERTY_01=e.PROPERTY_01 and je.GODS_ID=e.GODS_ID and je.UNIT_ID=e.UNIT_ID ');

        case QueryType of
          1:begin
            rs.ParamByName('SALES_DATE').AsString := QueryDate;
            rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
            rs.ParamByName('CREA_USER').AsString := USER_ID;
          end;
          2:begin
            rs.ParamByName('SALES_DATE').AsString := QueryDate;
            rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
          end;
          else
            begin
              rs.ParamByName('SALES_DATE').AsString := QueryDate;
              rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            end;
        end;
        Factor.Open(rs);
        if DevFactory.Width = 35 then
          DevFactory.WritePrint('商品名称             数量     金额')
        else
          DevFactory.WritePrint('商品名称        数量     金额');
        DevFactory.WritePrint(RepeatCharacter('-',DevFactory.Width-1));
        Sum_Goods := 0;
        Sum_Money := 0;
        rs.First;
        while not rs.Eof do
          begin
            Sum_Goods := Sum_Goods + rs.FieldbyName('AMOUNT').AsFloat;
            Sum_Money := Sum_Money + rs.FieldbyName('CALC_MONEY').AsFloat;
            FormatGoodsAndMoney(GetTicketGodsName(rs),rs.FieldbyName('AMOUNT').AsString,rs.FieldbyName('UNIT_NAME').AsString,rs.FieldbyName('CALC_MONEY').AsString);
            rs.Next;
          end;
        DevFactory.WritePrint(RepeatCharacter('-',DevFactory.Width-1));

        if DevFactory.Width = 35 then
          DevFactory.WritePrint('合计:'+RepeatCharacter(' ',10)+FormatText(FloatToStr(Sum_Goods),8,false)+' '+FormatText(FloatToStr(Sum_Money),8,false))
        else
          DevFactory.WritePrint('合计:'+RepeatCharacter(' ',8)+FormatText(FloatToStr(Sum_Goods),7,false)+' '+FormatText(FloatToStr(Sum_Money),8,false));
        DevFactory.WritePrint('');
        DevFactory.WritePrint(RepeatCharacter('-',DevFactory.Width-1));
      end;

    DevFactory.WritePrint('营业额:'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_A').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_B').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_C').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_D').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_E').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_F').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_G').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_H').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_I').AsFloat+
                                                        ForDay_rs.FieldbyName('PAY_J').AsFloat));

    DevFactory.WritePrint('');
    if ForDay_rs.FieldByName('PAY_A').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('A')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_A').AsFloat));
    if ForDay_rs.FieldByName('PAY_B').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('B')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_B').AsFloat));
    if ForDay_rs.FieldByName('PAY_C').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('C')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_C').AsFloat));
    if ForDay_rs.FieldByName('PAY_D').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('D')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_D').AsFloat));
    if ForDay_rs.FieldByName('PAY_E').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('E')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_E').AsFloat));
    if ForDay_rs.FieldByName('PAY_F').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('F')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_F').AsFloat));
    if ForDay_rs.FieldByName('PAY_G').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('G')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_G').AsFloat));
    if ForDay_rs.FieldByName('PAY_H').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('H')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_H').AsFloat));
    if ForDay_rs.FieldByName('PAY_I').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('I')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_I').AsFloat));
    if ForDay_rs.FieldByName('PAY_J').AsFloat <> 0 then
      DevFactory.WritePrint(GetPayText('J')+':'+FormatFloat('#0.00',ForDay_rs.FieldbyName('PAY_J').AsFloat));

    DevFactory.WritePrint(RepeatCharacter('-',DevFactory.Width-1));
    DevFactory.WritePrint('打印时间:'+FormatDateTime('YYYY-MM-DD HH:NN:SS',Now));
    For i:= 0 to DevFactory.PrintNull-1 do
      DevFactory.WritePrint(' ');

  finally
    DevFactory.EndPrint;
    ForDay_rs.Free;
    rs.Free;

  end;

end;

procedure TfrmTicketPrint.FormatGoodsAndMoney(Goods, Num,Unit_Name,
  Money: String);
var F_Num,F_Money,F_Goods:String;
    F_N,F_M,F_G,i,j:Integer;
begin
  {if DevFactory.Width = 38 then
    begin
      F_G := 20;
      F_N := 8;
      F_M := 8;
    end
  else
    begin
      F_G := 15;
      F_N := 7;
      F_M := 8;
    end;}
  F_M := 8;
  F_Num := ' '+Num+Unit_Name;

  if Length(Money) > F_M then
    F_Num :=F_Num+' '+FormatText(Money,length(Money),False)
  else
    F_Num :=F_Num+FormatText(Money,F_M+1,False);

  F_Goods := StringReplace(Goods,'（','(',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'）',')',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'！','!',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'，',',',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'？','?',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'。','.',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'，',':',[rfReplaceAll]);
  F_Goods := StringReplace(F_Goods,'；',';',[rfReplaceAll]);

  i := length(F_Num);    //数量、金额长度
  j := length(F_Goods);       //商品名称长度

  if (i+j) > DevFactory.Width then
    begin
      DevFactory.WritePrint(F_Goods);
      DevFactory.WritePrint(FormatText(F_Num,DevFactory.Width-1,False));
    end
  else
    begin
      DevFactory.WritePrint(FormatText(F_Goods,DevFactory.Width-i-1)+F_Num);
    end;

end;

function TfrmTicketPrint.FormatText(Text_Content: String; Text_Width: Integer;
  Left: Boolean): String;
var i,j:Integer;
begin
  j := Text_Width-length(Text_Content);
  for i := 1 to j do
    Result := Result + ' ';
    
  if Left then
    Result := Text_Content + Result
  else
    Result := Result + Text_Content;

end;

function TfrmTicketPrint.FormatTitle(Title: String): String;
var i,j:Integer;
begin
  j := (DevFactory.Width-length(Title)) div 2;
  for i := 1 to j do
    Result := Result + ' ';
  Result := Result + Title;
end;

function TfrmTicketPrint.GetPayText(Pay_Code: String): String;
var rs:TZQuery;
begin
  try
    rs := TZQuery.Create(nil);
    rs.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''1'' and CODE_ID='''+Pay_Code+'''';
    Factor.Open(rs);
    if rs.IsEmpty then
      Result := 'ID'
    else
      begin
        if Length(rs.FieldbyName('CODE_NAME').AsString)>5 then
          Result := rs.FieldbyName('CODE_NAME').AsString
        else
          Result := rs.FieldbyName('CODE_NAME').AsString+'支付';
      end;

  finally
    rs.Free;
  end;
end;

function TfrmTicketPrint.GetTicketGodsName(DataSet: TZQuery): string;
begin
  case DevFactory.TicketPrintName of
  0:result := DataSet.FieldbyName('GODS_NAME').AsString;
  1:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString;
  2:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString;
  3:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
  4:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
  5:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
  else
    result := DataSet.FieldbyName('GODS_NAME').AsString;
  end;
end;

function TfrmTicketPrint.RepeatCharacter(Str: char; L: Integer): String;
var i:Integer;
begin
  for i:=1 to L do
    Result := Result + Str;
end;

procedure TfrmTicketPrint.SetSHOP_ID(const Value: string);
begin
  FSHOP_ID := Value;
end;

procedure TfrmTicketPrint.SetSHOP_NAME(const Value: string);
begin
  FSHOP_NAME := Value;
end;

procedure TfrmTicketPrint.SetUSER_ID(const Value: string);
begin
  FUSER_ID := Value;
end;

procedure TfrmTicketPrint.SetUSER_NAME(const Value: string);
begin
  FUSER_NAME := Value;
end;

class function TfrmTicketPrint.ShowTicketPrint(Owner:TForm;SelectType: Integer;
  WhichDay: String;MyShopId:string='';myShopName:string='';myUserId:string='';myUserName:string=''): Boolean;
begin
  with TfrmTicketPrint.Create(Owner) do
    begin
      try
        if MyShopId='' then
           begin
             SHOP_ID := Global.SHOP_ID;
             SHOP_NAME := Global.SHOP_NAME;
             USER_ID := Global.UserID;
             USER_NAME := Global.UserName;
           end
        else
           begin
             SHOP_ID := myShopId;
             SHOP_NAME := myShopName;
             USER_ID := myUserId;
             USER_NAME := myUserName;
           end;
        DoPrintDetail(SelectType,WhichDay);
      finally
        Free;
      end;
    end;
end;

end.
