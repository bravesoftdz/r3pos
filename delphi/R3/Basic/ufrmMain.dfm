inherited frmMain: TfrmMain
  Left = 147
  Top = 193
  Caption = 'frmMain'
  FormStyle = fsMDIForm
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object stbBottom: TStatusBar [0]
    Left = 0
    Top = 357
    Width = 541
    Height = 19
    Panels = <>
  end
  object PopupMenu: TPopupMenu
    Left = 480
    Top = 56
    object miClose: TMenuItem
      Caption = #36864#20986#31995#32479'(&C)'
      OnClick = miCloseClick
    end
  end
  object UpdateTimer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = UpdateTimerTimer
    Left = 464
    Top = 88
  end
end
