inherited frmStorageReport: TfrmStorageReport
  Left = 121
  Top = 159
  Caption = #24211#23384#32479#35745#25253#34920
  ClientWidth = 979
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 979
    inherited PageControl: TRzPageControl
      Width = 979
      ActivePage = TabSheet2
      TabIndex = 1
      OnChange = PageControlChange
      FixedDimension = 21
      inherited TabSheet1: TRzTabSheet
        object RzPanel2: TRzPanel
          Left = 0
          Top = 0
          Width = 979
          Height = 329
          Align = alClient
          BorderOuter = fsNone
          BorderColor = 15461355
          BorderWidth = 10
          Color = clWhite
          TabOrder = 0
          object RzPanel3: TRzPanel
            Left = 10
            Top = 10
            Width = 959
            Height = 309
            Align = alClient
            BorderOuter = fsStatus
            TabOrder = 0
            object RzPanel7: TRzPanel
              Left = 1
              Top = 1
              Width = 957
              Height = 307
              Align = alClient
              BorderOuter = fsNone
              BorderSides = [sdLeft, sdTop]
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 957
                Height = 307
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                AutoFitColWidths = True
                BorderStyle = bsNone
                Color = clWhite
                DataSource = dsReport1
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
                IsDrawNullRow = True
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDblClick = DBGridEh1DblClick
                OnDrawColumnCell = DBGridEh1DrawColumnCell
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
                    Footer.Alignment = taCenter
                    Footer.Value = #21512#35745
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21830#21697#21517#31216
                    Width = 168
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #36135#21495
                    Width = 67
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    Title.Caption = #26465#22411#30721
                    Width = 93
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BATCH_NO'
                    Footers = <>
                    Title.Caption = #25209#21495
                    Width = 67
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UNIT_ID'
                    Footers = <>
                    Title.Caption = #21333#20301
                    Width = 26
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'BEG_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #26399#21021#32467#23384'|'#25968#37327
                    Width = 62
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'BEG_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26399#21021#32467#23384'|'#37329#39069
                    Width = 68
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'IN_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#36827#36135'|'#25968#37327
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'IN_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#36827#36135'|'#37329#39069
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'OUT_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#20986#36135'('#25104#26412')|'#25968#37327
                    Width = 62
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'OUT_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#20986#36135'('#25104#26412')|'#37329#39069
                    Width = 65
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'BAL_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26399#26411#32467#23384'|'#25968#37327
                    Width = 59
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'BAL_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26399#26411#32467#23384'|'#37329#39069
                    Width = 63
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TOOL_NAV'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25805#20316
                    Width = 30
                  end>
              end
              object rowToolNav: TRzToolbar
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
                TabOrder = 0
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
                  OnClick = RzToolButton5Click
                end
              end
            end
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        Caption = 'TabSheet2'
        object RzPanel1: TRzPanel
          Left = 0
          Top = 37
          Width = 979
          Height = 292
          Align = alClient
          BorderOuter = fsNone
          BorderColor = 15461355
          BorderWidth = 10
          Color = clWhite
          TabOrder = 0
          object RzPanel6: TRzPanel
            Left = 10
            Top = 10
            Width = 959
            Height = 272
            Align = alClient
            BorderOuter = fsStatus
            TabOrder = 0
            object RzPanel8: TRzPanel
              Left = 1
              Top = 1
              Width = 957
              Height = 270
              Align = alClient
              BorderOuter = fsNone
              BorderSides = [sdLeft, sdTop]
              TabOrder = 0
              object DBGridEh2: TDBGridEh
                Left = 0
                Top = 0
                Width = 957
                Height = 270
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                AutoFitColWidths = True
                BorderStyle = bsNone
                Color = clWhite
                DataSource = dsReport2
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
                IsDrawNullRow = True
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDrawColumnCell = DBGridEh2DrawColumnCell
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
                    FieldName = 'BILL_O_NAME'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #31867#22411
                    Width = 43
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'BILL_DATE'
                    Footer.Alignment = taCenter
                    Footer.Value = #21512#35745
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #26085#26399
                    Width = 85
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_NAME'
                    Footers = <>
                    Title.Caption = #20132#26131#21333#20301
                    Width = 149
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'IN_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#36827#36135'|'#25968#37327
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'IN_PRICE'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footers = <>
                    Title.Caption = #26085#24120#36827#36135'|'#21333#20215
                    Width = 60
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'IN_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#36827#36135'|'#37329#39069
                  end
                  item
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'OUT_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#20986#36135'('#25104#26412')|'#25968#37327
                    Width = 62
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'OUT_PRICE'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footers = <>
                    Title.Caption = #26085#24120#20986#36135'('#25104#26412')|'#21333#20215
                    Width = 62
                  end
                  item
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'OUT_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26085#24120#20986#36135'('#25104#26412')|'#37329#39069
                    Width = 65
                  end
                  item
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'BAL_AMOUNT'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.###'
                    Footers = <>
                    Title.Caption = #26399#26411#32467#23384'|'#25968#37327
                    Width = 59
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'BAL_PRICE'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footers = <>
                    Title.Caption = #26399#26411#32467#23384'|'#21333#20215
                    Width = 59
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'BAL_MONEY'
                    Footer.Alignment = taRightJustify
                    Footer.DisplayFormat = '#0.00#'
                    Footers = <>
                    Title.Caption = #26399#26411#32467#23384'|'#37329#39069
                    Width = 63
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TOOL_NAV'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #25805#20316
                    Width = 30
                  end>
              end
              object rowToolNav2: TRzToolbar
                Left = 521
                Top = 129
                Width = 48
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
                  )
                object TRzToolButton
                  Left = 0
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
              end
            end
          end
        end
        object RzPanel10: TRzPanel
          Left = 0
          Top = 0
          Width = 979
          Height = 37
          Align = alTop
          BorderOuter = fsNone
          Color = 12040119
          TabOrder = 1
          object RzLabel1: TRzLabel
            Left = 0
            Top = 0
            Width = 979
            Height = 37
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = #38144#21806#32479#35745#25253#34920
            Color = 15461355
            Font.Charset = GB2312_CHARSET
            Font.Color = 2889728
            Font.Height = -24
            Font.Name = #24494#36719#38597#40657
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Layout = tlCenter
            LightTextStyle = True
            ShadowColor = 16382457
            ShadowDepth = 1
            TextStyle = tsShadow
          end
        end
      end
    end
    inherited RzPanel11: TRzPanel
      Width = 979
      inherited RzPanel13: TRzPanel
        Width = 979
        inherited btnNav: TRzBitBtn
          Left = 1249
        end
        inherited RzBmpButton4: TRzBmpButton
          Left = 879
          OnClick = RzBmpButton4Click
        end
        object barcode: TRzPanel
          Left = 180
          Top = 20
          Width = 281
          Height = 29
          Anchors = [akLeft, akTop, akRight]
          BorderOuter = fsNone
          TabOrder = 2
          DesignSize = (
            281
            29)
          object barcode_input_left: TImage
            Left = 0
            Top = 0
            Width = 6
            Height = 29
            Align = alLeft
            AutoSize = True
            Picture.Data = {
              0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000600
              00001D080200000006BF8A47000000017352474200AECE1CE90000000467414D
              410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000
              00C04944415478DA63FCCFF09F010C162F5AFCFDFB77208311223469E2246969
              6929292901010190D0E44993D5D5D5D5D4D44444443838381867CF9E2D242464
              6C6C0C54C2CACA0AD2387DFA742323236D6D6D6E6E6E88A12055767676CACACA
              CCCCCC50A1B973E73A3838282A2A3232324285E6CD9B071162808151217C420B
              172EB4B1B14109C2D5AB57EBE9E9A104F4E9D3A7FFFFFFAFA5A585880E603C9E
              397D46545414116990D87EF4F0113052810AD9D9D919E169E2F9B3E7FCFCFC40
              2100D47866F951861B6A0000000049454E44AE426082}
            Transparent = True
          end
          object barcode_input_right: TImage
            Left = 276
            Top = 0
            Width = 5
            Height = 29
            Align = alRight
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000036000000280000000500
              00001D0000000100180000000000D0010000120B0000120B0000000000000000
              0000FCFCFCF5F5F5FF00FFFF00FFFF00FF00FCFCFCFCFCFCFFFFFFFF00FFFF00
              FF00FFFFFFFFFFFFFDFDFDFFFFFFFF00FF00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
              F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
              FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
              E600FBFBFBF3F3F3DFDFDFE2E2E2FF00FF00D6D6D6C6C6C6CBCBCBFF00FFFF00
              FF00AEAEAECBCBCBFF00FFFF00FFFF00FF00}
            Transparent = True
          end
          object barcode_input_line: TImage
            Left = 6
            Top = 0
            Width = 270
            Height = 29
            Hint = #25195#30721#38144#21806#35831#25353' pause '#20581
            Align = alClient
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D0000000100180000000000440200000000000000000000000000000000
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
              DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
              9E9E9E9E0000}
            Stretch = True
          end
          object edtGODS_ID: TzrComboBoxList
            Left = 6
            Top = 4
            Width = 270
            Height = 23
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = False
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonStyle = btsUltraFlat
            Style.ButtonTransparency = ebtInactive
            TabOrder = 0
            Text = #20840#37096#21830#21697
            OnExit = edtGODS_IDExit
            InGrid = True
            KeyValue = Null
            FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
            KeyField = 'GODS_ID'
            ListField = 'GODS_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'GODS_NAME'
                Footers = <>
                Title.Caption = #21830#21697#21517#31216
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'GODS_CODE'
                Footers = <>
                Title.Caption = #36135#21495
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'BARCODE'
                Footers = <>
                Title.Caption = #26465#30721
                Width = 65
              end>
            DropWidth = 380
            DropHeight = 250
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbClear]
            DropListStyle = lsFixed
            OnClearValue = edtGODS_IDClearValue
            MultiSelect = False
          end
        end
        object RzPanel4: TRzPanel
          Left = 475
          Top = 19
          Width = 387
          Height = 31
          Anchors = [akTop, akRight]
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 3
          object RzPanel9: TRzPanel
            Left = 2
            Top = 2
            Width = 63
            Height = 27
            Align = alLeft
            BorderOuter = fsFlat
            BorderSides = [sdRight, sdBottom]
            FlatColor = clGray
            TabOrder = 0
            object RzBackground7: TRzBackground
              Left = 0
              Top = 0
              Width = 62
              Height = 26
              Active = True
              Align = alClient
              FrameColor = 9145227
              GradientColorStart = clWhite
              GradientColorStop = 14277081
              ImageStyle = isStretch
              ShowGradient = True
              ShowImage = False
              ShowTexture = False
            end
            object RzLabel17: TRzLabel
              Left = 0
              Top = 0
              Width = 62
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #26085#26399
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ShadowColor = 16250871
              ShadowDepth = 1
              TextStyle = tsShadow
            end
          end
          object dateFlag: TcxComboBox
            Tag = -1
            Left = 64
            Top = 4
            Width = 55
            Height = 23
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              #20170#26085
              #26412#26376
              #26412#24180
              #33258#23450#20041)
            Properties.OnChange = dateFlagPropertiesChange
            Style.BorderColor = clWindowFrame
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 1
          end
          object D1: TcxDateEdit
            Tag = -1
            Left = 121
            Top = 4
            Width = 120
            Height = 23
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 2
          end
          object RzPanel23: TRzPanel
            Left = 119
            Top = 1
            Width = 3
            Height = 28
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdRight]
            TabOrder = 3
          end
          object RzPanel22: TRzPanel
            Left = 241
            Top = 2
            Width = 26
            Height = 27
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdRight]
            TabOrder = 4
            object RzBackground8: TRzBackground
              Left = 2
              Top = 0
              Width = 22
              Height = 27
              Active = True
              Align = alClient
              FrameColor = 9145227
              GradientColorStart = clWhite
              GradientColorStop = 14277081
              ImageStyle = isStretch
              ShowGradient = True
              ShowImage = False
              ShowTexture = False
            end
            object RzLabel16: TRzLabel
              Left = 2
              Top = 0
              Width = 22
              Height = 27
              Align = alClient
              Alignment = taCenter
              Caption = #33267
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ShadowColor = 16250871
              ShadowDepth = 1
              TextStyle = tsShadow
            end
          end
          object D2: TcxDateEdit
            Tag = -1
            Left = 266
            Top = 5
            Width = 119
            Height = 23
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonTransparency = ebtInactive
            TabOrder = 5
          end
        end
        object RzPanel5: TRzPanel
          Left = 12
          Top = 20
          Width = 157
          Height = 29
          BorderOuter = fsNone
          TabOrder = 4
          object Image1: TImage
            Left = 0
            Top = 0
            Width = 6
            Height = 29
            Align = alLeft
            AutoSize = True
            Picture.Data = {
              0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000600
              00001D080200000006BF8A47000000017352474200AECE1CE90000000467414D
              410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000
              00C04944415478DA63FCCFF09F010C162F5AFCFDFB77208311223469E2246969
              6929292901010190D0E44993D5D5D5D5D4D44444443838381867CF9E2D242464
              6C6C0C54C2CACA0AD2387DFA742323236D6D6D6E6E6E88A12055767676CACACA
              CCCCCC50A1B973E73A3838282A2A3232324285E6CD9B071162808151217C420B
              172EB4B1B14109C2D5AB57EBE9E9A104F4E9D3A7FFFFFFAFA5A585880E603C9E
              397D46545414116990D87EF4F0113052810AD9D9D919E169E2F9B3E7FCFCFC40
              2100D47866F951861B6A0000000049454E44AE426082}
            Transparent = True
          end
          object Image2: TImage
            Left = 152
            Top = 0
            Width = 5
            Height = 29
            Align = alRight
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000036000000280000000500
              00001D0000000100180000000000D0010000120B0000120B0000000000000000
              0000FCFCFCF5F5F5FF00FFFF00FFFF00FF00FCFCFCFCFCFCFFFFFFFF00FFFF00
              FF00FFFFFFFFFFFFFDFDFDFFFFFFFF00FF00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
              F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
              FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
              E600FBFBFBF3F3F3DFDFDFE2E2E2FF00FF00D6D6D6C6C6C6CBCBCBFF00FFFF00
              FF00AEAEAECBCBCBFF00FFFF00FFFF00FF00}
            Transparent = True
          end
          object Image3: TImage
            Left = 6
            Top = 0
            Width = 146
            Height = 29
            Hint = #25195#30721#38144#21806#35831#25353' pause '#20581
            Align = alClient
            AutoSize = True
            Picture.Data = {
              07544269746D61707A020000424D7A0200000000000036000000280000000600
              00001D0000000100180000000000440200000000000000000000000000000000
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
              DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
              9E9E9E9E0000}
            Stretch = True
          end
          object sortDrop: TcxButtonEdit
            Tag = -1
            Left = 6
            Top = 4
            Width = 146
            Height = 23
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            Properties.OnButtonClick = sortDropPropertiesButtonClick
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.HotTrack = False
            Style.ButtonStyle = btsUltraFlat
            Style.ButtonTransparency = ebtInactive
            TabOrder = 0
            Text = #20840#37096#20998#31867
            OnExit = sortDropExit
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 979
    inherited lblCaption: TRzLabel
      Width = 640
      Caption = #24211#23384#32479#35745#25253#34920
    end
    inherited RzPanel12: TRzPanel
      Left = 640
      Width = 339
      inherited RzBmpButton1: TRzBmpButton
        Left = 83
      end
      inherited RzBmpButton3: TRzBmpButton
        Left = 160
      end
      inherited RzBmpButton2: TRzBmpButton
        Left = 240
      end
      object btnPrior: TRzBmpButton
        Left = 4
        Top = 9
        Width = 72
        Height = 31
        Bitmaps.TransparentColor = clFuchsia
        Bitmaps.Up.Data = {
          5E1A0000424D5E1A0000000000003600000028000000480000001F0000000100
          180000000000281A000000000000000000000000000000000000B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B6B6B6B3B3B3ACAC
          ACA5A5A5A1A1A19F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A2A2A2A8A8A8B0B0
          B0B6B6B6B7B7B7B7B7B7B7B7B7B6B6B6B0B0B0A0A0A08B8B8B7B7B7B74747471
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          71717171717171717171717171727272767676828282959595A9A9A9B4B4B4B7
          B7B7B7B7B7B1B1B19C9C9CAAAAAAC3C3C3DADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADACECECEB4B4B48080807171718C8C8CA9A9A9B6B6B6B6B6B6ACACAC
          CCCCCCDADADADADADADBDBDBDADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADA989898717171959595B0B0B0B1B1B1D4D4D4DCDCDCDADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD8D8
          D87E7E7E808080A7A7A7BCBCBCE7E7E7DBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADABBBBBB757575A1
          A1A1C9C9C9E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAD4D4D4717171A0A0A0CBCBCBE7E7E7
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA737373A1A1A1CDCDCDE8E8E8DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DAD9D9D9797979A4A4A4CACACAECECECDBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADACBCBCB8A8A8AAC
          ACACBBBBBBEEEEEEE3E3E3DADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAAEAEAE9F9F9FB3B3B3B7B7B7CDCDCD
          EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADACECECE9E9E9EB1B1B1B6B6B6B7B7B7B7B7B7CDCDCDE9E9E9E7E7
          E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1DEDEDEC7C7C7ACAC
          ACB1B1B1B6B6B6B7B7B7B7B7B7B7B7B7B7B7B7BBBBBBC3C3C3C6C6C6C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4B8B8B8B3B3B3B6B6B6B7B7B7B7B7B7B7
          B7B7}
        Color = clBtnFace
        Caption = #36820#22238
        TabOrder = 3
        Visible = False
        OnClick = btnPriorClick
      end
    end
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
  end
  object cdsReport1: TZQuery
    FieldDefs = <>
    BeforeOpen = cdsReport1BeforeOpen
    CachedUpdates = True
    Params = <>
    Left = 214
    Top = 275
  end
  object dsReport1: TDataSource
    DataSet = cdsReport1
    Left = 254
    Top = 275
  end
  object cdsReport2: TZQuery
    FieldDefs = <>
    BeforeOpen = cdsReport2BeforeOpen
    CachedUpdates = True
    Params = <>
    Left = 214
    Top = 315
  end
  object dsReport2: TDataSource
    DataSet = cdsReport2
    Left = 254
    Top = 315
  end
end
