unit udllFnUtil;

interface
uses Classes,SysUtils,Controls,Windows,Math;
Const
  CodeFormat='0123456789'+
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'abcdefghijklmnopqrstuvwxyz' +
    '~!@#$%^&*()_+-/<>?:;{}[]|\';
type
FnTime=Class
  public
    //��ʽ���룬Ϊʱ���֣����ʽ
    Class function FormatSecond(Second:Integer):string;
    //���ַ���ת��������  20050401 ת������������
    Class function fnStrtoDate(Str:string):TDate;
    //ȡ��ǰ�·ݵ����һ�������
    Class function GetLastDate(Month:String):String;
    //��Ʒ���ַ��������ڷ�ʽ��ʾ  20050401->2005-04-01
    Class function FormatDateStr(Date:string):String;
    //��ʽ��ʱ�� Ϊ 10��2ʱ10��2�� ��ʽ
    Class function FormatExtDatetime(pDate:TDatetime):String;
    //�� 20050102152350 ��ʽ���ַ���ת��������
    Class function fnStrToDatetime(Str:string):TDateTime;
    //������ ת���� 20050102152350 ��ʽ���ַ���
    Class function fnDatetimeToStr(pDate:TDateTime):string;
    //���ַ����¼� pinc ��ϵ��ֵ
    Class function fnIncMonth(aMonth:String;pInc:Integer=1):string;
  end;
FnNumber=Class
  public
    //���������д���Ľ��ת��
    Class function SmallTOBig(small: real): string;
    //��λ�㷨
    //value ����ֵ
    //deci ����С��λ
    //CarryRule ��λ����
    Class function ConvertToFight(value: Currency; CarryRule,deci: Integer): real;
    Class function CompareFloat(a,b:real):integer;
  end;
FnString=Class
  private
  public
    //  1: ƴ��  2�����  3: ƴ������  2����ʼ���
    class function GetWordSpell(hzstr: string;codetype:integer=3): string;
    //����Ƿ�Ϸ��ı����ַ�
    Class function IsCodeFormat(Key:Char):Boolean;
    //�����ַ���һ,����ʽ����ָ������ ��ǰ��0��ʽ)
    Class function IncCode(Str:string;pLen:Integer):string;
    //����ַ����Ƿ���[0..9]���������
    Class function IsNumberChar(Str:string):Boolean;
    Class function IsCodeString(Str:string):Boolean;
    Class function FormatStringEx(Str:string;Len:Integer;C:Char='0'):string;
    Class function FormatStringBack(Str:string;Len:Integer;C:Char='0'):string;
    Class function GetBarCode(ID:string;Len:Integer=13):string;
    Class function GetCodeFlag(data:string):string;
    Class function GetBarProCode(ID:string;Size,Color:string):string;
    Class function IsCustBarCode(BarCode:string):Boolean;
    Class function CheckBankCode(Str:string):Boolean;
    //�ж��Ƿ�������
    Class function IsBarCode(BarCode:string):Boolean;
    Class function GetBarCodeID(BarCode:string):string;
    Class function GetBarCodeColor(BarCode:string):string;
    Class function GetBarCodeSize(BarCode:string):string;
    Class function IsNull(s:string):string;
    Class function CopyWideString(s:WideString;Start,wLen:Integer):string;
    Class function GetDight(s:integer):string;
    Class function TrimRight(s:string;len:integer):string;
  end;
FnSystem=Class
  public
    Class function GetGuid:string;
    Class function GetWinTmp:string;
    Class function GetWindowDir:string;
    Class function GetWinDir:string;
    Class function GetNetBIOSAddr:string;
  end;
  

//ʮ������(S)-->>ʮ����(I)  [��д:Jey]
function hextoint(s: string): Integer;
//������(S)-->>ʮ����(D)    [��д:Jey]
function Bintoint(s: string): double;
//ʮ����ת��Ϊ�������ַ���  [��д:Jey]
function inttoBin(i: integer): string;
implementation
uses NB30;
{$R wbtext.res} //��Դ�ļ�������

//ʮ������(S)-->>ʮ����(I)  [��д:Jey]
function hextoint(s: string): Integer;
begin          //$����16����
  Result:=StrToInt('$'+s);
end;

//ʮ����ת��Ϊ�������ַ���  [��д:Jey]
function inttoBin(i: integer): string;
begin
 while i <>0 do
 begin          //i mod 2ȡģ,��ʹ��format��ʽ��
   result:=Format('%d'+result,[i mod 2]);
   i:=i div 2
 end
end;

//������(S)-->>ʮ����(D)    [��д:Jey]
function Bintoint(s: string): double;
begin
  result := 0;
  while Length(s) <>0 do
  begin          //2^(����-1)�η�
    if s[1]='1' then  Result:=Result+power(2,Length(s)-1);
    s:=Copy(s,2,Length(s));
  end
end;
{ FnTime }

class function FnTime.fnDatetimeToStr(pDate: TDateTime): string;
begin
 Result := FormatDatetime('YYYYMMDDHHNNSS',pDate);
end;

class function FnTime.fnIncMonth(aMonth: String;pInc:Integer=1): string;
var Y,M:Integer;
begin
  Y := StrtoInt(Copy(aMonth,1,4));
  if Length(aMonth)=6 then
     M := StrtoInt(Copy(aMonth,5,2))
  else
     M := StrtoInt(Copy(aMonth,6,2));

  if Length(aMonth)=6 then
     Result := FormatDatetime('YYYYMM',IncMonth(EncodeDate(Y,M,1),pInc))
  else
     Result := FormatDatetime('YYYY/MM',IncMonth(EncodeDate(Y,M,1),pInc));
end;

class function FnTime.fnStrToDatetime(Str: string): TDateTime;
var Y,M,D:Word;
    H,N,S:Word;
begin
  Y := StrtoInt(Copy(Str,1,4));
  M := StrtoInt(Copy(Str,5,2));
  D := StrtoInt(Copy(Str,7,2));
  H := StrtoInt(Copy(Str,9,2));
  N := StrtoInt(Copy(Str,11,2));
  S := StrtoInt(Copy(Str,13,2));

  Result := EncodeDate(Y,M,D)+EncodeTime(H,N,S,0);

end;

class function FnTime.fnStrtoDate(Str: string): TDate;
var Y,M,D:Word;
begin
  try
  if Length(Str)=8 then
     begin
      Y := StrtoInt(Copy(Str,1,4));
      M := StrtoInt(Copy(Str,5,2));
      D := StrtoInt(Copy(Str,7,2));
     end
  else
     begin
      Y := StrtoInt(Copy(Str,1,4));
      M := StrtoInt(Copy(Str,6,2));
      D := StrtoInt(Copy(Str,9,2));
     end;
  Result := EnCodeDate(Y,M,D);
  Except
     Raise Exception.CreateFmt('%s��Ч�������ַ�����',[Str]); 
  end;
end;

class function FnTime.FormatDateStr(Date: string): String;
var Y,M,D:WORD;
begin
   Y := StrtoInt(Copy(Date,1,4));
   M := StrtoInt(Copy(Date,5,2));
   D := StrtoInt(Copy(Date,7,2));
   Result := FormatDatetime('YYYY/MM/DD',EncodeDate(Y,M,D));
end;

class function FnTime.FormatExtDatetime(pDate: TDatetime): String;
var
    Y,M,D:Word;
    H,N,S,MM:Word;
begin
  DecodeTime(pDate,H,N,S,MM);
  DecodeDate(pDate,Y,M,D);

  Result := '';
  if S>0 then
     Result := Inttostr(S)+'��'+Result;
  if N>0 then
     Result := Inttostr(N)+'��'+Result;
  if H>0 then
     Result := Inttostr(H)+'ʱ'+Result;

  D := Round(EncodeDate(Y,M,D));
  if D>0 then
     Result := Inttostr(D)+'��';
end;

class function FnTime.FormatSecond(Second: Integer): string;
var M,H,N,S:Integer;
begin
  H := Second DIV 3600;
  M := Second MOD 3600;
  N := M DIV 60;
  S := M MOD 60;
  result := '';
  if H<>0 then
     Result := Result +Inttostr(H)+'ʱ';
  if N<>0 then
     Result := Result +Inttostr(N)+'��';
  Result := Result +Inttostr(S)+'��';
end;

class function FnTime.GetLastDate(Month: String): String;
var D:TDate;
begin
  D := FnTime.fnStrtoDate(Month+'01');
  D := IncMonth(D,1);
  Result := FormatDatetime('YYYYMMDD',D-1);
end;

{ FnNumber }

class function FnNumber.CompareFloat(a, b: real): integer;
var
  _a,_b:currency;
begin
  _a := a;
  _b := b;
  if _a>_b then result := 1
  else
  if _a<_b then result := -1
  else
    result := 0;
end;

class function FnNumber.ConvertToFight(value: Currency; CarryRule,
  deci: Integer): real;
var s:string;
  n,w:integer;
  jw:Currency;
begin
  if CarryRule=0 then
  begin
    if Deci=0 then
       s := FormatFloat('#0',value);
    if Deci=1 then
       s := FormatFloat('#0.0',value);
    if Deci=2 then
       s := FormatFloat('#0.00',value);
    if Deci=3 then
       s := FormatFloat('#0.000',value);
    result := StrtoFloat(s);
    exit;
  end;
  if CarryRule=2 then
  begin
    if Deci=0 then
       result := Trunc(value);
    if Deci=1 then
       result := Trunc(value*10)/10;
    if Deci=2 then
       result := Trunc(value*100)/100;
    if Deci=3 then
       result := Trunc(value*1000)/1000;
    exit;
  end;
  if CarryRule=1 then
  begin
    if Deci=0 then
      s := FormatFloat('#0',value);
    if Deci=1 then
      s := FormatFloat('#0.0',value);
    if Deci=2 then
      s := FormatFloat('#0.00',value);
    if Deci=3 then
      s := FormatFloat('#0.000',value);
    n := length(s);
    if StrtoInt(s[n]) in [1..4] then
       begin
         s[n] := '5';
         Result := StrtoFloat(s);
       end
    else
    if StrtoInt(s[n]) in [6..9] then
       begin
         s[n] := '0';
         if Deci=0 then
           jw := 10;
         if Deci=1 then
           jw := 1;
         if Deci=2 then
           jw := 0.1;
         if Deci=3 then
           jw := 0.01;
         Result := StrtoFloat(s)+jw;
       end
    else
       Result := StrtoFloat(s);
  end;
  if CarryRule=3 then
  begin
    if Deci=0 then
      s := FormatFloat('#0',value);
    if Deci=1 then
      s := FormatFloat('#0.0',value);
    if Deci=2 then
      s := FormatFloat('#0.00',value);
    if Deci=3 then
      s := FormatFloat('#0.000',value);
    n := length(s);
    if StrtoInt(s[n]) in [1..4] then
       begin
         s[n] := '0';
         Result := StrtoFloat(s);
       end
    else
    if StrtoInt(s[n]) in [6..9] then
       begin
         s[n] := '0';
         if Deci=0 then
           jw := 10;
         if Deci=1 then
           jw := 1;
         if Deci=2 then
           jw := 0.1;
         if Deci=3 then
           jw := 0.01;
         Result := StrtoFloat(s)+jw;
       end
    else
       Result := StrtoFloat(s);
  end;
  if CarryRule=4 then
  begin
    if Deci=0 then
       result := Trunc(value);
    if Deci=1 then
       result := Trunc(value*10)/10;
    if Deci=2 then
       result := Trunc(value*100)/100;
    if Deci=3 then
       result := Trunc(value*1000)/1000;
    if result < value then
       begin
         if Deci=0 then
           jw := 1;
         if Deci=1 then
           jw := 0.1;
         if Deci=2 then
           jw := 0.01;
         if Deci=3 then
           jw := 0.001;
         Result := result+jw;
       end;
  end;
end;

class function FnNumber.SmallTOBig(small: real): string;
const
   cNum: WideString = '��Ҽ��������½��ƾ�--��Ǫ��ʰ��Ǫ��ʰ��Ǫ��ʰԪ�Ƿ�';
   cCha:array[0..1, 0..12]of string =
        (( '��Ԫ','��ʰ','���','��Ǫ','����','����','����','������','����','����','����','����','��Ԫ'),
         ( 'Ԫ','��','��','��','��','��','��','��','��','��','��','��','Ԫ'));
  var i : Integer;
      sNum,sTemp : WideString;
      flag:string;
begin
  result :='';
  if small<0 then flag := '(��)' else flag := '';
  sNum := format('%15d',[round(abs(small) * 100)]);
  for i := 0 to 14 do
  begin
    stemp := copy(snum,i+1,1);
    if stemp=' ' then continue
    else result := result + cNum[strtoint(stemp)+1] + cNum[i+13];
  end;
  for i:= 0 to 12 do
  Result := StringReplace(Result, cCha[0,i], cCha[1,i], [rfReplaceAll]);
  if pos('���',result)=0
    then Result := StringReplace(Result, '���', '��', [rfReplaceAll])
    else Result := StringReplace(Result, '���','��', [rfReplaceAll]);
  Result := flag + StringReplace(Result, '���','', [rfReplaceAll]);
end;

{ FnSystem }

Class function FnSystem.GetGuid: string;
var
 id:tguid;
begin
if CreateGUID(id)=s_ok then
result:=guidtostring(id);
end;

class function FnSystem.GetNetBIOSAddr: string;
var  ncb  : TNCB;
  status  : TAdapterStatus;
  lanenum : TLanaEnum;
    procedure ResetAdapter (num : char);
    begin
      fillchar(ncb,sizeof(ncb),0);
      ncb.ncb_command:=char(NCBRESET);
      ncb.ncb_lana_num:=num;
      Netbios(@ncb);
    end;
var
  i:integer;
  lanNum  : char;
  address : record
             part1 : Longint;
             part2 : Word;
            end absolute status;
begin
  Result:='';
  fillchar(ncb,sizeof(ncb),0);
    ncb.ncb_command:=char(NCBENUM);
    ncb.ncb_buffer:=@lanenum;
    ncb.ncb_length:=sizeof(lanenum);
  Netbios(@ncb);
  if lanenum.length=#0 then exit;
  lanNum:=lanenum.lana[0];
  ResetAdapter(lanNum);
  fillchar(ncb,sizeof(ncb),0);
    ncb.ncb_command:=char(NCBASTAT);
    ncb.ncb_lana_num:=lanNum;
    ncb.ncb_callname[0]:='*';
    ncb.ncb_buffer:=@status;
    ncb.ncb_length:=sizeof(status);
  Netbios(@ncb);
  ResetAdapter(lanNum);
  for i:=0 to 5 do
  begin
    result:=result+inttoHex(integer(Status.adapter_address[i]),2);
    if (i<5) then
    result:=result+'-';
  end;
end;

class function FnSystem.GetWinDir: string;
Var Len:DWord;
    Fp:Pchar;
Begin
  Len:=Max_Path+1;
  GetMem(Fp,Len);
  GetWindowsDirectory(Fp,Len);
  Result:=StrPas(Fp);
  FreeMem(Fp);
end;

class function FnSystem.GetWindowDir: string;
Var Len:DWord;
    Fp:Pchar;
Begin
  Len:=Max_Path+1;
  GetMem(Fp,Len);
  GetSystemDirectory(Fp,Len);
  Result:=StrPas(Fp);
  FreeMem(Fp);

end;

class function FnSystem.GetWinTmp: string;
Var Len:DWord;
    Fp:Pchar;
Begin
  Len:=Max_Path+1;
  GetMem(Fp,Len);
  GetTempPath(Len,Fp);
  Result:=StrPas(Fp);
  FreeMem(Fp);
end;

{ FnString }

class function FnString.CopyWideString(s: WideString; Start,
  wLen: Integer): string;
begin
  result := Copy(s,Start,wLen);
end;

class function FnString.FormatStringBack(Str: string; Len: Integer;
  C: Char): string;
var i:Integer;
begin
  Result := Str;
  for i:=Length(Result)+1 to Len do
    Result := Result+C;
end;

class function FnString.FormatStringEx(Str: string; Len: Integer;C:Char='0'): string;
var i:Integer;
begin
  Result := Str;
  for i:=Length(Result)+1 to Len do
    Result := C + Result;
end;

class function FnString.GetBarCode(ID:string;Len:Integer=13): string;
  function GetCodeFlag(data:String): String;
        var i,fak,sum : Integer;  begin
          sum := 0;
          fak := Length(data);
          for i:=1 to Length(data) do
          begin
                  if (fak mod 2) = 0 then
                          sum := sum + (StrToInt(data[i])*1)
                  else
                          sum := sum + (StrToInt(data[i])*3);
                  dec(fak);
          end;
          if (sum mod 10) = 0 then
                  result := data+'0'
          else
                  result := data+IntToStr(10-(sum mod 10));
  end;var s:string;
begin
  if not( Length(ID) in [6,7]) then
     Raise Exception.Create('��������λ������6��7λ');
  if Length(ID)=6 then
     s := '9'+FnString.FormatStringBack(ID,6)
  else
     s := '8'+FnString.FormatStringBack(ID,7);
  s := FnString.FormatStringBack(s,Len-1);
  Result := GetCodeFlag(s);
end;

class function FnString.GetBarCodeColor(BarCode: string): string;
begin
  if Length(BarCode)<13 then
     begin
       result := '#';
       Exit;
     end;
  Result := '0'+copy(BarCode,11,2);
  if Result = '000' then Result := '#';
end;
class function FnString.GetBarCodeID(BarCode: string): string;
begin
  if BarCode[1]='8' then
     Result := copy(BarCode,2,7)
  else
     Result := copy(BarCode,2,6);
end;
class function FnString.GetBarCodeSize(BarCode: string): string;
begin
  if Length(BarCode)<13 then
     begin
       result := '#';
       Exit;
     end;
  Result := '0'+copy(BarCode,9,2);
  if Result = '000' then Result := '#';
end;
class function FnString.GetBarProCode(ID, Size, Color: string): string;
  function GetCodeFlag(data:String): String;
        var i,fak,sum : Integer;  begin
          sum := 0;
          fak := Length(data);
          for i:=1 to Length(data) do
          begin
                  if (fak mod 2) = 0 then
                          sum := sum + (StrToInt(data[i])*1)
                  else
                          sum := sum + (StrToInt(data[i])*3);
                  dec(fak);
          end;
          if (sum mod 10) = 0 then
                  result := data+'0'
          else
                  result := data+IntToStr(10-(sum mod 10));
  end;
var s,m:string;
begin
  if not( Length(ID) in [6]) then
     Raise Exception.Create('��������λ������6λ');
  if Length(Size)<>2 then
     Raise Exception.Create('�������ڱ�����2λ����');
  if Length(Color)<>3 then
     Raise Exception.Create('��ɫ���ڱ�����3λ����');
  s := '9'+FnString.FormatStringEx(ID,6)+FnString.FormatStringEx(Size,2)+FnString.FormatStringEx(Color,3);
  Result := GetCodeFlag(s);
end;

class function FnString.GetCodeFlag(data: string): string;
var i,fak,sum : Integer;
begin
  sum := 0;
  fak := Length(data);
  for i:=1 to Length(data) do
  begin
          if (fak mod 2) = 0 then
                  sum := sum + (StrToInt(data[i])*1)
          else
                  sum := sum + (StrToInt(data[i])*3);
          dec(fak);
  end;
  if (sum mod 10) = 0 then
          result := data+'0'
  else
          result := data+IntToStr(10-(sum mod 10));
end;
class function FnString.GetDight(s: integer): string;
var i:integer;
begin
  if s=0 then
     result := '#0'
  else
     result := '#0.';
  for i:=1 to s do result := result +'0';
end;

class function FnString.IncCode(Str:string;pLen:Integer): string;
  function GetFormat:string;
    var i:Integer;
    begin
      Result := '';
      for i:=1 to pLen do Result := Result +'0';
    end;
  procedure IncChar(var c:Char;w:Integer);
    var vc:char;
        n:Integer;
    begin
      n := pos(c,CodeFormat);
      if n<88 then Result[w] := CodeFormat[n+1]
      else
         begin
           Result[w] := '0';
           if (w-1)=0 then Exit;
           IncChar(Result[w-1],w-1);
         end;
    end;
var IsNumber:Boolean;
    vLen:Integer;
begin
  IsNumber := IsNumberChar(Str);
  if IsNumber then
     begin
        Result := FormatFloat(GetFormat,StrtoInt(Str)+1);
     end
  else
     begin
        Result := FormatStringEx(Str,pLen);
        vLen := Length(Result);
        IncChar(Result[vLen],vLen);
     end;
end;                                            
class function FnString.IsCodeFormat(Key: Char): Boolean;
begin
  Result := (Pos(Key,CodeFormat)>0) or (Key=#8);
end;

class function FnString.IsCustBarCode(BarCode: string): Boolean;
  function GetCodeFlag(data:String): String;
        var i,fak,sum : Integer;  begin
          sum := 0;
          fak := Length(data);
          for i:=1 to Length(data) do
          begin
                  if (fak mod 2) = 0 then
                          sum := sum + (StrToInt(data[i])*1)
                  else
                          sum := sum + (StrToInt(data[i])*3);
                  dec(fak);
          end;
          if (sum mod 10) = 0 then
                  result := data+'0'
          else
                  result := data+IntToStr(10-(sum mod 10));
  end;begin
  result := false;
  if BarCode='' then Exit;
  Result := ((BarCode[1]='9') or (BarCode[1]='8')) and (Length(BarCode) in [8,13])
      and (GetCodeFlag(copy(BarCode,1,length(BarCode)-1))=BarCode)
      ;
end;

class function FnString.IsNull(s: string): string;
begin
  if s='' then result := 'null' else result := ''''+s+'''';
end;

class function FnString.IsNumberChar(Str: string): Boolean;
var i,r:Integer;
begin
  Result := True;
  if Str[1]='-' then  r := 2 else r := 1;
  for i:=r to Length(Str) do
    begin
      if not(Str[i] in ['0'..'9','.']) then
         begin
           Result := False;
           Exit;
         end;
    end;
  if str='.' then result := false;
  if str='-' then result := false;
end;

class function FnString.GetWordSpell(hzstr: string;codetype: integer): string;
var
  I: Integer;
  allstr: string;
  hh: THandle;
  pp: pointer;
  ss: TStringList;
  
  function retturn_wbpy(tempstr: string; tqtype: integer): string;
  var
    outstr, str: string;
    i: integer;
  begin
  //################### ���ֲ�ѯ��λ
    i := 0;
    while i <= ss.Count - 1 do
    begin
      str := ss.Strings[i];
      if (tempstr = trim(str[1] + str[2])) or (tempstr = trim(str[3] + str[4])) then
      begin
        str := ss.Strings[i];
        Break;
      end;
      i := i + 1;
    end;
  //###################

    outstr := '';     //��ȡ����
    if tqtype = 1 then
    begin
      for i := pos('��', str) + 2 to pos('��', str) - 1 do
        if str[i] <> '' then if outstr = '' then outstr := str[i] else outstr := outstr + str[i];
    end;

    if tqtype = 2 then
    begin
      for i := pos('��', str) + 2 to pos('��', str) - 1 do
        if str[i] <> '' then if outstr = '' then outstr := str[i] else outstr := outstr + str[i];
    end;

    if tqtype = 3 then
    begin
      for i := pos('��', str) + 2 to pos('��', str) - 1 do
        if str[i] <> '' then if outstr = '' then outstr := str[i] else outstr := outstr + str[i];
    end;

    if tqtype = 4 then
    begin
      for i := pos('��', str) + 2 to length(str) do
        if str[i] <> '' then if outstr = '' then outstr := str[i] else outstr := outstr + str[i];
    end;
    Result := trim(outstr);
  end;

begin
  result := '';
  if trim(hzstr)='' then Exit;
  //������Դ�ļ�,�����ݸ�ֵ�� s
  ss := TStringList.Create;
  try
    hh := FindResource(hInstance, 'mywb', 'TXT');
    hh := LoadResource(hInstance, hh);
    pp := LockResource(hh);
    ss.Text := pchar(pp);
    UnLockResource(hh);
    FreeResource(hh);

    allstr := '';
    i := 0;
    while i <= length(hzstr) do   //��ȡ�����ַ�
    begin
      if (Ord(hzstr[I]) > 127) then
      begin
        if allstr = '' then allstr := retturn_wbpy(hzstr[I] + hzstr[I + 1], codetype) else allstr := allstr + retturn_wbpy(hzstr[I] + hzstr[I + 1], codetype);
        i := i + 2;
      end
      else
      begin
        if allstr = '' then allstr := hzstr[I] else allstr := allstr + hzstr[I];
        i := i + 1;
      end;
    end;
  finally
    ss.Free;
  end;
  Result := trim(allstr);
end;

class function FnString.IsCodeString(Str: string): Boolean;
var i:Integer;
begin
  Result := true;
  for i:=1 to Length(Str) do
    begin
      if not FnString.IsCodeFormat(Str[i]) then
         begin
           Result := false;
           Exit;
         end;
    end;
end;

class function FnString.CheckBankCode(Str: string): Boolean;
function GetCodeFlag(data: string): string;
var i,fak,sum : Integer;
begin
  sum := 0;
  fak := 1;
  for i:=Length(data) downto 1 do
  begin
          if (fak mod 2) = 0 then
                  sum := sum + (StrToInt(data[i])*1)
          else
                  sum := sum + ((StrToInt(data[i])*2) div 10) + ((StrToInt(data[i])*2) mod 10);
          inc(fak);
  end;
  if (sum mod 10) = 0 then
          result := data+'0'
  else
          result := data+IntToStr(10-(sum mod 10));
end;

begin
  result := false;
  if length(Str) in [16,19,20] then
     begin
       result := GetCodeFlag(copy(Str,1,length(Str)-1))=Str;
     end;

end;

class function FnString.IsBarCode(BarCode: string): Boolean;
  function GetCodeFlag(data:String): String;
        var i,fak,sum : Integer;  begin
          sum := 0;
          fak := Length(data);
          for i:=1 to Length(data) do
          begin
                  if (fak mod 2) = 0 then
                          sum := sum + (StrToInt(data[i])*1)
                  else
                          sum := sum + (StrToInt(data[i])*3);
                  dec(fak);
          end;
          if (sum mod 10) = 0 then
                  result := data+'0'
          else
                  result := data+IntToStr(10-(sum mod 10));
  end;begin
  result := false;
  if BarCode='' then Exit;
  Result := (Length(BarCode)>=5)
      and (GetCodeFlag(copy(BarCode,1,length(BarCode)-1))=BarCode)
      ;
end;

class function FnString.TrimRight(s: string; len: integer): string;
begin
  result := trim(s);
  result := copy(result,length(result)-len+1,len);
end;

end.
