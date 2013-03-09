inherited frmInitGoods: TfrmInitGoods
  Left = 127
  Top = 120
  Caption = #21830#21697#21021#22987#21270#21521#23548
  ClientHeight = 567
  ClientWidth = 1047
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 1047
    Height = 567
    inherited webForm: TRzPanel
      Width = 1047
      Height = 567
      inherited bkgImage: TImage
        Width = 1047
        Height = 567
      end
      object RzPanel1: TRzPanel
        Left = 88
        Top = 46
        Width = 616
        Height = 435
        BorderOuter = fsFlatRounded
        BorderWidth = 2
        TabOrder = 0
        object RzPanel2: TRzPanel
          Left = 187
          Top = 45
          Width = 425
          Height = 341
          Align = alRight
          BorderOuter = fsFlat
          TabOrder = 0
          TabStop = True
          object rzPage: TRzPageControl
            Left = 1
            Top = 1
            Width = 423
            Height = 339
            ActivePage = TabSheet2
            Align = alClient
            Color = clWindow
            UseColoredTabs = True
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ShowCardFrame = False
            ShowShadow = False
            TabIndex = 1
            TabOrder = 0
            FixedDimension = 21
            object TabSheet1: TRzTabSheet
              Color = clWhite
              Caption = #24320#22987#21521#23548
              object RzBackground1: TRzBackground
                Left = 8
                Top = 11
                Width = 406
                Height = 49
                Active = True
                Align = alNone
                GradientColorStart = clGray
                GradientColorStop = clWhite
                GradientDirection = gdVerticalEnd
                ImageStyle = isCenter
                ShowGradient = True
                ShowImage = False
                ShowTexture = False
              end
              object RzLabel1: TRzLabel
                Left = 20
                Top = 23
                Width = 100
                Height = 24
                Caption = #31532#19968#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object RzLabel2: TRzLabel
                Left = 111
                Top = 32
                Width = 150
                Height = 15
                Caption = #35831#36873#25321#28155#21152#30340#26032#21697#31867#22411
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
              end
              object RzBorder1: TRzBorder
                Left = 8
                Top = 60
                Width = 407
                Height = 250
              end
              object RzLabel6: TRzLabel
                Left = 72
                Top = 128
                Width = 330
                Height = 15
                Caption = #25195#20837#26465#22411#30721#21518#31995#32479#23558#21040#20135#21697#24211#26816#27979#26159#21542#21830#21697#23384#22312#12290
                Font.Charset = GB2312_CHARSET
                Font.Color = clGreen
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
              end
              object RzLabel10: TRzLabel
                Left = 72
                Top = 205
                Width = 330
                Height = 15
                Caption = #27809#26377#26465#22411#30721#30340#21830#21697#31995#32479#23558#33258#21160#29983#25104#19968#20010#24215#20869#26465#30721#12290
                Font.Charset = GB2312_CHARSET
                Font.Color = clGreen
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
              end
              object edtGOODS_OPTION1: TcxRadioButton
                Left = 56
                Top = 99
                Width = 17
                Height = 17
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = edtGOODS_OPTION1Click
              end
              object RzPanel5: TRzPanel
                Left = 75
                Top = 97
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21830#21697#26465#22411#30721
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 3
                OnClick = RzPanel5Click
              end
              object edtGOODS_OPTION2: TcxRadioButton
                Left = 56
                Top = 178
                Width = 216
                Height = 17
                Caption = #27809#26377#26465#22411#30721#30340#21830#21697
                TabOrder = 1
                OnClick = edtGOODS_OPTION2Click
              end
              object edtInput: TcxTextEdit
                Left = 171
                Top = 96
                Width = 205
                Height = 23
                ParentFont = False
                Style.BorderColor = clGray
                Style.BorderStyle = ebsUltraFlat
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -15
                Style.Font.Name = #40657#20307
                Style.Font.Style = [fsBold]
                TabOrder = 2
                OnKeyPress = edtInputKeyPress
              end
              object RzPanel6: TRzPanel
                Left = 75
                Top = 175
                Width = 173
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #28155#21152#27809#26377#26465#22411#30721#30340#21830#21697
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 4
                OnClick = RzPanel6Click
              end
            end
            object TabSheet2: TRzTabSheet
              Color = clWindow
              Caption = #21830#21697#23646#24615
              object RzBorder2: TRzBorder
                Left = 8
                Top = 60
                Width = 407
                Height = 250
              end
              object RzBackground2: TRzBackground
                Left = 8
                Top = 11
                Width = 406
                Height = 49
                Active = True
                Align = alNone
                GradientColorStart = clGray
                GradientColorStop = clWhite
                GradientDirection = gdVerticalEnd
                ImageStyle = isCenter
                ShowGradient = True
                ShowImage = False
                ShowTexture = False
              end
              object RzLabel3: TRzLabel
                Left = 111
                Top = 32
                Width = 120
                Height = 15
                Caption = #22635#20889#21830#21697#30456#20851#23646#24615
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
              end
              object RzLabel9: TRzLabel
                Left = 20
                Top = 23
                Width = 100
                Height = 24
                Caption = #31532#20108#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object RzPanel17: TRzPanel
                Left = 25
                Top = 250
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #38646' '#21806' '#20215
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 15
              end
              object RzPanel16: TRzPanel
                Left = 25
                Top = 220
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #36827' '#36135' '#20215
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 14
              end
              object RzPanel14: TRzPanel
                Left = 25
                Top = 190
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #35745#37327#21333#20301
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 13
              end
              object RzPanel10: TRzPanel
                Left = 25
                Top = 130
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21830#21697#21517#31216
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 11
              end
              object RzPanel9: TRzPanel
                Left = 25
                Top = 100
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21830#21697#36135#21495
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 10
              end
              object edtGODS_CODE: TcxTextEdit
                Left = 121
                Top = 99
                Width = 116
                Height = 23
                Properties.MaxLength = 20
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtGODS_NAME: TcxTextEdit
                Left = 121
                Top = 129
                Width = 208
                Height = 23
                Properties.MaxLength = 50
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtCALC_UNITS: TzrComboBoxList
                Left = 121
                Top = 189
                Width = 60
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtCALC_UNITSPropertiesChange
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
                OnSaveValue = edtCALC_UNITSSaveValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtNEW_INPRICE: TcxTextEdit
                Left = 121
                Top = 219
                Width = 116
                Height = 23
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtNEW_OUTPRICE: TcxTextEdit
                Left = 121
                Top = 249
                Width = 116
                Height = 23
                TabOrder = 6
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtMoreUnits: TcxCheckBox
                Left = 189
                Top = 189
                Width = 136
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.OnChange = edtMoreUnitsPropertiesChange
                Properties.Caption = #21551#29992#21253#35013#21333#20301
                TabOrder = 8
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtSORT_ID1: TcxTextEdit
                Left = 270
                Top = 99
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 9
                Visible = False
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel12: TRzPanel
                Left = 25
                Top = 160
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21830#21697#31867#21035
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 12
              end
              object edtSORT_ID: TcxButtonEdit
                Left = 121
                Top = 159
                Width = 116
                Height = 23
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Properties.OnButtonClick = edtSORT_IDPropertiesButtonClick
                Style.BorderStyle = ebsUltraFlat
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.ButtonStyle = btsUltraFlat
                TabOrder = 3
                OnKeyPress = edtSORT_IDKeyPress
              end
              object RzPanel18: TRzPanel
                Left = 25
                Top = 280
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #24215#20869#21806#20215
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 16
              end
              object edtSHOP_NEW_OUTPRICE: TcxTextEdit
                Left = 121
                Top = 279
                Width = 116
                Height = 23
                TabOrder = 7
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel8: TRzPanel
                Left = 25
                Top = 70
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #26465' '#24418' '#30721
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 17
              end
              object edtBARCODE1: TcxTextEdit
                Left = 121
                Top = 69
                Width = 116
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object TabSheet3: TRzTabSheet
              Color = clWindow
              Caption = #21830#21697#21253#35013
              object RzBorder3: TRzBorder
                Left = 8
                Top = 60
                Width = 407
                Height = 250
              end
              object RzBackground3: TRzBackground
                Left = 8
                Top = 11
                Width = 406
                Height = 49
                Active = True
                Align = alNone
                GradientColorStart = clGray
                GradientColorStop = clWhite
                GradientDirection = gdVerticalEnd
                ImageStyle = isCenter
                ShowGradient = True
                ShowImage = False
                ShowTexture = False
              end
              object RzLabel7: TRzLabel
                Left = 25
                Top = 74
                Width = 45
                Height = 15
                Caption = #23567#21253#35013
              end
              object RzLabel8: TRzLabel
                Left = 25
                Top = 190
                Width = 45
                Height = 15
                Caption = #22823#21253#35013
              end
              object Bevel1: TBevel
                Left = 75
                Top = 80
                Width = 300
                Height = 2
                Shape = bsTopLine
              end
              object Bevel2: TBevel
                Left = 75
                Top = 196
                Width = 300
                Height = 2
                Shape = bsTopLine
              end
              object RzLabel4: TRzLabel
                Left = 111
                Top = 32
                Width = 135
                Height = 15
                Caption = #35774#32622#21830#21697#30340#21253#35013#23646#24615
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
              end
              object RzLabel5: TRzLabel
                Left = 20
                Top = 23
                Width = 100
                Height = 24
                Caption = #31532#19977#27493#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clWhite
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object edtDefault1: TcxCheckBox
                Left = 205
                Top = 100
                Width = 121
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#20026#31649#29702#21333#20301
                TabOrder = 6
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnClick = edtDefault1Click
              end
              object edtDefault2: TcxCheckBox
                Left = 205
                Top = 216
                Width = 121
                Height = 23
                Properties.DisplayUnchecked = 'False'
                Properties.Caption = #35774#20026#31649#29702#21333#20301
                TabOrder = 8
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnClick = edtDefault2Click
              end
              object RzPanel11: TRzPanel
                Left = 30
                Top = 100
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#21333#20301
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 7
              end
              object RzPanel13: TRzPanel
                Left = 30
                Top = 160
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#31995#25968
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 9
              end
              object RzPanel15: TRzPanel
                Left = 30
                Top = 246
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#26465#30721
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 10
              end
              object RzPanel19: TRzPanel
                Left = 30
                Top = 216
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#21333#20301
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 11
              end
              object RzPanel20: TRzPanel
                Left = 30
                Top = 130
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#26465#30721
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 12
              end
              object RzPanel21: TRzPanel
                Left = 30
                Top = 276
                Width = 99
                Height = 21
                BorderOuter = fsFlatRounded
                Caption = #21253#35013#31995#25968
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 13
              end
              object edtSMALL_UNITS: TzrComboBoxList
                Left = 126
                Top = 99
                Width = 70
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtSMALL_UNITSPropertiesChange
                TabOrder = 0
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
                Buttons = [zbClear]
                DropListStyle = lsFixed
                OnSaveValue = edtSMALL_UNITSSaveValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtBARCODE2: TcxTextEdit
                Left = 126
                Top = 129
                Width = 119
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtBIG_UNITS: TzrComboBoxList
                Left = 126
                Top = 215
                Width = 70
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtBIG_UNITSPropertiesChange
                TabOrder = 3
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
                Buttons = [zbClear]
                DropListStyle = lsFixed
                OnSaveValue = edtBIG_UNITSSaveValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
              object edtBARCODE3: TcxTextEdit
                Left = 126
                Top = 245
                Width = 119
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtBIGTO_CALC: TcxTextEdit
                Left = 126
                Top = 275
                Width = 40
                Height = 23
                TabOrder = 5
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel_SMALL: TRzPanel
                Left = 164
                Top = 160
                Width = 110
                Height = 21
                Alignment = taLeftJustify
                BorderOuter = fsFlat
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 14
              end
              object edtSMALLTO_CALC: TcxTextEdit
                Left = 126
                Top = 159
                Width = 40
                Height = 23
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel_BIG: TRzPanel
                Left = 164
                Top = 276
                Width = 110
                Height = 21
                Alignment = taLeftJustify
                BorderOuter = fsFlat
                Color = 16185078
                FlatColor = clMenuHighlight
                TabOrder = 15
              end
            end
          end
        end
        object RzPanel3: TRzPanel
          Left = 4
          Top = 386
          Width = 608
          Height = 45
          Align = alBottom
          BorderOuter = fsFlat
          BorderSides = [sdLeft, sdRight, sdBottom]
          Color = clWhite
          TabOrder = 1
          DesignSize = (
            608
            45)
          object btnNext: TRzBitBtn
            Left = 499
            Top = 7
            Width = 70
            Height = 28
            Anchors = [akTop]
            Caption = #19979#19968#27493
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
            TabOrder = 0
            ThemeAware = False
            OnClick = btnNextClick
            NumGlyphs = 2
            Spacing = 5
          end
          object btnPrev: TRzBitBtn
            Left = 408
            Top = 7
            Width = 70
            Height = 28
            Anchors = [akTop]
            Caption = #19978#19968#27493
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
            ThemeAware = False
            OnClick = btnPrevClick
            NumGlyphs = 2
            Spacing = 5
          end
        end
        object RzPanel7: TRzPanel
          Left = 4
          Top = 45
          Width = 180
          Height = 341
          Align = alLeft
          BorderOuter = fsFlat
          Color = clWhite
          TabOrder = 2
          object adv03: TImage
            Left = 1
            Top = 1
            Width = 178
            Height = 339
            Align = alClient
          end
        end
        object RzPanel4: TRzPanel
          Left = 4
          Top = 4
          Width = 608
          Height = 41
          Align = alTop
          BorderOuter = fsNone
          Color = clGray
          TabOrder = 3
          object lblCaption: TRzLabel
            Left = 16
            Top = 8
            Width = 150
            Height = 24
            Caption = #28155#21152#32463#33829#21830#21697
            Font.Charset = GB2312_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = #40657#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object btnClose: TRzBmpButton
            Left = 594
            Top = 5
            Width = 9
            Height = 9
            Bitmaps.TransparentColor = clFuchsia
            Bitmaps.Up.Data = {
              32010000424D3201000000000000360000002800000009000000090000000100
              180000000000FC00000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFAFAFAFAFAFAFFF
              00FFFF00FFFF00FFAFAFAFAFAFAFFF00FF00FF00FFAFAFAFAFAFAFAFAFAFFF00
              FFAFAFAFAFAFAFAFAFAFFF00FF00FF00FFFF00FFAFAFAFAFAFAFAFAFAFAFAFAF
              AFAFAFFF00FFFF00FF00FF00FFFF00FFFF00FFAFAFAFAEAEAEAFAFAFFF00FFFF
              00FFFF00FF00FF00FFFF00FFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFFF00FFFF00
              FF00FF00FFAFAFAFAFAFAFAFAFAFFF00FFAFAFAFAFAFAFAFAFAFFF00FF00FF00
              FFAFAFAFAFAFAFFF00FFFF00FFFF00FFAFAFAFAFAFAFFF00FF00FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
            Color = clBtnFace
            TabOrder = 0
            Visible = False
            OnClick = btnCloseClick
          end
        end
      end
    end
  end
  object cdsGoodsInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 450
    Top = 16
  end
  object cdsGoodsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 514
    Top = 16
  end
  object cdsBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 578
    Top = 16
  end
  object edtTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 646
    Top = 16
  end
  object cdsGoodsPrice: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 370
    Top = 16
  end
end
