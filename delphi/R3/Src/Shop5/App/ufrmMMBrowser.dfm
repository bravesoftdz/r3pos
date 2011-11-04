inherited frmMMBrowser: TfrmMMBrowser
  Caption = #30431#30431#27983#35272#22120
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel2: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 540
    Height = 1
    Align = alTop
    BorderOuter = fsNone
    BorderColor = 12300436
    BorderShadow = 12300436
    Color = clWhite
    FlatColor = 12300436
    TabOrder = 0
    Visible = False
  end
  object IEBrowser: TWebBrowser [1]
    Left = 0
    Top = 1
    Width = 540
    Height = 375
    Align = alClient
    TabOrder = 1
    OnTitleChange = IEBrowserTitleChange
    ControlData = {
      4C000000D0370000C22600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
