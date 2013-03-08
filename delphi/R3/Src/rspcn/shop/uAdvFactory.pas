unit uAdvFactory;

interface
uses Graphics,Forms,Windows,SysUtils;

type
  TAdvFactory=class
  public
    procedure getAdvPngImage(advId:string;Picture:TPicture);
  end;
var
  AdvFactory:TAdvFactory;
implementation

{ TAdvFactory }

procedure TAdvFactory.getAdvPngImage(advId: string;Picture:TPicture);
begin
  Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'built-in\images\'+advId+'.png');
end;

initialization
  AdvFactory := TAdvFactory.create;
finalization
  AdvFactory.Free;
end.
