inherited frmGoodsStorage: TfrmGoodsStorage
  Left = 92
  Top = 150
  Caption = #21830#21697#24211#23384
  ClientHeight = 554
  ClientWidth = 1008
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 1008
    Height = 507
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 507
      Align = alClient
      object RzPanel11: TRzPanel
        Left = 0
        Top = 0
        Width = 1008
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
          Width = 988
          Height = 45
          Align = alClient
          BorderOuter = fsFlatRounded
          TabOrder = 0
          object RzBitBtn1: TRzBitBtn
            Left = 16
            Top = 8
            Width = 74
            Height = 28
            Caption = #26032#22686#36135#21697
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = clSkyBlue
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 0
            TabStop = False
            Layout = blGlyphTop
            NumGlyphs = 2
            Spacing = 5
          end
          object btnPrint: TRzBitBtn
            Left = 109
            Top = 8
            Width = 70
            Height = 28
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
            TabOrder = 1
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object btnPreview: TRzBitBtn
            Left = 176
            Top = 8
            Width = 45
            Height = 28
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
            TabOrder = 2
            TabStop = False
            ThemeAware = False
            NumGlyphs = 2
            Spacing = 5
          end
          object RzBitBtn3: TRzBitBtn
            Left = 240
            Top = 8
            Width = 74
            Height = 28
            Caption = #26174#31034#20840#37096
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = clSkyBlue
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 3
            TabStop = False
            Layout = blGlyphTop
            NumGlyphs = 2
            Spacing = 5
          end
          object RzBitBtn4: TRzBitBtn
            Left = 332
            Top = 8
            Width = 74
            Height = 28
            AllowAllUp = True
            Caption = #25209#37327#21024#38500
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = clSkyBlue
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 4
            TabStop = False
            Layout = blGlyphTop
            NumGlyphs = 2
            Spacing = 5
          end
          object RzBitBtn5: TRzBitBtn
            Left = 425
            Top = 8
            Width = 74
            Height = 28
            Caption = #26356#25913#31867#21035#33267
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            HighlightColor = 14276036
            HotTrack = True
            HotTrackColor = clSkyBlue
            HotTrackColorType = htctActual
            ParentFont = False
            TextShadowColor = clWhite
            TextShadowDepth = 4
            TabOrder = 5
            TabStop = False
            Layout = blGlyphTop
            NumGlyphs = 2
            Spacing = 5
          end
          object RzPanel1: TRzPanel
            Left = 495
            Top = 9
            Width = 128
            Height = 26
            BorderOuter = fsFlat
            Color = clWhite
            TabOrder = 6
            object sortDrop: TcxButtonEdit
              Tag = -1
              Left = -1
              Top = 2
              Width = 130
              Height = 23
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              Properties.OnButtonClick = sortDropPropertiesButtonClick
              Style.BorderStyle = ebsUltraFlat
              Style.Edges = []
              Style.ButtonStyle = btsUltraFlat
              TabOrder = 0
            end
          end
        end
      end
      object RzPanel2: TRzPanel
        Left = 0
        Top = 341
        Width = 1008
        Height = 166
        Align = alClient
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        Color = clWhite
        TabOrder = 1
        object RzPanel3: TRzPanel
          Left = 10
          Top = 10
          Width = 988
          Height = 146
          Align = alClient
          BorderOuter = fsFlatRounded
          BorderWidth = 2
          TabOrder = 0
          object RzPanel4: TRzPanel
            Left = 4
            Top = 4
            Width = 172
            Height = 138
            Align = alLeft
            BorderInner = fsFlat
            BorderOuter = fsNone
            TabOrder = 0
            object RzPanel5: TRzPanel
              Left = 1
              Top = 110
              Width = 170
              Height = 27
              Align = alBottom
              BorderOuter = fsFlat
              BorderSides = [sdTop]
              TabOrder = 0
              DesignSize = (
                170
                27)
              object RzBitBtn2: TRzBitBtn
                Left = -1
                Top = 2
                Width = 172
                Anchors = [akTop]
                Caption = #26032#22686#20998#31867
                Color = 15461355
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                HighlightColor = 14276036
                HotTrack = True
                HotTrackColor = clSkyBlue
                HotTrackColorType = htctActual
                ParentFont = False
                TextShadowColor = clWhite
                TextShadowDepth = 4
                TabOrder = 0
                TabStop = False
                Layout = blGlyphTop
                NumGlyphs = 2
                Spacing = 5
              end
            end
            object rzTree: TRzTreeView
              Left = 1
              Top = 1
              Width = 170
              Height = 109
              SelectionPen.Color = clBtnShadow
              Align = alClient
              BorderStyle = bsNone
              FramingPreference = fpCustomFraming
              Indent = 19
              ReadOnly = True
              TabOrder = 1
              OnChange = rzTreeChange
            end
          end
          object RzPanel6: TRzPanel
            Left = 176
            Top = 4
            Width = 10
            Height = 138
            Align = alLeft
            Anchors = [akTop, akBottom]
            BorderOuter = fsNone
            BorderSides = [sdLeft, sdRight]
            TabOrder = 1
          end
          object RzPanel7: TRzPanel
            Left = 186
            Top = 4
            Width = 798
            Height = 138
            Align = alClient
            BorderOuter = fsFlat
            BorderSides = [sdLeft, sdTop]
            TabOrder = 2
            object DBGridEh1: TDBGridEh
              Left = 1
              Top = 1
              Width = 797
              Height = 137
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              AutoFitColWidths = True
              BorderStyle = bsNone
              Color = clWhite
              DataSource = dsList
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
              ReadOnly = True
              RowHeight = 25
              SumList.Active = True
              TabOrder = 0
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
              OnDrawColumnCell = DBGridEh1DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 28
                end
                item
                  Checkboxes = True
                  EditButtons = <>
                  FieldName = 'A'
                  Footers = <>
                  KeyList.Strings = (
                    '1'
                    '0')
                  Title.Caption = #36873#25321
                  Width = 24
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  Title.Caption = #21830#21697#21517#31216
                  Width = 165
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_CODE'
                  Footers = <>
                  Title.Caption = #36135#21495
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  Title.Caption = #26465#30721
                  Width = 110
                end
                item
                  EditButtons = <>
                  FieldName = 'SORT_ID1'
                  Footers = <>
                  Title.Caption = #20998#31867
                  Width = 66
                end
                item
                  EditButtons = <>
                  FieldName = 'CALC_UNITS'
                  Footers = <>
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
                  Title.Caption = #24211#23384
                  Width = 56
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'NEW_INPRICE'
                  Footer.DisplayFormat = '#0.00'
                  Footers = <>
                  Title.Caption = #36827#20215
                  Width = 51
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'NEW_OUTPRICE'
                  Footers = <>
                  Title.Caption = #21806#20215
                  Width = 52
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Caption = #25805#20316
                  Width = 115
                end>
            end
            object rowToolNav: TRzToolbar
              Left = 401
              Top = 177
              Width = 113
              Align = alNone
              AutoStyle = False
              Margin = 0
              TopMargin = 0
              TextOptions = ttoCustom
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
              TabOrder = 1
              Visible = False
              ToolbarControls = (
                RzToolButton2
                RzToolButton3
                RzSpacer1
                RzToolButton1)
              object RzToolButton1: TRzToolButton
                Left = 75
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
              object RzToolButton3: TRzToolButton
                Left = 35
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #35814#32454
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
              object RzSpacer1: TRzSpacer
                Left = 70
                Top = 0
                Width = 5
              end
            end
          end
        end
      end
      object RzPanel8: TRzPanel
        Left = 0
        Top = 65
        Width = 1008
        Height = 276
        Align = alTop
        BorderInner = fsFlatRounded
        BorderOuter = fsNone
        BorderColor = clWhite
        BorderWidth = 10
        TabOrder = 2
        DesignSize = (
          1008
          276)
        object RzBorder1: TRzBorder
          Left = 26
          Top = 146
          Width = 951
          Height = 2
        end
        object RzPanel22: TRzPanel
          Left = 24
          Top = 235
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #26368#20302#24211#23384
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 22
        end
        object RzPanel18: TRzPanel
          Left = 267
          Top = 180
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #26412#24215#21806#20215
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 17
        end
        object RzPanel19: TRzPanel
          Left = 350
          Top = 68
          Width = 51
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #25340#38899#30721
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 18
        end
        object RzPanel9: TRzPanel
          Left = 24
          Top = 44
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #21830#21697#36135#21495
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 11
        end
        object edtACCT_MNY: TcxTextEdit
          Left = 120
          Top = 43
          Width = 156
          Height = 23
          TabOrder = 0
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object RzPanel10: TRzPanel
          Left = 24
          Top = 68
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #21830#21697#21517#31216
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 12
        end
        object cxTextEdit1: TcxTextEdit
          Left = 120
          Top = 67
          Width = 233
          Height = 23
          TabOrder = 2
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object RzPanel12: TRzPanel
          Left = 24
          Top = 92
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #21830#21697#31867#21035
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 13
        end
        object RzPanel14: TRzPanel
          Left = 24
          Top = 116
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #35745#37327#21333#20301
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 14
        end
        object RzPanel16: TRzPanel
          Left = 24
          Top = 156
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #21442#32771#36827#20215
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 15
        end
        object cxTextEdit4: TcxTextEdit
          Left = 120
          Top = 155
          Width = 110
          Height = 23
          TabOrder = 5
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object RzPanel17: TRzPanel
          Left = 24
          Top = 180
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #26631#20934#21806#20215
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 16
        end
        object cxTextEdit5: TcxTextEdit
          Left = 120
          Top = 179
          Width = 110
          Height = 23
          TabOrder = 6
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object cxTextEdit6: TcxTextEdit
          Left = 363
          Top = 179
          Width = 110
          Height = 23
          TabOrder = 7
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtAGIO_RATE: TcxTextEdit
          Left = 398
          Top = 67
          Width = 75
          Height = 23
          TabStop = False
          TabOrder = 19
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object cxButtonEdit1: TcxButtonEdit
          Left = 120
          Top = 91
          Width = 157
          Height = 23
          Properties.Buttons = <
            item
              Default = True
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = sortDropPropertiesButtonClick
          Style.BorderStyle = ebsUltraFlat
          Style.Edges = [bLeft, bTop, bRight, bBottom]
          Style.ButtonStyle = btsUltraFlat
          TabOrder = 3
        end
        object RzPanel20: TRzPanel
          Left = 24
          Top = 20
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #26465' '#22411' '#30721
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 20
        end
        object cxTextEdit2: TcxTextEdit
          Left = 120
          Top = 19
          Width = 156
          Height = 23
          TabOrder = 1
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtCALC_UNITS: TzrComboBoxList
          Left = 120
          Top = 115
          Width = 75
          Height = 23
          Properties.AutoSelect = False
          Properties.Buttons = <
            item
              Default = True
            end>
          Properties.ReadOnly = False
          TabOrder = 4
          InGrid = False
          KeyValue = Null
          FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
          KeyField = 'UNIT_ID'
          ListField = 'UNIT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'UNIT_NAME'
              Footers = <>
              Title.Caption = #21333#20301#21517#31216
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'UNIT_ID'
              Footers = <>
              Title.Caption = #20195#30721
              Visible = False
              Width = 50
            end>
          DropWidth = 100
          DropHeight = 120
          ShowTitle = False
          AutoFitColWidth = True
          ShowButton = True
          LocateStyle = lsDark
          Buttons = []
          DropListStyle = lsFixed
          MultiSelect = False
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        end
        object RzPanel21: TRzPanel
          Left = 24
          Top = 211
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #24403#21069#24211#23384
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 21
        end
        object cxTextEdit3: TcxTextEdit
          Left = 120
          Top = 210
          Width = 110
          Height = 23
          TabOrder = 8
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object cxTextEdit7: TcxTextEdit
          Left = 120
          Top = 234
          Width = 110
          Height = 23
          TabOrder = 9
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object RzPanel23: TRzPanel
          Left = 267
          Top = 236
          Width = 99
          Height = 21
          BorderOuter = fsFlatRounded
          Caption = #26368#39640#24211#23384
          Color = 16185078
          FlatColor = clMenuHighlight
          TabOrder = 23
        end
        object cxTextEdit8: TcxTextEdit
          Left = 363
          Top = 235
          Width = 110
          Height = 23
          TabOrder = 10
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        end
        object edtUNIT_ID_USING: TcxCheckBox
          Left = 197
          Top = 115
          Width = 116
          Height = 23
          Properties.DisplayUnchecked = 'False'
          Properties.Caption = #21551#29992#21253#35013#21333#20301
          TabOrder = 24
        end
        object RzBitBtn6: TRzBitBtn
          Left = 861
          Top = 230
          Width = 70
          Height = 28
          Anchors = [akTop, akRight]
          Caption = #20445#23384
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
          TabOrder = 25
          TabStop = False
          ThemeAware = False
          NumGlyphs = 2
          Spacing = 5
        end
        object RzBitBtn7: TRzBitBtn
          Left = 928
          Top = 230
          Width = 45
          Height = 28
          Anchors = [akTop, akRight]
          Caption = #21462#28040
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
          TabOrder = 26
          TabStop = False
          ThemeAware = False
          NumGlyphs = 2
          Spacing = 5
        end
        object RzPanel24: TRzPanel
          Left = 312
          Top = 110
          Width = 569
          Height = 33
          BorderOuter = fsNone
          TabOrder = 27
          object RzPanel28: TRzPanel
            Left = 459
            Top = 6
            Width = 38
            Height = 21
            BorderOuter = fsFlatRounded
            Caption = #25442#31639
            Color = 16185078
            FlatColor = clMenuHighlight
            TabOrder = 6
          end
          object RzPanel26: TRzPanel
            Left = 171
            Top = 6
            Width = 38
            Height = 21
            BorderOuter = fsFlatRounded
            Caption = #25442#31639
            Color = 16185078
            FlatColor = clMenuHighlight
            TabOrder = 2
          end
          object RzPanel25: TRzPanel
            Left = 3
            Top = 6
            Width = 99
            Height = 21
            BorderOuter = fsFlatRounded
            Caption = #23567#20214#21333#20301
            Color = 16185078
            FlatColor = clMenuHighlight
            TabOrder = 0
          end
          object zrComboBoxList1: TzrComboBoxList
            Left = 99
            Top = 5
            Width = 75
            Height = 23
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            TabOrder = 1
            InGrid = False
            KeyValue = Null
            FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
            KeyField = 'UNIT_ID'
            ListField = 'UNIT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                Title.Caption = #21333#20301#21517#31216
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #20195#30721
                Visible = False
                Width = 50
              end>
            DropWidth = 100
            DropHeight = 120
            ShowTitle = False
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = []
            DropListStyle = lsFixed
            MultiSelect = False
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          end
          object cxTextEdit9: TcxTextEdit
            Left = 206
            Top = 5
            Width = 75
            Height = 23
            TabStop = False
            TabOrder = 3
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object RzPanel27: TRzPanel
            Left = 291
            Top = 6
            Width = 99
            Height = 21
            BorderOuter = fsFlatRounded
            Caption = #22823#20214#21333#20301
            Color = 16185078
            FlatColor = clMenuHighlight
            TabOrder = 4
          end
          object zrComboBoxList2: TzrComboBoxList
            Left = 387
            Top = 5
            Width = 75
            Height = 23
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            TabOrder = 5
            InGrid = False
            KeyValue = Null
            FilterFields = 'UNIT_NAME;UNIT_SPELL;UNIT_ID'
            KeyField = 'UNIT_ID'
            ListField = 'UNIT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'UNIT_NAME'
                Footers = <>
                Title.Caption = #21333#20301#21517#31216
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'UNIT_ID'
                Footers = <>
                Title.Caption = #20195#30721
                Visible = False
                Width = 50
              end>
            DropWidth = 100
            DropHeight = 120
            ShowTitle = False
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = []
            DropListStyle = lsFixed
            MultiSelect = False
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          end
          object cxTextEdit10: TcxTextEdit
            Left = 494
            Top = 5
            Width = 75
            Height = 23
            TabStop = False
            TabOrder = 7
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 1008
    object lblCaption: TRzLabel
      Left = 14
      Top = 11
      Width = 100
      Height = 24
      Caption = #21830#21697#24211#23384
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RzPanel15: TRzPanel
      Left = 634
      Top = 12
      Width = 265
      Height = 22
      Anchors = [akTop, akRight]
      BorderOuter = fsFlatRounded
      BorderColor = clBtnShadow
      Color = clWindow
      FlatColor = clWindowFrame
      TabOrder = 0
      DesignSize = (
        265
        22)
      object serachText: TEdit
        Tag = -1
        Left = 3
        Top = 2
        Width = 259
        Height = 18
        Hint = #35831#36755#20837#21333#21495#25110#23458#25143#21517#31216#25110#21830#21697#21517#31216#25110#22791#27880#35828#26126
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
    object btnNav: TRzBitBtn
      Left = 917
      Top = 8
      Width = 74
      Height = 28
      Anchors = [akTop, akRight]
      Caption = #26597#25214
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
      OnClick = btnNavClick
      NumGlyphs = 2
      Spacing = 5
    end
  end
  object dsList: TDataSource
    DataSet = cdsList
    Left = 104
    Top = 392
  end
  object cdsList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 144
    Top = 392
  end
  object cdsGoodsInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 624
    Top = 144
  end
  object cdsStorage: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 672
    Top = 144
  end
  object cdsGodsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 624
    Top = 176
  end
  object cdsGoodsPrice: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 624
    Top = 208
  end
  object cdsGoodsExt: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 624
    Top = 242
  end
  object cdsBarcode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 624
    Top = 274
  end
end
