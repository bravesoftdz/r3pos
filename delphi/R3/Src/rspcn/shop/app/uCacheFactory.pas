unit uCacheFactory;

interface
uses Graphics,Forms,Windows,SysUtils,ZDataSet;

type
  TCacheFactory=class
  public
    procedure getAdvPngImage(advId:string;Picture:TPicture);
    procedure getGodsPngImage(godsId:string;Picture:TPicture;flag:string='_middle_face');
  end;
var
  CacheFactory:TCacheFactory;
implementation
uses udllGlobal;
{ TAdvFactory }

procedure TCacheFactory.getAdvPngImage(advId: string;Picture:TPicture);
begin
  try
    if not fileExists(ExtractFilePath(Application.ExeName)+'built-in\cache\'+advId+'.png') then
       Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\nulladv.png')
    else
       Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\'+advId+'.png');
  except
    Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\nulladv.png')
  end;
end;

procedure TCacheFactory.getGodsPngImage(godsId: string; Picture: TPicture;flag:string='_middle_face');
var
  rs,bs:TZQuery;
  barcode:string;
begin
  try
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select BARCODE,UNIT_ID from PUB_BARCODE where TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+') and GODS_ID=:GODS_ID';
      rs.ParamByName('GODS_ID').AsString := godsId;
      dllGlobal.OpenSqlite(rs);
      bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
      if bs.Locate('GODS_ID',godsID,[]) and rs.Locate('UNIT_ID',bs.FieldbyName('UNIT_ID').AsString,[]) then
         barcode := rs.FieldbyName('BARCODE').asString
      else
         barcode := '';
      if not fileExists(ExtractFilePath(Application.ExeName)+'built-in\cache\'+barcode+flag+'.png') then
         Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\nullimage.png')
      else
         Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\'+barcode+flag+'.png');
    finally
      rs.Free;
    end;
  except
     Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\cache\nullimage.png')
  end;
end;

initialization
  CacheFactory := TCacheFactory.create;
finalization
  CacheFactory.Free;
end.
