object UcFactory: TUcFactory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 247
  Top = 130
  Height = 532
  Width = 704
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
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
    Left = 32
    Top = 24
  end
  object IdCookieManager1: TIdCookieManager
    OnNewCookie = IdCookieManager1NewCookie
    Left = 104
    Top = 24
  end
end
