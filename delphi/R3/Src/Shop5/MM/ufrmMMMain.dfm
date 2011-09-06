inherited frmMMMain: TfrmMMMain
  Caption = #30431#30431
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  inherited PopupMenu: TPopupMenu
    Left = 256
    Top = 80
  end
  object RzTrayIcon1: TRzTrayIcon
    HideOnMinimize = False
    PopupMenu = PopupMenu
    OnMinimizeApp = RzTrayIcon1MinimizeApp
    OnRestoreApp = RzTrayIcon1RestoreApp
    OnLButtonDown = RzTrayIcon1LButtonDown
    Left = 112
    Top = 96
  end
end
