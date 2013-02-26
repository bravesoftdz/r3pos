unit urlParser;

interface
uses
  SysUtils, windows, Classes;
type
  PurlToken=^TurlToken;
  TurlToken=record
    appId:string;
    path:string;
    moduname:string;
    appFlag:integer;
    url:string;
  end;
function decodeUrl(url:string):TurlToken;
function encodeUrl(urltoken:TurlToken):string;
function isRspcn(url:string):boolean;
implementation
function isRspcn(url:string):boolean;
begin
  result := pos('rspcn://', LowerCase(url)) = 1;
end;
function decodeUrl(url:string):TurlToken;
var sl:TStringList;
begin
  result.url := url;
  delete(url,1,8);
  sl := TStringList.Create;
  try
    sl.Delimiter := '/';
    sl.DelimitedText := url;
    if sl.Count=0 then Raise Exception.Create('无效地址'); 
    result.appId := sl[0];
    if result.appId='built-in' then
       result.appFlag := 0
    else
       result.appFlag := 1;
//    sl.Delete(0);
//    if sl.Count=0 then Raise Exception.Create('无效地址'); 
    if sl[sl.count-1]='' then sl.Delete(sl.count-1);
    if sl.Count=0 then Raise Exception.Create('无效地址'); 
    result.moduname := sl[sl.count-1];
    sl.Delete(sl.count-1);
    if sl.Count=0 then
    result.path := '';
    result.path := sl.DelimitedText;
  finally
    sl.Free;
  end;
end;
function encodeUrl(urltoken:TurlToken):string;
begin
  if urltoken.path='/' then
     result := 'rspcn://'+urltoken.appId+urltoken.path+urltoken.moduname
  else
     result := 'rspcn://'+urltoken.appId+'/'+urltoken.path+'/'+urltoken.moduname;
end;
end.
