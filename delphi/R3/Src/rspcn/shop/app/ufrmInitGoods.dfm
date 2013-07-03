inherited frmInitGoods: TfrmInitGoods
  Left = 359
  Top = 154
  Caption = #21830#21697#21021#22987#21270#21521#23548
  ClientHeight = 425
  ClientWidth = 613
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  inherited RzPanel1: TRzPanel
    Width = 613
    Height = 397
    object RzPanel2: TRzPanel
      Left = 1
      Top = 1
      Width = 611
      Height = 395
      Align = alClient
      BorderOuter = fsFlatRounded
      BorderWidth = 2
      TabOrder = 0
      object RzPanel3: TRzPanel
        Left = 184
        Top = 4
        Width = 423
        Height = 342
        Align = alClient
        BorderOuter = fsFlat
        TabOrder = 0
        object rzPage: TRzPageControl
          Left = 1
          Top = 1
          Width = 421
          Height = 340
          ActivePage = TabSheet1
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
          TabOrder = 0
          TabStop = False
          FixedDimension = 0
          object TabSheet1: TRzTabSheet
            Color = 15461355
            TabVisible = False
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
            object RzLabel2: TRzLabel
              Left = 42
              Top = 29
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
              Height = 270
            end
            object RzLabel6: TRzLabel
              Left = 64
              Top = 152
              Width = 315
              Height = 15
              Caption = #25195#20837#26465#22411#30721#21518#31995#32479#23558#21040#20135#21697#24211#26816#27979#26159#21542#21830#21697#23384#22312
              Font.Charset = GB2312_CHARSET
              Font.Color = clGreen
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object RzLabel10: TRzLabel
              Left = 64
              Top = 245
              Width = 315
              Height = 15
              Caption = #27809#26377#26465#22411#30721#30340#21830#21697#31995#32479#23558#33258#21160#29983#25104#19968#20010#24215#20869#26465#30721
              Font.Charset = GB2312_CHARSET
              Font.Color = clGreen
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object edtGOODS_OPTION1: TcxRadioButton
              Left = 40
              Top = 115
              Width = 17
              Height = 17
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = edtGOODS_OPTION1Click
            end
            object edtGOODS_OPTION2: TcxRadioButton
              Left = 40
              Top = 210
              Width = 17
              Height = 17
              TabOrder = 1
              OnClick = edtGOODS_OPTION2Click
            end
            object edtBK_Input: TRzPanel
              Left = 64
              Top = 108
              Width = 313
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 2
              DesignSize = (
                313
                31)
              object RzPanel24: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel11: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21830#21697#26465#24418#30721
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  OnClick = RzLabel11Click
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtInput: TcxTextEdit
                Left = 105
                Top = 4
                Width = 205
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                ParentFont = False
                Style.BorderColor = clGray
                Style.BorderStyle = ebsUltraFlat
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -15
                Style.Font.Name = #40657#20307
                Style.Font.Style = [fsBold]
                TabOrder = 1
                OnKeyPress = edtInputKeyPress
              end
            end
            object RzPanel5: TRzPanel
              Left = 64
              Top = 202
              Width = 313
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 3
              object RzPanel23: TRzPanel
                Left = 2
                Top = 2
                Width = 309
                Height = 27
                Align = alClient
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel12: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 308
                  Height = 27
                  Align = alClient
                  Caption = '  '#28155#21152#27809#26377#26465#22411#30721#30340#21830#21697
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  OnClick = RzLabel12Click
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
            end
          end
          object TabSheet2: TRzTabSheet
            Color = 15461355
            TabVisible = False
            Caption = #21830#21697#23646#24615
            object RzBorder2: TRzBorder
              Left = 8
              Top = 60
              Width = 407
              Height = 270
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
            object red2: TLabel
              Left = 290
              Top = 141
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object red1: TLabel
              Left = 290
              Top = 77
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object red3: TLabel
              Left = 290
              Top = 173
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object red4: TLabel
              Left = 197
              Top = 205
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object red5: TLabel
              Left = 290
              Top = 269
              Width = 6
              Height = 12
              Alignment = taRightJustify
              Caption = '*'
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object edtMoreUnits: TcxCheckBox
              Left = 212
              Top = 200
              Width = 136
              Height = 23
              Properties.DisplayUnchecked = 'False'
              Properties.OnChange = edtMoreUnitsPropertiesChange
              Properties.Caption = #21551#29992#21253#35013#21333#20301
              TabOrder = 8
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object edtSORT_ID1: TcxTextEdit
              Left = 294
              Top = 116
              Width = 116
              Height = 23
              TabStop = False
              Properties.MaxLength = 30
              TabOrder = 9
              Visible = False
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object edtBK_BARCODE1: TRzPanel
              Left = 24
              Top = 68
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 0
              DesignSize = (
                260
                31)
              object RzPanel8: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel13: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 62
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #26465' '#22411' '#30721
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
              object edtBARCODE1: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 30
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtBARCODE1KeyPress
              end
            end
            object edtBK_GODS_CODE: TRzPanel
              Left = 24
              Top = 100
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              DesignSize = (
                260
                31)
              object RzPanel26: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel14: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21830#21697#36135#21495
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
              object edtGODS_CODE: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 20
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtGODS_CODEKeyPress
              end
            end
            object edtBK_GODS_NAME: TRzPanel
              Left = 24
              Top = 132
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 2
              DesignSize = (
                260
                31)
              object RzPanel27: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel15: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21830#21697#21517#31216
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
              object edtGODS_NAME: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 50
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtGODS_NAMEKeyPress
              end
            end
            object edtBK_SORT_ID: TRzPanel
              Left = 24
              Top = 164
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 3
              DesignSize = (
                260
                31)
              object RzPanel28: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel16: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21830#21697#20998#31867
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
              object edtSORT_ID: TcxButtonEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Properties.OnButtonClick = edtSORT_IDPropertiesButtonClick
                Style.BorderStyle = ebsUltraFlat
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.ButtonStyle = btsUltraFlat
                Style.ButtonTransparency = ebtInactive
                TabOrder = 0
                OnKeyDown = edtSORT_IDKeyDown
                OnKeyPress = edtSORT_IDKeyPress
              end
            end
            object edtBK_CALC_UNITS: TRzPanel
              Left = 24
              Top = 196
              Width = 167
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 4
              DesignSize = (
                167
                31)
              object RzPanel29: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel17: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #35745#37327#21333#20301
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
              object edtCALC_UNITS: TzrComboBoxList
                Left = 105
                Top = 4
                Width = 60
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtCALC_UNITSPropertiesChange
                Style.ButtonTransparency = ebtInactive
                TabOrder = 0
                OnKeyPress = edtCALC_UNITSKeyPress
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
            end
            object edtBK_NEW_INPRICE: TRzPanel
              Left = 24
              Top = 228
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 5
              DesignSize = (
                260
                31)
              object RzPanel16: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel18: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 62
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #36827' '#36135' '#20215
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
              object edtNEW_INPRICE: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 9
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtNEW_INPRICEKeyPress
              end
            end
            object edtBK_NEW_OUTPRICE: TRzPanel
              Left = 24
              Top = 260
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 6
              DesignSize = (
                260
                31)
              object RzPanel31: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel19: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 62
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #38646' '#21806' '#20215
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
              object edtNEW_OUTPRICE: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 9
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtNEW_OUTPRICEKeyPress
              end
            end
            object edtBK_SHOP_NEW_OUTPRICE: TRzPanel
              Left = 24
              Top = 292
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 7
              DesignSize = (
                260
                31)
              object RzPanel18: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 1
                object RzLabel20: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #24215#20869#21806#20215
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
              object edtSHOP_NEW_OUTPRICE: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 9
                TabOrder = 0
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtSHOP_NEW_OUTPRICEKeyPress
              end
            end
          end
          object TabSheet3: TRzTabSheet
            Color = 15461355
            TabVisible = False
            Caption = #21830#21697#21253#35013
            object RzBorder3: TRzBorder
              Left = 8
              Top = 60
              Width = 407
              Height = 270
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
              Top = 71
              Width = 45
              Height = 15
              Caption = #23567#21253#35013
            end
            object RzLabel8: TRzLabel
              Left = 25
              Top = 203
              Width = 45
              Height = 15
              Caption = #22823#21253#35013
            end
            object Bevel1: TBevel
              Left = 75
              Top = 77
              Width = 300
              Height = 2
              Shape = bsTopLine
            end
            object Bevel2: TBevel
              Left = 75
              Top = 209
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
              Left = 213
              Top = 101
              Width = 121
              Height = 23
              Properties.DisplayUnchecked = 'False'
              Properties.Caption = #35774#20026#31649#29702#21333#20301
              TabOrder = 6
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              OnClick = edtDefault1Click
            end
            object edtDefault2: TcxCheckBox
              Left = 213
              Top = 229
              Width = 121
              Height = 23
              Properties.DisplayUnchecked = 'False'
              Properties.Caption = #35774#20026#31649#29702#21333#20301
              TabOrder = 7
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              OnClick = edtDefault2Click
            end
            object edtBK_SMALL_UNITS: TRzPanel
              Left = 32
              Top = 97
              Width = 178
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 0
              DesignSize = (
                178
                31)
              object RzPanel33: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel21: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#21333#20301
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
              object edtSMALL_UNITS: TzrComboBoxList
                Left = 105
                Top = 4
                Width = 70
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtSMALL_UNITSPropertiesChange
                Style.ButtonTransparency = ebtInactive
                TabOrder = 1
                OnKeyPress = edtSMALL_UNITSKeyPress
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
                OnClearValue = edtSMALL_UNITSClearValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
            end
            object edtBK_BARCODE2: TRzPanel
              Left = 32
              Top = 129
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              DesignSize = (
                260
                31)
              object RzPanel34: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel22: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#26465#30721
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
              object edtBARCODE2: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 30
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object edtBK_SMALLTO_CALC: TRzPanel
              Left = 32
              Top = 161
              Width = 148
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 2
              DesignSize = (
                148
                31)
              object RzPanel35: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel23: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#31995#25968
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
              object edtSMALLTO_CALC: TcxTextEdit
                Left = 105
                Top = 4
                Width = 40
                Height = 23
                Anchors = [akLeft, akTop, akRight]
                Properties.MaxLength = 9
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtSMALLTO_CALCKeyPress
              end
            end
            object RzPanel13: TRzPanel
              Left = 179
              Top = 161
              Width = 114
              Height = 31
              BorderOuter = fsStatus
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 8
              object RzPanel36: TRzPanel
                Left = 1
                Top = 1
                Width = 112
                Height = 29
                Align = alClient
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzPanel_SMALL: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 9
                  Height = 16
                  Align = alClient
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
            end
            object edtBK_BIG_UNITS: TRzPanel
              Left = 32
              Top = 225
              Width = 178
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 3
              object RzPanel38: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel24: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#21333#20301
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
              object edtBIG_UNITS: TzrComboBoxList
                Left = 105
                Top = 4
                Width = 70
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                Properties.OnChange = edtBIG_UNITSPropertiesChange
                Style.ButtonTransparency = ebtInactive
                TabOrder = 1
                OnKeyPress = edtBIG_UNITSKeyPress
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
                OnClearValue = edtBIG_UNITSClearValue
                MultiSelect = False
                ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
              end
            end
            object edtBK_BARCODE3: TRzPanel
              Left = 32
              Top = 257
              Width = 260
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 4
              object RzPanel19: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel25: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#26465#30721
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
              object edtBARCODE3: TcxTextEdit
                Left = 105
                Top = 4
                Width = 153
                Height = 23
                Properties.MaxLength = 30
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object RzPanel39: TRzPanel
              Left = 179
              Top = 289
              Width = 114
              Height = 31
              BorderOuter = fsStatus
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 9
              object RzPanel40: TRzPanel
                Left = 1
                Top = 1
                Width = 112
                Height = 29
                Align = alClient
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzPanel_BIG: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 9
                  Height = 16
                  Align = alClient
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
            end
            object edtBK_BIGTO_CALC: TRzPanel
              Left = 32
              Top = 289
              Width = 148
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 5
              object RzPanel42: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel27: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 61
                  Height = 16
                  Align = alClient
                  Alignment = taCenter
                  Caption = #21253#35013#31995#25968
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
              object edtBIGTO_CALC: TcxTextEdit
                Left = 105
                Top = 4
                Width = 40
                Height = 23
                Properties.MaxLength = 9
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtBIGTO_CALCKeyPress
              end
            end
          end
        end
      end
      object RzPanel4: TRzPanel
        Left = 4
        Top = 346
        Width = 603
        Height = 45
        Align = alBottom
        BorderOuter = fsFlat
        BorderSides = [sdLeft, sdRight, sdBottom]
        Color = 15461355
        TabOrder = 1
        object btnNext: TRzBmpButton
          Left = 522
          Top = 7
          Width = 72
          Bitmaps.TransparentColor = clFuchsia
          Bitmaps.Up.Data = {
            86190000424D86190000000000003600000028000000480000001E0000000100
            1800000000005019000000000000000000000000000000000000EBEBEBEBEBEB
            EAEAEAE6E6E6DDDDDDD4D4D4CECECECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCECECE
            D0D0D0D8D8D8E2E2E2E9E9E9EBEBEBEBEBEBEBEBEBEAEAEAE2E2E2CECECEB3B3
            B39F9F9F94949492929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            929292929292929292929292929292929292929292939393989898A7A7A7C0C0
            C0D9D9D9E7E7E7EBEBEBEBEBEBE3E3E3C7C7C7BCBCBCC9C9C9DADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADAD0D0D0BCBCBC959595919191B4B4B4D9D9D9E9
            E9E9E9E9E9D4D4D4D2D2D2DADADADADADADBDBDBDADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADAA6A6A6919191BFBFBFE2E2E2E4E4E4DDDDDD
            DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADAD9D9D9939393A5A5A5D7D7D7E2E2E2E7E7E7DBDBDBDADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DAC1C1C1969696CFCFCFE4E4E4E7E7E7DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D5929292CE
            CECEE5E5E5E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA939393CECECEE8E8E8E8E8E8
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADAD9D9D99C9C9CD2D2D2EAEAEAECECECDBDBDBDADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DACFCFCFB1B1B1DCDCDCEBEBEBF0F0F0E3E3E3DADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADABFBFBFCDCDCDE6
            E6E6EBEBEBECECECEEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADAD3D3D3C9C9C9E3E3E3EAEAEAEBEBEBEBEBEB
            EBEBEBEBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
            DEDEDED4D4D4D6D6D6E4E4E4EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAE7E7
            E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1E1E1E1E5E5E5E9E9
            E9EBEBEBEBEBEBEBEBEB}
          Color = clBtnFace
          Caption = #19979#19968#27493
          TabOrder = 0
          OnClick = btnNextClick
        end
        object btnPrev: TRzBmpButton
          Left = 426
          Top = 7
          Width = 72
          Bitmaps.TransparentColor = clFuchsia
          Bitmaps.Up.Data = {
            86190000424D86190000000000003600000028000000480000001E0000000100
            1800000000005019000000000000000000000000000000000000EBEBEBEBEBEB
            EAEAEAE6E6E6DDDDDDD4D4D4CECECECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
            CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCECECE
            D0D0D0D8D8D8E2E2E2E9E9E9EBEBEBEBEBEBEBEBEBEAEAEAE2E2E2CECECEB3B3
            B39F9F9F94949492929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            9292929292929292929292929292929292929292929292929292929292929292
            929292929292929292929292929292929292929292939393989898A7A7A7C0C0
            C0D9D9D9E7E7E7EBEBEBEBEBEBE3E3E3C7C7C7BCBCBCC9C9C9DADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADAD0D0D0BCBCBC959595919191B4B4B4D9D9D9E9
            E9E9E9E9E9D4D4D4D2D2D2DADADADADADADBDBDBDADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADAA6A6A6919191BFBFBFE2E2E2E4E4E4DDDDDD
            DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADAD9D9D9939393A5A5A5D7D7D7E2E2E2E7E7E7DBDBDBDADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DAC1C1C1969696CFCFCFE4E4E4E7E7E7DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D5929292CE
            CECEE5E5E5E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
            CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADA939393CECECEE8E8E8E8E8E8
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADAD9D9D99C9C9CD2D2D2EAEAEAECECECDBDBDBDADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DACFCFCFB1B1B1DCDCDCEBEBEBF0F0F0E3E3E3DADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADABFBFBFCDCDCDE6
            E6E6EBEBEBECECECEEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
            DADADADADADADADADADADADADADAD3D3D3C9C9C9E3E3E3EAEAEAEBEBEBEBEBEB
            EBEBEBEBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
            DEDEDED4D4D4D6D6D6E4E4E4EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAE7E7
            E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
            E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1E1E1E1E5E5E5E9E9
            E9EBEBEBEBEBEBEBEBEB}
          Color = clBtnFace
          Caption = #19978#19968#27493
          TabOrder = 1
          OnClick = btnPrevClick
        end
      end
      object RzPanel7: TRzPanel
        Left = 4
        Top = 4
        Width = 180
        Height = 342
        Align = alLeft
        BorderOuter = fsFlat
        Color = clWhite
        TabOrder = 2
        object adv03: TImage
          Left = 1
          Top = 1
          Width = 178
          Height = 340
          Align = alClient
          Picture.Data = {
            0A544A504547496D6167651F7F0000FFD8FFE000104A46494600010201004800
            480000FFE1087B4578696600004D4D002A000000080007011200030000000100
            010000011A00050000000100000062011B0005000000010000006A0128000300
            00000100020000013100020000001C0000007201320002000000140000008E87
            69000400000001000000A4000000D0000AFC8000002710000AFC800000271041
            646F62652050686F746F73686F70204353342057696E646F777300323031333A
            30373A30322031363A35363A34360000000003A00100030000000100010000A0
            02000400000001000000B2A00300040000000100000154000000000000000601
            0300030000000100060000011A0005000000010000011E011B00050000000100
            00012601280003000000010002000002010004000000010000012E0202000400
            000001000007450000000000000048000000010000004800000001FFD8FFE000
            104A46494600010200004800480000FFED000C41646F62655F434D0001FFEE00
            0E41646F626500648000000001FFDB0084000C08080809080C09090C110B0A0B
            11150F0C0C0F1518131315131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E
            0E14140E0E0E0E14110C0C0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC000110800A0005403012200
            021101031101FFDD00040006FFC4013F00000105010101010101000000000000
            00030001020405060708090A0B01000105010101010101000000000000000100
            02030405060708090A0B1000010401030204020507060805030C330100021103
            04211231054151611322718132061491A1B14223241552C16233347282D14307
            259253F0E1F163733516A2B283264493546445C2A3743617D255E265F2B384C3
            D375E3F3462794A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F6
            37475767778797A7B7C7D7E7F711000202010204040304050607070605350100
            021103213112044151617122130532819114A1B14223C152D1F0332462E17282
            92435315637334F1250616A2B283072635C2D2449354A317644555367465E2F2
            B384C3D375E3F34694A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6
            E6F62737475767778797A7B7C7FFDA000C03010002110311003F00EC0FD23F12
            9939FA47E2532B6D45249249294924924A5249249294924924A524924929FFD0
            EC0FD23F129939FA47E2532B6D45249249294924924A5249249294924924A524
            924929FFD1EC0FD23F129939FA47E2532B6D45249E1386A4A629D4F6A5B50B4D
            23494CB53108DA298A492B56E11AF145A7F9C065EDEC1A7FF228190157D52013
            75D1AA92492287FFD2EC0FD23F1290091FA47E254DA15A6A280530D4ED6A206A
            692BC061B52DAAEE3D753036C7997BBE88F01C6F52CBC7ADA3D46692608EC67B
            A671EB4BF834B73CB544B51CB541CD4E05690B6235BEB89692402E07480478FE
            77F555CBED35D0F7801DC0DAE983B8ED8D157C6105CEF804F9AEFD0B5BFBCE9F
            9347FE66987D59005E3D38C968F924924A7607FFD3EC7F38FC4A23428773F13F
            9515AAC96B048D63B6EF8F6CC4F9A235AA2D2636CFB6663B4A3304F0A391ADD9
            005377379F734F71C8F8FEF31AA44BDCDDA746032077526C112148851D8DC327
            440E6A13823BCB5B1B881B8C367B9E6021BC42782B08635E810B30CB98DFDD6C
            FCDC777FD4ED45682600E4E8102F76EB5EE1C4C0F80F6B52C7AC89564D22020E
            E927EE929981FFD4ECBB9F89FCA8AD41EE7E2511A5592D609D88EC246AD89F3E
            10ABA6D73439AD9078F153AC39E76B449514C02083A8EAC812540B41DC65C4C9
            44250C8730C3931B1A3427551C60231111B05E1C0EA5D5187AA5D8578735AD73
            595D8DEC21AE735D59FDEB3DDEA56AFE0DCEB718D867D373CB69DDA9D8D11BBF
            B6F44EA4CE99656C77507575898AAC7BB6BA47D26D647BDCDD7F49F988840F68
            6C0AC347A7B60B4B23DAE616FB762688912249BBDBEADAC99E12C30C71818CA3
            5C57F2FA7F4A3FD6C8C9A7682FFDD048F8FD16FF00D22AABBC11ADB1801A5A65
            ED33681F9A63D8C77F2BDDBF6A038AB18C50F368E43AF931EE926EE929189FFF
            D5EC0FD23F12AD62D05F163D8E755DB6899F94EED9FD5555DC9F89456752CA6B
            4825AF2D880E681EDFA3F99B14F92440D3AB06388275E8E9D4FAC388639D206A
            D76ED00FDD6D9EE40B9CEAAE2E61DBEA091F3FA63FCE4D4F521658DA9D5EDDE3
            730876874FA3047EF7B118B8167BDA1C4FD1900850834CC45B56EC87EC049977
            D169FE28350363DAC06371E7C072E77F65AACE5D349A8B9AD0C7B0493C478B55
            5160A8068D6DBC1DA3C2B07DF61FF8C77E8D9FF5C47720046C092E3F54E9FD47
            A8750764D168C5A83456C6B86F3B19F47E9FD0FDEF4D8AEF4BC2CEC166D7F51B
            6E66A5B48654DAC38EA5CD3E99B9BFD5AACA914EEDCEEFA9446121BAF8A7888B
            58646B7605B7B746DA23531B40E753C26DD67E741F30A64A895280C44AD29249
            2287FFD6EBDFC9F8940AAE6FAC5B21C2092D9E5A7DAF561DC9F89556CE9F865D
            EA0A8B6C1C3AB25875FE535599C4C8535A1211369A0B418D1F4BB735C3C0F7F6
            FF002B6FF9EB62BB05AD6DCD3ABF503C23E96E9FA3B172CDA7AF0C82E6E5D4CA
            00DA2AB6BF58ED8DBB77B0D0FF00FC155DB2ABF2B09D8375A1B8EF3FACBAADCC
            7BEB23DF8AC3B9DE8B721DFCEBF7FF0035EA28380DD33F18AB65566BBAAE43AF
            67FC95418C700C1CAB468EC973FF00C1E033E8E3BBFED47F3F57A9FA25600DAE
            73DCEDF6D9ABDED1A69A358C6FE6555B7F9B62800D6B5B5D6D6D75B006B2B608
            6B40D035AD09D4D1C75E6C32C97E4CBDA3C53174A8A49C000B492574C9248A14
            924924A7FFD7EC0FD23F1299D31EDE7B273F48FC4A656DA88C547B9FB9100810
            38E524900004924A92492450A4924925292492494A49249253FFD0EC0FD23F12
            9939E4FC4A656DA8A4924925292492494A4924925292492494A49249253FFFD9
            FFED0D4E50686F746F73686F7020332E30003842494D04250000000000100000
            00000000000000000000000000003842494D03ED000000000010004800000001
            000200480000000100023842494D042600000000000E00000000000000000000
            3F8000003842494D040D000000000004000000783842494D0419000000000004
            0000001E3842494D03F3000000000009000000000000000001003842494D2710
            00000000000A000100000000000000023842494D03F5000000000048002F6666
            0001006C66660006000000000001002F6666000100A1999A0006000000000001
            003200000001005A00000006000000000001003500000001002D000000060000
            000000013842494D03F80000000000700000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E80000
            3842494D040000000000000200073842494D0402000000000010000000000001
            000100010000000000003842494D043000000000000801010101010101013842
            494D042D00000000000200003842494D04080000000000100000000100000240
            00000240000000003842494D041E000000000004000000003842494D041A0000
            0000033F00000006000000000000000000000154000000B200000005672A6807
            9898002D00310000000100000000000000000000000000000000000000010000
            000000000000000000B200000154000000000000000000000000000000000100
            00000000000000000000000000000000000010000000010000000000006E756C
            6C0000000200000006626F756E64734F626A6300000001000000000000526374
            310000000400000000546F70206C6F6E6700000000000000004C6566746C6F6E
            67000000000000000042746F6D6C6F6E670000015400000000526768746C6F6E
            67000000B200000006736C69636573566C4C73000000014F626A630000000100
            0000000005736C6963650000001200000007736C69636549446C6F6E67000000
            000000000767726F757049446C6F6E6700000000000000066F726967696E656E
            756D0000000C45536C6963654F726967696E0000000D6175746F47656E657261
            7465640000000054797065656E756D0000000A45536C69636554797065000000
            00496D672000000006626F756E64734F626A6300000001000000000000526374
            310000000400000000546F70206C6F6E6700000000000000004C6566746C6F6E
            67000000000000000042746F6D6C6F6E670000015400000000526768746C6F6E
            67000000B20000000375726C54455854000000010000000000006E756C6C5445
            5854000000010000000000004D7367655445585400000001000000000006616C
            74546167544558540000000100000000000E63656C6C54657874497348544D4C
            626F6F6C010000000863656C6C54657874544558540000000100000000000968
            6F727A416C69676E656E756D0000000F45536C696365486F727A416C69676E00
            00000764656661756C740000000976657274416C69676E656E756D0000000F45
            536C69636556657274416C69676E0000000764656661756C740000000B626743
            6F6C6F7254797065656E756D0000001145536C6963654247436F6C6F72547970
            65000000004E6F6E6500000009746F704F75747365746C6F6E67000000000000
            000A6C6566744F75747365746C6F6E67000000000000000C626F74746F6D4F75
            747365746C6F6E67000000000000000B72696768744F75747365746C6F6E6700
            000000003842494D042800000000000C000000023FF00000000000003842494D
            0414000000000004000000083842494D040C0000000007610000000100000054
            000000A0000000FC00009D800000074500180001FFD8FFE000104A4649460001
            0200004800480000FFED000C41646F62655F434D0001FFEE000E41646F626500
            648000000001FFDB0084000C08080809080C09090C110B0A0B11150F0C0C0F15
            18131315131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E0E14140E0E0E0E
            14110C0C0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C0CFFC000110800A0005403012200021101031101FF
            DD00040006FFC4013F0000010501010101010100000000000000030001020405
            060708090A0B0100010501010101010100000000000000010002030405060708
            090A0B1000010401030204020507060805030C33010002110304211231054151
            611322718132061491A1B14223241552C16233347282D14307259253F0E1F163
            733516A2B283264493546445C2A3743617D255E265F2B384C3D375E3F3462794
            A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F637475767778797
            A7B7C7D7E7F71100020201020404030405060707060535010002110321311204
            4151617122130532819114A1B14223C152D1F0332462E1728292435315637334
            F1250616A2B283072635C2D2449354A317644555367465E2F2B384C3D375E3F3
            4694A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F62737475767
            778797A7B7C7FFDA000C03010002110311003F00EC0FD23F129939FA47E2532B
            6D45249249294924924A5249249294924924A524924929FFD0EC0FD23F129939
            FA47E2532B6D45249249294924924A5249249294924924A524924929FFD1EC0F
            D23F129939FA47E2532B6D45249E1386A4A629D4F6A5B50B4D23494CB53108DA
            298A492B56E11AF145A7F9C065EDEC1A7FF228190157D5201375D1AA92492287
            FFD2EC0FD23F1290091FA47E254DA15A6A280530D4ED6A206A692BC061B52DAA
            EE3D753036C7997BBE88F01C6F52CBC7ADA3D46692608EC67BA671EB4BF834B7
            3CB544B51CB541CD4E05690B6235BEB89692402E07480478FE77F555CBED35D0
            F7801DC0DAE983B8ED8D157C6105CEF804F9AEFD0B5BFBCE9F9347FE66987D59
            005E3D38C968F924924A7607FFD3EC7F38FC4A23428773F13F9515AAC96B048D
            63B6EF8F6CC4F9A235AA2D2636CFB6663B4A3304F0A391ADD9005377379F734F
            71C8F8FEF31AA44BDCDDA746032077526C112148851D8DC327440E6A13823BCB
            5B1B881B8C367B9E6021BC42782B08635E810B30CB98DFDD6CFCDC777FD4ED45
            682600E4E8102F76EB5EE1C4C0F80F6B52C7AC89564D22020EE927EE929981FF
            D4ECBB9F89FCA8AD41EE7E2511A5592D609D88EC246AD89F3E10ABA6D73439AD
            9078F153AC39E76B449514C02083A8EAC812540B41DC65C4C944250C8730C393
            1B1A3427551C60231111B05E1C0EA5D5187AA5D8578735AD73595D8DEC21AE73
            5D59FDEB3DDEA56AFE0DCEB718D867D373CB69DDA9D8D11BBFB6F44EA4CE9965
            6C77507575898AAC7BB6BA47D26D647BDCDD7F49F988840F686C0AC347A7B60B
            4B23DAE616FB762688912249BBDBEADAC99E12C30C71818CA35C57F2FA7F4A3F
            D6C8C9A7682FFDD048F8FD16FF00D22AABBC11ADB1801A5A65ED33681F9A63D8
            C77F2BDDBF6A038AB18C50F368E43AF931EE926EE929189FFFD5EC0FD23F12AD
            62D05F163D8E755DB6899F94EED9FD5555DC9F89456752CA6B4825AF2D880E68
            1EDFA3F99B14F92440D3AB06388275E8E9D4FAC388639D206AD76ED00FDD6D9E
            E40B9CEAAE2E61DBEA091F3FA63FCE4D4F521658DA9D5EDDE3730876874FA304
            7EF7B118B8167BDA1C4FD1900850834CC45B56EC87EC049977D169FE28350363
            DAC06371E7C072E77F65AACE5D349A8B9AD0C7B0493C478B555160A8068D6DBC
            1DA3C2B07DF61FF8C77E8D9FF5C47720046C092E3F54E9FD47A8750764D168C5
            A83456C6B86F3B19F47E9FD0FDEF4D8AEF4BC2CEC166D7F51B6E66A5B48654DA
            C38EA5CD3E99B9BFD5AACA914EEDCEEFA9446121BAF8A7888B58646B7605B7B7
            46DA23531B40E753C26DD67E741F30A64A895280C44AD292492287FFD6EBDFC9
            F8940AAE6FAC5B21C2092D9E5A7DAF561DC9F89556CE9F865DEA0A8B6C1C3AB2
            5875FE535599C4C8535A1211369A0B418D1F4BB735C3C0F7F6FF002B6FF9EB62
            BB05AD6DCD3ABF503C23E96E9FA3B172CDA7AF0C82E6E5D4CA00DA2AB6BF58ED
            8DBB77B0D0FF00FC155DB2ABF2B09D8375A1B8EF3FACBAADCC7BEB23DF8AC3B9
            DE8B721DFCEBF7FF0035EA28380DD33F18AB65566BBAAE43AF67FC95418C700C
            1CAB468EC973FF00C1E033E8E3BBFED47F3F57A9FA25600DAE73DCEDF6D9ABDE
            D1A69A358C6FE6555B7F9B62800D6B5B5D6D6D75B006B2B6086B40D035AD09D4
            D1C75E6C32C97E4CBDA3C53174A8A49C000B492574C9248A14924924A7FFD7EC
            0FD23F1299D31EDE7B273F48FC4A656DA88C547B9FB910081038E52490000492
            4A92492450A4924925292492494A49249253FFD0EC0FD23F129939E4FC4A656D
            A8A4924925292492494A4924925292492494A49249253FFFD9003842494D0421
            00000000005500000001010000000F00410064006F0062006500200050006800
            6F0074006F00730068006F00700000001300410064006F006200650020005000
            68006F0074006F00730068006F0070002000430053003400000001003842494D
            04060000000000070008000000010100FFE1112D687474703A2F2F6E732E6164
            6F62652E636F6D2F7861702F312E302F003C3F787061636B657420626567696E
            3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B
            633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F6265
            3A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F
            726520342E322E322D633036332035332E3335323632342C20323030382F3037
            2F33302D31383A31323A31382020202020202020223E203C7264663A52444620
            786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939
            392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465
            736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D70
            3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220
            786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D
            2F7861702F312E302F6D6D2F2220786D6C6E733A73744576743D22687474703A
            2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F526573
            6F757263654576656E74232220786D6C6E733A64633D22687474703A2F2F7075
            726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A70
            686F746F73686F703D22687474703A2F2F6E732E61646F62652E636F6D2F7068
            6F746F73686F702F312E302F2220786D6C6E733A746966663D22687474703A2F
            2F6E732E61646F62652E636F6D2F746966662F312E302F2220786D6C6E733A65
            7869663D22687474703A2F2F6E732E61646F62652E636F6D2F657869662F312E
            302F2220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F
            73686F70204353342057696E646F77732220786D703A4D657461646174614461
            74653D22323031332D30372D30325431363A35363A34362B30383A3030222078
            6D703A4D6F64696679446174653D22323031332D30372D30325431363A35363A
            34362B30383A30302220786D703A437265617465446174653D22323031332D30
            372D30325431363A35363A34362B30383A30302220786D704D4D3A496E737461
            6E636549443D22786D702E6969643A4335323542443835463045324532313139
            4145443938453737303737454132392220786D704D4D3A446F63756D656E7449
            443D22786D702E6469643A433432354244383546304532453231313941454439
            38453737303737454132392220786D704D4D3A4F726967696E616C446F63756D
            656E7449443D22786D702E6469643A4334323542443835463045324532313139
            414544393845373730373745413239222064633A666F726D61743D22696D6167
            652F6A706567222070686F746F73686F703A436F6C6F724D6F64653D22332220
            70686F746F73686F703A49434350726F66696C653D2273524742204945433631
            3936362D322E312220746966663A4F7269656E746174696F6E3D223122207469
            66663A585265736F6C7574696F6E3D223732303030302F313030303022207469
            66663A595265736F6C7574696F6E3D223732303030302F313030303022207469
            66663A5265736F6C7574696F6E556E69743D22322220746966663A4E61746976
            654469676573743D223235362C3235372C3235382C3235392C3236322C323734
            2C3237372C3238342C3533302C3533312C3238322C3238332C3239362C333031
            2C3331382C3331392C3532392C3533322C3330362C3237302C3237312C323732
            2C3330352C3331352C33333433323B4135443933373737383737454142363041
            3435453946413845454236433037332220657869663A506978656C5844696D65
            6E73696F6E3D223137382220657869663A506978656C5944696D656E73696F6E
            3D223334302220657869663A436F6C6F7253706163653D22312220657869663A
            4E61746976654469676573743D2233363836342C34303936302C34303936312C
            33373132312C33373132322C34303936322C34303936332C33373531302C3430
            3936342C33363836372C33363836382C33333433342C33333433372C33343835
            302C33343835322C33343835352C33343835362C33373337372C33373337382C
            33373337392C33373338302C33373338312C33373338322C33373338332C3337
            3338342C33373338352C33373338362C33373339362C34313438332C34313438
            342C34313438362C34313438372C34313438382C34313439322C34313439332C
            34313439352C34313732382C34313732392C34313733302C34313938352C3431
            3938362C34313938372C34313938382C34313938392C34313939302C34313939
            312C34313939322C34313939332C34313939342C34313939352C34313939362C
            34323031362C302C322C342C352C362C372C382C392C31302C31312C31322C31
            332C31342C31352C31362C31372C31382C32302C32322C32332C32342C32352C
            32362C32372C32382C33303B4145383035353131324446323538363041463141
            444146393432353931313536223E203C786D704D4D3A486973746F72793E203C
            7264663A5365713E203C7264663A6C692073744576743A616374696F6E3D2263
            726561746564222073744576743A696E7374616E636549443D22786D702E6969
            643A433432354244383546304532453231313941454439384537373037374541
            3239222073744576743A7768656E3D22323031332D30372D30325431363A3536
            3A34362B30383A3030222073744576743A736F6674776172654167656E743D22
            41646F62652050686F746F73686F70204353342057696E646F7773222F3E203C
            7264663A6C692073744576743A616374696F6E3D227361766564222073744576
            743A696E7374616E636549443D22786D702E6969643A43353235424438354630
            45324532313139414544393845373730373745413239222073744576743A7768
            656E3D22323031332D30372D30325431363A35363A34362B30383A3030222073
            744576743A736F6674776172654167656E743D2241646F62652050686F746F73
            686F70204353342057696E646F7773222073744576743A6368616E6765643D22
            2F222F3E203C2F7264663A5365713E203C2F786D704D4D3A486973746F72793E
            203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C
            2F783A786D706D6574613E202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020202020202020202020202020202020202020202020
            2020202020202020202020203C3F787061636B657420656E643D2277223F3EFF
            E20C584943435F50524F46494C4500010100000C484C696E6F021000006D6E74
            725247422058595A2007CE00020009000600310000616373704D534654000000
            0049454320735247420000000000000000000000000000F6D6000100000000D3
            2D48502020000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000116370727400000150000000
            3364657363000001840000006C77747074000001F000000014626B7074000002
            04000000147258595A00000218000000146758595A0000022C00000014625859
            5A0000024000000014646D6E640000025400000070646D6464000002C4000000
            88767565640000034C0000008676696577000003D4000000246C756D69000003
            F8000000146D6561730000040C0000002474656368000004300000000C725452
            430000043C0000080C675452430000043C0000080C625452430000043C000008
            0C7465787400000000436F70797269676874202863292031393938204865776C
            6574742D5061636B61726420436F6D70616E7900006465736300000000000000
            12735247422049454336313936362D322E310000000000000000000000127352
            47422049454336313936362D322E310000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0058595A20000000000000F35100010000000116CC58595A2000000000000000
            00000000000000000058595A200000000000006FA2000038F50000039058595A
            2000000000000062990000B785000018DA58595A2000000000000024A000000F
            840000B6CF64657363000000000000001649454320687474703A2F2F7777772E
            6965632E636800000000000000000000001649454320687474703A2F2F777777
            2E6965632E636800000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000006465736300000000000000
            2E4945432036313936362D322E312044656661756C742052474220636F6C6F75
            72207370616365202D207352474200000000000000000000002E494543203631
            3936362D322E312044656661756C742052474220636F6C6F7572207370616365
            202D207352474200000000000000000000000000000000000000000000646573
            63000000000000002C5265666572656E63652056696577696E6720436F6E6469
            74696F6E20696E2049454336313936362D322E3100000000000000000000002C
            5265666572656E63652056696577696E6720436F6E646974696F6E20696E2049
            454336313936362D322E31000000000000000000000000000000000000000000
            000000000076696577000000000013A4FE00145F2E0010CF140003EDCC000413
            0B00035C9E0000000158595A2000000000004C09560050000000571FE76D6561
            730000000000000001000000000000000000000000000000000000028F000000
            0273696720000000004352542063757276000000000000040000000005000A00
            0F00140019001E00230028002D00320037003B00400045004A004F0054005900
            5E00630068006D00720077007C00810086008B00900095009A009F00A400A900
            AE00B200B700BC00C100C600CB00D000D500DB00E000E500EB00F000F600FB01
            010107010D01130119011F0125012B01320138013E0145014C01520159016001
            67016E0175017C0183018B0192019A01A101A901B101B901C101C901D101D901
            E101E901F201FA0203020C0214021D0226022F02380241024B0254025D026702
            71027A0284028E029802A202AC02B602C102CB02D502E002EB02F50300030B03
            160321032D03380343034F035A03660372037E038A039603A203AE03BA03C703
            D303E003EC03F9040604130420042D043B0448045504630471047E048C049A04
            A804B604C404D304E104F004FE050D051C052B053A0549055805670577058605
            9605A605B505C505D505E505F6060606160627063706480659066A067B068C06
            9D06AF06C006D106E306F507070719072B073D074F076107740786079907AC07
            BF07D207E507F8080B081F08320846085A086E0882089608AA08BE08D208E708
            FB09100925093A094F09640979098F09A409BA09CF09E509FB0A110A270A3D0A
            540A6A0A810A980AAE0AC50ADC0AF30B0B0B220B390B510B690B800B980BB00B
            C80BE10BF90C120C2A0C430C5C0C750C8E0CA70CC00CD90CF30D0D0D260D400D
            5A0D740D8E0DA90DC30DDE0DF80E130E2E0E490E640E7F0E9B0EB60ED20EEE0F
            090F250F410F5E0F7A0F960FB30FCF0FEC1009102610431061107E109B10B910
            D710F511131131114F116D118C11AA11C911E81207122612451264128412A312
            C312E31303132313431363138313A413C513E5140614271449146A148B14AD14
            CE14F01512153415561578159B15BD15E0160316261649166C168F16B216D616
            FA171D17411765178917AE17D217F7181B18401865188A18AF18D518FA192019
            45196B199119B719DD1A041A2A1A511A771A9E1AC51AEC1B141B3B1B631B8A1B
            B21BDA1C021C2A1C521C7B1CA31CCC1CF51D1E1D471D701D991DC31DEC1E161E
            401E6A1E941EBE1EE91F131F3E1F691F941FBF1FEA20152041206C209820C420
            F0211C2148217521A121CE21FB22272255228222AF22DD230A23382366239423
            C223F0241F244D247C24AB24DA250925382568259725C725F726272657268726
            B726E827182749277A27AB27DC280D283F287128A228D429062938296B299D29
            D02A022A352A682A9B2ACF2B022B362B692B9D2BD12C052C392C6E2CA22CD72D
            0C2D412D762DAB2DE12E162E4C2E822EB72EEE2F242F5A2F912FC72FFE303530
            6C30A430DB3112314A318231BA31F2322A3263329B32D4330D3346337F33B833
            F1342B3465349E34D83513354D358735C235FD3637367236AE36E93724376037
            9C37D738143850388C38C839053942397F39BC39F93A363A743AB23AEF3B2D3B
            6B3BAA3BE83C273C653CA43CE33D223D613DA13DE03E203E603EA03EE03F213F
            613FA23FE24023406440A640E74129416A41AC41EE4230427242B542F7433A43
            7D43C044034447448A44CE45124555459A45DE4622466746AB46F04735477B47
            C04805484B489148D7491D496349A949F04A374A7D4AC44B0C4B534B9A4BE24C
            2A4C724CBA4D024D4A4D934DDC4E254E6E4EB74F004F494F934FDD5027507150
            BB51065150519B51E65231527C52C75313535F53AA53F65442548F54DB552855
            7555C2560F565C56A956F75744579257E0582F587D58CB591A596959B85A075A
            565AA65AF55B455B955BE55C355C865CD65D275D785DC95E1A5E6C5EBD5F0F5F
            615FB36005605760AA60FC614F61A261F56249629C62F06343639763EB644064
            9464E9653D659265E7663D669266E8673D679367E9683F689668EC6943699A69
            F16A486A9F6AF76B4F6BA76BFF6C576CAF6D086D606DB96E126E6B6EC46F1E6F
            786FD1702B708670E0713A719571F0724B72A67301735D73B87414747074CC75
            28758575E1763E769B76F8775677B37811786E78CC792A798979E77A467AA57B
            047B637BC27C217C817CE17D417DA17E017E627EC27F237F847FE5804780A881
            0A816B81CD8230829282F4835783BA841D848084E3854785AB860E867286D787
            3B879F8804886988CE8933899989FE8A648ACA8B308B968BFC8C638CCA8D318D
            988DFF8E668ECE8F368F9E9006906E90D6913F91A89211927A92E3934D93B694
            20948A94F4955F95C99634969F970A977597E0984C98B89924999099FC9A689A
            D59B429BAF9C1C9C899CF79D649DD29E409EAE9F1D9F8B9FFAA069A0D8A147A1
            B6A226A296A306A376A3E6A456A4C7A538A5A9A61AA68BA6FDA76EA7E0A852A8
            C4A937A9A9AA1CAA8FAB02AB75ABE9AC5CACD0AD44ADB8AE2DAEA1AF16AF8BB0
            00B075B0EAB160B1D6B24BB2C2B338B3AEB425B49CB513B58AB601B679B6F0B7
            68B7E0B859B8D1B94AB9C2BA3BBAB5BB2EBBA7BC21BC9BBD15BD8FBE0ABE84BE
            FFBF7ABFF5C070C0ECC167C1E3C25FC2DBC358C3D4C451C4CEC54BC5C8C646C6
            C3C741C7BFC83DC8BCC93AC9B9CA38CAB7CB36CBB6CC35CCB5CD35CDB5CE36CE
            B6CF37CFB8D039D0BAD13CD1BED23FD2C1D344D3C6D449D4CBD54ED5D1D655D6
            D8D75CD7E0D864D8E8D96CD9F1DA76DAFBDB80DC05DC8ADD10DD96DE1CDEA2DF
            29DFAFE036E0BDE144E1CCE253E2DBE363E3EBE473E4FCE584E60DE696E71FE7
            A9E832E8BCE946E9D0EA5BEAE5EB70EBFBEC86ED11ED9CEE28EEB4EF40EFCCF0
            58F0E5F172F1FFF28CF319F3A7F434F4C2F550F5DEF66DF6FBF78AF819F8A8F9
            38F9C7FA57FAE7FB77FC07FC98FD29FDBAFE4BFEDCFF6DFFFFFFEE000E41646F
            626500644000000001FFDB008400010101010101010101010101010101010101
            0101010101010101010101010101010101010101010101010102020202020202
            0202020203030303030303030303010101010101010101010102020102020303
            0303030303030303030303030303030303030303030303030303030303030303
            030303030303030303030303030303FFC0001108015400B20301110002110103
            1101FFDD00040017FFC401A20000000602030100000000000000000000070806
            050409030A0201000B0100000603010101000000000000000000060504030702
            080109000A0B1000020103040103030203030302060975010203041105120621
            071322000831144132231509514216612433175271811862912543A1B1F02634
            720A19C1D13527E1533682F192A24454734546374763285556571AB2C2D2E2F2
            648374938465A3B3C3D3E3293866F3752A393A48494A58595A6768696A767778
            797A85868788898A9495969798999AA4A5A6A7A8A9AAB4B5B6B7B8B9BAC4C5C6
            C7C8C9CAD4D5D6D7D8D9DAE4E5E6E7E8E9EAF4F5F6F7F8F9FA11000201030204
            0403050404040606056D01020311042112053106002213415107326114710842
            8123911552A162163309B124C1D14372F017E18234259253186344F1A2B22635
            1954364564270A7383934674C2D2E2F255657556378485A3B3C3D3E3F3291A94
            A4B4C4D4E4F495A5B5C5D5E5F52847576638768696A6B6C6D6E6F667778797A7
            B7C7D7E7F7485868788898A8B8C8D8E8F839495969798999A9B9C9D9E9F92A3A
            4A5A6A7A8A9AAABACADAEAFAFFDA000C03010002110311003F00D92331FF0017
            6CA7FDAC6B7FF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BB
            DBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBA
            F75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7B
            DFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD0D9
            2331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39
            FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7E
            EBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75
            EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFB
            AF75FFD1D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E
            3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BD
            FBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBD
            D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7
            EEBDD7BDFBAF75FFD2D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A4
            1FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75E
            F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBA
            F75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7B
            DFBAF75EF7EEBDD7BDFBAF75FFD3D92331FF00176CA7FDAC6BBFF7265F790F07
            F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD
            7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7E
            EBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75
            EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD4D92331FF00176CA7FDAC6BBFF7
            265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF
            75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BD
            FBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBD
            D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD5D92331FF00176CA7
            FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD
            33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75E
            F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBA
            F75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD6D92331
            FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF00
            09E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD
            7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7E
            EBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75
            FFD7D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB7
            9FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF
            75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BD
            FBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBD
            D7BDFBAF75FFD0D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0
            EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EE
            BDD7BDFBAF75EF7EEBDD7BDFBAF75EF7AEB7D7BDFBAF50FA75EB7BF75EA1F4EB
            DEFDD7A87D3AF7BDF5AEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF
            7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAFFFD1D92331FF00176CA7FDAC6BBFF7
            265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF
            75EF7EEBDD7BDFBAF75EF7EEBDD7AD7F7AEB74AF5CC213FEFBFDF1F7A2C3AB05
            EB208BFD7FF61FEF8FBA97EAC17E5D6410FF0087FBEFF6FEEBA8F5BD3D72F0FF
            0080FF006DFF001AF7ED47D7AB69EBDE1FF01FEDBFE35EFD53EBD7B4F5D187FC
            07FB0E3FE29EFDA8F5AD3D70317F81FF0088F7BD5D68AF58CC67FDF7FBEB7BB0
            6EAA57AC6548F76A83D5687AEBDEFAAF5EF7EEBDD7BDFBAF75EF7EEBDD7BDFBA
            F75EF7EEBDD7BDFBAF75FFD2D92331FF00176CA7FDAC6BBFF7265F790F07F610
            FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDE
            BADD2BD645427EBEEA5BAB05EA4245FE16FF007BF742D5E9C0BD48587FC3FDBF
            FC53DD0B0E9C0BD48587FC3FE207BA17EAE13AC820FF0001EEA64EAC13AE7E0F
            F0FF00937DD7C4F9F5BD1F2EBBF01FE9FF0026FBF789F3EB7E1FCBAE260FF0FF
            0078B7BD893AD68EB1983FC3FDB7FBEBFBB093AA94EB0343FE1FF107DDC30EA8
            53A8ED17FC88FBB83D3657A8ED1FFB0F770DD50AF584823DDC1AF54229D75EF7
            D57A11BAD361D46F9CF474F22BC586A2649F2D562EA0457BA5244E2DFE535562
            05BF4A82DF8E4879837A8F67B32E08376F845F9FF11F90FE671D08397B649379
            BD08411689976F97F08F99FE42A7A9BDB7B220D95B9BC38E88C585C9D3256E31
            3C92CFF6E033415148D3CCF24923C5346581662743ADFDD396F766DDB6E59666
            ADD21D2FC054F10683D4756E66DA1768DC5A285696AE35271341C08A9CE08FD9
            4E82CF621E83BD7BDFBAF75FFFD3D92331FF00176CA7FDAC6BBFF7265F790F07
            F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75D804FBD1
            34EB6057A9091FFBEFC0F6D96E9D0BD4B48BFE47FF0014F6D96A74E85EA6243F
            E1FF0015F6D33F4EAA752D20FF000FF89F6D173D3A13A92B4FFE1FF13FF1AF6D
            97F9F4E04EB3AD3FF87FBEFF0061EEA5C75711F59053FF0087FBC1F75F17E7D6
            FC3F975DFDBFF87FBC7BF78BF3EB7E1FCBAE069FFC3FDEFF00E37EF6241D57C3
            EB0B53FF0087FBEFF5C7BB071D54A7519E0FF0FF007DFF0011EDC0DF3E9B29D4
            5787FC3DB8AFD3653A88F17F87FB0FF8A7B78357A64A750DE2FF006DFEF23DB8
            0D3A68AF52B0F84AFCEE4E93158E88CD5557288D383A235FAC934ADF448A24BB
            313C003DB3777B058DB4B7570F489057EDF403D49F2E9EB3B19EFEEA2B4B64AC
            AE69F67A93E80713D1F7D97B7283686169B118F0A4A8F255D49004B5958C0096
            A246163CDACA3E8AA00FC7B84375DCE7DD6F24BA9CF1C28F255F203FCBEA73D4
            EBB4ED906D3651DA4038658F9B37993FE4F418E98BB736A8DD9B3EB1E9D11B27
            8559B2D44C5499658E9A067ACA38F4DCB3D4D3C7E851F5751F93ECDB95374FDD
            FB9A47237F8BCD453E8093DA7F6F1F9744FCDDB57EF1DADE58D7FC621AB8F520
            0EE1FB387CFA21DF4E0F047B993A85BAF7BDF5AEBFFFD4D92331FF00176CA7FD
            AC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33
            D7605CFBD134EB6057A931C7FF001B3FF103DB4CD5E9D03A9F1C5FE1FEFBFA9F
            6DB353A7957A9F1C3F4E3FDF7F87B4ECFD3EA9D4F8E0FF000FF7DFE3ED967A74
            FAA7CBA9D1D3FF0087FBC7FC47B65A4E9E54EA5A537F87FBEFF7AF6D17F9F4F0
            8FA92B4DFE1FEFBFD87B6CB8EAE23FDBD6514DFE1FEF5FEF7EF5E20EAC23FDBD
            77F6DFE1FEF47DEBC41D6FC3F53D6334DFE1FEFBFD85FDD8483AA98FF67581E9
            BFC3FDF7FB0E7DDC3FCFAA18FA89253FF87FBEFF005FDB81FA69A3EA14907D78
            FF007DFF0013EDE57AF4CB27506487FC3DBCADD32C9D4134EEECA88ACEEEC111
            5412CCEC40550A2E4B126C3DBC240012C68074C98CB30551563E5D1A2EB6D98B
            B5A88D6D7C41733918D1E50C06AA5A56B3A5327D482C7973F9616FC7B8A399B7
            C3BA5C781031FA28CE3FA47F8BFC83E59F3EA5AE58D886D56DE3CEA3EBA419FE
            8AF92FF94FCF1E5D0BF0C82DF5E7FAFF004B71FD3FA7B0BF42AE9A3776F7C56C
            5C32E7B354F969F1C2B20A4D788C64D95996AA6D4F4C9241002C892188FA8FA7
            837E39F6A2DAD6E6EE5115AC2CF2F1A2F1C79F49EEAEADACE2335DCCA90F0AB7
            0CF97443F70D661B2399C86430095B0E26BAA24ABA5A7C8528A2ABA513B191E9
            A5804922AF85D88041B15B7B9CF697BA7DBEDBEB612972168C0FCB15FCFA81B7
            74B48F71B9163307B52D5523850E69F974CBECCBA2CEBFFFD5D92331FF00176C
            A7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDB
            BD34057A931A7FBEFE83DB6C7A75474E1147F4FF007DFEC7DB2CD4E9F55E9CA2
            8AF6E3FDF7FC53DA766AF4FAAF4E7143F4E3FDF7FC40F69DDE9D2944F974E515
            3FD38FF7DFF11ED3B3FAF4A153E5D38C74FF004E3DB0D274A163EA7474DF4E3D
            B25FE7D3CB1F52D697FC3DB6641D3A23EA68C654FDBFDD7DB4DF6DAB47DC789F
            C1AF9B2F902E80C4836E79B1FE87DB3F511EB31EB1E252B4F3E9DFA77D024287
            45695A62BF6F587EDBFC3FDEFDDBC51D57C203AC4D4BFE1FEFBFDE3DD8483AA9
            8FCE9D477A6FF0F6E07F43D3663EA1494FF5E3DBCB274CB47D37CB4FF5E3FDF7
            FC47B7D5FA6193A6D960FAF1EDF47E93B27CBA68ABA5F345343E49E112C72446
            5A5A89E92A62122142F4F574B245534D32837492365746B1520807DB92471CF1
            490C8B58D81047A83D371BC96F2C73C4D4950820FA11F6F43A74A6D5C76D1DA9
            3A6392B436772F5199AF9F2395C9E62B6AAA4C3050C52C95B97AAADABD029E95
            42A07D0B724017B7B8A39862B4B7DC9EDECE209122818AF1E26B52739EA5AE5C
            9AEEE36D4B9BD94BCAEC4D4D387014000A70AF437452116E78FF005CDEDFD7FC
            3EBEC8FA3EE826EFAC9343B33058C5703F8A6E0A8AD917D5ADA1C4D1FDB43720
            DBC667AF90D8DC12AA7EA3D8FB90E0D5757B7247C28147E66A7FC1D47DCFF71A
            6D2C6D81F8A42C7F2141FE1FF074523DC9FD459D7BDFBAF75FFFD6D92331FF00
            176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009EA
            1C6B7E7FDF5FFE35EEEC7AAA8E9C228FFE37FF0014F6CB1A74FA8E9CE18AFED3
            3B74A517874ED0C5F4FF007DFEF87B4CEF4E94A270E9DE183E9C7FBEFF008AFB
            4ACDD2A44E9D6183E9C7B4CEF5E952274E9153FF0087B4ED253A52B1F4E31D37
            F87FBEFF007BF69D9CFAF4FAC7D0A9B1FAE67DC2E95F901252E1D1C1BD8A4D5D
            A4F31C07EAB11FA349FEB81CFD09372DD92D418A2EEB83FB17EDFF003747BB6E
            CED7444B3556DFF99FB3E5F3E8D063F05889E8ABF0EF8FA57C4C31D2E345218D
            3C60A426A6A22D206ABC52D4870D7B932137BFB088B89C4DF50253E356B5F3E8
            606DE030FD39887834A53CBA2F9BEBA9AAB03E6C9E1165AEC3825E486C64ABA0
            53737700169E9D3F2E3951CB717205361BCADC5229C859BF91FF0031E829B86C
            AD6FAA582AD07F31FE71F3E81E6A5FF0FF007DFEF3ECE8483A2431FCBA892537
            F87FBEFF007AF6E2BFA1E9B68FA812D3FD78F6FAC9E47A61A3E9B26A7FAF1ED4
            2BFA7499D3A6A9A0FAF1ED4A3D7A4CE9D354B01660A072C428B0BDC93602DF9B
            FB50B269049381D2668C920019AF4657090AD0E3A86913814F4B0C76E6DA9631
            ACF249177B9FF0F70E5F4E6E6F2EA7272EE4FF003C7F2EA67B0805B595ADB818
            48C0FE59FE7D28E19585B9000B127FA7D39249E3DA5E95F45F3BF6B44BB83058
            A4B95C56DCA39242C0A935395926C8B817246914D2C5F80435C1FA7B9639261F
            0B6A798F192427F218FF000D7A88F9E27F1776484708E303F36CFF00829D005E
            C69D0208A75EF7BEB5D7FFD7D9272E2F97CA7FDAC6B7FF007265F790F07F610F
            FA41FE0EB1CA715B89BFD39FF09EB1449F4FF0FF007BF7A27ADA8E9D214FA7FB
            EE7FE35ED3BB74A117A77823FA71FEFBFE37ED33B5074AD17A79A78BE9FEFBFD
            F5BDA476F3E95A2F0E9EA086F6F691DEB5E95A274F3041F4E3DA4793D3A5689D
            3BC34FF4E3DA677A74AD23E9EE831EF55534F4D1A1679E68A1450396691C2003
            FC493ED24B369467270057A551425D9100C934E8CDEE0DD349B4E9A8B0D434C7
            33B8A5A15FE1D8486458238E085638132B9EADB34784C1A4CEBAE560F5132871
            4B0D4488C8002EC5DD9CF126BD4828A1115070000E9EF65EE13251C74396AE82
            B32B779AB6AE0A3FB08A79DC80D253518791851C68AA884932E951AC5C81EEBD
            5BA110E92A4FA5D0A161621D1D74922C45D595BDFBAF7443B40A9515219E4153
            79D6493F5B2CE4CA19AE17D443FB1AC127E8C55E3A47F83A03DC463C698A8EDD
            47FC3D45929BEBC7B54AFE87A4AD1F4DB353FF0087B50927AF49DE3E9A66A7FA
            F1ED4A3D3ECE92BA74CF3C1F5E3DAB47F3E92BA75831B462A3294519175FB847
            6E2E34C67C8DC7E410BEDADCAE7E9F6EBB96B90840FB4E07F87A776CB6FA8DC6
            D22A635827EC19FF00274384127D3F03FA7FB6E2C40FEBEE29EA59E9EA891AAA
            782956DAAA258E1E79E247556E2C7837F7EEBDD155ED1C89CBEFADCD561C3C71
            E4E7A28194597C18F228A30BCB0202C1C1FCFD7F3EE71D92016DB558C54A1118
            27ED39FF002F5056FB3FD56EB7D35706423F2181FE0E8359058DFF00DF7F8FB3
            9538E88D8758FDDFAA75FFD0D933282F97CA1FFAB8D77FEE4CBEF21623FA10FF
            00A41FE0EB1D261FAF37FA73FE13D770AFD3FDF73EF4C71D59074ED027D3FDF7
            FAFED231E9520E9EA9E3FA7FBEFF007D61ED248DD2C45E9F69E2FA7FB0F68E46
            E96C6BD3E53C3F4E3DA391A9D2C8D7A7DA787E9ED1BBD3EDE96A274F5041F4E3
            FDF7FC57DA477F5E962270E9CBEE729884193C2D252D6E4E89E2A8A4A7AD0E60
            7649535BF8D25A7334D0C3A9E28CCB12CB2AAA3488AC5C17DDEB96196343DC45
            3A30B4D114F148E3B41AF4AADB35B89C8D054643135B5791A8AA9D1370D765B4
            AEE597331C626960DD14EB153FF0EC8C22A75A524714349145287A6430C89248
            127468D8ABAD18742F4759143A3554F4A14778D95E3664743A95D0956523F208
            E41F75EADD2A47648C2E36A60AD791F233D254C58986963F354D5D798245A768
            6994810B432B2BCD23158446ACC6C401EEE88D23055153D51DD6352CC683A08B
            ED02222050A1555428FA285160A3FC05BD8A164C0E82AD1D493D43969FEBC7B7
            D5FD3A61A3E9AE783EBC7B528F5E933A74CD3C1F5E3DAB47F23D24913A63A887
            EBC7B571BD3A45227523014E0573CC4711444027F0D21038FF001D20FB26E649
            F4D9C5083F1BFF0021FECD3A3BE59B7D57B2CC46113F99FF0062BD0830B723FD
            E7EB7E2FF9FF001F607E875D2871354B4734D9261A970D4190CBB01603550D2C
            9253162CC00B559423F1702FC7B536709B8BBB6807E2703F9E7A4B7B30B6B4B9
            9CFE1427F963A25B56CD2CB2CADFAA591E53FEBBB166FF00793EE768A8AAAA38
            014EA05932CC4F127A67957EBFEDFF00DF7FB0F6A54E7A4AC3A8B6FF008A7B73
            A6A9D7FFD1D94724B7CB64FF00C7235BFF00B932FBC8388FE8C3FE907F80758E
            D2FF006F37FA63FE1EB9C2BF4FF6FF00EFBFD8FBA487A71074F34E9F4FF7DFE2
            7DA4738E95A0E9F6993E9FEFBFC4FB46E78F4B631C3A505243A9957817205CFD
            05C8173F5E05FD965DDCC76D0C93CA7B147467676D25CCD1C110EF634FF67F21
            9E84ACC6CAC9EDCA5C7D6D54B49554B9025619E8A49658D1FC6B34492B490C41
            5A788B325AF708DFD3D92DA6ED0DFBC888A55C0AD0F98F3FD98FDBD1E5DED135
            8223BB0642698F23E5FB7A854D17D3DBAEDD331AF4FB4F0FD38F68DDEBE7D2D4
            4E9E6183E9C7FBEFF8AFB48EFD2B44EA2D6EDD33CE72988AA385DC0B1C71C794
            862134755142CEF15066A8B5C4997C5B348C0C4ECB247A8B412432859150CE89
            28A38CFAF4BE0792135438F4EA751E53704F19A2A8C1AD1E5E294C53D69944FB
            7E4A7088E992A1915D2B6615018A7DAC8892C532B062D1049642CFA67D7427B7
            D7A33FAA4D1A80EEF4EA75261D291A69E5965ACAFAA62D5590AAB3544BC9290A
            69023A6A380711411858A31FA56E492BA20910A20E904A5E53573F9759E4A7FF
            000FF7DF9E7E9ED4AB83D2764E9BA683FC3DBCAF4E9874E9A2A21FAF1ED5A379
            F491D3A63A987EBC7FBEE7DAB8DABD239178F4C35317D7DAE8DAA3A4522F59F1
            69E3473F43231FF6200B58FE40BDFD84F9827F12ED230708BFCCE7FCDD0B797A
            0F0ECDE5A65DBF90C7F9FA51C07E9CFD7FA7FBEFC9F643D1FF0059370D67F0FD
            8BB9E759024B5FFC370300E3538AB9FEF2B6D71723ED28F4903F1213F8F622E5
            783C6DDA272B558C16FCF80FE67A0E7354FE0ED13206A34842FE5C4FF21D15A9
            D7EBFEFBFD7F72D21EA2171D34CCBFF14F6A81E1D2571C7A87A7FE86D3EDCAF4
            D75FFFD2D957243FDCB64FFED615BFFB9327FC57DE4145FD8C5FE947F83AC789
            47EBCDFE9CFF0087ACB00FA7FB0FF8DFB6A43D3883A7BA75FA7FBEFF007DC7B4
            921E96463A7EA65FA7FBEFF1F68A438E96C63A51D105578CBA9740CA5D03682E
            A08D4BAC025750E2F636F6557B0ADCDBCB03FC2C3F67A1FCBA36B19DAD6E22B8
            4E2A6BF6FA8FCC7428E6B7754EE0A3A3C78A38B1F434854A53C32C92ABE8411C
            418B8516892FA401FDAF64969B64560CF22C859C8A548A53A3DBCDD25BF54468
            C2A035C1AD7EDFB3A6FA68FE9FEFBFDE7FD7F6F48D8E998D7874FF004D1FD3DA
            191A9D2E8D7A7C822FA7FBEFF7D7F68DDA9D2D45E9DE186F6E3FDF7FC53DA566
            AF4A557A9E9071F4F6C97A74F84EB9183FC3FDB7FC6FDFBC4EB653A892C3F5E3
            FDF7F8FB715BD3A6993A6B9E2FAF1FEFBFE35ED423D7A4CEBD32D447F5FF007D
            FEFAE3DAB8DBA4922F4C3531FD7FE29FF11ED6C6D9E90C8BD27AA93EBED746D4
            FB3A4322D7038F5C29CE90A0716B7FAFFF0011FD7D812EE5F1EE6797F898FECF
            2E87D690882DA08BF8547EDF3E9DE073C5BFC3FDE0FF00C47B4FD28E9AFB32A5
            A976E6D6C42AAA1AF7C8EE0A8B13AD834DFC3A8F58FA69229652BFD01B8E0FB1
            DF274002DD5D1E24851FE13FE11D00B9CEE096B4B51C002C7F3C0FF2F400542F
            D78FEBFF001AF63E439EA3E71D344E3EBFEC3FE29ED5AF0E9230EA1D87FBCDFF
            00D8FB73A67AFFD3D95F23FF00176CA7FDAC2B3FF7265F79030FF6317FA51FE0
            1D63CCBFDBCDFE9DBFC27ACD07D47FAE7FDEBDB4FD3A83A7CA71F4FF007DF8F6
            8E5F3E96463A50530FA7FB6FF7AF68A5E9747E47A50D28FA7FBEFEBED04BD2F8
            C7023A51D2AFD3FDF7F4FF008A7B4329AF46110F31D28E957E96FF006DFEFBFD
            7F682539E97C43A50D328E3FDB7FBCDB8F68253C6BD2F8C70E9E8B2524B1C555
            FB2D2AABC6CFC2386FC07FA2B0FA106DEE39FF005C8E546DDA5D9E6DC443386D
            28F276C529F3D12574E0D47769AF956BD2D5A2901B07A7E810581FF63FF14F62
            E660402A6A0F4B1070E9CE38AFFF0015F69CB74A157AC8D171FD7FD87BD57D3A
            B15F9750264FAFFBEE3DBC8DD32EBD345427D7FDF7D3DAA439E9238E933F7747
            5826347554D5429EA2A292734F3473082AA965686A69A531B378EA29E6528E86
            CCAC08201F6AA2951EBA1C1A120D0F023883F31D33756B716FE1FD45BBA6B40C
            BA948AAB0AAB0AF1561904608C8E9A2A57EBFEF7FEF1ECC10F0E8AA41C7A4CD7
            108AC7E9F8FF006248F77BC9BC1B499EBDDA683ED38EA9670F8F790A53B7554F
            D833D4380FD3E9F8FC7FB7F60BE86DD3BD386919628F5792565892C031D72304
            5B0279376F7EEBDD23BB46AE29F74D551C1FF01F0B4F4783879E0FF0D8160998
            7A9ADAEA039FEBCF3CFB95397EDFE9F6DB607E261A8FE79FF07513F315C7D46E
            772C3E153A47E5D04B503FE23D8917CBA0D4838F4CD37E7FD63FF13ED5AF0E92
            3F50BFE2BEDCE9AA7F87AFFFD4D96323FF00176C9FFDAC6B3FF7265F790317F6
            317FA51FE0EB1E65FEDE6FF4EDFE13D6683EA3FD7FF88F6D3F4EA7974F94FF00
            8FF7DF8F68E4F3E96C5E5D2829BF1FEFBF23DA197CFA5B170E9454DF8FF61FEF
            47DA1978F4611F0E9494BF8FF7DF93ECBE5E3D2F8BA5152716FF0061FF0011ED
            0CBC7A308BA536327860ABA66AA0A29598A492B13682572AB4F249F814EAE4EB
            6FEC8B1FA5FDC69EE45D6ED69B04AFB6AFE831D3330F892322848F45AE1CF929
            AF0AF463052ABAB8753F7AE468A8E8929E75F25648E0C08801922506CF235EC3
            4102D63FD7DE1773CEE961676096D709AAF18D500F897D4FD9E5FE0E9EB89151
            003F157AF6D1CA3E428DC3249A69D95124706C45B98831E5CC5F4BFE47BC81F6
            2F9B774E65E5BB8B5BF82568AC9952399B83291FD9D4E58C54A6ACD55941E195
            367299148A6079F4BC888FF79F7359E1D1929EB2BB023FA7BAA823AB1E1D36CC
            458FFAC7FDE7DBC9C7A61FA2D1DC9D93594134DB1B6954C94D9F96922ABDC19D
            863121DAD879C5E34A04914C757BA33512BA5146352D3ADEA25E1634948F7DDE
            5ACD7E8ED0917656A5BF814FA7ABB674FA713E40CB7ED8FB7F0EF8E9CC5BE46A
            DB2C72158E227FDC89578EBA1AAC11920C84D359A46B5AB942418CEDDAEDA595
            A6FEE8D4434BB7A39A1C5CF8DCAD26531D90C5576B2AC998A9F156F9D6B6594B
            3CD34534C646D5A4EA6758DADB7FBAB0B9596C66D31D684306041FE971AD7D48
            27FC2330F74F6B767E66DA65B4E63B1326E1A0C88F1347224894C180550A9400
            5151D568284E02B1C5DB5DA34F98931189CE519C667F30D32525240E9571CE69
            E07A8A898185DFC54F146809724A8322293A8DBDCB7B1735477F2DBD95DC263B
            D7AD2990682A4FCBFC19038F5851CFFECF5C72EDAEEBBE6C77E2E797ADB49767
            1A1D35B0555C81AD893400004E9634A0AF4A7CB4A03C7103C93AC8FF000B691F
            EF27D8837996890C00F1C9FF00275116CB0D5E69C8E181FE5EB0C1736BFF00C4
            7D6DFEF7EC3FD087A5A6D73145958EB6703EDB0F4D579AAA041378F1D03CB0C4
            6D7E27AA089CDB826C6F6F6F5B426E2E218578B301D317330B7B79A76E0AA4FE
            C1D00593A996B2AAA6AE776927AAA89AA6691CDD9E59E47964763F9667624FB9
            8E1408A88A28A0003F2EA199DCBB48EC6AC4927F3E93551FF13ED7A7974824F3
            E99A6FA1FF0058FF00BD7B569D237E3D42FF008AFB73A6BFCFD7FFD5D95B227F
            DCB653FED615BFFB9327FC57DE40C5FD8C5FE947F83AC7994FEBCDFE9CFF0087
            ACD01E47FAFF00EF7EDA93A713A7CA73F4FF0061FEF56F69251C7A5919E9FE99
            BE9FEFBFDF7D3DA29474BA33FB3A5152B7D3FDF7FBEFAFB4128C74BE33C2BD28
            A95BE9FEFBFDF7D3DA0947A746119E1D28A99BE9FEF5FEF1ED0CA3CC74BE33C3
            A7F80ABA95701958156522EA43704107EA0FB2DBA8229E29219A30F0BA90CA45
            410450823CC11C7A5D19E986B36BE4EB32095299A359472BC4B3C1958CC9594B
            0287D5F6390A708D21248F45424A005E185C9F78C5CDFF00771DB37BDCE2DC36
            BDFA7B74665F11241E28080F7786D820D3806A81C4D7A75A1F1581D46BD09D8E
            8A0A2A7869A9D0470C2BA5147FB762C7EACCC4DC93C927DCE9B36C5B6F2EED56
            5B2ED16C22B0B74D2AA3F69627896624B331C92493D1945A5142A8C0E9E525FF
            001FF8A8F6B993A521FAC8D371F5FF006E7DD749EB65FA852CA3FDF7E7FE35ED
            F45E9A76EB5D3F90FF0020779EC8F929DBB9ADA134DB9B0BFE91E5C1D761BF88
            D3C73D1FF77F0787DB5967C550D50F3558C6667032F9A381908D577BC4CCAD00
            7336E775FD6EDD45BDD28542AA15AB43A545457C88353F3A533C3AEB0FB35C95
            B037B01C88FBC6C32C92DCACB2B4B11512209656F0DCA9A78885342D31A092E0
            A9A30197ADBE4375D6FC7A8DC192C7E576F6EBC5D14D06570B554AF14D99FDB5
            96248E211CB89DCDE068AC9594124CB18D464318528376FBB59C9278B70BA2E8
            21A8041D63EC18247E4471200E92EF1EDF731D95A7D16CF3FD46C2F70A164756
            8FE9D8D6A75351A3560722AD1B1A2A3C8C6BD0D1F19F375DD8DDAFB8F78D4433
            7D960F6D18A8EA6328D8B8BF8BD6B41418FC5CA1BCB514494D4D50E646502597
            53F218586DEDD24D7FCC177B84ABD91418A1C0D6D455FB080C6BE6413E7D40DF
            7A1936FE56F6BB64E56B192B35E6E60B6A521A410465A590F96A57689081F0A9
            54FC27A39B573F9EB656E0046F12D8DC10970587FC1EE3FC3DC897D378D73230
            3DA0D07E5D612D843E05AC6A4771C9FB4F5329EFE93CDCDB9E79FCFB47D2CE94
            55D53FC2B63E5AA432AD4EE0AEA7C153585DDA868C2E4328D76436412F823E08
            B963FD0FB1172D5B78D7FE311D91AD7F3381FE5E839CCF75E0EDFE0AB77C8D4F
            C864FF0093A02AA4FD7FDF7E3FE37EE4A4E3D46521E98AA0FD7FDF7D07B58BE5
            D2173C7A6798FD7FD6FF0089FF008DFB56BC3A4AFD42BFFC57DB9D335EBFFFD6
            D94F247FDCB64FFED615A3FDB54CBFF14F790517F630FF00A51FE0EB1DE5FEDE
            6FF4E7FC27ACB01FA7FB0FF78E3DB720E9C43D3D53B7D3FDF7F8FB4920C74B23
            3D3F533FD3FDF7F8FB4720C74B633D28299FE9ED0C831D2F8CF4A1A693E9FEFB
            FDF73ED0C8B83D2E8DBA50D349F4FF007DFEF1FEB7B4322D474BE36E1D3F53CB
            F4E7DA275E96C6DD3DC137D39F68DD7A588DC3A768A6FF001F699D3A54AFD4D5
            A8FF001F6C95F51D3C1FAE46A3FDF7FC8FDEB4FCBAD97F9F51A49EF7E7FDE7FE
            27DB8A87A6D9FAAB6F945FCBF76F765E4B31BF7AF64869776D765329B92AB0B9
            499BC1599CCCD54B5B99AEC3E65E45AAC4CF979A66F3D3BBFDB4E2C81A9D7D5E
            E38E63E4092E6E6EF75D966A5DCADA9E273DAEDEAAC6BA1BCC56AB5FE119EB32
            BDA3FBD1DAED1B2EC3C8BEE36DE5B64B08FC1B5BEB753E35BC7C0473C2A545C4
            34A062BA65D2384AD41D57575A748EFEDB3BBAB7AE6AF6D65B1BB956AC53FD8D
            61AA91A94545434F415B811908C78B0F2D7E3E9B540A5E9E2A39E728EF1E9768
            9A3D9B747DF1F6E7B175BD2557495D273904791C800B0A82B52091D6765DFB81
            C976FEDA5A733DB731DBCBCBE82593C459BC78FB469646228EBD8CCD1C4E1644
            98246555AA05D7F56F5B62FA6F63C38986593259DA9829E5DC39DAA31CB5B9AC
            BA53882392A1D129E3FB6A6FD288891A2AEA2AA0B1F7929B26CD6FCB1B318D00
            378E06B7F367A53EDA2F01F993924F5C83F73BDC5DCBDD5E706DC27674D96066
            5B584D291435A934145D72101A420015A2AD1154052D2AF03FDE4F36BDBF26DF
            4FE9ED1F41EE9FE95198AA46BAA46215139BB3B10107FAE5881EFDD7BAEFB26A
            929AB31FB661746876D50A52D4140006CB551FBBCAB31006A78EA24F193FED1E
            E45E5BB4F02C84AC3BE435FCBCBA8E399AEC5C5F1894D52314FCFCFF00CDD03F
            50DF5FF7DF5F6298C741390F1E98E76FAFFBEFAFB58833D2373D344C7EBFEBDB
            FDB7FC8BDAA5E03A48C7A87ABFE86D3EDCA7F83A6BAFFFD7D93F267FDCB653FC
            3255BFFB932FBC84887E843FE907F83AC7697FB79BFD39FF0009EB9C2DF4FF00
            7DC1F7571D590F4F14EFF4FF007DF4F691871E95A1E1D3E53BFD3FDF7FADED1B
            8E3D2D8DB874FB4D27D07F5B587FBD7FB7F68A414AF4B636E1D2C7F85E5A8D63
            7AAC756C09280636969A545705437A495B1F49E7FA1F655F536D29611CE8C471
            A11D1B7D35D4414C96EEA0F0A83D4D8242A6CC0A91C107820FFAC791EDA75F31
            91D3A8C460F1E9F29A52C55541666202AA824927E8001C93ED1CAA14162683A5
            B112C42A824F4AFA3C3E666A67AB4C7D408235D65E4511338BD8F8A290ACD210
            39E148B7E7D95BDD5AEB09E28D47F67EDE8D12D6EB417F08D3F9FECEB147395E
            0DC106C41E083F9047D411EEC53F675A0FD4B5A9FF0063FEF36F6D94F974E093
            E7D76D5361727FD8FF004FF6E7DD7401D6F593C3A8EF543FD50FF6E3FDBFF4F7
            B1A071603F3EBC759E087F61EA1B48F23048D59D98E955452CCCDFD1545CB1F6
            E2C900E332FED1D36D14E46216FD87AC353B2B2B512C59D7DA9512D4D153CD1D
            36524C4EBACA6A59B49A88E9EA5E13551C136905D5080D6E7E9EEEA6C1E78E56
            311B85042B1A6A00F100F100F98AF57171BC456371B7C53DC2EDB2B2B3C419C4
            6ECBF0B3203A5996A7492091E54E831CC541A9AAF02DF4D331571F4B4C6DA811
            F86407FD87B2DDD6E04928850F6271FB7FD8E966D36C6388CCE3BDFF00C1FECF
            5DD352B1D27937E7F16FEBF53ECA7A37E97FB745361E3AEDD79211AE3B6DC42A
            23F285F1D5E6A505711420B9556B4F695C7FA84B7D09F6B2C2D5AF6EA2B75E04
            E7E43CFA477F76B65692DC371031F32780E806AEC99C85454D5C93FDCCF533CB
            513CBAB5B4934CED2CB23B7E4B33124FF53EE588635445441450283ECEA239A4
            67667635624927E67A61A87FAFFBEFAFFC6BDAF8C53A4121E99676FAFF00B7FF
            008A7B5518E91B9E9AA66FF78F6A40E9331EA1DFFDEFFDE7DBB4E9AA8EBFFFD0
            D92F2A6D98CA7FDAC6B7FF007265F790D08AC10FFA41FE0EB1CE63FAF3FF00A7
            3FE1EBA85BE9FE1EF4475653D3AC0F6B7FBEFF005BDA571D2A43D3CC127D39FF
            007DFF001AF69645E95A37431EC69B65E0A58F2DBDB3749819E3AA14D4306E18
            2B70D40B585C4700390CA52D363EB6AE7723C114124A58FF00B502A23FE60DEF
            533D8DA376F0661E7F21F2F53F9752172F6C7A563BEBC5EEE2AA7CBE6C3D7D07
            E7D1AEC4454F98264A5A9A7A9A38C8134F4B3C3531A92BA8465A2691448C0FE9
            3CFB077433E83AEDCDBF051AE3B37430470C208C7D5AC51E9BB10F253CD295E2
            E42B2927F247B13EC3725C4B6AEC491915FE63FCBD05B7FB60862BA45001C1A7
            AF91FF0027490EB93E6DD78CBAA3AC495D230750C07FB8FAA8D1C02080D1CB22
            B03F822FF5F6A37A1A2CDBE6C07F97FC9D27D90EBBD5F9293FE4FF002F43FCD9
            6C6BD51C78C8D23575BC86944C0CF61C5D87D0581FC9BFB087431E826DEBE3A5
            CC8548D6267A749240AA14B397752CC38F55D793FD7D8876DD4F6E751A8069D0
            77732B1DC8A0A556BD06F9CDCF0E1604242CD533122184B6906DFAA4908F508C
            1E38E49E3DDEF275B6418FD43C07F97AA5940D74E7348C713FE4E90ADBB6B677
            66925E093E95BAAAF25AC029B80A0FB0FBCB2486AEE4F4218E28E30022803A95
            0EE2A991D5119DA495D52344B17777215114024B3316B01F4E7DB7D39D001F2D
            FE60D6FC6AF1F52F58CB8CABEF0C962A9B23BD7786422A6C9D175850E4E9C4F4
            184C5D04BAE1A9DD7554CEB30F3031C111591D58491AFBF75EEAAD71DF237BDC
            6E58F78CDDEFD9B26E113254FDF49BAEA8C0EEAFE4114D8A4098692975804C3E
            011B0E2D6F7EEBDD5B97C76F92DB3FE4B52D36DDDD391DB5B4FBE68E30925389
            A0C4E0BB4E950158F258812BA4347B996D6A8A504EB7F5A0D0405F75EE8D5D5E
            D58B6CC4B55BB72D86DA58F5E4D5E672147199486E531D4914D255E4EA9CF11C
            5023BC878039F76546760A8A4B1F4EAACEA8A59D8051E67A2CBBE5F76765EE1A
            2593EF766F516D72E76D6D795D693726F1CAC848AADE1BC58C8131A9531AAA51
            63975494F00BCC44AEC8838D936F5B3532CEE3C66F21E43D3FCFD0137CDC1AF5
            C4502FE8AF99F33EBFE6EB2FDB78635829E15544015238D95D881F4B2AB33B9F
            F1E4FB16C72446801E8232C528AD57A68A91225C323AFD41D4A47D3EBF51ED72
            1534A30E90481856AA7A6599FEBFEFB8F6B5053A44E7A6C95BFDE7FDF7FBDFB7
            D4749D8F583DB9D35D7FFFD1D92331FF00177CA7FDAC6B7FF7265F790F07F610
            FF00A41FE0EB1C67C5C4DFE9CFF84F58227FA7FB63EF6C3AF29E9CE17FA7FBEE
            3DB0EBD2846E8C2F4E6D7DBF96ACA7C86472F85AECA96964C56D64C9514B9673
            472B2C95F3E244DF7D2C50BC44802328000CC6C40F71DF3273069326DD62F918
            761FCD47F94FE43A91B96797B52C7B8DF2769A1443FC99BFC83F33E9D1AB11EB
            493CAA0C0C8D4F30750C254752AF4D66043074E194F1A7EA3D80BA903A8787A1
            A0DBF1494BB7B1B8FC1524D3795E870D41498EA3794DC6B34B470C50995B51D4
            DA75313C93EFDD7BA70CD429B831991DB5552A3D5D551B3C722AAE886AE0649E
            9A0D43F54FE445B9078E41BF23DAAB2B836B750CDE40E7EC383FCBA4B7D6E2EA
            D6680F1231F68C8FE7D1498AA6AF1B533C4B2494D55034F4B2B46E5248D81686
            640C2C47208FF1F63DB8B686F20D120AC6C011FE423A8FEDAEA6B29F5C66922D
            41FF0028EB8C72D509D274AC99248DF5A4A257F22B5EF717279BFF00B03EC327
            97E6F148132F83EBE7FB3FD9E850398613102616F1BD3CBF6F4A2C86E0A9AD11
            D564671235251AC0662A14F820324977B5F515D6793CDAC3D9ADBD9A58C0CBAC
            9504B127ECFF0063A29B8BC7BE9D5B400C40000FB7FD9E8BDE5B3D265F255158
            CCDE266F1D3291A7453A7118D2C38BFEA3C7D493EC257539B99DE5FC3E5F6797
            42FB4B716D0245F8BCFEDF3EB84354458FF8FD2C3FDE781F9F69BA53D0C3D672
            62B1073FD8FB9084DB9D7B8F3967D681D2B3392864C450C63FDD92F94170ABC9
            6D3C8F6F5BC2D3CC912F99FE5E7D337132DBC2F2B790FE7E5D50F7CDCA3ED3F9
            4DBFEB33981A27DA14E6491532B8BA5829370E4D439293E43290C5F78F1DAC12
            3D64AA0B7007B105CDB46446BE10A0141EB4E83D6B71282EC6539353E953E9D1
            42DB3FCBCBBAF393832F65EFC87CA406FF007F1E69058DFF004AAD4051FE007B
            482C437E11D2A6BF2A3E23D1A9D83FCA2E0AF9694EFCED1DFF0058B2CD1BBA36
            F0DC75155A8B0B0A684E51228581FA16E17EA071ED647B647F8863A4926E727E
            13D5A77587C6EEB2E8ADB49B7BAC572F43978697ECA5DFB9CCAD56EDDDEF158A
            CB4D4196DC325736231E4B11E2A214E8DF53F8F621B2DAA18D3505D24FEDE839
            7DBB4F23952F503F6751B2DD5B94A895EA0EECAFCA4CCE58B6627AD9656FCF33
            7DCCDEA27FDA401ECCD6C69F0BF456D7DEA9D271F65EE1C693E83322F3E4A4AA
            67B802E485D51CBFE1F4F6A52D645CD2BD276BA8D8F1A753696AB3344C10D664
            202BC14926988D20DAC52424107FA7B551C641C8CF48E492BC0F4A0872F5CE00
            99A29C7D6EF1AA3FFC951E9FF79F6BE304601E8BE4209C8EA5AD52C9FA9190FF
            0081D4BFE1F8047B58A4819E91B81E5D64D6BFD7FC7E87E9FEDBEBEEF5EA94F9
            F5FFD2D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3F
            B79FFD39FF0009EA02B58FB708AF4DA9E8CB7527554992FB5DD1B96999319E8A
            8C563E642BFC46D668EAE606D7A107955FF761FAFA7EA00E67E6416E24DBAC1E
            B39C3B0FC3F21FD2F53E5F6F090F95B968DCF87B8EE094B7E2887F17F48FF47D
            079FD9C4C4E6360EC9DCD049167F696DEC94174791A7C5522CC595F5C7FBF0C7
            14D23EB5B80CCC2E2E471EE342492493527A938000000500E98E4EB9A4A59619
            B6CEE8DEDB51A14317831BB824C9636A20D66414F3E2B714399A3A7859C8D6D4
            428E77550865D200F7AEB7D293058CDDF827ADFE33BBA9773435289FC283EDDA
            5C1E530A07EB32D45154544792350070F29F2213E90A3EBEEBDD384105641511
            CF0A191E17F35C1B8F49BB1909E429BFA89FEBEFDD7BA06BB136A649B735764B
            018E9EB71B9058EB5FC0AABF6D54EAAB5519567D4E64954C97008BBDBF1EC6DB
            4EEB6BF471437530599719F31E5FCB1D01F76DA6EBEB659AD602D0B671E47CFF
            009E7F3E83A7A7C8D2955ABC7D752B35F42D452CF097B5EE53C88BA80B7D471E
            CE164B7981314E8C3E441E899A2B888812C0EA7E608E919BD330D4D8E14113E9
            A8AD70920D5678E9908694942355A52340FF005CFF004F645BF5CF8302DBA1EF
            938FFA5FF67FCFD1F6C16C669DAE1C7647C3ED3FE619FD9D069083FD3FC791FE
            B5B9F60EE867D3BC21B8D218B3582AAF2C589015547D4BB3703FA9F7EEBDD186
            DF583A5C075F6DCEBCAA2229EA11776EEF0086F2646B13C943412FE5D71F4E05
            87A86A008E7D8A361B3AAC976E31C07F94FF0093A0B6FF007D478ED10FCDBF3E
            03FCBD14EA7C66DF8A4330A389E5918C9665165D64B2AF001F4210A3FC00F6B1
            D75BB13EBD2146288AA3A53D35752528FD88A28988B3322A8623FA161C9FF627
            DBAA80701D36CF5F3E94385C9F96AE7707D50D05548847D52560B042DCDEE11E
            5D5FF20DBDAB863D4E8298A8E91CF2698DDABE5D4E9660058703E800E00B7E07
            B12AA5303A0CBBD6B53D35CD37B52894E92BBF4D534B7BFF00BEFF007C3DA855
            E933374D551A24043AAB8FE8C035CFFB1F6A554538749D9BD3A6692969C1BA26
            83FED26C3FC38E40F6E2A0E3D32CE7AE0B0E9FA1BFFBDFFC8FDB94E9B26BD64D
            03FDE2DF8FF6FF00EBFBF50F5AEBFFD3D92331FF00176CA7FDAC6BBFF7265F79
            0F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9ADDD5473CFF85AFF00EDEF
            C7B74D0820F0E9B524104711D65C57676FCDA73BC188DCF9C86841D431B26526
            ADA1D6140A768A3CA2E464A3A4A78D55568E95E9A9342E954424B7B8237AB13B
            7EE7776C7E10D55FF4AD91FC8D3EDEA7CD8EFC6E3B559DD0F88AD1BFD32E0FF3
            15E8709BE476F8C4516DD9EB23DBD9EA2C9E1E9AA7F88C98897173D56469D529
            F2914B4D89AE4A3C4D4D4D42891D74D42D2ABA855750012AE8DBA12703F2530D
            59819B3F93DA991A17A0AFA3A1C8C58ECA50E5E9295AA629A76A9A09A78B1791
            CA242B12AC68D474D2D4CAE56243A588F75EE84BDADDB3B037AD6D363B0BB810
            65AB0DA3C566296A311915988D469665AA534495F6FF0094759DE636365363EF
            DD7BA77CD67FCACB458E7228E9E659259D4F35D3446FA87D3FC99187A3E9A872
            7EBEFDD7BA54C53C268972550C63A3F0A4EEE383216E0C305FF5CBE5056C2F62
            0FF4F7EEBDD32E3B392E52AAA69EA0A246C049494C2DE38E389591A350782DA1
            EE7F2C4B1FCFBF024703D7A80F11D336F3C16D8AAC6BD1E430D8EAAC8D744C21
            67A58966C7C4F75359E4455916A0FF00BA813C7D7DED9998D59893F3EB4AAAA2
            8AA00F97443A5A07A1AFAEC7CA0B4D8FACA8A39B86505E091A32EA0807448175
            291F5520FBD75BE85CEABC1E35F295DBBB71E88F69EC3A36DC1989265BC35155
            09D58BC6FAB8925AAAA00E9B124002DC8F6EC10BDC4D1C318AB31A74D4F325BC
            324D21EC515E91B94DED5BBF73196CBCB26993273D4CDA356A10AC97586204DC
            11146147F85BDC9D6D6CB0C11C118ED55A7FABF3EA2DB9BA69E792793E266A9F
            F57CBA0369659F4AB36A572A858137208451F5E6FF004F65210D4F46E5F033D3
            B44F29FADFDBEA94E9967C1E955B764923AD98DEC1F1D5DA89FA5A281E5173FE
            D52201FEBB0F6AA05EF4C79F48E77AA3FD87A514B3FD79F625441C7A0CB3F4DB
            2CD7F6FAAF49D9BE7D37CB27D79F6A1569D30CDD37C927FC6BDBCA2BD30C7A8C
            4DFDB9D344D7AEBDEFAD75EF7EEBDD7FFFD4D91334FF00EE5B2A07FCEC6B79E7
            FE5665F790F07F610FFA41FE0EB1C6E3FB79BFD39FF09E98A57B027FDF7FBCFB
            B93D37F2E92D902D248BA25811B4B0513AC9691858A45AE33684484105D8154B
            DC82011EC03CF161AEDEDEFD17B90E96FB0F03F91C7E7D485C897FE1DC5C6DCE
            7B1C6A5FF4C3881F68CFE5D3EE216AF2FB772382340ED5B8B964DC546692A69A
            B2974AD3F87371C136B82AAA21F0470B0714E825655E01D2A633EA50EBBD8F98
            C62D5E530198964C7E3F746264A2AA8B251BE2E6A7ABA32D558AFB86C80829F1
            9502A9EC0CEC9E9908FAB7BF75EEBADA597ABDA1BAF175AEEAAD8CC87DB56A9D
            469BC4D27DA641D51C011DE12D6700385FE9EFDD7BAB1BC652AE69E29E92F4D4
            33D3A642592A0DFF0085D14CAB318EB08FD55146AE23651766916C073EFDD7BA
            F563519A9A8FE194F2458F9569D642F2B995AAA922F04392A88CB78CC992FDB8
            3480044141B5C927DD7BA934D44B1D0CD93AAA8ACA20CB2418C7A197EDEB65AC
            D36F3D3CA558A43497BB385617B2FD48F7EEBDD33E43243C75396CA4E9078E39
            67C94F33AC74F0494A87EFA48E4721171D13C6E617240F00527DFBAF74526937
            6D076AEEC94ECFA192B62ADAA8B1F8EAA8C31397963634F15584F1A343032200
            A5BFDD4818DAE40F75EEA0F7C6F55A2ADC37C6CEBE94D6D4E2AA20CE76AE7296
            C69A4CFCA88F4B86150B7674C5C6C19D0D95494BFA81B0C79736D6AFD6489922
            8BF6799FCF80E81BCCBB9281F471BE065BEDF21F979F58F198F836F61CC2BFB9
            3880ABC9F56799C150AA491F576B7B1A951146CC7801D01C486591547127A494
            78F17FA0200038FA1D205CA8B7D09FA7F87B21D249A9E8FCB5053A738A840E08
            17FF005BFDE6DF8F6F2A74CB3F4F74902D3415350400D2A8A48BFE437492623F
            C1624B7FAE45FDAEB58B5CA829819E905DCC121724F114EB1C937F8FFC53FE37
            EC40A9D0759FA8524BF5E7FE2A7DBEAB4E9966EA0C927FC687B742D7A659BA8C
            4DFDB8053A6C9AF5D7BDF55EBDEFDD7BAF7BF75EEBFFD5D90B3608CBE548FCE4
            6B8FFB1FBA96FEF21E0FEC21FF00483FC1D638CFFEE44DFE9CFF0084F49DA96B
            21B7E6FF00EF56FF007BF76F3EA9E7D07F9DADFB6FDC563746BDEFC716D4381E
            D15FDBC7796B3DB4AB547523FCC7F239E97D85C4967756F731351D181FF38FCC
            63F3E9DF6BEEDC7E232F8CCC7DDC51247A5AB29EA0185E5C6540B55C3530542A
            37D9D5535C86701244B3A92A41304DC42F6F3CD049F1A3153F91A753E5BCE973
            043711FC0EA187E62BD3EEE6C64B80CBD6D0D349AB1ECE2AF1A4325650CB4552
            7EE689A23289696BA3A70E15262AC1CA6B1ED9E9EEA76FAC5E2724F8DDD71E32
            97C3BA68D67AF6A5FB8A0A883311204AB81B258F9A96B258EA5D0D44B4FE4F0E
            A60B22B0E3DFBAF746BFA3B77D5E6761CB81ABC95555D6E2F212D44CD58D0495
            55747FE4EBAE6A8A7A7A5063A59EA6211C6CB760CCD76D248F75EE864A6C7D65
            641573D35553D00A3884A2BAB2279E952A9583D1C0F046E8F50D3D4228D209D2
            B772085B1F75EEBD5F907C8491CC6334D4F1C29152D091A568604B8F004BB052
            CE0BB1B9D5AAFEFDD7BAA5EF903F29F717C8DEF3AEF88FF1FA57C96DADBB94A2
            C7F6A6F4C419AA9B239EA491D6BF62E127A406338CC7B941919439125523C22C
            91B97F75EE8F15511F19F68D075E75F474399EFECF619606AC7F1D4E1BA9B095
            9198E4DC39D60AD1CB989D49FB5A53EB9DC5EDE1562E79B2ECF36E73062A45B2
            9C9F5F90E88B7BDE61DAE02A181BA6181E9F33FE4E837D85B368B66D04882B2A
            739B832534B5D9EDC15AD254E4F3192AA90CD5955339324AC66A872C792493CF
            B94228ADED630BA94281F2EA2B965B8BB94B952589F4E97135164EB180145502
            25370BE33A89208D6F7FD3C1B01F8BF3CFD0BEEEE44C7C38C7E98FE7D1959DB7
            83FA927F687F97FB3D76985AF16D54EE9C7F6B481FEC45FDA4543D2A2FD65343
            1D3FAAAEA228940B94570F2B71FA5517FADBEA6C2FED54503C8405524F49659D
            2315770074DB5758266508BE38625D10444DF4213762E7FB5248C2EC7FD61F81
            ECFADAD44099F8CF1E882EAE8CCFE883874DCF2DFF00DF71ED601E9D222DD447
            93FD8FF8FB702F4D96EB0937F77E9B26BD75EF7D6BAF7BF75EEBDEFDD7BAF7BF
            75EEBFFFD6D91F322F95CA8FFAB8D6FF00EE4CBEF21E0FEC21FF00483FC1D638
            DC7F6F3FFA73FE13D256BEE8849FA0B93FE1C8BFBB9C1EA83A2D3BC7B276BC12
            55529AC9649A09A486558E9676459616D2C81F4056208FC5F9F6159F9AB668DE
            489A76D6A483DA788C742D8394F7A9238E55817432823B87022BD73EA6EC9C76
            E8396DB14F586AA5C52FDE8A2AAA476A7971F513059167A4AE85A96B228EADEC
            55D1D6C45C7D3DC79CC17361797BF5764E4EB1DD5046462BF98FE7D48BCBD6D7
            F6563F497C80683DB420E0E698F43FCBA3172E3A832FB4E2A95A084D56DDAB6A
            4AE7A79AAA8AB463328D2C94325155524E9518F869AA298C6CD078D625648D74
            8603D91747FD4CC024F99DBD98DA6B93A989A9524DC7851514D4791FB4A9A792
            9A2C9251C2E68269E4ACA10B09124F239D466B3B4766F75EE9EFA777564B6B6E
            FA44AA8E8EBF119B920C7E4E9A86A65A5ACA49B54B150D5D3C39184264A581AA
            A42E88D0AE93CB703DFBAF7560593AE8675868F1E6D88A755968C8BFF9779E35
            917292EA0199EB2270C808052320581BFBF75EEA9E7F9937CC6DD3B15E93E257
            4555FF000BEF4EDBC0D05657762D65551C183EABD879DAEC86073591FB91566B
            137A4F4D8E4FE114FE0023FBA7AAD4C5238DF6AACE42A8258F55665405998051
            EBD2CBE157466D9F89FD514587EBBA47A5DDD98A512EEEEE0DD540467AB2A67B
            8AD5DA789C9A8AE496B1AEC2AEB234B6AD421949D4043B76C13DC32B5C290BFC
            2389FF003741DDC79820B7465B760587163F08FB3D7FC1D0FB4D5182C4BD5CD8
            FC6FDFE42BEAE4AECA66B2EC6AF2597AF9D8BD464321552DEAAA6AE76372EEE4
            FE000001EE40B5D95D23442C1230380FF553A8F6EB7A4924691575C87CCE3FD9
            EB8D5EE0CBCFE9A6C8D4E363E7F6E812922B8FA732494D34A2DFE0C3D98A6D56
            EBF1549FB7A2F7DDAE58E34A8F90E9A9EAABE437A8CCE6EA0FFCDECC57693FF4
            EE39A28FFDB0F6EAEDF6A3FD0C74C1DC2E4FFA29FD83AE1F70E011E59483C9D5
            2CB25C8FC92EED73EDF5B68178443F674CB5D4ED5ACADFB7AC0D2FD4FF00B727
            DBC140C28A0E93B393C4E7AC2D2FF8DFFDEBDDC2F542DD612E4FBB8007542DD7
            0F7BEABD7BDEFAD75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFFD7D92331FF
            00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009
            E99A6A78E61661FD7FDE7FD8FB748AF4D034E827DD3D25B1375BCB36470B40F5
            331D4F5229C453B31BDCB4B018A42496B9E79F65771B36DB744B4D651963E7A4
            57F68E8D6DF7BDD2D40586F650A3CB51A7F3E80BAAF877B728722D9ADA597CC6
            D9CB82ED1D7627399AA19503000C7786BEC6336BE9B5AE01FA81ECAE4E52DA1E
            B4B6009F4247F97A348B9BF798E80DD123E614FF0093A0A3B27B43B73E34E2AB
            FF0087EF8C76F7A89E82AB1FFC1770D3FF0018927A6A89A2A9615B9357A7C9B1
            59A9E329AA721194587B24BEE56DB2153A0307F931FF002D7A3DDBF9AF749986
            B2A53E6A3FC943D15DD91FCD9B76EDDDC7407787C71DC755518DAFA4F0E4B61E
            7A0C92C89A44557553E37294745320991DED04724A749FD67D836EB6A785F4A3
            D7A1ADA6EC93A6A74A7CEB8E8F7ECCF985D45D9791AFA8C1E0BB6363514B927F
            E16BBF7ADF3F86558E62B2890653151E6F0D45494F23B0492A6A61B228D5CFD5
            19B1BA02BE0B11F2E960BFB424033A83F33D1E5ED7F99D86D87D074BBCB65D25
            276676FEE163B4F60EC3C3CE6AE2DC7BE6AE9E5929723956A09126C4ECBC3122
            7CA541788AC31B470B795E31EF50DA4F34A221190DE78E1D5A6BB82188CA6405
            7CB3C7A25DF14FE2351F5AE6B70FC92EF79CF647C96ED5C8D4EE5DCBBB33D7AE
            AD8ABEBC86FE1D855AA69A3DB7B57094FA29282869447053D2431C48BA55401E
            ECDB20042C69DFE6C7CBA8FB7ADF0905A47ECAE1479F476AB327555F299AA642
            E6E7420BAC5129B7A224B9545000FF0013F9B9E7D8EEDECE1B64D31AE7CCF99E
            805717935CB9691F1E43C87517CBFE1FEFBFDB7B7F474C6BF9F5EF2FF87FBCFF
            00C6BDFB475ED7F3EBA327FBEFF7D6F7BD3D6B57CFAE2643FEFBFDF1F7BD23AD
            6AEB8924FBDD3AD54F5D7BF755EBDEF7D7BAF7BF75EEBDEFDD7BAF7BF75EEBDE
            FDD7BAF7BF75EEBDEFDD7BAFFFD0D92331FF00176CA7FDAC6BBFF7265F790F07
            F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D744D85EC4FF0080E4
            FBD75BE9A323057D6C2F052C82955C15329BF90022D75B7D0FBA9D4787565201
            A9E803DD1D03B1B3127DDEE713E5AAAA1D8AC4EE445FD5E4706E5912E05BF248
            1F9E0AB70105BC46493BA43803E7FE61D1BEDC67B994471F6C6324FA0FF39EBB
            DB5D37D5DB55964C3ECCC24332F22A27A282A67D57B97F24A8DC93F536F613D0
            A58B951A8F42ED6C15503768E85344A6112C2208442A3D3108E311ADBF023D21
            07FB6F771F674D93D2A36A6DCC3C955366EAB1B471D1E246B7922A5A78EA2AAA
            64FF00334514DA035E56FD42F6FEBC5FDBD0C2D2C891A2F7934E999A65863796
            46ED03A5156D64F5F532555411ADEC151388E18D78486216168E31F4FEA6E4F2
            4FB19DB5BA5B44B1A71F33EA7A055D5CBDD4CD2BFE43D07517DA8E9375EF7EEB
            DD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF
            7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7FFFD1D92331FF00176CA7FD
            AC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33
            D7BDFBAF75C5DD634691D82A22B3BB1E02AA82CCC4FF004007BD1200249C0EB6
            012400327A0CAB722F5B52F335D431F42137F1C43F4476E46A0BCB5BFB44FF00
            87B055FDC9BBB867AFE98C0FB3FD9E3D0E2C2D45A5BA253BCE58FCFF00D8EB84
            6ECDC2EA6278B2824FFB016B9F6940248A0CF4A8B002A4D074F14F8EAF9EC561
            6453C8793F6C7E7F07D5FEF1ED743B75DCD42B110A7CCE3A4336E5690D6B282C
            3C867A10BC91C58EC7E32990C7051AB4B3136D5535D28B4B52F6B9B2AFA505F8
            04FF005E0FAC36FF00A42D23B06908FD9D07B70DC7EAC2C71A95881AE789EA3F
            B34E8AFAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF7
            5EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF
            FFD2D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB7
            9FFD39FF0009E9BBDBDD33D7BDFBAF74D995A5A9ADA614B4EE912CB22F9DDC5F
            F690EBD017F21DC0BFF85C7E7DA5BB8A59E13144C175609F974AECE58A099669
            54B69C81F3F2E9B29F6BD1C5CCF24B50DC13CF896FF9E149363FEBFB410ECB6C
            9FDA3339FD83A309B7CB97C44AA83F6FF87A7E86929A9C010411476FCAA00DFE
            C5ADA8FB338E0861148A255FB074552DC4F31ACB2B37DA7A91EDEE99EBDEFDD7
            BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDE
            FDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75E
            EBFFD3D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3F
            B79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFB
            AF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7
            BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EE
            BDD7BDFBAF75FFD4D92331FF00176CA7FDAC6BBFF7265F790F07F610FF00A41F
            E0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7
            EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF7
            5EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDF
            BAF75EF7EEBDD7BDFBAF75FFD5D92331FF00176CA7FDAC6BBFF7265F790F07F6
            10FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75EF7EEBDD7B
            DFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEB
            DD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF
            7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD6D92331FF00176CA7FDAC6BBFF726
            5F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33D7BDFBAF75
            EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFB
            AF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7
            BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD7D92331FF00176CA7FD
            AC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009E9BBDBDD33
            D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7
            EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF7
            5EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FFD0D92331FF
            00176CA7FDAC6BBFF7265F790F07F610FF00A41FE0EB1C6E3FB79FFD39FF0009
            E9BBDBDD33D7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7B
            DFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEB
            DD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75FF
            D1D91F2D7FE2B93BDEFF00C42B6FAAD7BFDCC9F5D3E9BFFADC7BC8883FB187FD
            28FF000758E33FF6F37FA73FE1E9BFDBBD33D7BDFBAF75EF7EEBDD7BDFBAF75E
            F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBA
            F75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7B
            DFBAF75EF7EEBDD7BDFBAF75FFD9}
        end
      end
    end
  end
  inherited pnlAddressBar: TPanel
    Width = 613
    inherited Image3: TImage
      Width = 605
    end
    inherited RzLabel1: TRzLabel
      Width = 7
      Caption = ''
    end
    inherited Image1: TImage
      Left = 609
    end
    object RzLabel26: TRzLabel [4]
      Left = 10
      Top = 7
      Width = 106
      Height = 16
      Alignment = taCenter
      Caption = #21830#21697#21021#22987#21270#21521#23548
      Transparent = True
      Layout = tlCenter
      ShadowColor = 16250871
      ShadowDepth = 1
      TextStyle = tsShadow
    end
    inherited RzFormShape1: TRzFormShape
      Width = 613
    end
    inherited btnClose: TRzBmpButton
      Left = 582
    end
    inherited RzBmpButton4: TRzBmpButton
      Left = 530
      Visible = False
    end
    inherited btnWindow: TRzBmpButton
      Left = 556
      Visible = False
    end
  end
  object cdsGoodsPrice: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 106
    Top = 440
  end
  object cdsGoodsInfo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 138
    Top = 440
  end
  object cdsGoodsRelation: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 170
    Top = 440
  end
  object cdsBarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 202
    Top = 440
  end
  object edtTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 238
    Top = 440
  end
  object cdsUnits: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 45
    Top = 383
  end
end
