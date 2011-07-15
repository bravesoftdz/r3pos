inherited frmXsmIEBrowser: TfrmXsmIEBrowser
  Left = 671
  Top = 216
  Width = 457
  Height = 333
  Caption = 'frmXsmIEBrowser'
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 441
    Height = 294
    inherited IEBrowser: TWebBrowser
      Width = 441
      Height = 264
      ControlData = {
        4C000000B53700008E2300000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    inherited RzPanel1: TRzPanel
      Width = 441
    end
    object LCObject: TLCObject
      Left = -112
      Top = -8
      Width = 81
      Height = 41
      TabOrder = 2
      ControlData = {100700005F0800003D040000}
    end
  end
  inherited RzPanel2: TRzPanel
    Width = 441
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
    CookieManager = IdCookieManager1
    Left = 40
    Top = 41
  end
  object IdCookieManager1: TIdCookieManager
    Left = 88
    Top = 41
  end
end
