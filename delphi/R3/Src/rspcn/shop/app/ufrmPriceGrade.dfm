inherited frmPriceGrade: TfrmPriceGrade
  Left = 262
  Top = 114
  Caption = #23458#25143#31561#32423
  ClientHeight = 422
  ClientWidth = 552
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlAddressBar: TPanel
    Width = 552
    inherited Image3: TImage
      Width = 134
    end
    inherited Image1: TImage
      Left = 342
    end
    inherited RzFormShape1: TRzFormShape
      Width = 552
    end
    object RzLabel26: TRzLabel [4]
      Left = 10
      Top = 7
      Width = 61
      Height = 16
      Alignment = taCenter
      Caption = #20250#21592#31561#32423
      Transparent = True
      Layout = tlCenter
      ShadowColor = 16250871
      ShadowDepth = 1
      TextStyle = tsShadow
    end
    inherited RzBmpButton2: TRzBmpButton
      Left = 521
    end
  end
  inherited RzPanel1: TRzPanel
    Width = 552
    Height = 392
    object RzPanel2: TRzPanel
      Left = 1
      Top = 1
      Width = 550
      Height = 390
      Align = alClient
      BorderOuter = fsNone
      BorderColor = 15461355
      BorderWidth = 5
      Color = 15461355
      TabOrder = 0
      object RzPanel3: TRzPanel
        Left = 5
        Top = 5
        Width = 540
        Height = 128
        Align = alTop
        BorderOuter = fsGroove
        BorderSides = [sdBottom]
        BorderColor = 15461355
        Color = 15461355
        TabOrder = 0
        object edtBK_PRICE_NAME: TRzPanel
          Left = 20
          Top = 8
          Width = 260
          Height = 31
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 0
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
            object RzBackground3: TRzBackground
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
              Width = 102
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #20250#21592#31561#32423
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
          object edtPRICE_NAME: TcxTextEdit
            Left = 105
            Top = 4
            Width = 153
            Height = 23
            Properties.MaxLength = 30
            TabOrder = 1
          end
        end
        object edtBK_AGIO_TYPE: TRzPanel
          Left = 20
          Top = 81
          Width = 260
          Height = 31
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 1
          object RzPanel5: TRzPanel
            Left = 2
            Top = 2
            Width = 103
            Height = 27
            Align = alLeft
            BorderOuter = fsFlat
            BorderSides = [sdRight, sdBottom]
            FlatColor = clGray
            TabOrder = 0
            object RzBackground1: TRzBackground
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
            object RzLabel1: TRzLabel
              Left = 0
              Top = 0
              Width = 102
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #20248#24800#31867#22411
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
          object edtAGIO_TYPE: TcxComboBox
            Left = 105
            Top = 4
            Width = 153
            Height = 23
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtAGIO_TYPEPropertiesChange
            TabOrder = 1
          end
        end
        object edtBK_INTE_TYPE: TRzPanel
          Left = 20
          Top = 44
          Width = 237
          Height = 31
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 2
          object RzPanel7: TRzPanel
            Left = 2
            Top = 2
            Width = 103
            Height = 27
            Align = alLeft
            BorderOuter = fsFlat
            BorderSides = [sdRight, sdBottom]
            FlatColor = clGray
            TabOrder = 0
            object RzBackground2: TRzBackground
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
            object RzLabel2: TRzLabel
              Left = 0
              Top = 0
              Width = 102
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #31215#20998#26041#24335
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
          object edtINTE_TYPE: TcxComboBox
            Left = 105
            Top = 4
            Width = 130
            Height = 23
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtINTE_TYPEPropertiesChange
            TabOrder = 1
          end
        end
        object edtBK_INTE_AMOUNT: TRzPanel
          Left = 256
          Top = 44
          Width = 157
          Height = 31
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 3
          object RzPanel9: TRzPanel
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
            object RzLabel3: TRzLabel
              Left = 0
              Top = 0
              Width = 102
              Height = 26
              Align = alClient
              Alignment = taCenter
              Caption = #31215#19968#20998#38656#36141#20080
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
          object edtINTE_AMOUNT: TcxTextEdit
            Left = 105
            Top = 4
            Width = 50
            Height = 23
            TabOrder = 1
          end
        end
        object RzPanel10: TRzPanel
          Left = 412
          Top = 44
          Width = 80
          Height = 31
          BorderOuter = fsStatus
          BorderWidth = 1
          Color = clWhite
          FlatColor = 9145227
          TabOrder = 4
          object RzPanel11: TRzPanel
            Left = 2
            Top = 2
            Width = 76
            Height = 27
            Align = alClient
            BorderOuter = fsFlat
            BorderSides = [sdRight, sdBottom]
            FlatColor = clGray
            TabOrder = 0
            object RzBackground5: TRzBackground
              Left = 0
              Top = 0
              Width = 75
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
            object RzLabel4: TRzLabel
              Left = 0
              Top = 0
              Width = 75
              Height = 26
              Align = alClient
              Caption = #20803#30340#21830#21697
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
      end
      object RzPanel13: TRzPanel
        Left = 5
        Top = 133
        Width = 540
        Height = 252
        Align = alClient
        BorderOuter = fsNone
        BorderSides = []
        Color = 15461355
        TabOrder = 1
        object RzPanel14: TRzPanel
          Left = 20
          Top = 16
          Width = 502
          Height = 188
          BorderOuter = fsStatus
          Color = 15461355
          TabOrder = 0
          object PNL_AGIO_TYPE_1: TRzPanel
            Left = 1
            Top = 1
            Width = 500
            Height = 186
            Align = alClient
            BorderOuter = fsNone
            Color = 14606046
            TabOrder = 1
            object RzPanel12: TRzPanel
              Left = 329
              Top = 90
              Width = 30
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 0
              object RzPanel15: TRzPanel
                Left = 2
                Top = 2
                Width = 26
                Height = 27
                Align = alClient
                BorderOuter = fsFlat
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground6: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 25
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
                object RzLabel7: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 25
                  Height = 26
                  Align = alClient
                  Caption = ' %'
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
            object RzPanel16: TRzPanel
              Left = 172
              Top = 90
              Width = 157
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              object RzPanel17: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
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
                object RzLabel8: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Align = alClient
                  Alignment = taCenter
                  Caption = #25351#23450#25240#25187#29575
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
              object edtAGIO_PERCENT: TcxSpinEdit
                Left = 105
                Top = 4
                Width = 50
                Height = 23
                Properties.MaxValue = 100.000000000000000000
                Properties.ValueType = vtFloat
                TabOrder = 1
                Value = 10.000000000000000000
              end
            end
          end
          object PNL_AGIO_TYPE_2: TRzPanel
            Left = 1
            Top = 1
            Width = 500
            Height = 186
            Align = alClient
            BorderOuter = fsNone
            BorderColor = 14606046
            BorderWidth = 10
            Color = 14606046
            TabOrder = 2
            object RzPanel18: TRzPanel
              Left = 10
              Top = 10
              Width = 64
              Height = 166
              Align = alLeft
              BorderOuter = fsNone
              Color = 15461355
              TabOrder = 0
              object Label17: TLabel
                Left = 0
                Top = 0
                Width = 64
                Height = 166
                Align = alClient
                Caption = #13#12288#21487#25353'  '#13#12288#25351#19981'  '#13#12288#23450#21516'  '#13#12288#19981#30340'  '#13#12288#21516#25240'  '#13#12288#20998#25187'  '#13#12288#31867#29575'  '#13#12288#12288#35745'  '#13#12288#12288#20215
                Color = 14606046
                ParentColor = False
              end
            end
            object RzPanel21: TRzPanel
              Left = 74
              Top = 10
              Width = 416
              Height = 166
              Align = alClient
              BorderOuter = fsStatus
              Color = 15461355
              TabOrder = 1
              DesignSize = (
                416
                166)
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 414
                Height = 164
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                AutoFitColWidths = True
                BorderStyle = bsNone
                DataSource = DataSource1
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clBlack
                FooterFont.Height = -15
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                FrozenCols = 1
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghEnterAsTab]
                RowHeight = 20
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clBlack
                TitleFont.Height = -15
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 25
                IsDrawNullRow = True
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnMouseDown = DBGridEh1MouseDown
                Columns = <
                  item
                    Alignment = taCenter
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #24207#21495
                    Width = 34
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SORT_NAME'
                    Footers = <>
                    ReadOnly = True
                    Title.Alignment = taCenter
                    Title.Caption = #21830#21697#31867#21035
                    Title.Color = clWhite
                    Width = 267
                    Control = edtSORT_ID
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00%'
                    EditButtons = <>
                    FieldName = 'AGIO_SORTS'
                    Footers = <>
                    MaxWidth = 100
                    Title.Alignment = taCenter
                    Title.Caption = #25240#25187#29575
                    Title.Color = clWhite
                    Width = 58
                    OnUpdateData = DBGridEh1Columns1UpdateData
                  end
                  item
                    Alignment = taCenter
                    EditButtons = <>
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #25805#20316
                    Width = 42
                  end>
              end
              object edtSORT_ID: TcxButtonEdit
                Left = 41
                Top = 52
                Width = 213
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
                TabOrder = 1
                Visible = False
                OnEnter = edtSORT_IDEnter
              end
              object rowToolNav: TRzToolbar
                Left = 210
                Top = 73
                Width = 55
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
                TabOrder = 2
                Visible = False
                ToolbarControls = (
                  RzToolButton1)
                object RzToolButton1: TRzToolButton
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
                  OnClick = RzToolButton1Click
                end
              end
            end
          end
          object PNL_AGIO_TYPE_3: TRzPanel
            Left = 1
            Top = 1
            Width = 500
            Height = 186
            Align = alClient
            BorderOuter = fsNone
            Color = 15461355
            TabOrder = 3
            object RzLabel6: TRzLabel
              Left = 140
              Top = 90
              Width = 240
              Height = 15
              Caption = #25353#21830#21697#36164#26009#20013#35774#23450#30340#21508#32423#20195#29702#20215#35745#20215
            end
          end
          object PNL_AGIO_TYPE_0: TRzPanel
            Left = 1
            Top = 1
            Width = 500
            Height = 186
            Align = alClient
            BorderOuter = fsNone
            Color = 14606046
            TabOrder = 0
            object RzLabel5: TRzLabel
              Left = 136
              Top = 90
              Width = 255
              Height = 15
              Caption = #25152#26377#21830#21697#37117#19981#25171#25240#65292#25353#32479#19968#38646#21806#20215#35745#20215
            end
          end
        end
        object btnSave: TRzBmpButton
          Left = 352
          Top = 214
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
          Caption = #20445#23384
          TabOrder = 1
          OnClick = btnSaveClick
        end
        object btnCancel: TRzBmpButton
          Left = 435
          Top = 214
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
          Caption = #21462#28040
          TabOrder = 2
          OnClick = btnCancelClick
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsGoodsPercent
    Left = 197
    Top = 291
  end
  object cdsPriceGrade: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 157
    Top = 331
  end
  object cdsGoodsPercent: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 158
    Top = 293
  end
end
