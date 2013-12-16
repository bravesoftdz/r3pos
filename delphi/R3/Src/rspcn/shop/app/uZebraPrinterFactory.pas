unit uZebraPrinterFactory;

interface

uses Windows,SysUtils,math,ZDataSet,winspool;

const
  dllname = 'fnthex32.dll';

type
TGetFontHEX=function(chnstr,fontname: string; orient,height,width,bold,italic: integer; hexbuf: string): integer;stdcall;

TZebraPrinterFactory=class
  private
    dllLoaded: boolean;
    dllValid: boolean;
    zplStr: string;
    PrinterName:  string;
  protected
    CodePrinterHandle: THandle;
    GetFontHEX: TGetFontHEX;
    procedure LoadCodePrinterFactory;
    procedure FreeCodePrinterFactory;
  public
    constructor Create;
    destructor Destroy;override;
    function OpenPriterZ(pName:string;var pHandle: THandle): boolean;
    function ClosePrintZ(pHandle:THandle): boolean;
    function Setup(LabelFlag,LabelWidth,LabelHeight,LabelGap :Integer): boolean;
    function ClearBuffer: boolean;
    function WindowsFont(X,Y,FontSize,xmf,ymf: integer;Font,Chnstr: String): boolean;
    function WindowsAztex(X, Y, mf2: integer;mf1: real; pstr1,pstr2,Chnstr: String): boolean;
    function GetPrintStart:boolean;
    function GetPrintEnd:boolean;
    function SetPrintFrequency(num: Integer):boolean;
    function GetChnStr(chastr,fontname: string;height: integer): string;
    procedure WriteRawStringToPrinter(PrinterName, printStr: String);overload;
    procedure WriteRawStringToPrinter(pHandle:THandle;PString:String);overload;
    function PrintCode(data: OleVariant; FHandle:HWnd; pName:String): boolean;
    function GetUnitRate(GodsId,UnitId: string):Currency;
  end;

var ZebraPrinterFactory: TZebraPrinterFactory;

implementation
uses udllGlobal,udataFactory,uTokenFactory,ObjCommon,EncDec;


constructor TZebraPrinterFactory.Create;
begin
  LoadCodePrinterFactory;
end;

destructor TZebraPrinterFactory.Destroy;
begin
  FreeCodePrinterFactory;
  inherited;
end;

procedure TZebraPrinterFactory.LoadCodePrinterFactory;
begin
  dllLoaded := false;
  dllValid := false;

  { //不打印汉字时不用加 fnthex32.dll
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  CodePrinterHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0)) + dllname));
  if CodePrinterHandle = 0 then Exit;
  dllLoaded := true;
  
  @GetFontHEX := GetProcAddress(CodePrinterHandle, 'GETFONTHEX');
  if @GetFontHEX = nil then Exit;
   }

  dllValid := true;
end;

procedure TZebraPrinterFactory.FreeCodePrinterFactory;
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + dllname) then Exit;
  if not dllLoaded then Exit;
  dllLoaded := false;
  dllValid := false;
  FreeLibrary(CodePrinterHandle);
end;

function TZebraPrinterFactory.Setup(LabelFlag,LabelWidth,LabelHeight,LabelGap :Integer):boolean;
var code: integer;
begin

 result:= true;
end;

function TZebraPrinterFactory.ClearBuffer:boolean;
var code: integer;
var str: string;
begin
  result:= false;
  if zplStr<>'' then zplStr:= '';
//  str:= '^XA~JA^XZ';
//  zplStr:= zplStr + str;
  result:= true;
end;

function TZebraPrinterFactory.PrintCode(data: OleVariant;FHandle: HWnd; pName:String): boolean;
var
  printTime: TDateTime;
  rs,cs,ss,gs: TZQuery;
  LinkMan,ShopName,LicenseCode,GodsId,GodsName,BarCode,UnitId,Address,Telphone: string;
  Aprice,Amt,UnitRate: Currency;
  i,SeqNo: integer;
  pHandle: THandle;
begin
  result := false;

  if not dllValid then Exit;

  cs := dllGlobal.GetZQueryFromName('CA_TENANT');
  ss := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  gs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

  if ss.RecordCount > 1 then
     ShopName := token.shopName
  else
     ShopName := cs.FieldByName('SHORT_TENANT_NAME').AsString;

  if ss.Locate('SHOP_ID',token.shopId,[]) then
  begin
     LinkMan := ss.FieldByName('LINKMAN').AsString;
     Address := ss.FieldByName('ADDRESS').AsString;
     Telphone := ss.FieldByName('TELEPHONE').AsString;
  end
  else
  begin
     LinkMan := '未知';
     Address := '未知';
     Telphone := '未知';
  end;

  LicenseCode := ss.FieldByName('LICENSE_CODE').AsString;

  PrinterName:= pName;
  rs := TZQuery.Create(nil);
  try
    rs.Data := data;
    printTime := now();
    if OpenPriterZ(PrinterName,pHandle) then
    begin
      try
      rs.First;
      while not rs.Eof do
        begin
          SeqNo := rs.FieldByName('SEQNO').AsInteger;
          GodsId := rs.FieldByName('GODS_ID').AsString;
          GodsName := rs.FieldByName('GODS_NAME').AsString;
          UnitId := rs.FieldByName('UNIT_ID').AsString;
          Aprice := rs.FieldByName('APRICE').AsFloat;
          BarCode := rs.FieldByName('BARCODE').AsString;
          Amt := rs.FieldByName('AMOUNT').AsFloat;
          UnitRate := GetUnitRate(GodsId,UnitId);

          if gs.Locate('GODS_ID',GodsId,[]) then // 只打印卷烟商品
            begin
              if gs.FieldByName('RELATION_ID').AsInteger <> 1000006 then
                begin
                  rs.Next;
                  continue;
                end;
            end
          else
            begin
              rs.Next;
              continue;
            end;

          ClearBuffer;
          GetPrintStart;
          //zebra不打印汉字
          //WindowsFont(325, 4, 16, 1, 1, 'Arial','店名:'+ShopName);
          //WindowsFont(325,22, 16, 1, 1, 'Arial','卷烟:'+GodsName);
          //WindowsFont(325,40, 16, 1, 1, 'Arial','价格:'+FormatFloat('#0.00',Aprice)+'元');
          //WindowsFont(325,58, 16, 1, 1, 'Arial','时间:'+FormatDateTime('YYYY年MM月DD日HH点NN分',printTime));     //
          WindowsAztex(364, 3, 26, 3,'','',EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'|'+EncStr(ShopName,ENC_KEY)+'|'+EncStr(Address,ENC_KEY)+'|'+EncStr(Telphone,ENC_KEY)+'|'+EncStr(GodsName,ENC_KEY));
          SetPrintFrequency(Trunc(Amt));
          GetPrintEnd;
          WriteRawStringToPrinter(pHandle,zplStr);

          if (Amt - Trunc(Amt)) <> 0 then //处理小数部分
            begin
              if unitId = gs.FieldByName('CALC_UNITS').AsString then
                begin
                  MessageBox(FHandle,pchar('第'+IntToStr(SeqNo)+'行商品【'+GodsName+'】数量不是有效数量！'),'友情提示..',MB_OK);
                end
              else
                begin
                  Amt := (Amt - Trunc(Amt)) * UnitRate;
                  ClearBuffer;
                  GetPrintStart;
                  //zebra不打印汉字
                  //WindowsFont(325, 4, 16, 1, 1, 'Arial','店名:'+ShopName);
                  //WindowsFont(325,22, 16, 1, 1, 'Arial','卷烟:'+GodsName);
                  //WindowsFont(325,40, 16, 1, 1, 'Arial','价格:'+FormatFloat('#0.00',Aprice/UnitRate)+'元');
                  //WindowsFont(325,58, 16, 1, 1, 'Arial','时间:'+FormatDateTime('YYYY年MM月DD日HH点NN分',printTime));
                  WindowsAztex(364, 3, 26, 3,'','',EncStr(LinkMan,ENC_KEY)+'|'+LicenseCode+'|'+BarCode+'|'+FormatFloat('#0.00',Aprice)+'|'+FormatDateTime('YYYYMMDDHHNNSSZZZ',printTime)+'|'+EncStr(ShopName,ENC_KEY)+'|'+EncStr(Address,ENC_KEY)+'|'+EncStr(Telphone,ENC_KEY)+'|'+EncStr(GodsName,ENC_KEY));
                  SetPrintFrequency(Trunc(Amt));
                  GetPrintEnd;
                  WriteRawStringToPrinter(pHandle,zplStr);

                  if (Amt - Trunc(Amt)) <> 0 then MessageBox(FHandle,pchar('第'+IntToStr(SeqNo)+'行商品【'+GodsName+'】数量不是有效数量！'),'友情提示..',MB_OK);
                end;
            end;
          rs.Next;
        end;
    finally
      ClosePrintZ(pHandle);
    end;
    end;
  finally
    rs.Free;
  end;
end;

function TZebraPrinterFactory.GetChnStr(chastr,fontname: string;height: integer): string;
var
  buf, ret: string;
  count: integer;
begin
  result := '';
  setlength(buf, 21 * 1024);
  count := GetFontHEX(chastr, fontname, 0, height, 0, 0, 0, buf);
   if count > 0 then
  begin
    ret := Copy(buf, 1, count);
    result := ret;
  end;
end;

function TZebraPrinterFactory.WindowsFont(X,Y,FontSize,xmf,ymf: integer;Font,Chnstr: String):boolean;
var str:  string;
begin
  result := false;
  str:= '';
  if Chnstr='' then exit;
  str:= GetChnStr(Chnstr,Font,FontSize);
  if str<>'' then
  begin
    str:=str +'^LH'+ inttostr(x) + ',' + inttostr(y);
    str:=str + '^FO2,2^XGOUTSTR01,' + inttostr(xmf) + ',' + inttostr(ymf) + '^FS';
    result:= true;
  end;
  zplStr:=zplStr+str;
end;

function TZebraPrinterFactory.WindowsAztex(X, Y, mf2: integer;mf1: real; pstr1,pstr2,Chnstr: String): boolean;
var str:  string;
begin
  result := false;
  str:= '';
  if Chnstr<>'' then
  begin
    str:=str+'^LH'+ inttostr(x) + ',' + inttostr(y) ;
    //mf1 设置大小； mf2 设置需要编码的列
    str:=str + '^BXN,'+floattostr(mf1)+',200'+'^FD' + Chnstr + '^FS';  //+inttostr(mf2)+','+inttostr(mf2)
    result:= true;
  end;
  zplStr:=zplStr+str;
end;
     
function TZebraPrinterFactory.GetPrintEnd: boolean;
var str: string;
begin
  result:= false;
  if zplStr='' then exit;
  str:= '^XA';
  if zplStr <> str then
    zplStr:= zplStr + '^XZ'
  else
    zplStr:= '';  

  result:= true;
end;

function TZebraPrinterFactory.GetPrintStart: boolean;
var str: string;
begin
  result:= false;
  //if zplStr<>'' then zplStr:= '';   //不用ClearBuffer时，zapStr需要置空，不然会多次打印
  str:= '^XA';

  zplStr:=zplStr + str;
  result:= true;
end;

function TZebraPrinterFactory.SetPrintFrequency(num: Integer): boolean;
var str: string;
begin
  result:= false;
  str:= '';
  if num>0 then
    str:= '^PQ'+inttostr(num)
  else
    str:= '^PQ1';
  zplStr:= zplStr + str;

  result:= true;
end;

function TZebraPrinterFactory.OpenPriterZ(pName: string;var pHandle: THandle): boolean;
begin
  result:= false;
  if pName = '' then
    Raise Exception.Create('请选择打印二维码打印机！');
  try
    if not OpenPrinter(PChar(PrinterName), pHandle, nil) then
    begin
      Raise Exception.Create('无法打开'+PrinterName+'打印机！');
    end;

  except
     on E:Exception do
     begin
       Raise Exception.Create(E.Message);
     end;
  end;
  result:= true;
end;

procedure TZebraPrinterFactory.WriteRawStringToPrinter(PrinterName, printStr: String);
var
  pHandle: THandle;
  N: DWORD;
  DocInfo1: TDocInfo1;
begin
  try
    if PrinterName = '' then
      Raise Exception.Create('请选择打印二维码打印机！');
      
    if printStr = '' then Exit;
    
    try
      if not OpenPrinter(PChar(PrinterName), pHandle, nil) then
      begin
        Raise Exception.Create('无法打开'+PrinterName+'打印机！');
      end;

      with DocInfo1 do begin
        pDocName := PChar('print doc'); {在打印列表中显示的打印内容}
        pOutputFile := nil;
        pDataType := 'RAW';            {关键，数据类型必须是RAW，这样打印机通过驱动程序才能识别ZPL语言}
      end;

      if StartDocPrinter(pHandle, 1, @DocInfo1) =0 then
      begin
        ClosePrinter(pHandle);
        Exit;
      end;
      if not StartPagePrinter(pHandle) then
      begin
        EndDocPrinter(pHandle);
        ClosePrinter(pHandle);
        Exit;
      end;
      WritePrinter(pHandle, PChar(printStr), Length(printStr), N);
      EndPagePrinter(pHandle);
      EndDocPrinter(pHandle);
      ClosePrinter(pHandle);
    except
      on E:Exception do
      begin
        Raise Exception.Create(E.Message);
      end;
    end;

  finally

  end;
end;

procedure TZebraPrinterFactory.WriteRawStringToPrinter(pHandle: THandle;PString: String);
var
  N: DWORD;
  DocInfo1: TDocInfo1;
begin
  try
    if PString= '' then exit;
    
    with DocInfo1 do begin
      pDocName := PChar('print doc'); {在打印列表中显示的打印内容}
      pOutputFile := nil;
      pDataType := 'RAW';            {关键，数据类型必须是RAW，这样打印机通过驱动程序才能识别ZPL语言}
    end;

    if StartDocPrinter(pHandle, 1, @DocInfo1) =0 then
    begin
      ClosePrinter(pHandle);
      Exit;
    end;
    if not StartPagePrinter(pHandle) then
    begin
      EndDocPrinter(pHandle);
      ClosePrinter(pHandle);
      Exit;
    end;
    WritePrinter(pHandle, PChar(PString), Length(PString), N);
    EndPagePrinter(pHandle);
    EndDocPrinter(pHandle);
  except
    on E:Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;
end;

function TZebraPrinterFactory.ClosePrintZ(pHandle: THandle): boolean;
begin
  try
    ClosePrinter(pHandle);
  except
    on E:Exception do
    begin
      Raise Exception.Create(E.Message);
    end;
  end;
end;

function TZebraPrinterFactory.GetUnitRate(GodsId,
  UnitId: string): Currency;
var
  rs: TZQuery;
  SourceScale: Currency;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  SourceScale := 1;
  if rs.Locate('GODS_ID',GodsId,[]) then
    begin
      if unitId = rs.FieldByName('CALC_UNITS').AsString then
        begin
          SourceScale := 1;
        end
      else
      if unitId = rs.FieldByName('BIG_UNITS').AsString then
        begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
        end
      else
      if unitId = rs.FieldByName('SMALL_UNITS').AsString then
        begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
        end
      else
        begin
          SourceScale := 1;
        end;
    end;
  result := SourceScale;
end;


initialization
  ZebraPrinterFactory := TZebraPrinterFactory.Create;
finalization
  if Assigned(ZebraPrinterFactory) then FreeAndNil(ZebraPrinterFactory);
end.
