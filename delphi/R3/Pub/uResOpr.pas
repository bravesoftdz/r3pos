
unit uResOpr;

interface

  uses  SysUtils, Windows, Graphics,Jpeg,classes,GifImage;

  type THsResOpr = class
    public
      constructor Create;
      destructor Destroy; override;
      procedure GetDllBmpRes(Bitmap: TBitmap; ResName: string;DllName: string);
      procedure GetDllIcoRes(Ico: TIcon; ResName: string;DllName: string);
      procedure GetDllGifRes(Picture: TPicture; ResName: string; DllName: string;Animate: Boolean = True );
      procedure GetDllJpgRes(Picture: TPicture; ResName: string; DllName: string;
        Animate: Boolean = True);
      procedure GetDllImgBtnJpgRes(Bitmap: TBitmap; ResName: string;DllName: string );
      procedure GetDllImgBtnGifRes(Bitmap: TBitmap; ResName: string;DllName: string );
   end;

implementation

procedure THsResOpr.GetDllIcoRes(ico: Ticon; ResName: string;DllName: string);
var Fico: Ticon;
  Stream: TStream;
  DllHandle: THandle;
begin
  DllHandle := LoadLibrary(pchar(Dllname));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'BMP') <> 0 then
    try
      Stream := TResourceStream.Create(DllHandle, ResName, 'BMP');
      try
        Fico := Ticon.Create;
        try
          Fico.LoadFromStream(Stream);
          ico.Assign(Fico);
        finally
          Fico.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure THsResOpr.GetDllBmpRes(Bitmap: TBitmap; ResName: string;DllName: string);
var BMP: TBITMAP;
  Stream: TStream;
  DllHandle: THandle;
begin
  DllHandle := LoadLibrary(pchar(Dllname));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'BMP') <> 0 then
    try
      Stream := TResourceStream.Create(DllHandle, ResName, 'BMP');
      try
        BMP := TBITMAP.Create;
        try
          BMP.LoadFromStream(Stream);
          Bitmap.Assign(BMP);
        finally
          BMP.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure THsResOpr.GetDllJpgRes(Picture: TPicture; ResName: string; DllName: string ;
  Animate: Boolean = True);
var JPEG: TJPEGImage;
    Stream: TStream;
    DllHandle: THandle;
begin
  DllHandle := LoadLibrary(pchar(dllname));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'JPG') <> 0 then
    try
      Stream := TResourceStream.Create(DllHandle, ResName, 'JPG');
      try
        JPEG := TJPEGImage.Create;
        try
          JPEG.LoadFromStream(Stream);
          if Animate then
               Picture.Assign(JPEG)
          else Picture.Bitmap.Assign(JPEG);
        finally
          JPEG.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure THsResOpr.GetDllImgBtnJpgRes(Bitmap: TBitmap; ResName: string;DllName: string);
var JPEG: TJPEGImage;
    Stream: TStream;
    DllHandle: THandle;
begin
  DllHandle := LoadLibrary(pchar(dllname));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'JPG') <> 0 then
    try
      Stream := TResourceStream.Create(DllHandle, ResName, 'JPG');
      try
        JPEG := TJPEGImage.Create;
        try
          JPEG.LoadFromStream(Stream);
          Bitmap.Assign(JPEG);
        finally
          JPEG.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure THsResOpr.GetDllImgBtnGifRes(Bitmap: TBitmap; ResName: string;DllName: string);
var Gif: TGifImage;
    Stream: TStream;
    DllHandle: THandle;
begin
  DllHandle := LoadLibrary(pchar(dllname));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'GIF') <> 0 then
    try
      Stream := TResourceStream.Create(DllHandle, ResName, 'GIF');
      try
        Gif := TGifImage.Create;
        try
          Gif.LoadFromStream(Stream);
          Bitmap.Assign(Gif);
        finally
          Gif.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

procedure THsResOpr.GetDllGifRes(Picture: TPicture; ResName: string; DllName: string;
  Animate: Boolean = True );
var Gif: TGIFImage;
    Stream: TStream;
    DllHandle: THandle;
begin
  DllHandle := LoadLibrary(Pchar(DllName));
  if DllHandle > 0 then
  try
    if FindResource(DllHandle, PChar(ResName), 'GIF') <> 0 then
    try
      Include(GIFImageDefaultDrawOptions, goDirectDraw);
      Stream := TResourceStream.Create(DllHandle, ResName, 'GIF');
      try
        Gif := TGifImage.Create;
        try
          GIF.LoadFromStream(Stream);
          if Animate then
               Picture.Assign(Gif)
          else Picture.Bitmap.Assign(Gif);
        finally
          Gif.Free;
        end;
      finally
        Stream.Free;
      end;
    except
    end;
  finally
    FreeLibrary(DllHandle);
  end;
end;

constructor THsResOpr.Create;
begin
  Inherited Create;
end;

destructor THsResOpr.Destroy;
begin
  Inherited Destroy;
end;

end.
