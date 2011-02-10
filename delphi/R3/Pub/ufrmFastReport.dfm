inherited frmFastReport: TfrmFastReport
  Left = 135
  Top = 186
  Width = 1024
  Height = 738
  Caption = #25253#34920#25171#21360
  Menu = nil
  OldCreateOrder = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object CoolBar1: TCoolBar [0]
    Left = 0
    Top = 20
    Width = 1008
    Height = 39
    AutoSize = True
    Bands = <
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 35
        Width = 1004
      end>
    Images = dmIcon.ImgLst16
    object ToolBar2: TToolBar
      Left = 9
      Top = 0
      Width = 991
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
        Action = actOnePage
      end
      object ToolButton10: TToolButton
        Left = 43
        Top = 0
        Action = actPageWidth
      end
      object ToolButton11: TToolButton
        Left = 86
        Top = 0
        Action = actZoom
      end
      object ToolButton16: TToolButton
        Left = 129
        Top = 0
        Width = 8
        Caption = 'ToolButton16'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 137
        Top = 0
        Action = actNext
      end
      object ToolButton5: TToolButton
        Left = 180
        Top = 0
        Action = actPrior
      end
      object ToolButton7: TToolButton
        Left = 223
        Top = 0
        Width = 7
        Caption = 'ToolButton7'
        ImageIndex = 3
        Style = tbsDivider
      end
      object ToolButton1: TToolButton
        Left = 230
        Top = 0
        Action = actPrintSetup
      end
      object ToolButton4: TToolButton
        Left = 273
        Top = 0
        Action = actFormer
      end
      object ToolButton2: TToolButton
        Left = 316
        Top = 0
        Action = actPrint
      end
      object ToolButton13: TToolButton
        Left = 359
        Top = 0
        Caption = #23548#20986
        DropdownMenu = PopupMenu1
        ImageIndex = 4
        Style = tbsDropDown
      end
      object ToolButton9: TToolButton
        Left = 419
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 0
        Style = tbsDivider
      end
      object ToolButton12: TToolButton
        Left = 427
        Top = 0
        Action = actExit
      end
    end
  end
  object PageControl1: TPageControl [1]
    Left = 0
    Top = 59
    Width = 1008
    Height = 641
    ActivePage = tabPrev
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 1
    object tabPrev: TTabSheet
      Caption = #25253#34920#39044#35272
      TabVisible = False
      object frPreview1: TfrPreview
        Left = 0
        Top = 0
        Width = 1000
        Height = 631
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        ScrollBars = ssBoth
      end
    end
  end
  object ToolBar1: TToolBar [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 20
    ButtonHeight = 20
    ButtonWidth = 55
    Caption = #28155#21152
    EdgeBorders = []
    Flat = True
    ShowCaptions = True
    TabOrder = 2
    object ToolButton8: TToolButton
      Left = 0
      Top = 0
      Caption = #25991#20214'(&F)'
      MenuItem = F1
      OnClick = actOnePageExecute
    end
    object ToolButton14: TToolButton
      Left = 55
      Top = 0
      Caption = #35270#22270'(&E)'
      MenuItem = E1
      OnClick = actPageWidthExecute
    end
    object ToolButton15: TToolButton
      Left = 110
      Top = 0
      Caption = #26597#25214'(&S)'
      MenuItem = F2
      OnClick = actZoomExecute
    end
  end
  inherited mmMenu: TMainMenu
    object F1: TMenuItem
      Caption = #25991#20214'(&F)'
      object N14: TMenuItem
        Action = actPrintSetup
      end
      object N15: TMenuItem
        Action = actPrint
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
        Action = actOnePage
      end
      object N7: TMenuItem
        Action = actPageWidth
      end
      object N6: TMenuItem
        Action = actZoom
      end
    end
    object F2: TMenuItem
      Caption = #26597#25214'(&S)'
      object N10: TMenuItem
        Action = actNext
      end
      object N9: TMenuItem
        Action = actPrior
      end
    end
  end
  inherited actList: TActionList
    object actPrint: TAction
      Caption = #25171#21360
      ImageIndex = 10
      ShortCut = 16464
      OnExecute = actPrintExecute
    end
    object actExit: TAction
      Caption = ' '#36864#20986' '
      ImageIndex = 13
      ShortCut = 49240
      OnExecute = actExitExecute
    end
    object actPrintSetup: TAction
      Caption = #35774#32622
      ImageIndex = 40
      ShortCut = 16467
      OnExecute = actPrintSetupExecute
    end
    object actPrior: TAction
      Caption = #19978#39029
      ImageIndex = 11
      OnExecute = actPriorExecute
    end
    object actNext: TAction
      Caption = #19979#39029
      ImageIndex = 8
      OnExecute = actNextExecute
    end
    object actZoom: TAction
      Caption = '100%'
      ImageIndex = 9
      ShortCut = 116
      OnExecute = actZoomExecute
    end
    object actOnePage: TAction
      Caption = #21333#39029
      ImageIndex = 9
      ShortCut = 117
      OnExecute = actOnePageExecute
    end
    object actPageWidth: TAction
      Caption = #39029#23485
      ImageIndex = 9
      ShortCut = 118
      OnExecute = actPageWidthExecute
    end
    object actFormer: TAction
      Caption = #27169#29256
      ImageIndex = 16
      OnExecute = actFormerExecute
    end
  end
  object frReport1: TfrReport
    Dataset = frTable
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnUserFunction = frReport1UserFunction
    Left = 208
    Top = 175
    ReportForm = {18000000}
  end
  object frTable: TfrDBDataSet
    DataSet = adoTable
    Left = 208
    Top = 223
  end
  object frCSVExport1: TfrCSVExport
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Delimiter = ';'
    Left = 288
    Top = 79
  end
  object frHTMExport1: TfrHTMExport
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 288
    Top = 119
  end
  object frTextExport1: TfrTextExport
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 288
    Top = 159
  end
  object frRTFExport1: TfrRTFExport
    ScaleX = 1.300000000000000000
    ScaleY = 1.000000000000000000
    Left = 288
    Top = 199
  end
  object PopupMenu1: TPopupMenu
    Left = 400
    Top = 127
    object HTML1: TMenuItem
      Caption = #23548#20986#21040#32593#39029#26684#24335#65288'*.HTML'#65289
      OnClick = HTML1Click
    end
    object CSV1: TMenuItem
      Caption = #23548#20986#21040#65288'*.CSV'#65289#26684#24335
      OnClick = CSV1Click
    end
    object N3: TMenuItem
      Caption = #23548#20986#21040#25991#26412#65288'*.TXT'#65289
      OnClick = N3Click
    end
    object RTF1: TMenuItem
      Caption = #23548#20986#21040#65288'*.RTF'#65289#26684#24335
      OnClick = RTF1Click
    end
    object PDF1: TMenuItem
      Caption = #23548#20986#21040#65288'*.PDF'#65289#25991#20214
      OnClick = PDF1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'sdffsdf|(*.html)'
    Left = 328
    Top = 119
  end
  object frPDFExport1: TfrPDFExport
    ShowDialog = False
    Left = 284
    Top = 233
  end
  object frDesigner1: TfrDesigner
    OnSaveReport = frDesigner1SaveReport
    Left = 222
    Top = 197
  end
  object adoTable: TZReadOnlyQuery
    FieldDefs = <>
    Params = <>
    Left = 172
    Top = 225
  end
end
