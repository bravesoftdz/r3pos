inherited frmIEWebForm: TfrmIEWebForm
  Caption = 'HTML'#27169#22359#35843#29992
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Top = 1
    Height = 375
    BorderInner = fsFlat
    BorderColor = 12300436
    BorderWidth = 0
    FlatColor = 12300436
    object IEBrowser: TWebBrowser
      Left = 1
      Top = 30
      Width = 539
      Height = 344
      Align = alClient
      TabOrder = 0
      OnTitleChange = IEBrowserTitleChange
      OnNavigateComplete2 = IEBrowserNavigateComplete2
      OnDocumentComplete = IEBrowserDocumentComplete
      ControlData = {
        4C000000B53700008E2300000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object RzPanel1: TRzPanel
      Left = 1
      Top = 1
      Width = 539
      Height = 29
      Align = alTop
      BorderOuter = fsNone
      BorderColor = 12300436
      BorderShadow = 12300436
      Color = clWhite
      FlatColor = 12300436
      TabOrder = 1
      Visible = False
      object RzTab: TRzTabControl
        Left = 0
        Top = 0
        Width = 539
        Height = 29
        Align = alClient
        FlatColor = 12300436
        Images = ImgLst16
        ShowCard = False
        TabColors.HighlightBar = 10344365
        TabHeight = 25
        TabIndex = 0
        TabOrder = 0
        Tabs = <
          item
            Caption = #32593#19978#37197#36135
            ImageIndex = 0
          end>
        TabStyle = tsRoundCorners
        OnChange = RzTabChange
        FixedDimension = 25
      end
    end
  end
  object RzPanel2: TRzPanel [1]
    Left = 0
    Top = 0
    Width = 541
    Height = 1
    Align = alTop
    BorderOuter = fsNone
    BorderColor = 12300436
    BorderShadow = 12300436
    Color = clWhite
    FlatColor = 12300436
    TabOrder = 1
  end
  inherited actList: TActionList
    Top = 136
  end
  object ImgLst16: TImageList
    Left = 64
    Top = 136
  end
end
