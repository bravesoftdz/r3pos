inherited frmIEWebForm: TfrmIEWebForm
  Caption = #26032#21830#30431
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    object IEBrowser: TWebBrowser
      Left = 5
      Top = 5
      Width = 539
      Height = 377
      Align = alClient
      TabOrder = 0
      OnNavigateComplete2 = IEBrowserNavigateComplete2
      OnDocumentComplete = IEBrowserDocumentComplete
      ControlData = {
        4C000000B5370000F72600000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
