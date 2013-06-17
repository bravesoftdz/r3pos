unit urlParser;

interface
uses
  SysUtils, windows, Classes,Forms;
type
  PurlToken=^TurlToken;
  TurlToken=record
    appId:string;
    path:string;
    moduname:string;
    appFlag:integer;
    url:string;
    showUrl:string;
  end;
function decodeUrl(url:string):TurlToken;
function encodeUrl(urltoken:TurlToken):string;
function isRspcn(url:string):boolean;
implementation
uses uUcFactory;
function isRspcn(url:string):boolean;
begin
  result := pos('rspcn://', LowerCase(url)) = 1;
end;
function decodeUrl(url:string):TurlToken;
var sl:TStringList;
begin
  result.url := url;
  result.showUrl := url;
  delete(url,1,8);
  sl := TStringList.Create;
  try
    sl.Delimiter := '/';
    sl.DelimitedText := url;
    if sl.Count=0 then Raise Exception.Create('无效地址'); 
    result.appId := sl[0];
    if result.appId='built-in' then
       begin
         result.appFlag := 0;
         sl.Delete(0);
       end
    else
    if result.appId='xsm-in' then
       begin
         result.appFlag := 0;
         sl.Delete(0);
       end
    else
    if result.appId='local-in' then
       begin
         sl.Delete(0); 
         result.appFlag := 0;
         delete(url,1,8);
         result.url := 'file:///'+StringReplace(ExtractFilePath(Application.ExeName),'\','/',[rfReplaceAll])+'built-in'+url;
       end
    else
       result.appFlag := 1;
    if sl[sl.count-1]='' then sl.Delete(sl.count-1);
    if sl.Count=0 then Raise Exception.Create('无效地址'); 
    result.moduname := sl[sl.count-1];
    sl.Delete(sl.count-1);
    if sl.Count=0 then
    result.path := '/' else
    result.path := sl.DelimitedText;
  finally
    sl.Free;
  end;
end;
function encodeUrl(urltoken:TurlToken):string;
var wb:string;
begin
  if urlToken.appId='xsm-in' then
     begin
        if pos('xsm.htm',urltoken.moduname)>0 then
           begin
             if UcFactory.xsmWB='' then Raise Exception.Create('新商盟地址配置有误...');
             result := UcFactory.xsmWB
           end
        else
           begin
              if pos('ecweb',urltoken.path)>0 then
                 begin
                   if UcFactory.ecWeb='' then Raise Exception.Create('新商盟ecweb地址配置有误...');
                   wb := UcFactory.ecWeb;
                 end
              else
              if pos('scweb',urltoken.path)>0 then
                 begin
                   if UcFactory.scWeb='' then Raise Exception.Create('新商盟scweb地址配置有误...');
                   wb := UcFactory.scWeb;
                 end
              else
                 Raise Exception.Create('无效的新商盟地址...');
              delete(urltoken.path,1,6);
              if wb[length(wb)]='/' then
                 begin
                   if urltoken.path='/' then
                      result := wb+urltoken.path+urltoken.moduname
                   else
                      result := wb+urltoken.path+'/'+urltoken.moduname;
                 end
              else
                 result := wb+'/'+urltoken.path+'/'+urltoken.moduname;
           end;
     end
  else
     begin
        if urltoken.path='/' then
           result := 'rspcn://'+urltoken.appId+urltoken.path+urltoken.moduname
        else
           result := 'rspcn://'+urltoken.appId+'/'+urltoken.path+'/'+urltoken.moduname;
     end;
end;
end.
