unit uRcFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, jpeg, Graphics;

type
  TrcFactory=class
  private
    DllHandle:THandle;
  public
    constructor Create;
    destructor Destory;
    function GetJpeg(ResName:String):TJPEGImage;
    function GetBitmap(ResName:String):TBitmap;
    function GetResString(ResName:Integer):String;
  end;

var
  rcFactory:TrcFactory;
implementation

{ TrcFactory }

constructor TrcFactory.Create;
begin
  inherited;
  DllHandle := LoadLibrary('Pic32.dll');
end;

destructor TrcFactory.Destory;
begin

  inherited;
end;

function TrcFactory.GetBitmap(ResName: String): TBitmap;
var
  Stream: TStream;
  FilePath: String;
begin
  result := nil;
  //×°ÔØLogo
  FilePath := ExtractFilePath(ParamStr(0))+'res\images\'+ResName+'.bmp';
  if FileExists(FilePath) then
  begin
    Result := TBitmap.Create;
    try
      Result.LoadFromFile(FilePath);
    except
      FreeAndNil(Result);
    end;
  end
  else if FindResource(DllHandle, PChar(ResName), 'BMP') <> 0 then
  begin
    Stream := TResourceStream.Create(DllHandle, ResName, 'BMP');
    try
      result := TBITMAP.Create;
      try
        Stream.Position := 0;
        result.LoadFromStream(Stream);
      except
        freeandnil(result);
      end;
    finally
      Stream.Free;
    end;
  end;
end;

function TrcFactory.GetJpeg(ResName: String): TJPEGImage;
var
  Stream: TStream;
  FilePath: String;
begin
  result := nil;
  //×°ÔØLogo
  FilePath := ExtractFilePath(ParamStr(0))+'res\images\'+ResName+'.jpg';
  if FileExists(FilePath) then
  begin
    Result := TJPEGImage.Create;
    try
      Result.LoadFromFile(FilePath);
    except
      FreeAndNil(Result);
    end;
  end
  else if FindResource(DllHandle, PChar(ResName), 'JPG') <> 0 then
  begin
    Stream := TResourceStream.Create(DllHandle, ResName, 'JPG');
    try
      result := TJPEGImage.Create;
      try
        Stream.Position := 0;
        result.LoadFromStream(Stream);
      except
        freeandnil(result);
      end;
    finally
      Stream.Free;
    end;
  end;
end;

function TrcFactory.GetResString(ResName: Integer): String;
var
  iRet:array[0..254] of char;
begin
  result := '';
  LoadString(DllHandle, ResName, iRet, 254);
  result := StrPas(iRet);
end;


initialization
  rcFactory := TrcFactory.Create;
finalization
  rcFactory.Free;

end.
