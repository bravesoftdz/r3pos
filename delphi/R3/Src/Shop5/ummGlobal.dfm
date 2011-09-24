inherited mmGlobal: TmmGlobal
  Left = 191
  Top = 127
  inherited CA_MODULE: TZQuery
    Left = 88
    Top = 442
  end
  object IdCookieManager1: TIdCookieManager
    OnNewCookie = IdCookieManager1NewCookie
    Left = 208
    Top = 545
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
    HTTPOptions = [hoKeepOrigProtocol, hoForceEncodeParams]
    CookieManager = IdCookieManager1
    Left = 160
    Top = 545
  end
end
