inherited frmCustomerInfo: TfrmCustomerInfo
  Left = 476
  Top = 171
  Caption = #20250#21592#26723#26696
  ClientHeight = 414
  ClientWidth = 530
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 530
    Height = 414
    BorderColor = clWhite
    Color = clWhite
    object labCUST_CODE: TRzLabel [0]
      Left = 0
      Top = 13
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20250#21592#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel1: TRzLabel [1]
      Left = 100
      Top = 12
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labCUST_NAME: TRzLabel [2]
      Left = 0
      Top = 37
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20250#21592#22995#21517
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel [3]
      Left = 100
      Top = 36
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labCUST_SPELL: TRzLabel [4]
      Left = 228
      Top = 37
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25340#38899#30721
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel4: TRzLabel [5]
      Left = 328
      Top = 36
      Width = 6
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labIC_CARDNO: TRzLabel [6]
      Left = 228
      Top = 13
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20250#21592#21345#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzLabel5: TRzLabel [7]
      Left = -1
      Top = 58
      Width = 100
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24615#21035
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited RzPage: TRzPageControl
      Top = 162
      Width = 520
      Height = 212
      ActivePage = TabSheet6
      Align = alBottom
      TabIndex = 1
      OnChange = RzPageChange
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #35814#32454#20449#24687
        inherited RzPanel2: TRzPanel
          Width = 965
          Height = 479
          Align = alNone
          BorderColor = clWhite
          Color = clWhite
          object RzLabel18: TRzLabel
            Left = 2
            Top = 35
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35777#20214#21495#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel20: TRzLabel
            Left = 240
            Top = 103
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21487#29992#20313#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel21: TRzLabel
            Left = 240
            Top = 80
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24050#29992#31215#20998
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel24: TRzLabel
            Left = 2
            Top = 57
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20837#20250#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel27: TRzLabel
            Left = 2
            Top = 102
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26377#25928#25130#27490#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel28: TRzLabel
            Left = 2
            Top = 81
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32493#20250#26085#26399
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labHOMEPAGE: TRzLabel
            Left = 2
            Top = 127
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22791#27880
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labIDN_TYPE: TRzLabel
            Left = 2
            Top = 12
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #35777#20214#31867#22411
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel17: TRzLabel
            Left = 240
            Top = 58
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21487#29992#31215#20998
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel12: TRzLabel
            Left = 241
            Top = 34
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32047#35745#31215#20998
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object cmbID_NUMBER: TcxTextEdit
            Left = 109
            Top = 30
            Width = 122
            Height = 20
            Properties.OnChange = edtCUST_NAMEPropertiesChange
            TabOrder = 1
            OnKeyPress = cmbID_NUMBERKeyPress
          end
          object cmbBALANCE: TcxTextEdit
            Left = 347
            Top = 99
            Width = 121
            Height = 20
            Enabled = False
            Properties.OnChange = edtCUST_NAMEPropertiesChange
            TabOrder = 6
            OnKeyPress = cmbBALANCEKeyPress
          end
          object cmbRULE_INTEGRAL: TcxTextEdit
            Left = 347
            Top = 76
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 7
            OnKeyPress = cmbRULE_INTEGRALKeyPress
          end
          object cmbSND_DATE: TcxDateEdit
            Left = 109
            Top = 53
            Width = 121
            Height = 20
            TabOrder = 2
          end
          object cmbEND_DATE: TcxDateEdit
            Left = 109
            Top = 99
            Width = 121
            Height = 20
            TabOrder = 4
          end
          object cmbCON_DATE: TcxDateEdit
            Left = 109
            Top = 76
            Width = 121
            Height = 20
            TabOrder = 3
          end
          object cmbREMARK: TcxMemo
            Left = 109
            Top = 123
            Width = 360
            Height = 56
            TabOrder = 5
          end
          object edtIDN_TYPE: TcxComboBox
            Left = 109
            Top = 7
            Width = 121
            Height = 20
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 0
          end
          object cmbINTEGRAL: TcxTextEdit
            Left = 347
            Top = 53
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 8
            OnKeyPress = cmbINTEGRALKeyPress
          end
          object edtACCU_INTEGRAL: TcxTextEdit
            Left = 346
            Top = 30
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 9
          end
        end
      end
      object TabSheet6: TRzTabSheet
        Color = clWhite
        Caption = #32852#31995#20449#24687
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 516
          Height = 185
          Align = alClient
          BorderOuter = fsNone
          BorderColor = clWhite
          Color = clWhite
          TabOrder = 0
          object RzLabel19: TRzLabel
            Left = 241
            Top = 110
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #21150#20844#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labADDRESS: TRzLabel
            Left = 2
            Top = 156
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#22336
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel26: TRzLabel
            Left = 3
            Top = 16
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #22320#21306
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labPOSTALCODE: TRzLabel
            Left = 2
            Top = 133
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #37038#32534
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labTELEPHONE2: TRzLabel
            Left = 241
            Top = 40
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'QQ'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labMSN: TRzLabel
            Left = 241
            Top = 63
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'MSN'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labEMAIL: TRzLabel
            Left = 241
            Top = 86
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #30005#23376#37038#20214
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel31: TRzLabel
            Left = 241
            Top = 133
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23478#24237#30005#35805
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labDEGREES: TRzLabel
            Left = 2
            Top = 40
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #23398#21382
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel32: TRzLabel
            Left = 4
            Top = 86
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #26376#25910#20837
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labOCCUPATION: TRzLabel
            Left = 4
            Top = 63
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #32844#19994
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object labJOBUNIT: TRzLabel
            Left = 2
            Top = 110
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24037#20316#21333#20301
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object cmbOFFI_TELE: TcxTextEdit
            Left = 348
            Top = 106
            Width = 121
            Height = 20
            TabOrder = 9
            OnKeyPress = cmbOFFI_TELEKeyPress
          end
          object cmbFAMI_ADDR: TcxTextEdit
            Left = 109
            Top = 153
            Width = 360
            Height = 20
            TabOrder = 11
          end
          object edtREGION_ID: TzrComboBoxList
            Left = 109
            Top = 13
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 0
            InGrid = False
            KeyValue = Null
            FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
            KeyField = 'CODE_ID'
            ListField = 'CODE_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'CODE_ID'
                Footers = <>
                Title.Caption = #32534#30721
                Width = 40
              end>
            DropWidth = 176
            DropHeight = 130
            ShowTitle = True
            AutoFitColWidth = True
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            MultiSelect = False
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 109
            Top = 129
            Width = 121
            Height = 20
            TabOrder = 5
          end
          object edtQQ: TcxTextEdit
            Left = 348
            Top = 36
            Width = 121
            Height = 20
            TabOrder = 6
          end
          object edtMSN: TcxTextEdit
            Left = 348
            Top = 59
            Width = 121
            Height = 20
            TabOrder = 7
          end
          object edtEMAIL: TcxTextEdit
            Left = 348
            Top = 82
            Width = 121
            Height = 20
            TabOrder = 8
          end
          object edtFAMI_TELE: TcxTextEdit
            Left = 348
            Top = 129
            Width = 121
            Height = 20
            TabOrder = 10
          end
          object edtDEGREES: TcxComboBox
            Left = 109
            Top = 36
            Width = 121
            Height = 20
            TabOrder = 1
          end
          object edtMONTH_PAY: TcxComboBox
            Left = 109
            Top = 82
            Width = 121
            Height = 20
            TabOrder = 3
          end
          object edtOCCUPATION: TcxComboBox
            Left = 109
            Top = 59
            Width = 121
            Height = 20
            TabOrder = 2
          end
          object edtJOBUNIT: TcxTextEdit
            Left = 109
            Top = 106
            Width = 150
            Height = 20
            TabOrder = 4
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #28040#36153#35760#24405
        object DBGridEh2: TDBGridEh
          Left = 0
          Top = 0
          Width = 516
          Height = 185
          Align = alClient
          AllowedOperations = []
          DataSource = dsCustomerData
          FixedColor = clWhite
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          RowHeight = 20
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
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
              FieldName = 'SALES_DATE'
              Footers = <>
              Title.Caption = #26085#26399
              Width = 65
            end
            item
              EditButtons = <>
              FieldName = 'SALES_TYPE'
              Footers = <>
              Title.Caption = #31867#22411
              Width = 42
            end
            item
              EditButtons = <>
              FieldName = 'GODS_NAME'
              Footers = <>
              Title.Caption = #21830#21697#21517#31216
              Width = 119
            end
            item
              EditButtons = <>
              FieldName = 'COLORNAME'
              Footers = <>
              Title.Caption = #39068#33394
              Width = 42
            end
            item
              EditButtons = <>
              FieldName = 'SIZENAME'
              Footers = <>
              Title.Caption = #23610#30721
              Width = 34
            end
            item
              EditButtons = <>
              FieldName = 'AMOUNT'
              Footers = <>
              Title.Caption = #25968#37327
              Width = 48
            end
            item
              EditButtons = <>
              FieldName = 'UNIT_NAME'
              Footers = <>
              Title.Caption = #21333#20301
              Width = 24
            end
            item
              EditButtons = <>
              FieldName = 'APRICE'
              Footers = <>
              Title.Caption = #21333#20215
              Width = 46
            end
            item
              EditButtons = <>
              FieldName = 'AMONEY'
              Footers = <>
              Title.Caption = #37329#39069
              Width = 59
            end
            item
              EditButtons = <>
              FieldName = 'COMP_NAME'
              Footers = <>
              Title.Caption = #38376#24215#21517#31216
              Width = 114
            end>
        end
      end
      object TabSheet3: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #20817#25442#35760#24405
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 516
          Height = 185
          Align = alClient
          AllowedOperations = []
          AutoFitColWidths = True
          DataSource = dsGlide
          FixedColor = clWhite
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          RowHeight = 20
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
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
              FieldName = 'CREA_DATE'
              Footers = <>
              Title.Caption = #20817#25442#26085#26399
              Width = 69
            end
            item
              EditButtons = <>
              FieldName = 'INTEGRAL_FLAG'
              Footers = <>
              Title.Caption = #20817#25442#26041#24335
              Width = 79
            end
            item
              EditButtons = <>
              FieldName = 'FLAG_AMT'
              Footers = <>
              Title.Caption = #20817#25442#25968#37327
              Width = 61
            end
            item
              EditButtons = <>
              FieldName = 'INTEGRAL'
              Footers = <>
              Title.Caption = #23545#25442#31215#20998
              Width = 61
            end
            item
              EditButtons = <>
              FieldName = 'GLIDE_INFO'
              Footers = <>
              Title.Caption = #25688#35201#35828#26126
              Width = 247
            end>
        end
      end
      object TabSheet4: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #20805#20540#35760#24405
        object DBGridEh3: TDBGridEh
          Left = 0
          Top = 0
          Width = 516
          Height = 185
          Align = alClient
          AllowedOperations = []
          AutoFitColWidths = True
          DataSource = dsDeposit
          FixedColor = clWhite
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          RowHeight = 20
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
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
              FieldName = 'CREA_DATE'
              Footers = <>
              Title.Caption = #20805#20540#26085#26399
              Width = 69
            end
            item
              EditButtons = <>
              FieldName = 'IC_CARDNO'
              Footers = <>
              Title.Caption = #20805#20540#21345#21495
              Width = 74
            end
            item
              EditButtons = <>
              FieldName = 'IC_AMONEY'
              Footers = <>
              Title.Caption = #20805#20540#37329#39069
              Width = 61
            end
            item
              EditButtons = <>
              FieldName = 'PAY_CASH'
              Footers = <>
              Title.Caption = #29616#37329#25903#20184
              Width = 61
            end
            item
              EditButtons = <>
              FieldName = 'PAY_A'
              Footers = <>
              Title.Caption = #38134#32852#25903#20184
            end
            item
              EditButtons = <>
              FieldName = 'OPER_USER_TEXT'
              Footers = <>
              Title.Caption = #25805#20316#21592
              Width = 79
            end
            item
              EditButtons = <>
              FieldName = 'GLIDE_INFO'
              Footers = <>
              Title.Caption = #25688#35201
              Width = 118
            end>
        end
      end
      object TabSheet5: TRzTabSheet
        Color = clWhite
        TabVisible = False
        Caption = #32493#20250#35760#24405
        object DBGridEh4: TDBGridEh
          Left = 0
          Top = 0
          Width = 516
          Height = 185
          Align = alClient
          AllowedOperations = []
          DataSource = dsRenew
          FixedColor = clWhite
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          RowHeight = 20
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
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
              FieldName = 'CREA_DATE'
              Footers = <>
              Title.Caption = #32493#20250#26085#26399
              Width = 74
            end
            item
              EditButtons = <>
              FieldName = 'AMONEY'
              Footers = <>
              Title.Caption = #32493#20250#29616#37329
              Width = 54
            end
            item
              EditButtons = <>
              FieldName = 'PAY_A'
              Footers = <>
              Title.Caption = #32493#20250#38134#32852
              Width = 56
            end
            item
              EditButtons = <>
              FieldName = 'ACCU_INTEGRAL'
              Footers = <>
              Title.Caption = #24635#31215#20998
              Width = 59
            end
            item
              EditButtons = <>
              FieldName = 'INTEGRAL1'
              Footers = <>
              Title.Caption = #32493#21069#21487#29992#31215#20998
              Width = 52
            end
            item
              EditButtons = <>
              FieldName = 'INTEGRAL2'
              Footers = <>
              Title.Caption = #32493#21518#21487#29992#31215#20998
              Width = 59
            end
            item
              EditButtons = <>
              FieldName = 'END_DATE1'
              Footers = <>
              Title.Caption = #32493#21069#25130#27490#26085#26399
              Width = 63
            end
            item
              EditButtons = <>
              FieldName = 'END_DATE2'
              Footers = <>
              Title.Caption = #32493#21518#25130#27490#26085#26399
              Width = 63
            end
            item
              EditButtons = <>
              FieldName = 'OPER_USER_TEXT'
              Footers = <>
              Title.Alignment = taLeftJustify
              Title.Caption = #25805#20316#21592
              Width = 73
            end
            item
              EditButtons = <>
              FieldName = 'GLIDE_INFO'
              Footers = <>
              Title.Caption = #25688#35201
              Width = 121
            end>
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 374
      Width = 520
      Height = 35
      BorderColor = clWhite
      Color = clWhite
      DesignSize = (
        520
        35)
      object Btn_Save: TRzBitBtn
        Left = 348
        Top = 5
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
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
        OnClick = Btn_SaveClick
        NumGlyphs = 2
        Spacing = 5
      end
      object Btn_Close: TRzBitBtn
        Left = 439
        Top = 5
        Width = 67
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #20851#38381'(&C)'
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
        TabOrder = 1
        TextStyle = tsRaised
        ThemeAware = False
        OnClick = Btn_CloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 520
      Height = 157
      Align = alClient
      BorderOuter = fsNone
      BorderColor = clWhite
      BorderWidth = 5
      Color = clWhite
      TabOrder = 2
      object RzLabel6: TRzLabel
        Left = 7
        Top = 6
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20250#21592#32534#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel7: TRzLabel
        Left = 236
        Top = 5
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel8: TRzLabel
        Left = 7
        Top = 29
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20250#21592#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel9: TRzLabel
        Left = 236
        Top = 29
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel10: TRzLabel
        Left = 241
        Top = 30
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25340#38899#30721#13' '
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel13: TRzLabel
        Left = 7
        Top = 83
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #24615#21035
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel14: TRzLabel
        Left = 7
        Top = 52
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20250#21592#31561#32423
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel15: TRzLabel
        Left = 241
        Top = 84
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20250#21592#29983#26085
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel16: TRzLabel
        Left = 7
        Top = 113
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #31227#21160#30005#35805
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel3: TRzLabel
        Left = 471
        Top = 52
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel29: TRzLabel
        Left = 241
        Top = 52
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20250#21592#31867#21035
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel30: TRzLabel
        Left = 236
        Top = 52
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel22: TRzLabel
        Left = 241
        Top = 112
        Width = 100
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20837#20250#38376#24215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel11: TRzLabel
        Left = 471
        Top = 112
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel23: TRzLabel
        Left = 236
        Top = 112
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RzLabel25: TRzLabel
        Left = 471
        Top = 83
        Width = 6
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object cmbCUST_CODE: TcxTextEdit
        Left = 113
        Top = 1
        Width = 121
        Height = 20
        TabOrder = 0
      end
      object cmbCUST_NAME: TcxTextEdit
        Left = 113
        Top = 25
        Width = 121
        Height = 20
        Properties.OnChange = edtCUST_NAMEPropertiesChange
        TabOrder = 1
      end
      object cmbCUST_SPELL: TcxTextEdit
        Left = 348
        Top = 25
        Width = 121
        Height = 20
        TabStop = False
        TabOrder = 5
      end
      object cmbPRICE_ID: TzrComboBoxList
        Left = 113
        Top = 48
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 2
        InGrid = False
        KeyValue = Null
        FilterFields = 'PRICE_ID;PRICE_NAME;PRICE_SPELL'
        KeyField = 'PRICE_ID'
        ListField = 'PRICE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'PRICE_NAME'
            Footers = <>
            Title.Caption = #31561#32423#21517#31216
            Width = 120
          end>
        DropWidth = 125
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        OnAddClick = cmbPRICE_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = cmbPRICE_IDSaveValue
        MultiSelect = False
      end
      object cmbBIRTHDAY: TcxDateEdit
        Left = 348
        Top = 79
        Width = 121
        Height = 20
        TabOrder = 7
      end
      object cmbMOVE_TELE: TcxTextEdit
        Left = 113
        Top = 108
        Width = 121
        Height = 20
        Properties.OnChange = edtCUST_NAMEPropertiesChange
        TabOrder = 4
        OnKeyPress = cmbMOVE_TELEKeyPress
      end
      object cmbSEX: TRadioGroup
        Left = 114
        Top = 68
        Width = 150
        Height = 37
        Columns = 3
        Items.Strings = (
          #22899
          #30007
          #20445#23494)
        TabOrder = 3
      end
      object edtSORT_ID: TzrComboBoxList
        Left = 348
        Top = 48
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 6
        InGrid = False
        KeyValue = Null
        FilterFields = 'CODE_ID;CODE_NAME;CODE_SPELL'
        KeyField = 'CODE_ID'
        ListField = 'CODE_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CODE_NAME'
            Footers = <>
            Title.Caption = #20250#21592#31867#21035
            Width = 120
          end>
        DropWidth = 125
        DropHeight = 120
        ShowTitle = False
        AutoFitColWidth = True
        OnAddClick = edtSORT_IDAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        MultiSelect = False
      end
      object cmbSHOP_ID: TzrComboBoxList
        Left = 348
        Top = 108
        Width = 121
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        TabOrder = 8
        InGrid = False
        KeyValue = Null
        FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
        KeyField = 'SHOP_ID'
        ListField = 'SHOP_NAME'
        Columns = <
          item
            EditButtons = <>
            FieldName = 'SHOP_NAME'
            Footers = <>
            Title.Caption = #38376#24215#21517#31216
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'SHOP_ID'
            Footers = <>
            Title.Caption = #32534'  '#21495
            Width = 50
          end>
        DropWidth = 170
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        ShowButton = True
        LocateStyle = lsDark
        Buttons = []
        DropListStyle = lsFixed
        MultiSelect = False
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 498
    Top = 134
  end
  inherited actList: TActionList
    Left = 426
    Top = 134
  end
  object dsGlide: TDataSource
    DataSet = adoGlide
    Left = 515
    Top = 221
  end
  object dsCustomerData: TDataSource
    DataSet = adoCustomerData
    Left = 515
    Top = 253
  end
  object dsDeposit: TDataSource
    DataSet = adoDeposit
    Left = 515
    Top = 285
  end
  object dsRenew: TDataSource
    DataSet = adoRenew
    Left = 515
    Top = 325
  end
  object adoGlide: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 482
    Top = 222
  end
  object adoCustomerData: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 482
    Top = 254
  end
  object adoDeposit: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 482
    Top = 286
  end
  object adoRenew: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 482
    Top = 326
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 463
    Top = 132
  end
end
