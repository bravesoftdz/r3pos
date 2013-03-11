inherited frmShopReport: TfrmShopReport
  Left = 209
  Top = 129
  Caption = #32463#33829#20998#26512
  ClientHeight = 617
  ClientWidth = 984
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 984
    Height = 570
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 984
      Height = 570
      Align = alClient
    end
  end
  inherited toolNav: TRzPanel
    Width = 984
    object lblCaption: TRzLabel
      Left = 0
      Top = 0
      Width = 185
      Height = 47
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = #32463#33829#20998#26512
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      TextStyle = tsShadow
    end
  end
  object PageControl: TRzPageControl
    Left = 0
    Top = 47
    Width = 984
    Height = 570
    ActivePage = TabSheet1
    Align = alClient
    ShowCardFrame = False
    ShowFocusRect = False
    ShowFullFrame = False
    ShowShadow = False
    TabIndex = 0
    TabOrder = 2
    FixedDimension = 21
    object TabSheet1: TRzTabSheet
      Color = clWhite
      Caption = 'TabSheet1'
      object RzPanel11: TRzPanel
        Left = 0
        Top = 0
        Width = 984
        Height = 65
        Align = alTop
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        Color = clWhite
        TabOrder = 0
        object RzPanel13: TRzPanel
          Left = 10
          Top = 10
          Width = 964
          Height = 45
          Align = alClient
          BorderOuter = fsFlatRounded
          TabOrder = 0
          DesignSize = (
            964
            45)
          object RzPanel16: TRzPanel
            Left = 11
            Top = 12
            Width = 402
            Height = 22
            BorderOuter = fsFlatRounded
            BorderColor = clBtnShadow
            Color = clWindow
            FlatColor = clWindowFrame
            TabOrder = 0
            object Label8: TLabel
              Left = 14
              Top = 3
              Width = 30
              Height = 15
              Caption = #26085#26399
            end
            object Label9: TLabel
              Left = 257
              Top = 3
              Width = 15
              Height = 15
              Caption = #33267
            end
            object dateFlag: TcxComboBox
              Tag = -1
              Left = 56
              Top = -1
              Width = 73
              Height = 23
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                #20170#26085
                #26412#26376
                #26412#24180
                #33258#23450#20041)
              Style.BorderColor = clWindowFrame
              Style.BorderStyle = ebsUltraFlat
              Style.Edges = [bLeft, bRight]
              TabOrder = 0
            end
            object D1: TcxDateEdit
              Tag = -1
              Left = 133
              Top = -1
              Width = 121
              Height = 23
              Style.BorderStyle = ebsUltraFlat
              Style.Edges = [bLeft, bRight]
              TabOrder = 1
            end
            object D2: TcxDateEdit
              Tag = -1
              Left = 277
              Top = -1
              Width = 121
              Height = 23
              Style.BorderStyle = ebsUltraFlat
              Style.Edges = [bLeft, bRight]
              TabOrder = 2
            end
          end
          object btnNav: TRzBitBtn
            Left = 1116
            Top = 9
            Width = 74
            Height = 28
            Anchors = [akTop, akRight]
            Caption = #26597#35810
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = 3983359
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 1
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
        end
      end
      object RzPanel2: TRzPanel
        Left = 0
        Top = 65
        Width = 984
        Height = 230
        Align = alClient
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        Color = clWhite
        TabOrder = 1
        object RzPanel3: TRzPanel
          Left = 10
          Top = 10
          Width = 964
          Height = 210
          Align = alClient
          BorderOuter = fsFlatRounded
          BorderWidth = 2
          TabOrder = 0
          object RzPanel7: TRzPanel
            Left = 4
            Top = 4
            Width = 956
            Height = 202
            Align = alClient
            BorderOuter = fsFlat
            BorderSides = [sdLeft, sdTop]
            TabOrder = 0
            object rowToolNav: TRzToolbar
              Left = 401
              Top = 177
              Width = 184
              Align = alNone
              AutoStyle = False
              Margin = 0
              TopMargin = 0
              BorderInner = fsNone
              BorderOuter = fsNone
              BorderSides = [sdTop]
              BorderWidth = 0
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Visible = False
              ToolbarControls = (
                RzToolButton2
                RzToolButton4
                RzToolButton3
                RzSpacer1
                RzToolButton1)
              object RzToolButton1: TRzToolButton
                Left = 116
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #21024#38500
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
              object RzToolButton2: TRzToolButton
                Left = 0
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #20462#25913
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
              object RzSpacer1: TRzSpacer
                Left = 111
                Top = 0
                Width = 5
              end
              object RzToolButton3: TRzToolButton
                Left = 73
                Top = 0
                Width = 38
                ShowCaption = True
                UseToolbarShowCaption = False
                Caption = #20817#25442
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
              object RzToolButton4: TRzToolButton
                Left = 35
                Top = 0
                Width = 38
                ShowCaption = True
                UseToolbarShowCaption = False
                Caption = #20805#20540
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
            end
            object DBGridEh1: TDBGridEh
              Tag = -1
              Left = 1
              Top = 1
              Width = 955
              Height = 201
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              AutoFitColWidths = True
              BorderStyle = bsNone
              Color = clWhite
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBlack
              FooterFont.Height = -15
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 1
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghHighlightFocus, dghClearSelection]
              RowHeight = 25
              SumList.Active = True
              TabOrder = 1
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = -15
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 20
              UseMultiTitle = True
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24207#21495
                  Width = 28
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21830#21697#21517#31216
                  Width = 193
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_CODE'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #36135#21495
                  Width = 75
                end
                item
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #26465#30721
                  Width = 104
                end
                item
                  EditButtons = <>
                  FieldName = 'SORT_ID1'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #20998#31867
                  Width = 66
                end
                item
                  EditButtons = <>
                  FieldName = 'CALC_UNITS'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21333#20301
                  Width = 27
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.###'
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.###'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #38144#37327
                  Width = 62
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'APRICE'
                  Footer.DisplayFormat = '#0.00'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21333#20215
                  Width = 63
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'NEW_OUTPRICE'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #38144#21806#39069
                  Width = 71
                end
                item
                  EditButtons = <>
                  Footers = <>
                  Title.Caption = #27611#21033
                end
                item
                  EditButtons = <>
                  Footers = <>
                  Title.Caption = #27611#21033#29575
                  Width = 55
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #25805#20316
                  Width = 29
                end>
            end
            object RzToolbar1: TRzToolbar
              Left = 521
              Top = 9
              Width = 40
              Align = alNone
              AutoStyle = False
              Margin = 0
              TopMargin = 0
              BorderInner = fsNone
              BorderOuter = fsNone
              BorderSides = [sdTop]
              BorderWidth = 0
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              Visible = False
              ToolbarControls = (
                RzToolButton5)
              object RzToolButton5: TRzToolButton
                Left = 0
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #26126#32454
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
            end
          end
        end
      end
      object RzPanel1: TRzPanel
        Left = 0
        Top = 295
        Width = 984
        Height = 254
        Align = alBottom
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        Color = clWhite
        TabOrder = 2
        object RzPanel4: TRzPanel
          Left = 10
          Top = 10
          Width = 964
          Height = 234
          Align = alClient
          BorderOuter = fsFlatRounded
          BorderWidth = 2
          TabOrder = 0
          object RzPanel5: TRzPanel
            Left = 4
            Top = 4
            Width = 956
            Height = 226
            Align = alClient
            BorderOuter = fsFlat
            TabOrder = 0
            object Chart1: TChart
              Left = 1
              Top = 1
              Width = 954
              Height = 224
              BackWall.Brush.Color = clWhite
              BackWall.Brush.Style = bsClear
              Title.Text.Strings = (
                #38144#37327#25490#34892#27036)
              View3D = False
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object Series1: TBarSeries
                Marks.ArrowLength = 20
                Marks.Visible = True
                SeriesColor = clRed
                MultiBar = mbStacked
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Multiplier = 1.000000000000000000
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Bar'
                YValues.Multiplier = 1.000000000000000000
                YValues.Order = loNone
              end
            end
          end
        end
      end
    end
  end
end
