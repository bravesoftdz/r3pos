object frmDateControl: TfrmDateControl
  Left = 0
  Top = 0
  Width = 170
  Height = 20
  TabOrder = 0
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 170
    Height = 20
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 0
    object LabToday: TRzLabel
      Left = 2
      Top = 3
      Width = 28
      Height = 13
      Caption = #20170#22825
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LabTodayClick
      FlyByColor = clRed
      FlyByEnabled = True
    end
    object LabYesterday: TRzLabel
      Left = 38
      Top = 3
      Width = 28
      Height = 13
      Caption = #26152#22825
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LabYesterdayClick
      FlyByColor = clRed
      FlyByEnabled = True
    end
    object LabThisweek: TRzLabel
      Left = 72
      Top = 3
      Width = 28
      Height = 13
      Caption = #26412#21608
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LabThisweekClick
      FlyByColor = clRed
      FlyByEnabled = True
    end
    object LabThisMonth: TRzLabel
      Left = 106
      Top = 3
      Width = 28
      Height = 13
      Caption = #26412#26376
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LabThisMonthClick
      FlyByColor = clRed
      FlyByEnabled = True
    end
    object LabLastMonth: TRzLabel
      Left = 139
      Top = 3
      Width = 28
      Height = 13
      Caption = #19978#26376
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LabLastMonthClick
      FlyByColor = clRed
      FlyByEnabled = True
    end
  end
end
