inherited frmQuestionnaire: TfrmQuestionnaire
  Left = 553
  Top = 136
  BorderStyle = bsDialog
  Caption = #38382#21367#35843#26597
  ClientHeight = 477
  ClientWidth = 706
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel2: TRzPanel [0]
    Left = 0
    Top = 0
    Width = 706
    Height = 477
    Align = alClient
    BorderOuter = fsNone
    BorderSides = [sdLeft]
    BorderColor = clTeal
    Color = 16182753
    TabOrder = 0
    object RzPanel9: TRzPanel
      Left = 0
      Top = 19
      Width = 142
      Height = 458
      Align = alLeft
      BorderOuter = fsNone
      BorderSides = [sdTop, sdRight]
      BorderColor = 16765589
      BorderWidth = 1
      Color = 16182753
      TabOrder = 0
      object RzPanel12: TRzPanel
        Left = 1
        Top = 217
        Width = 140
        Height = 256
        Align = alTop
        BorderOuter = fsNone
        BorderColor = 16765589
        Color = 16182753
        TabOrder = 0
        object labShopName: TLabel
          Left = 8
          Top = 23
          Width = 65
          Height = 12
          Caption = #38376#24215#21517#31216#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object labANSWER_USER: TLabel
          Left = 8
          Top = 67
          Width = 66
          Height = 12
          Caption = #31572' '#21367' '#20154#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object labANSWER_DATE: TLabel
          Left = 8
          Top = 110
          Width = 65
          Height = 12
          Caption = #31572#21367#26102#38388#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSHOP_ID: TLabel
          Left = 8
          Top = 41
          Width = 42
          Height = 12
          Caption = 'SHOP_ID'
        end
        object edtANSWER_USER: TLabel
          Left = 8
          Top = 85
          Width = 66
          Height = 12
          Caption = 'ANSWER_USER'
        end
        object edtANSWER_DATE: TLabel
          Left = 8
          Top = 129
          Width = 66
          Height = 12
          Caption = 'ANSWER_DATE'
        end
        object ledANSWER_USE_TIME: TRzLEDDisplay
          Left = 7
          Top = 172
          Width = 91
          Caption = '00:00'
        end
        object Label4: TLabel
          Left = 8
          Top = 155
          Width = 39
          Height = 12
          Caption = #29992#26102#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RzPanel35: TRzPanel
        Left = 1
        Top = 1
        Width = 140
        Height = 216
        Align = alTop
        BorderOuter = fsNone
        BorderColor = 16765589
        Color = 16182753
        TabOrder = 1
        object Label9: TLabel
          Left = 8
          Top = 22
          Width = 52
          Height = 12
          Caption = #38382#21367#25968#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 8
          Top = 56
          Width = 52
          Height = 12
          Caption = #38382#31572#21367#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 8
          Top = 91
          Width = 52
          Height = 12
          Caption = #28385#24847#24230#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object QUESTION_SUM: TLabel
          Left = 57
          Top = 22
          Width = 72
          Height = 12
          Caption = 'QUESTION_SUM'
        end
        object QUESTION1_SUM: TLabel
          Left = 57
          Top = 55
          Width = 78
          Height = 12
          Caption = 'QUESTION1_SUM'
        end
        object QUESTION2_SUM: TLabel
          Left = 57
          Top = 90
          Width = 78
          Height = 12
          Caption = 'QUESTION2_SUM'
        end
        object Label18: TLabel
          Left = 8
          Top = 125
          Width = 52
          Height = 12
          Caption = #32771#35797#39064#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object QUESTION3_SUM: TLabel
          Left = 57
          Top = 124
          Width = 78
          Height = 12
          Caption = 'QUESTION3_SUM'
        end
        object Label15: TLabel
          Left = 20
          Top = 156
          Width = 39
          Height = 12
          Caption = #20854#23427#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object QUESTION4_SUM: TLabel
          Left = 57
          Top = 155
          Width = 78
          Height = 12
          Caption = 'QUESTION4_SUM'
        end
      end
    end
    object RzPanel10: TRzPanel
      Left = 0
      Top = 0
      Width = 706
      Height = 19
      Align = alTop
      BorderOuter = fsNone
      BorderSides = []
      BorderColor = 16765589
      BorderWidth = 1
      Color = 16182753
      TabOrder = 1
      DesignSize = (
        706
        19)
      object Image2: TImage
        Left = 135
        Top = 3
        Width = 21
        Height = 23
      end
      object Image3: TImage
        Left = 156
        Top = 5
        Width = 553
        Height = 14
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentShowHint = False
        ShowHint = False
        Stretch = True
      end
    end
    object RzPanel1: TRzPanel
      Left = 142
      Top = 19
      Width = 564
      Height = 458
      Align = alClient
      BorderOuter = fsNone
      Color = clWhite
      TabOrder = 2
      object RzPanel6: TRzPanel
        Left = 0
        Top = 0
        Width = 564
        Height = 413
        Align = alClient
        BevelWidth = 2
        BorderOuter = fsNone
        BorderSides = [sdLeft]
        BorderColor = clWhite
        BorderShadow = clWhite
        BorderWidth = 5
        Color = clWhite
        TabOrder = 0
        object RzPage: TRzPageControl
          Left = 5
          Top = 5
          Width = 554
          Height = 403
          ActivePage = TabTittle
          Align = alClient
          FlatColor = clWhite
          ShowCardFrame = False
          TabColors.Shadow = clWhite
          TabIndex = 1
          TabOrder = 0
          TabStyle = tsDoubleSlant
          TextColors.DisabledShadow = clBtnHighlight
          UseGradients = False
          FixedDimension = 18
          object TabSheet1: TRzTabSheet
            Color = clWhite
            Caption = 'TabQuestionList'
            object RzPanel5: TRzPanel
              Left = 0
              Top = 0
              Width = 554
              Height = 385
              Align = alClient
              BorderOuter = fsNone
              BorderColor = clWhite
              Color = 16119285
              TabOrder = 0
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 554
                Height = 385
                Align = alClient
                AllowedOperations = []
                AutoFitColWidths = True
                BorderStyle = bsNone
                DataSource = dsQuestionList
                FixedColor = clAqua
                Flat = True
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Options = [dgTitles, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                ParentFont = False
                RowHeight = 20
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 10
                TitleLines = 1
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnCellClick = DBGridEh1CellClick
                OnDblClick = DBGridEh1DblClick
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'QUESTION_TITLE'
                    Footers = <>
                    ReadOnly = True
                    Title.Alignment = taCenter
                    Title.Caption = #38382#21367#26631#39064
                    Title.Color = clWhite
                    Width = 290
                  end
                  item
                    EditButtons = <>
                    FieldName = 'QUESTION_SOURCE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #38382#21367#26469#28304
                    Title.Color = clWhite
                    Width = 120
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'ISSUE_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21457#24067#26085#26399
                    Title.Color = clWhite
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ANSWER'
                    Footers = <>
                    ReadOnly = True
                    Title.Alignment = taCenter
                    Title.Caption = #35814#24773
                    Title.Color = clWhite
                    Width = 60
                  end>
              end
            end
          end
          object TabTittle: TRzTabSheet
            Color = clWhite
            Caption = 'TabQuestion'
            object RzPanel7: TRzPanel
              Left = 0
              Top = 0
              Width = 554
              Height = 385
              Align = alClient
              BorderOuter = fsNone
              BorderColor = clWhite
              Color = clWhite
              TabOrder = 0
              object RzPanel8: TRzPanel
                Left = 0
                Top = 0
                Width = 554
                Height = 121
                Align = alTop
                BevelWidth = 20
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 40
                Color = clWhite
                TabOrder = 0
                object labQUESTION_TITLE: TLabel
                  Left = 40
                  Top = 40
                  Width = 504
                  Height = 41
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'QUESTION_TITLE'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -29
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                end
              end
              object RzPanel15: TRzPanel
                Left = 0
                Top = 121
                Width = 554
                Height = 16
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 1
                object RzPanel16: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 12
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object Label8: TLabel
                    Left = 230
                    Top = 0
                    Width = 65
                    Height = 12
                    Align = alRight
                    Alignment = taRightJustify
                    Caption = #38382#21367#31867#22411#65306
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                end
                object RzPanel17: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 12
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                  object labQUESTION_CLASS: TLabel
                    Left = 0
                    Top = 0
                    Width = 84
                    Height = 12
                    Align = alLeft
                    Caption = 'QUESTION_CLASS'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                end
              end
              object RzPanel18: TRzPanel
                Left = 0
                Top = 137
                Width = 554
                Height = 16
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 2
                object RzPanel19: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 12
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object Label2: TLabel
                    Left = 230
                    Top = 0
                    Width = 65
                    Height = 12
                    Align = alRight
                    Caption = #38382#21367#26469#28304#65306
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                end
                object RzPanel20: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 12
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                  object labQUESTION_SOURCE: TLabel
                    Left = 0
                    Top = 0
                    Width = 90
                    Height = 12
                    Align = alLeft
                    Caption = 'QUESTION_SOURCE'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                end
              end
              object RzPanel21: TRzPanel
                Left = 0
                Top = 153
                Width = 554
                Height = 16
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 3
                object RzPanel22: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 12
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object Label12: TLabel
                    Left = 230
                    Top = 0
                    Width = 65
                    Height = 12
                    Align = alRight
                    Caption = #21457#24067#26085#26399#65306
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                end
                object RzPanel23: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 12
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                  object labISSUE_DATE: TLabel
                    Left = 0
                    Top = 0
                    Width = 60
                    Height = 12
                    Align = alLeft
                    Caption = 'ISSUE_DATE'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                end
              end
              object RzPanel24: TRzPanel
                Left = 0
                Top = 169
                Width = 554
                Height = 16
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 4
                object RzPanel25: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 12
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object Label14: TLabel
                    Left = 230
                    Top = 0
                    Width = 65
                    Height = 12
                    Align = alRight
                    Caption = #32467#26463#26085#26399#65306
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                end
                object RzPanel26: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 12
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                  object labEND_DATE: TLabel
                    Left = 0
                    Top = 0
                    Width = 48
                    Height = 12
                    Align = alLeft
                    Caption = 'END_DATE'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                end
              end
              object RzPanel27: TRzPanel
                Left = 0
                Top = 185
                Width = 554
                Height = 16
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 5
                object RzPanel28: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 12
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object Label6: TLabel
                    Left = 230
                    Top = 0
                    Width = 65
                    Height = 12
                    Align = alRight
                    Caption = #20849#35745#31572#39064#65306
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                end
                object RzPanel29: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 12
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                  object labQUESTION_ITEM_AMT: TLabel
                    Left = 0
                    Top = 0
                    Width = 102
                    Height = 12
                    Align = alLeft
                    Caption = 'QUESTION_ITEM_AMT'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                  end
                end
              end
              object RzPanel30: TRzPanel
                Left = 0
                Top = 211
                Width = 554
                Height = 135
                Align = alClient
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderSides = [sdTop]
                BorderColor = clWhite
                BorderWidth = 20
                Color = clWhite
                TabOrder = 6
                object RzPanel32: TRzPanel
                  Left = 137
                  Top = 20
                  Width = 294
                  Height = 95
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                  object labREMARK: TLabel
                    Left = 0
                    Top = 0
                    Width = 294
                    Height = 95
                    Align = alClient
                    Caption = 'REMARK'
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsUnderline]
                    ParentFont = False
                    WordWrap = True
                  end
                end
                object RzPanel33: TRzPanel
                  Left = 431
                  Top = 20
                  Width = 103
                  Height = 95
                  Align = alRight
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                end
                object RzPanel31: TRzPanel
                  Left = 20
                  Top = 20
                  Width = 117
                  Height = 95
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 2
                end
              end
              object RzPanel11: TRzPanel
                Left = 0
                Top = 201
                Width = 554
                Height = 10
                Align = alTop
                AlignmentVertical = avTop
                BorderOuter = fsNone
                BorderColor = clWhite
                BorderWidth = 2
                Color = clWhite
                TabOrder = 7
                object RzPanel13: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 295
                  Height = 6
                  Align = alLeft
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 0
                end
                object RzPanel14: TRzPanel
                  Left = 297
                  Top = 2
                  Width = 255
                  Height = 6
                  Align = alClient
                  BorderOuter = fsNone
                  Color = clWhite
                  TabOrder = 1
                end
              end
              object RzPanel34: TRzPanel
                Left = 0
                Top = 346
                Width = 554
                Height = 39
                Align = alBottom
                BorderOuter = fsNone
                Color = clWhite
                TabOrder = 8
                DesignSize = (
                  554
                  39)
                object btnReturn: TRzBmpButton
                  Left = 210
                  Top = 10
                  Width = 69
                  Height = 21
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  TabOrder = 1
                  OnClick = btnReturnClick
                end
                object btnLook: TRzBmpButton
                  Left = 325
                  Top = 10
                  Width = 69
                  Height = 21
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  TabOrder = 2
                  OnClick = btnLookClick
                end
                object btnAnswer: TRzBmpButton
                  Left = 325
                  Top = 10
                  Width = 69
                  Height = 21
                  Bitmaps.TransparentColor = clOlive
                  Color = clBtnHighlight
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  TabOrder = 0
                  OnClick = btnAnswerClick
                end
              end
            end
          end
          object TabContents: TRzTabSheet
            Color = clWhite
            Caption = 'TabAnswer'
            object RzPanel4: TRzPanel
              Left = 0
              Top = 0
              Width = 554
              Height = 385
              Align = alClient
              BorderInner = fsGroove
              BorderOuter = fsNone
              BorderColor = clWhite
              Color = clWhite
              TabOrder = 0
              object WebBrowser1: TWebBrowser
                Left = 2
                Top = 2
                Width = 550
                Height = 381
                Align = alClient
                DragMode = dmAutomatic
                TabOrder = 0
                OnDownloadComplete = WebBrowser1DownloadComplete
                ControlData = {
                  4C000000D8380000612700000000000000000000000000000000000000000000
                  000000004C000000000000000000000001000000E0D057007335CF11AE690800
                  2B2E126208000000000000004C0000000114020000000000C000000000000046
                  8000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000100000000000000000000000000000000000000}
              end
            end
          end
        end
      end
      object RzPanel3: TRzPanel
        Left = 0
        Top = 413
        Width = 564
        Height = 45
        Align = alBottom
        BorderOuter = fsNone
        BorderSides = [sdTop]
        BorderColor = 16765589
        BorderWidth = 1
        Color = 16182753
        TabOrder = 1
        DesignSize = (
          564
          45)
        object Label1: TLabel
          Left = 11
          Top = 20
          Width = 36
          Height = 12
          Caption = #24403#21069#31532
        end
        object labCURRENT: TLabel
          Left = 47
          Top = 20
          Width = 30
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Caption = '0'
          Font.Charset = GB2312_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 79
          Top = 20
          Width = 42
          Height = 12
          Caption = #39064'/'#24050#31572
        end
        object labALREADY: TLabel
          Left = 121
          Top = 20
          Width = 30
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Caption = '0'
          Font.Charset = GB2312_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 153
          Top = 20
          Width = 42
          Height = 12
          Caption = #39064'/'#20849#35745
        end
        object labSUM: TLabel
          Left = 196
          Top = 20
          Width = 30
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Caption = '0'
          Font.Charset = GB2312_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 227
          Top = 20
          Width = 12
          Height = 12
          Caption = #39064
        end
        object btnPrevious: TRzBmpButton
          Left = 319
          Top = 14
          Width = 69
          Height = 21
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Anchors = [akRight, akBottom]
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          OnClick = btnPreviousClick
        end
        object btnNext: TRzBmpButton
          Left = 399
          Top = 14
          Width = 69
          Height = 21
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Anchors = [akRight, akBottom]
          TabOrder = 1
          OnClick = btnNextClick
        end
        object btnRetrun_Main: TRzBmpButton
          Left = 479
          Top = 14
          Width = 69
          Height = 21
          Bitmaps.Hot.Data = {
            46110000424D4611000000000000360000002800000045000000150000000100
            18000000000010110000120B0000120B00000000000000000000FEDBACE6C79E
            D6A25ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D6A25EE6C79EFEDAA900E7C9A2E6B65AFCD562FEDA63FEDA63FEDA63FEDA63FE
            DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
            FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
            63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FE
            DA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63
            FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA63FEDA
            63FEDA63FEDA63FEDA63FEDA63FEDA63FCD562E6B65AE6C79E00D6A25EFCD25D
            FDEAB5FEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF0CEFEF1
            D2FEF1D2FEF1D2FEF1D2FEF1D2FEF1D1FEF0D0F9EDC2F8EABCF7E8B6F8E8B7F8
            E8B6F8EABAF8EABAFAEBC0F9EEC5FDEEC9FCEDC8FDF0CDFDF1D0FDF1D0FDF1D0
            FDF1D0FDF1D1FDF2D2FEF3D6FEF4D7FEF3D5FEF3D5FEF1D2FAF2CDFAF2CAFAF2
            CAF9EEC5FCF2C2FCF2C2FCF2BDFAF2BCFAF2BCFAF2BCFAEDB5F9E9B1F9E9B1F8
            E6AFF8E6AFF6E5AAF9E6ABF6E5AAF6E5AAF6E5AAF5E2A6F5E2A6F5E2A6F5E2A6
            F3DE93FCD25DD6A25E00D2994EFCD25DFDEAC1FCDE9CFCDE9CFCDE9CFCDE9CFC
            DE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CFCDE9CF9DB95F4D78C
            F3D585F3D482F3D37FF4D480F4D27FF4D27DF4D27EF5D280F4D482F5D686F7D6
            88F6D789F7D88BF9D88DF9D88DF9D78CF9D78BF9D78CFAD98FFBDB95FCDD99FA
            DE99FADE99FADE99FAE19AFAE19AFAE19AF9E69BF9E69BF9E69BF9E99DF9E99D
            F9E595F9DB87F6D884F6D884F6D884F5D683F5D683F5D683F5D683F5D683F3D5
            81F3D581F3D581F3D581F2D47FF1D37EF2DD9AFCD25DD2994E00D2994EFDCF57
            FDE6B8FAD991FBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD78CFBD7
            8CF9D686F5D47FF2D179F2D179F2D178F2CF76F2CE73F3CD72F3CC70F3CC70F3
            CC6FF3CC70F3CC70F4CE72F5CF74F4CF75F5CF75F5CF76F5CF76F5CD74F5CD73
            F5CC72F6CD73F7CF78F8D280FAD484FAD585F9D586FAD689F9DB8BF9DB8CF9DE
            8BF9E291F9E391F8E292F8E393F8DA86F6D57AF6D57AF6D279F6D279F6D279F4
            D177F4D177F4D177F4D177F2D076F2D076F2D076F2CE73F2CE73F2CD72F2D076
            F3DA95FDCF57D2994E00D2994EFCCB54FCE4B2FAD386FAD181FAD181FAD181FA
            D181FAD181FAD181FAD181F6CF7AF4CD72F3CC6FF3CC6FF2CD72F2CD72F2CD71
            8E7842F1CA6CF3C96AF2C86B61512B61502B61512B61512C61512B62512B6151
            2CF3CB6EF4CC6FF4CB6FF3C96EF3CA6DF3C96DF3C96DF4CB70F5CC72F6CD73F7
            CE76F6CE78F7D482F7D589635636F7D888F6D785F6D982F7D782F5D077F4CE72
            F4CF72F4CF72907A43F4CE71F4CE71F4CE71F5CD70F3CC6FF3CC6FF3CC6FF2CB
            6DF2CB6DF1CA6BF1CA6BF1CA6BF2CB6DF3DA95FCCB54D2994E00D2994EFCCB54
            FDE3B0FAD181FACE7BFACE7BFACE7BFACF7CF9CE7AF6CB72F3C86BF1C96AF3CA
            6BF3CA6BF2CB6DF2CB6DF3CC6FF3CC6EF3CA6C3E331BF3C8692F2714F3C96BF3
            CB6DF3CB6CF3CA6CF3C96AF3C96BF3C96BF4CA6CF4C96CF3CA6DF3CB6EF3CB6D
            F3CA6CF3C96BF3C96BF4CA6CF4CA6EF4CB70F4CD72F4CE75F6D68E483F29483D
            27483C21473C20473C20483C21483C214A3E225647277F6A39F5CC6EF4CA6CF4
            CA6CF3CA6BF4C96BF3CA6BF3C869F3C869F1C868F1C866F1C866F1C866F1CA6B
            F8E0A5FCCB54D2994E00D2994EFCC750FCE0ACFACD7BFACC76FACC76F9CB72F4
            C96BF1C765F1C765F3C766F1C868F1C868F3C869F3C869F3CA6BF4CA6CF4CA6C
            F3C86AF3C869211B0EF4C86AF3CA6B211B0EF4CA6CF3C86AF3C869201B0EF3C9
            6BF4CA6CF4C96CF4CA6CF4CA6CF4CA6CF3C86AF3C869F3C869F4C86AF3CA6DF3
            CA6EF4CB6FF4CA6DF3C96C3B311AF3CA6EF4C86BF3C96AF3C96AF4CA6CF4CA6C
            F4CA6CF5CB6D756133F5CA69F4C968F4C968F3C866F3C866F3C866F2C665F2C6
            65F2C564F1C663F1C663F1C563F6CB72FBDDA5FCC750D2994E00D2994EFCC750
            FCE0ACFACD78F9C86EF3C766F1C563F1C563F2C564F2C665F2C665F3C766F3C7
            68F3C869F3C869F4C96BF4C96BF4CA6BF4C96BF4C96B211B0E1F190DF4C96BF4
            C96B1F190DF4C96B1F190DF4C96BF4C96BF5CA6EF4CA6CF5CA6DF4C96CF4CA6B
            F4C96BF4C96BF4CA6CF4C96CF4CA6CF4C96BF4C96CF4CA6BF4C96B392F19F4CA
            6D1F190DF4C96BF4C96BF4C96B1F190EF5CB6DF5CA6B745F31F3C867F5C766F4
            C665F3C663F3C663F3C663F3C563F2C461F2C461F1C460F1C35FF6C768F9CA74
            FBDDA5FCC750D2994E00D2994EFCC750FBDDA5F3C86BF1C563F3C563F2C564F2
            C564F2C665F3C766F3C766F3C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6D
            F4CA6CF4C96B211B0FF5CA6C1F190EF4CA6CF5CB6D1F190EF4C96BF4CA6CF4CA
            6DF5CB6FF5CB6EF4CB6EF4CA6CF5CB6DF4CA6CF4C96BF4CA6DF5CB6DF5CA6DF4
            CA6DF4CA6DF5CB6DF4CA6C392F19F4CA6E3A301A3A301A39301A3930193A301A
            F5CB6DF6CA6D745F32F5C767F4C564F4C564F4C564F3C563F3C563F2C461F1C4
            60F1C35FF1C35FF4C564F9C86EF9CA74FBDDA5FCC750D2994E00D2994EFCC750
            F3D68FF3C768F2C564F2C665F2C665F3C766F3C768F3C768F3C869F3C869F4C9
            6BF4CA6CF4CA6CF5CB6EF5CB6EF6CC71F5CD72F5CE76211C10F5CE771F1A0FF5
            CC721F1A0EF5CE741F1A0FF5CF79F5CF7AF6D07BF6CF7AF5CE76F5CC72F6CD72
            F5CD73F5CE77F5D078F5D079F6D17DF5CE76F5CE74F6CC73F5CD723A301CF5D1
            7B3A311CF5CE78F5CD74F5CC6F3A301AF6CC71F6CB6E745F32F4C766F4C665F4
            C564F3C563F3C563F2C461F2C461F1C460F1C360F2C461F9C86EF9C86EF9CA74
            FBDDA5FCC750D2994E00D2994EFCC750F3D691F3C768F2C665F3C766F3C766F3
            C768F3C869F3C869F4C96BF4CA6CF4CA6CF5CB6EF5CC6EF6CC70F6CD72F6CE73
            62522E2F2716211B0FF5CE741F1A0FF6CF75F6CE75F6CE75F6CF751F1A10F6CE
            75F6CF77F7CF76F7CE74F6CD74F6CE74F6CD74F6CF77F6CD74F6CE74F7CE74F7
            D07AF7D07BF6CE75F7CE753A301DF7D3813A301BF6CD72F6CD70F6CB703A301A
            F6CB6EF6CA6D745F32F4C666F4C564F4C564F3C563F2C461F2C461F2C461F1C3
            60F1C460F8C76CF9C86EFAC86FF9CA74FBDDA5FCC750D2994E00D2994EFCD25D
            F5E2A6F4D78CF5D789F4D78CF4D78CF7D88DF7D88DF6D990F6D990F6D990F7DB
            93F7DB93F7DB93F9DB95F9DB95F9DD97F9DD96F8DC96F8DB94F8DC951F1C131F
            1C131F1C131F1C131F1C131F1C13F8DC96F8DC95FADC97F9DC95F8DB95F8DC96
            F8DC95F8DD9CFAE0A0F9DFA1F8DE9CF8DE9AF8DD9AF9DF9FFAE1A53B3425FAE2
            A83B34233B34233A34233A33223A3322F8D990F8D990746642F5D789F5D789F5
            D789F4D486F4D486F4D486F3D384F3D384FAD991FBDB99FBDB99FBDB99FADE9E
            FDE9C1FCD25DD2994E00D2994EFCD25DF5E3AFF5DA93F5DA93F5DA93F6DA95F6
            DC96F6DC96F6DC96F7DD9AF7DD9AF7DD9AF7DD9AF7DD9AF9E19DF9E19DF9E19D
            F9E19DF9E29F221F16F7DE9B211E15F7DD9BF9E19EF8E09DF8DE9BF7DE9BF7DE
            9BF7DD9BF9E19EF8E09DF8DE9BF7DE9BF7DE9BF7DE9CF9E19EF8E09DF8DE9BF7
            DE9AF7DE9CF7DD9AF9E19E3D3727F9E3A4F9E19EFAE39FFAE19DF9DD99F7DC95
            F7DB94F6DA91766845F6D990F6D990F6D990F3D68FF4D78CF3D68BF3D68BF6DA
            95FBDEA1FBDEA1FBDEA1FCDEA3FCDFA6FDEBC5FCD25DD2994E00D2994EFCD562
            F7E5B4F6DE9DF6DE9DF7DD9AF6DE9DF6DE9DF9E19DF9E2A2F9E2A2F9E2A2F9E2
            A2F9E2A2FBE4A4FBE4A4FAE6A6FBE4A4FAE6A6FAE5A5322E21F9E3A3302B1F30
            2C20302C20FAE5A5FAE3A3F9E2A2F9E2A2FBE4A4FBE4A4FAE5A5FAE3A3F9E2A2
            F9E2A2FBE4A4FBE4A4FAE5A5FAE3A3F9E2A2F9E2A2FBE4A4FBE4A44A4431FBE4
            A5FAE6A6FAE5A5FBE5A6FAE1A1F7DE9BF7DD9AF7DD9A807250F6DB98F6DB98F6
            DA95F6DA95F3DA95F5DA93F7DD9AFDE2ADFDE2ADFDE2ADFDE2ADFDE2ADFDE3B0
            FEEECDFCD562D2994E00D2994EFED966F9EAB9F5E2A6F8E0A5F8E3A9F8E3A9F8
            E3A9F8E3A9F9E6ABF9E6ABF9E6ABF9E6ABFAE8ADFAE8ADFAE8ADFAE8ADFBEBB0
            FBEBB06F674DFAE8ADF9E6ABFAE8ADFAE8ADFAE8AD645C45645D45645C44FAE8
            ADFAE8ADFAE8ADFAE7ACFAE8ADF9E6ABFAE8ADFAE8ADFAE8ADFAE7ACFAE8ADF9
            E6ABFAE8ADFAE8ADFAE8AD776E52777054777054776F53776E53766C50766B4F
            776B4F7E73539D8F68F6DFA2F6DFA2F6DE9DF6DE9DF6DE9DF6DE9DFCE6B5FDE6
            B8FDE6B8FDE6B8FDE6B8FDE6B8FDE8BBFEF1D2FED966D2994E00D2994EFED966
            F8EBC0F8E6AFF8E6AFF8E6AFF9E6B1F9E9B1F9E9B1F9E9B1F9E9B1FBEBB4FBEB
            B4FBEBB4FBEBB4FCEDB5FCEDB5FCEDB5FCEDB5FBECB4FCEDB5FBECB4FBEBB4FB
            EBB4FCEDB5FBEDB8FBECB4FBEBB4FBEBB4FBEBB4FCEEB9FBECB5FBECB5FBEBB4
            FBEBB4FBEBB4FCEEB9FBECB5FBECB6FBEBB5FBEBB5FBECB6FCEEB9FCEEBBFCEE
            BBFCECB6FCECB4FCECB4F9E9B1F8E4AEF8E3ADF8E3ADF8E3A9F8E3A9F8E3A9F5
            E2A6F5E2A6F5E2A6F9E7B9FEEAC1FEEAC1FEEAC2FEEAC2FEEAC2FEEAC2FDEBC5
            FEF4D8FED966D2994E00D2994EFBD96BF9EEC5F9EAB9F9EAB9F9EAB9FAECBBFA
            ECBBFAECBBFAECBBFBEEBCFBEEBCFBEEBCFBEEBCFBEEBCFDF0BAFCF2BDFCF2BD
            FCF2BDFCF1BDFCF0BDFBEFBCFBEFBCFBEFBCFDF1BBFCF1BEFCF0BEFBEFBDFBEF
            BDFCEEBFFDEFBFFDF0C1FCF0C0FCEFBFFCEFBFFCEFBFFDF0BFFDF0C1FCF0C0FC
            EFBFFBEFBFFBEFC0FDF0BFFCF1C2FCF1C1FCF1C1FBEEBDFAEDBDFAE9BAF9E8B9
            F9E7B9F7E5B4F7E5B4F7E5B4F7E5B4F5E3AFF5E3AFF9E8BDFEEECFFEEECFFEEE
            CFFEEECFFEEECFFEEECFFEEECFFEEECFFDF5E0FBD96BD2994E00D6A25EFBD96B
            FAEDB5FAF2CAFAF2CDFAF2CDFAF2CDFBF5CEFBF5CEFBF5CEFBF5CEFBF6D1FBF6
            D1FBF6D1FBF6D1FCF7D1FCF7D1FDF9D3FDF9D3FCF7D1FDF8D3FCF8D2FCF8D2FC
            F8D2FDF8D2FDF8D6FDF6DAFCF7DBFCF7DCFDF8DFFDF8E1FDF8E2FDF8E1FDF8DF
            FCF7DFFDF8E0FDF8E2FDF8E2FDF8E1FDF8DFFCF7DDFDF8DFFDF7DFFDF6DEFDF6
            DCFDF6DCFBF4D8FBF4D9F9F3D6F9F2D6F9F2D6F8F0D2F8F0D2F7EFD0F7EECCF7
            EECCF8EFCEFEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7FEF7E7
            FEF1CAFBD96BD6A25E00E7C9A2E6B65AFBD96BFFDF70FFDF70FFDF70FFDF70FF
            DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
            FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
            70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FF
            DF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70
            FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF70FFDF
            70FFDF70FFDF70FFDF70FFDF70FFDF70FBD96BE6B65AE7C9A200FFDBAAE7C9A2
            D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D7A461E7C9A2FFDCAB00}
          Bitmaps.TransparentColor = clOlive
          Bitmaps.Up.Data = {
            46110000424D4611000000000000360000002800000045000000150000000100
            1800000000001011000000000000000000000000000000000000FEDBACE6C79D
            D6A35FD2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D6A35FE6C79DFEDAA900E7C9A1E4BD8DF8E4D1FCECDFFCECDFFCECDFFCECDFFC
            ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
            FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
            DFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFC
            ECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDF
            FCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCECDFFCEC
            DFFCECDFFCECDFFCECDFFCECDFFCECDFF8E4D1E4BD8DE7C89F00D6A15DF6E1CC
            F8E3D0F7DEC8F7DEC8F7DFC9F7DFC9F8DFCAF8DFCAF8E0CBF8E0CBF8E0CCF8E1
            CCF8E1CDF8E2CEF8E2CEF8E2CFF8E3D0F8E3D0F9E4D0F9E4D1F9E4D1F9E5D2F9
            E5D2F9E5D3F9E6D4F9E6D3F9E6D3F9E5D4F9E6D4F9E6D6F9E6D6F9E6D6F9E6D6
            F9E7D5F9E6D5F9E6D5F9E6D5F9E6D5F9E6D5F9E6D5F9E6D5F9E6D4F9E6D4F9E6
            D4F9E5D4F9E5D3F9E4D3F9E4D2F9E4D1F8E3D1F8E3D0F8E2CFF8E2CEF8E2CEF8
            E1CDF8E1CCF8E0CCF8E0CBF8E0CBF8E0CAF8DFCAF7DFC9F7DFC9F7DEC8F7DEC8
            F8E3D0F6E1CCD6A15D00D2994EF7E3D0F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
            D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
            F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
            BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4
            D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BC
            F4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7
            BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF4D7BCF7E3D0D2994E00D2994EF6E0CB
            F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
            B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
            D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
            F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2
            B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2
            D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4F2D2B4
            F2D2B4F6E0CBD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            8E7B69F2D1B3F2D1B3F2D2B46154486154486154486154486154486154486154
            48F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3615448F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B38E7B69F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B33E352EF2D1B32F2822F2D1B4F2
            D1B4F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3473D35473D
            35473D35473D35473D35473D35473D35493F3654493E7D6C5DF2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3211D19F2D1B3F2D1B3201C18F2D1B3F2D1B3F2D1B3201C18F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B33B332CF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3746456F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3201C181E1A16F2D1B3F2
            D1B31E1A16F2D1B31E1A16F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B339312AF2D1
            B31E1A16F2D1B3F2D1B3F2D1B31E1A16F2D1B3F2D1B3736355F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3201C18F2D1B31E1A16F2D1B3F2D1B31E1A16F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B339312AF2D1B339312A39312A39312A39312A39312A
            F2D1B3F2D1B3736355F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EF6DFCA
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3201C18F2D2B41E1B17F3
            D4B81E1B17F2D2B41E1A16F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B339312AF2D1
            B339312AF2D1B3F2D1B3F2D1B339312AF2D1B3F2D1B3736355F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            F2D1B3F6DFCAD2994E00D2994EF6DFCAF2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2
            D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3
            6154482F2822201C18F3D3B61E1A17F2D3B6F2D2B5F2D2B4F2D1B31E1A16F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D2B4F2D1B3F2D1B3F2D1B3F2
            D1B4F2D2B4F2D1B3F2D1B439312AF3D3B739312AF2D1B3F2D1B3F2D1B339312A
            F2D1B3F2D1B3736355F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1
            B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F2D1B3F6DFCAD2994E00D2994EFCE9D9
            FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0
            C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C81F1C191F
            1C191F1C191F1C191F1C19201C19FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8
            FBE0C8FBE1C9FBE1C9FBE1C9FBE1C9FBE0C9FBE0C9FBE1C9FBE1CA3B352FFBE1
            CB3B352F3B352F3B352F3B352F3B352FFBE0C8FBE0C8776A5FFBE0C8FBE0C8FB
            E0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8FBE0C8
            FBE0C8FCE9D9D2994E00D2994EFDEBDBFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFC
            E3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
            FCE3CCFCE3CC231F1CFCE3CC221E1BFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3
            CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFC
            E3CCFCE3CCFCE3CCFCE3CC3D3732FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CC
            FCE3CCFCE3CC796D62FCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3
            CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFCE3CCFDEBDBD2994E00D2994EFDEEDE
            FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6
            D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0322E2AFCE6D0302C2830
            2C28302C28FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0
            FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D04A443DFCE6
            D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D082776CFCE6D0FCE6D0FC
            E6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0FCE6D0
            FCE6D0FDEEDED2994E00D2994EFEEFE2FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FD
            E8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5
            FDE8D570675EFDE8D5FDE8D5FDE8D5FDE8D5FDE8D5655D55655D55655D55FDE8
            D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FD
            E8D5FDE8D5FDE8D5FDE8D5786E65786E65786E65786E65786E65786E65786E65
            796F6682776DA29488FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8
            D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FDE8D5FEEFE2D2994E00D2994EFEF1E5
            FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEB
            DAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFE
            EBDAFEEBDAFEECDBFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDA
            FEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDBFEEBDBFEEB
            DBFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFE
            EBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDAFEEBDA
            FEEBDAFEF1E5D2994E00D2994EFEF3E8FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFE
            EEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDE
            FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEE
            DEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFE
            EEDEFEEEDEFEEEDEFEEEDFFEEEDFFEEEDFFEEEDFFEEEDEFEEEDEFEEEDEFEEEDE
            FEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEE
            DEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEEEDEFEF3E8D2994E00D6A15DFBEDDE
            FFF3E7FFF1E3FFF1E3FFF2E3FFF2E3FFF2E4FFF2E4FFF2E4FFF2E4FFF2E5FFF2
            E5FFF3E5FFF3E6FFF3E6FFF3E6FFF3E6FFF3E6FFF3E6FFF3E7FFF3E7FFF3E7FF
            F3E8FFF4E8FFF4E8FFF4E8FFF4E8FFF3E8FFF3E7FFF4E7FFF4E8FFF4E9FFF4E9
            FFF4E8FFF4E8FFF3E8FFF3E7FFF3E8FFF3E7FFF4E8FFF4E8FFF4E8FFF4E9FFF4
            E8FFF4E8FFF4E8FFF4E8FFF4E8FFF4E8FFF4E7FFF3E7FFF3E7FFF3E6FFF3E6FF
            F3E6FFF3E5FFF2E5FFF2E5FFF2E4FFF2E4FFF2E4FFF2E4FFF2E3FFF2E3FFF1E3
            FFF3E7FBEDDED6A15D00E7C9A1E6C59BFAF4ECFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4ECE6C59BE7C9A100FFDBAAE8CAA3
            D7A461D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED299
            4ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2
            994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994ED2994E
            D7A461E8CAA3FFDCAB00}
          Color = clBtnHighlight
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 3
          OnClick = btnRetrun_MainClick
        end
        object btnCommit: TRzBmpButton
          Left = 479
          Top = 14
          Width = 69
          Height = 21
          Bitmaps.TransparentColor = clOlive
          Color = clBtnHighlight
          Anchors = [akRight, akBottom]
          TabOrder = 2
          OnClick = btnCommitClick
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 5
    Top = 444
  end
  inherited actList: TActionList
    Left = 71
    Top = 415
  end
  object cdsQuestion: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 70
    Top = 444
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 5
    Top = 415
  end
  object cdsAnswer: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 102
    Top = 444
  end
  object cdsListAnswer: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 102
    Top = 412
  end
  object cdsQuestionList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 38
    Top = 444
  end
  object dsQuestionList: TDataSource
    DataSet = cdsQuestionList
    Left = 38
    Top = 412
  end
end
