inherited frmChart: TfrmChart
  Width = 579
  Height = 449
  Caption = #32479#35745#20998#26512#22270
  PixelsPerInch = 96
  TextHeight = 12
  object CoolBar1: TCoolBar [0]
    Left = 0
    Top = 0
    Width = 571
    Height = 43
    AutoSize = True
    Bands = <
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 39
        Width = 567
      end>
    Images = dmIcon.ImgLst16
    object ToolBar2: TToolBar
      Left = 9
      Top = 0
      Width = 554
      Height = 39
      ButtonHeight = 38
      ButtonWidth = 39
      Caption = #28155#21152
      DisabledImages = dmIcon.ImgLst16
      EdgeBorders = []
      Flat = True
      Images = Image
      TabOrder = 0
      object ToolButton3: TToolButton
        Left = 0
        Top = 0
      end
      object ToolButton10: TToolButton
        Left = 39
        Top = 0
      end
      object ToolButton11: TToolButton
        Left = 78
        Top = 0
      end
      object ToolButton16: TToolButton
        Left = 117
        Top = 0
        Width = 8
        Caption = 'ToolButton16'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 125
        Top = 0
      end
      object ToolButton6: TToolButton
        Left = 164
        Top = 0
      end
      object ToolButton5: TToolButton
        Left = 203
        Top = 0
      end
      object ToolButton7: TToolButton
        Left = 242
        Top = 0
        Width = 7
        Caption = 'ToolButton7'
        ImageIndex = 3
        Style = tbsDivider
      end
      object ToolButton1: TToolButton
        Left = 249
        Top = 0
      end
      object ToolButton2: TToolButton
        Left = 288
        Top = 0
      end
      object ToolButton13: TToolButton
        Left = 327
        Top = 0
      end
      object ToolButton9: TToolButton
        Left = 366
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 0
        Style = tbsDivider
      end
      object ToolButton12: TToolButton
        Left = 374
        Top = 0
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 43
    Width = 571
    Height = 360
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    BorderWidth = 2
    TabOrder = 1
    object Chart1: TChart
      Left = 4
      Top = 4
      Width = 563
      Height = 352
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        'TChart')
      Align = alClient
      TabOrder = 0
    end
  end
  inherited mmMenu: TMainMenu
    object F1: TMenuItem
      Caption = #25991#20214'(&F)'
      object N5: TMenuItem
      end
      object N4: TMenuItem
      end
      object N3: TMenuItem
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object N1: TMenuItem
      end
    end
    object E1: TMenuItem
      Caption = #35270#22270'(&E)'
      object N8: TMenuItem
      end
      object N7: TMenuItem
      end
      object N6: TMenuItem
      end
    end
    object F2: TMenuItem
      Caption = #26597#25214'(&F)'
      object N12: TMenuItem
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N10: TMenuItem
      end
      object N9: TMenuItem
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      object N13: TMenuItem
      end
    end
  end
  object Image: TImageList
    Height = 32
    Width = 32
    Left = 40
    Top = 80
  end
end
