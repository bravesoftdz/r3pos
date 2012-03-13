inherited frmMktKpiCalculate: TfrmMktKpiCalculate
  Left = 562
  Top = 240
  Width = 366
  Height = 242
  BorderIcons = [biSystemMenu]
  Caption = #32771#26680#35745#31639
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 350
    Height = 204
    Align = alClient
    BorderOuter = fsNone
    Color = clWhite
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 0
      Top = 0
      Width = 350
      Height = 162
      Align = alClient
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 0
      object Bevel1: TBevel
        Left = 14
        Top = 13
        Width = 320
        Height = 150
        Shape = bsFrame
      end
      object RzLabel4: TRzLabel
        Left = 39
        Top = 57
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #32463' '#38144' '#21830
      end
      object RzLabel7: TRzLabel
        Left = 39
        Top = 34
        Width = 48
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #24180'    '#24230
      end
      object ProgressBar1: TRzProgressBar
        Left = 34
        Top = 129
        Width = 280
        Height = 17
        BorderInner = fsFlatRounded
        BorderOuter = fsFlatRounded
        BorderWidth = 0
        InteriorOffset = 0
        PartsComplete = 0
        Percent = 0
        TotalParts = 0
      end
      object RzLabel1: TRzLabel
        Left = 39
        Top = 79
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25351'    '#26631
      end
      object labINFO: TLabel
        Left = 34
        Top = 112
        Width = 52
        Height = 12
        Caption = #20449#24687#25552#31034
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object fndCLIENT_ID: TzrComboBoxList
        Left = 95
        Top = 53
        Width = 215
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 0
        InGrid = False
        KeyValue = Null
        FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
        KeyField = 'CLIENT_ID'
        ListField = 'CLIENT_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CLIENT_CODE'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_NAME'
            Footers = <>
            Title.Caption = #20379#24212#21830#21517#31216
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'LINKMAN'
            Footers = <>
            Title.Caption = #32852#31995#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'TELEPHONE2'
            Footers = <>
            Title.Caption = #32852#31995#30005#35805
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'LICENSE_CODE'
            Footers = <>
            Title.Caption = #35777#20214#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = #22320#22336
            Width = 150
          end>
        DropWidth = 236
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object fndKPI_YEAR: TcxSpinEdit
        Left = 95
        Top = 30
        Width = 121
        Height = 20
        Properties.MaxValue = 2111.000000000000000000
        Properties.MinValue = 2000.000000000000000000
        Properties.OnValidate = fndKPI_YEARPropertiesValidate
        TabOrder = 1
        Value = 2011
      end
      object fndKPI_ID: TzrComboBoxList
        Left = 95
        Top = 75
        Width = 215
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 2
        InGrid = False
        KeyValue = Null
        FilterFields = 'KPI_NAME;KPI_SPELL'
        KeyField = 'KPI_ID'
        ListField = 'KPI_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'KPI_NAME'
            Footers = <>
            Title.Caption = #21517'    '#31216
            Width = 230
          end>
        DropWidth = 236
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object fndPLAN_USER: TzrComboBoxList
        Left = 95
        Top = 53
        Width = 215
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = False
        TabOrder = 3
        InGrid = False
        KeyValue = Null
        FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
        KeyField = 'USER_ID'
        ListField = 'USER_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ACCOUNT'
            Footers = <>
            Title.Caption = #24080#21495
          end
          item
            EditButtons = <>
            FieldName = 'USER_NAME'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 130
          end>
        DropWidth = 180
        DropHeight = 150
        ShowTitle = True
        AutoFitColWidth = True
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbClear]
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
    object RzPanel3: TRzPanel
      Left = 0
      Top = 162
      Width = 350
      Height = 42
      Align = alBottom
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 1
      object btnStart: TRzBitBtn
        Left = 144
        Top = 4
        Width = 67
        Height = 24
        Caption = #24320#22987#35745#31639
        Color = clSilver
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        HighlightColor = 16026986
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 0
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = btnStartClick
        ImageIndex = 12
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 408
    Top = 176
  end
  inherited actList: TActionList
    Left = 368
    Top = 176
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 2
    Top = 117
  end
  object cdsDetail: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 2
    Top = 149
  end
  object cdsKpiIndex: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 33
    Top = 149
  end
  object cdsKpiLevel: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 64
    Top = 149
  end
  object CdsKpiRatio: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 64
    Top = 181
  end
  object CdsKpiSeqNo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 33
    Top = 181
  end
  object CdsKpiTimes: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 2
    Top = 181
  end
  object CdsKpiGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 95
    Top = 181
  end
end
