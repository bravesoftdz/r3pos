unit NSHandler;

interface
uses
  Classes, Windows, Forms, Axctrls, dialogs, SysUtils, ComObj, ActiveX, UrlMon, urlParser;

const
  Class_NSHandler: TGUID = '{C9D74356-44FB-4845-9AF3-CB982D1C8725}';

type
  TNSHandler = class(TComObject, IInternetProtocol)
  private
    Url: string;
    Written, TotalSize: Integer;
    ProtSink: IInternetProtocolSink;
    DataStream: IStream;
  protected
    function Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
      OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
    function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
    function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
    function Terminate(dwOptions: DWORD): HResult; stdcall;
    function Suspend: HResult; stdcall;
    function Resume: HResult; stdcall;
    function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
    function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
      out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
    function LockRequest(dwOptions: DWORD): HResult; stdcall;
    function UnlockRequest: HResult; stdcall;
    function GetDataFromFile(Url: string):HResult;
  end;



implementation

uses
  comserv;

function TNSHandler.Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
  OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
var
  iNeg: IHTTPNegotiate;
  szHeaders, szAdditionalHeaders: PWideChar;
  SrvProv: IServiceProvider;
begin
  Url := trim(szUrl);
  DataStream := nil;
  ProtSink := OIProtSink;
  
  if not isRspcn(Url) then
    Result := INET_E_USE_DEFAULT_PROTOCOLHANDLER
  else begin
    written := 0;

    (OIProtSink as iUnknown).QueryInterface(IServiceProvider, SrvProv);
    if Assigned(SrvProv) then
    begin
      SrvProv.QueryService(IID_IHTTPNegotiate, IID_IHTTPNegotiate, iNeg);
      if Assigned(iNeg) then
      begin
        szHeaders := nil;
        szAdditionalHeaders := nil;
        iNeg.BeginningTransaction(szUrl, szHeaders, 0, szAdditionalHeaders);
      end;
    end;

    result := GetDataFromFile(Url);
    if Failed(result) then Exit;

    szAdditionalHeaders := nil;
    iNeg.OnResponse(201,nil,nil,szAdditionalHeaders);
        
    ProtSink.ReportData(BSCF_FIRSTDATANOTIFICATION, TotalSize, TotalSize);

    ProtSink.ReportResult(S_OK, S_OK, nil);

    result := S_OK;
  end;
end;


function TNSHandler.Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult;
begin
  DataStream.Read(pv, cb, @cbRead);
  Inc(written, cbread);
  if (written = totalSize) then
     result := S_FALSE
  else
     Result := S_OK;// E_PENDING;
end;


function TNSHandler.GetDataFromFile(Url: string):HResult;
var
  F: TFileStream;
  Dummy: INT64;
  urlToken:TurlToken;
begin
  try
    urlToken := decodeUrl(url);

    if urlToken.path='/' then
       Url := stringReplace(ExtractFilePath(Application.exename)+'built-in/'+
          urlToken.moduname,'/','\',[rfReplaceAll])
    else
       Url := stringReplace(ExtractFilePath(Application.exename)+'built-in/'+
          urlToken.path+'/'+urlToken.moduname,'/','\',[rfReplaceAll]);

    F := TFileStream.Create(Url, fmShareDenyNone);
    try
      CreateStreamOnHGlobal(0, True, DataStream);
      TOleStream.Create(DataStream).CopyFrom(F, F.Size);
      DataStream.Seek(0, STREAM_SEEK_SET, Dummy);
      TotalSize := F.Size;
    finally
      F.Free;
    end;
  except
    result := INET_E_RESOURCE_NOT_FOUND;
  end;
end;



function TNSHandler.Terminate(dwOptions: DWORD): HResult; stdcall;
begin
  if Assigned(DataStream) then DataStream._Release;
  if Assigned(Protsink) then Protsink._Release;
  result := S_OK;
end;

function TNSHandler.LockRequest(dwOptions: DWORD): HResult; stdcall;
begin
  result := S_OK;
end;

function TNSHandler.UnlockRequest: HResult;
begin
  result := S_OK;
end;

function TNSHandler.Continue(const ProtocolData: TProtocolData): HResult;
begin
  result := S_OK;
end;

function TNSHandler.Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TNSHandler.Suspend: HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TNSHandler.Resume: HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TNSHandler.Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
  out libNewPosition: ULARGE_INTEGER): HResult;
begin
  result := E_NOTIMPL;
end;

initialization
  begin
    TComObjectFactory.Create(ComServer, TNSHandler, Class_NSHandler,
      'NSHandler', 'NSHandler', ciMultiInstance, tmApartment);
  end;

finalization
end.

