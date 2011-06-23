inherited frmXsmIEBrowser: TfrmXsmIEBrowser
  Left = 386
  Top = 234
  Caption = 'frmXsmIEBrowser'
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    inherited IEBrowser: TWebBrowser
      ControlData = {
        4C000000B53700008E2300000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    inherited RzPanel1: TRzPanel
      inherited RzTab: TRzTabControl
        Visible = False
        FixedDimension = 25
      end
    end
    object Button1: TButton
      Left = 336
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
