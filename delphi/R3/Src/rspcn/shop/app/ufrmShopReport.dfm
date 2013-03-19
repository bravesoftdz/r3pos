inherited frmShopReport: TfrmShopReport
  Left = 115
  Top = 86
  Caption = #32463#33829#20998#26512
  ClientHeight = 722
  ClientWidth = 984
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 984
    Height = 675
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 984
      Height = 675
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
    Height = 675
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
            Left = 251
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
          object btnPrint: TRzBitBtn
            Left = 750
            Top = 8
            Width = 70
            Height = 28
            Anchors = [akTop, akRight]
            Caption = #25171#21360
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
            TabOrder = 2
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object btnPreview: TRzBitBtn
            Left = 817
            Top = 8
            Width = 45
            Height = 28
            Anchors = [akTop, akRight]
            Caption = #39044#35272
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
            TabOrder = 3
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object btnExport: TRzBitBtn
            Left = 874
            Top = 8
            Width = 76
            Height = 28
            Anchors = [akTop, akRight]
            Caption = #23548#20986'(&I)'
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
            TabOrder = 4
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object RzBitBtn1: TRzBitBtn
            Left = 665
            Top = 8
            Width = 74
            Height = 28
            Anchors = [akTop, akRight]
            Caption = #26597#35810#21333#25454
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
            TabOrder = 5
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object edtCLIENT_ID: TzrComboBoxList
            Left = 8
            Top = 11
            Width = 233
            Height = 23
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 6
            Text = #20840#37096#23458#25143
            InGrid = False
            KeyValue = Null
            FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
            KeyField = 'CLIENT_ID'
            ListField = 'CLIENT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CLIENT_CODE'
                Footers = <>
                Title.Caption = #23458#25143#21495
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'CLIENT_NAME'
                Footers = <>
                Title.Caption = #23458#25143#21517#31216
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
            DropWidth = 314
            DropHeight = 281
            ShowTitle = True
            AutoFitColWidth = False
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew, zbFind]
            DropListStyle = lsFixed
            MultiSelect = False
          end
        end
      end
      object chart1Panel: TRzPanel
        Left = 0
        Top = 400
        Width = 984
        Height = 254
        Align = alBottom
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        Color = clWhite
        TabOrder = 1
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
            object myChart1: TChart
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
      object tool1: TRzPanel
        Left = 0
        Top = 374
        Width = 984
        Height = 26
        Align = alBottom
        BorderOuter = fsNone
        BorderSides = [sdLeft, sdRight]
        BorderColor = clWhite
        Color = clWhite
        TabOrder = 2
        DesignSize = (
          984
          26)
        object RzBorder1: TRzBorder
          Left = 10
          Top = 0
          Width = 319
          Height = 27
        end
        object chart1: TRzBmpButton
          Left = 948
          Top = 5
          Width = 16
          Height = 16
          AllowAllUp = True
          GroupIndex = 3
          Down = True
          Bitmaps.Down.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            D7CDC2BEAD9AB7A490B7A490B7A490B7A490B7A490B7A490B7A490B7A490BEAD
            9AD7CDC2FF00FFFF00FFFF00FFB9A692DFD1C2F8EEE2FFF6EBFFF6EBFFF6EBFF
            F6EBFFF6EBFFF6EBFFF6EBFFF6EBF8EEE2DFD1C2B9A692FF00FFD9CFC4DDD0C1
            FFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7
            ECFFF7ECDED1C2D8CEC3BDAB99F9F0E5FFF7EDFFF7ED7D66567D6656FFF7EDFF
            F7EDFFF7EDFFF7ED7D66557D6655FFF7EDFFF7EDF9F0E5BDAB99B7A490FFF7EE
            FFF7EEFFF7EEA78F7CA78F7C7D6656FFF7EEFFF7EE7C6655A78F7CA78F7CFFF7
            EEFFF7EEFFF7EEB7A490B7A490FFF8EFFFF8EFFFF8EFFFF8EFA8907DA78F7C7C
            66557D6656A78F7CA78F7CFFF8EFFFF8EFFFF8EFFFF8EFB7A490B7A490FFF8F0
            FFF8F0FFF8F0FFF8F0FFF8F0A78F7CA8907DA78F7CA8907DFFF8F0FFF8F0FFF8
            F0FFF8F0FFF8F0B7A490B7A490FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0A8
            8F7CA78F7CFFF9F0FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0B7A490B7A490FFF9F1
            FFF9F1FFF9F17D66567D6656FFF9F1FFF9F1FFF9F1FFF9F17D66557D6655FFF9
            F1FFF9F1FFF9F1B7A490B7A490FFF9F2FFF9F2FFF9F2A78F7CA78F7C7D6656FF
            F9F2FFF9F27C6655A78F7CA78F7CFFF9F2FFF9F2FFF9F2B7A490B7A490FFFAF3
            FFFAF3FFFAF3FFFAF3A8907DA78F7C7C66557D6656A78F7CA78F7CFFFAF3FFFA
            F3FFFAF3FFFAF3B7A490B7A490FFFAF4FFFAF4FFFAF4FFFAF4FFFAF4A78F7CA8
            907DA78F7CA8907DFFFAF4FFFAF4FFFAF4FFFAF4FFFAF4B7A490BDAB99F9F4ED
            FFFBF5FFFBF5FFFBF5FFFBF5FFFBF5A88F7CA78F7CFFFBF5FFFBF5FFFBF5FFFB
            F5FFFBF5F9F4EDBDAB99D9CFC4DDD2C6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FF
            FBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6DDD2C6D9CFC4FF00FFB9A692
            DCD1C5F7F2EBFFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6F7F2
            EBDCD1C5B9A692FF00FFFF00FFFF00FFDAD0C6BFAE9CB7A490B7A490B7A490B7
            A490B7A490B7A490B7A490B7A490BFAE9CDAD0C6FF00FFFF00FF}
          Bitmaps.TransparentColor = clOlive
          Bitmaps.Up.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            D7CDC2BEAD9AB7A490B7A490B7A490B7A490B7A490B7A490B7A490B7A490BEAD
            9AD7CDC2FF00FFFF00FFFF00FFB9A692DFD1C2F8EEE2FFF6EBFFF6EBFFF6EBFF
            F6EBFFF6EBFFF6EBFFF6EBFFF6EBF8EEE2DFD1C2B9A692FF00FFD9CFC4DDD0C1
            FFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7
            ECFFF7ECDED1C2D8CEC3BDAB99F9F0E5FFF7EDFFF7EDFFF7EDFFF7EDFFF7EDA8
            8F7CA78F7CFFF7EDFFF7EDFFF7EDFFF7EDFFF7EDF9F0E5BDAB99B7A490FFF7EE
            FFF7EEFFF7EEFFF7EEFFF7EEA78F7CA8907DA78F7CA8907DFFF7EEFFF7EEFFF7
            EEFFF7EEFFF7EEB7A490B7A490FFF8EFFFF8EFFFF8EFFFF8EFA8907DA78F7C7C
            66557D6656A78F7CA78F7CFFF8EFFFF8EFFFF8EFFFF8EFB7A490B7A490FFF8F0
            FFF8F0FFF8F0A78F7CA78F7C7D6656FFF8F0FFF8F07C6655A78F7CA78F7CFFF8
            F0FFF8F0FFF8F0B7A490B7A490FFF9F0FFF9F0FFF9F07D66567D6656FFF9F0FF
            F9F0FFF9F0FFF9F07D66557D6655FFF9F0FFF9F0FFF9F0B7A490B7A490FFF9F1
            FFF9F1FFF9F1FFF9F1FFF9F1FFF9F1A88F7CA78F7CFFF9F1FFF9F1FFF9F1FFF9
            F1FFF9F1FFF9F1B7A490B7A490FFF9F2FFF9F2FFF9F2FFF9F2FFF9F2A78F7CA8
            907DA78F7CA8907DFFF9F2FFF9F2FFF9F2FFF9F2FFF9F2B7A490B7A490FFFAF3
            FFFAF3FFFAF3FFFAF3A8907DA78F7C7C66557D6656A78F7CA78F7CFFFAF3FFFA
            F3FFFAF3FFFAF3B7A490B7A490FFFAF4FFFAF4FFFAF4A78F7CA78F7C7D6656FF
            FAF4FFFAF47C6655A78F7CA78F7CFFFAF4FFFAF4FFFAF4B7A490BDAB99F9F4ED
            FFFBF5FFFBF57D66567D6656FFFBF5FFFBF5FFFBF5FFFBF57D66557D6655FFFB
            F5FFFBF5F9F4EDBDAB99D9CFC4DDD2C6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FF
            FBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6DDD2C6D9CFC4FF00FFB9A692
            DCD1C5F7F2EBFFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6F7F2
            EBDCD1C5B9A692FF00FFFF00FFFF00FFDAD0C6BFAE9CB7A490B7A490B7A490B7
            A490B7A490B7A490B7A490B7A490BFAE9CDAD0C6FF00FFFF00FF}
          Color = clBtnFace
          Anchors = [akTop, akRight]
          TabOrder = 0
          OnClick = chart1Click
        end
        object cxRadioButton1: TcxRadioButton
          Left = 20
          Top = 5
          Width = 113
          Height = 17
          Caption = #38144#21806#39069#25490#21517
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object cxRadioButton2: TcxRadioButton
          Left = 127
          Top = 5
          Width = 113
          Height = 17
          Caption = #38144#21806#37327#25490#21517
          TabOrder = 2
        end
        object cxRadioButton3: TcxRadioButton
          Left = 237
          Top = 5
          Width = 84
          Height = 17
          Caption = #27611#21033#25490#21517
          TabOrder = 3
        end
      end
      object RzPageControl1: TRzPageControl
        Left = 0
        Top = 65
        Width = 984
        Height = 309
        ActivePage = TabSheet3
        Align = alClient
        TabIndex = 1
        TabOrder = 3
        FixedDimension = 21
        object TabSheet2: TRzTabSheet
          Color = clWhite
          Caption = 'TabSheet2'
          object RzPanel2: TRzPanel
            Left = 0
            Top = 0
            Width = 980
            Height = 284
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object RzPanel3: TRzPanel
              Left = 10
              Top = 10
              Width = 960
              Height = 264
              Align = alClient
              BorderOuter = fsFlatRounded
              BorderWidth = 2
              TabOrder = 0
              object RzPanel7: TRzPanel
                Left = 4
                Top = 4
                Width = 952
                Height = 256
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
                  Width = 951
                  Height = 255
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
                      Width = 272
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
                      Title.Caption = #22343#20215
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
                      FieldName = 'TOOL_NAV'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25805#20316
                      Width = 38
                    end>
                end
                object RzToolbar1: TRzToolbar
                  Left = 513
                  Top = 49
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
        end
        object TabSheet3: TRzTabSheet
          Color = clWhite
          Caption = 'TabSheet3'
          object RzPanel1: TRzPanel
            Left = 0
            Top = 0
            Width = 980
            Height = 284
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object RzPanel6: TRzPanel
              Left = 10
              Top = 10
              Width = 960
              Height = 264
              Align = alClient
              BorderOuter = fsFlatRounded
              BorderWidth = 2
              TabOrder = 0
              object RzPanel8: TRzPanel
                Left = 4
                Top = 4
                Width = 952
                Height = 256
                Align = alClient
                BorderOuter = fsFlat
                BorderSides = [sdLeft, sdTop]
                TabOrder = 0
                object RzToolbar2: TRzToolbar
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
                    RzToolButton6
                    RzToolButton7
                    RzSpacer2
                    RzToolButton8
                    RzToolButton9)
                  object RzToolButton6: TRzToolButton
                    Left = 0
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
                  object RzToolButton7: TRzToolButton
                    Left = 35
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
                  object RzSpacer2: TRzSpacer
                    Left = 70
                    Top = 0
                    Width = 5
                  end
                  object RzToolButton8: TRzToolButton
                    Left = 75
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
                  object RzToolButton9: TRzToolButton
                    Left = 113
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
                object DBGridEh2: TDBGridEh
                  Tag = -1
                  Left = 1
                  Top = 1
                  Width = 951
                  Height = 255
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
                      Footers = <>
                      Title.Caption = #26085#26399
                      Width = 81
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                      Title.Caption = #21333#25454
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      Footers = <>
                      Title.Caption = #23458#25143
                      Width = 131
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footer.Value = #21512#35745
                      Footer.ValueType = fvtStaticText
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #21830#21697#21517#31216
                      Width = 159
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #36135#21495
                      Width = 70
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
                      FieldName = 'TOOL_NAV'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25805#20316
                      Width = 38
                    end>
                end
                object RzToolbar3: TRzToolbar
                  Left = 513
                  Top = 49
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
                    RzToolButton10)
                  object RzToolButton10: TRzToolButton
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
        end
      end
    end
  end
end
