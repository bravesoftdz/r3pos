object XsmCacheFactory: TXsmCacheFactory
  Left = 571
  Top = 251
  Width = 496
  Height = 363
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #21152#36733#22120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 325
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 2
      Top = 57
      Width = 476
      Height = 266
      Align = alClient
      BorderOuter = fsNone
      TabOrder = 0
      object Bevel1: TBevel
        Left = 5
        Top = 228
        Width = 474
        Height = 2
      end
      object RzProgressBar1: TRzProgressBar
        Left = 35
        Top = 39
        Width = 419
        Height = 17
        BorderOuter = fsFlatRounded
        BorderWidth = 0
        InteriorOffset = 0
        PartsComplete = 0
        Percent = 0
        TotalParts = 0
      end
      object RzLabel1: TRzLabel
        Left = 36
        Top = 8
        Width = 213
        Height = 12
        AutoSize = False
        Caption = #27491#22312#21152#36733#25991#20214#21450#22270#29255'...'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object labInfo: TRzLabel
        Left = 36
        Top = 23
        Width = 81
        Height = 13
        Caption = #27491#22312#21152#36733#22270#29255'...'
      end
      object WebBrowser1: TWebBrowser
        Left = 36
        Top = 60
        Width = 417
        Height = 163
        TabOrder = 0
        OnDownloadComplete = WebBrowser1DownloadComplete
        ControlData = {
          4C000000192B0000D91000000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object btnCancel: TRzBitBtn
        Left = 381
        Top = 236
        Width = 67
        Height = 24
        Caption = #21462#28040
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = actCancelExecute
        ImageIndex = 12
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel3: TRzPanel
      Left = 2
      Top = 2
      Width = 476
      Height = 55
      Align = alTop
      Anchors = []
      BorderInner = fsGroove
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 1
      object RzLabel2: TRzLabel
        Left = 16
        Top = 8
        Width = 70
        Height = 13
        AutoSize = False
        Caption = #21152#36733#25991#20214
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RzLabel3: TRzLabel
        Left = 48
        Top = 24
        Width = 300
        Height = 13
        AutoSize = False
        Caption = #20026#24744#30340#35745#31639#26426#20013#21152#36733'MM'#25152#38656#30340#22270#29255#12290
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 40
    Top = 283
  end
  object ActionList1: TActionList
    Left = 74
    Top = 281
  end
end
