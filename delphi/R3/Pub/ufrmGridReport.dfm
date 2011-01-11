inherited frmGridReport: TfrmGridReport
  Caption = #26597#35810#22522#31867
  Menu = nil
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object CoolBar1: TCoolBar [0]
    Left = 0
    Top = 20
    Width = 549
    Height = 39
    AutoSize = True
    Bands = <
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 35
        Width = 545
      end>
    Images = dmIcon.ImgLst16
    object ToolBar2: TToolBar
      Left = 9
      Top = 0
      Width = 532
      Height = 35
      ButtonHeight = 35
      ButtonWidth = 43
      Caption = #28155#21152
      DisabledImages = dmIcon.ImgLst16
      EdgeBorders = []
      Flat = True
      Images = dmIcon.ImgLst16
      ShowCaptions = True
      TabOrder = 0
      object ToolButton3: TToolButton
        Left = 0
        Top = 0
        Action = actPrior
      end
      object ToolButton10: TToolButton
        Left = 43
        Top = 0
        Action = actNext
      end
      object ToolButton11: TToolButton
        Left = 86
        Top = 0
        Action = actFind
      end
      object ToolButton16: TToolButton
        Left = 129
        Top = 0
        Width = 8
        Caption = 'ToolButton16'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 137
        Top = 0
        Action = actPrintSetup
      end
      object ToolButton6: TToolButton
        Left = 180
        Top = 0
        Action = actPrint
      end
      object ToolButton5: TToolButton
        Left = 223
        Top = 0
        Action = actPreview
      end
      object ToolButton7: TToolButton
        Left = 266
        Top = 0
        Width = 7
        Caption = 'ToolButton7'
        ImageIndex = 3
        Style = tbsDivider
      end
      object ToolButton12: TToolButton
        Left = 273
        Top = 0
        Action = actExit
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 59
    Width = 549
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object DBGridEh1: TDBGridEh [2]
    Left = 0
    Top = 100
    Width = 549
    Height = 287
    Align = alClient
    DataSource = dsrTable
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = GB2312_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = #23435#20307
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
    RowHeight = 20
    TabOrder = 2
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    UseMultiTitle = True
    IsDrawNullRow = False
    CurrencySymbol = #65509
    DecimalNumber = 2
    DigitalNumber = 12
  end
  object ToolBar1: TToolBar [3]
    Left = 0
    Top = 0
    Width = 549
    Height = 20
    ButtonHeight = 20
    ButtonWidth = 55
    Caption = #28155#21152
    EdgeBorders = []
    Flat = True
    ShowCaptions = True
    TabOrder = 3
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = #25991#20214'(&F)'
      MenuItem = F1
      OnClick = actPriorExecute
    end
    object ToolButton2: TToolButton
      Left = 55
      Top = 0
      Caption = #35270#22270'(&E)'
      MenuItem = E1
      OnClick = actNextExecute
    end
    object ToolButton8: TToolButton
      Left = 110
      Top = 0
      MenuItem = F2
    end
  end
  inherited mmMenu: TMainMenu
    object F1: TMenuItem
      Caption = #25991#20214'(&F)'
      object N5: TMenuItem
        Action = actPrintSetup
      end
      object N4: TMenuItem
        Action = actPrint
      end
      object N3: TMenuItem
        Action = actPreview
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object N1: TMenuItem
        Action = actExit
      end
    end
    object E1: TMenuItem
      Caption = #35270#22270'(&E)'
      object N8: TMenuItem
        Action = actPrior
      end
      object N7: TMenuItem
        Action = actNext
      end
      object N6: TMenuItem
      end
    end
    object F2: TMenuItem
      Action = actFind
    end
  end
  inherited actList: TActionList
    object actPrint: TAction
      Caption = #25171#21360
      ImageIndex = 10
    end
    object actPreview: TAction
      Caption = #39044#35272
      ImageIndex = 9
    end
    object actPrintSetup: TAction
      Caption = #35774#32622
      ImageIndex = 40
      OnExecute = actPrintSetupExecute
    end
    object actNext: TAction
      Caption = #19979#19968#26465
      ImageIndex = 8
      OnExecute = actNextExecute
    end
    object actPrior: TAction
      Caption = #19978#19968#26465
      ImageIndex = 11
      OnExecute = actPriorExecute
    end
    object actExit: TAction
      Caption = #36864#20986
      ImageIndex = 13
      ShortCut = 49240
      OnExecute = actExitExecute
    end
    object actFind: TAction
      Caption = #26597#25214
      ImageIndex = 12
    end
  end
  object rTable: TADODataSet
    Parameters = <>
    Left = 176
    Top = 216
  end
  object dsrTable: TDataSource
    DataSet = rTable
    Left = 208
    Top = 216
  end
end
