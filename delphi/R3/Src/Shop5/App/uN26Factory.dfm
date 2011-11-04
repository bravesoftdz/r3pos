object N26Factory: TN26Factory
  OldCreateOrder = False
  Left = 192
  Top = 160
  Height = 150
  Width = 215
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
    Left = 48
    Top = 9
  end
  object IdCookieManager1: TIdCookieManager
    Left = 96
    Top = 9
  end
end
