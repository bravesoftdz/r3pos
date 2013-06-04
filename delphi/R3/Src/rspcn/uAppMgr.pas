unit uAppMgr;

interface
uses
  Windows ,Messages, SysUtils, Classes;
function getUrlForId(url:string):integer;
function getIdForUrl(id:integer):string;
implementation
function getUrlForId(url:string):integer;
begin
  url := lowercase(url);
  if url='' then
     result := 0
  else
  if url='rspcn://shop.dll/tfrmsaleorder' then
     result := 1
  else
  if url='rspcn://shop.dll/tfrmstockorder' then
     result := 2
  else
  if url='rspcn://shop.dll/tfrmgoodsstorage' then
     result := 3
  else
  if url='rspcn://shop.dll/tfrmdownstockorder' then
     result := 4
  else
  if url='rspcn://shop.dll/tfrmcustomer' then
     result := 5
  else
  if url='rspcn://shop.dll/tfrmsysdefine' then
     result := 6
  else
  if url='rspcn://local-in/report.html' then
     result := 7
  else
     raise Exception.Create('无效url地址串');

end;
function getIdForUrl(id:integer):string;
begin
  case id of
  0:result := '';
  1:result := 'rspcn://shop.dll/tfrmsaleorder';
  2:result := 'rspcn://shop.dll/tfrmstockorder';
  3:result := 'rspcn://shop.dll/tfrmgoodsstorage';
  4:result := 'rspcn://shop.dll/tfrmdownstockorder';
  5:result := 'rspcn://shop.dll/tfrmcustomer';
  6:result := 'rspcn://shop.dll/tfrmsysdefine';
  7:result := 'rspcn://local-in/report.html';
  else
     raise Exception.Create('无效ID地址编号');
  end;
end;
end.
