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
  inherited pnlAddressBar: TPanel
    Width = 613
    inherited Image3: TImage
      Width = 195
    end
    inherited Image1: TImage
      Left = 403
    end
    inherited RzFormShape1: TRzFormShape
      Width = 613
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
    inherited RzBmpButton2: TRzBmpButton
      Left = 582
    end
  end
  inherited RzPanel1: TRzPanel
    Width = 613
    Height = 395
    object RzPanel2: TRzPanel
      Left = 1
      Top = 1
      Width = 611
      Height = 393
      Align = alClient
      BorderOuter = fsFlatRounded
      BorderWidth = 2
      TabOrder = 0
      object RzPanel3: TRzPanel
        Left = 184
        Top = 4
        Width = 423
        Height = 340
        Align = alClient
        BorderOuter = fsFlat
        TabOrder = 0
        object rzPage: TRzPageControl
          Left = 1
          Top = 1
          Width = 421
          Height = 338
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground4: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel11: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 76
                  Height = 16
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground5: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 308
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
                object RzLabel12: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 167
                  Height = 16
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
              Left = 238
              Top = 28
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground6: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel13: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground7: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel14: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground8: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel15: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground9: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel16: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground10: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground11: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel18: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground12: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel19: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 1
                object RzBackground13: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                object RzLabel20: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground14: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground15: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground16: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground17: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 111
                  Height = 28
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground18: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground19: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground20: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 111
                  Height = 28
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground21: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
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
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
          end
        end
      end
      object RzPanel4: TRzPanel
        Left = 4
        Top = 344
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
        Height = 340
        Align = alLeft
        BorderOuter = fsFlat
        Color = clWhite
        TabOrder = 2
        object adv03: TImage
          Left = 1
          Top = 1
          Width = 178
          Height = 338
          Align = alClient
        end
      end
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
end
