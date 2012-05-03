inherited frmCustomerInfo: TfrmCustomerInfo
  Left = 342
  Top = 169
  Caption = #20250#21592#26723#26696
  ClientHeight = 414
  ClientWidth = 535
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 535
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
      Width = 525
      Height = 212
      Align = alBottom
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
            Properties.MaxLength = 50
            Properties.OnChange = edtCUST_NAMEPropertiesChange
            TabOrder = 1
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            OnKeyPress = cmbBALANCEKeyPress
          end
          object cmbRULE_INTEGRAL: TcxTextEdit
            Left = 347
            Top = 76
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 7
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            OnKeyPress = cmbRULE_INTEGRALKeyPress
          end
          object cmbSND_DATE: TcxDateEdit
            Left = 109
            Top = 53
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            TabOrder = 2
          end
          object cmbEND_DATE: TcxDateEdit
            Left = 109
            Top = 99
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            TabOrder = 4
          end
          object cmbCON_DATE: TcxDateEdit
            Left = 109
            Top = 76
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            TabOrder = 3
          end
          object cmbREMARK: TcxMemo
            Left = 109
            Top = 123
            Width = 360
            Height = 56
            Properties.MaxLength = 500
            TabOrder = 5
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtIDN_TYPE: TcxComboBox
            Left = 109
            Top = 7
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            OnKeyPress = cmbINTEGRALKeyPress
          end
          object edtACCU_INTEGRAL: TcxTextEdit
            Left = 347
            Top = 30
            Width = 121
            Height = 20
            Enabled = False
            TabOrder = 9
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
        end
      end
      object TabSheet6: TRzTabSheet
        Color = clWhite
        Caption = #32852#31995#20449#24687
        object RzPanel3: TRzPanel
          Left = 0
          Top = 0
          Width = 521
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
          object RzLabel34: TRzLabel
            Left = 233
            Top = 17
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
          object cmbOFFI_TELE: TcxTextEdit
            Left = 348
            Top = 106
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 9
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            OnKeyPress = cmbOFFI_TELEKeyPress
          end
          object cmbFAMI_ADDR: TcxTextEdit
            Left = 109
            Top = 153
            Width = 360
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 11
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
            OnAddClick = edtREGION_IDAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = []
            DropListStyle = lsFixed
            MultiSelect = False
          end
          object edtPOSTALCODE: TcxTextEdit
            Left = 109
            Top = 129
            Width = 121
            Height = 20
            Properties.MaxLength = 6
            TabOrder = 5
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtQQ: TcxTextEdit
            Left = 348
            Top = 36
            Width = 121
            Height = 20
            Properties.MaxLength = 20
            TabOrder = 6
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtMSN: TcxTextEdit
            Left = 348
            Top = 59
            Width = 121
            Height = 20
            Properties.MaxLength = 35
            TabOrder = 7
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtEMAIL: TcxTextEdit
            Left = 348
            Top = 82
            Width = 121
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 8
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtFAMI_TELE: TcxTextEdit
            Left = 348
            Top = 129
            Width = 121
            Height = 20
            Properties.MaxLength = 30
            TabOrder = 10
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtDEGREES: TcxComboBox
            Left = 109
            Top = 36
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            TabOrder = 1
          end
          object edtMONTH_PAY: TcxComboBox
            Left = 109
            Top = 82
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            TabOrder = 3
          end
          object edtOCCUPATION: TcxComboBox
            Left = 109
            Top = 59
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Properties.DropDownListStyle = lsFixedList
            TabOrder = 2
          end
          object edtJOBUNIT: TcxTextEdit
            Left = 109
            Top = 106
            Width = 150
            Height = 20
            Properties.MaxLength = 50
            TabOrder = 4
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #21830#30431#20449#24687
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 521
          Height = 185
          Align = alClient
          AllowedOperations = []
          AutoFitColWidths = True
          DataSource = dsUnionCard
          FixedColor = clWhite
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
          OnCellClick = DBGridEh1CellClick
          OnDrawColumnCell = DBGridEh1DrawColumnCell
          Columns = <
            item
              EditButtons = <>
              FieldName = 'UNION_NAME'
              Footers = <>
              Title.Caption = #21830#30431#21517#31216
              Width = 96
            end
            item
              EditButtons = <>
              FieldName = 'IC_CARDNO'
              Footers = <>
              Title.Caption = #21345'  '#21495
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'IC_STATUS'
              Footers = <>
              Title.Caption = #29366#24577
              Width = 40
            end
            item
              EditButtons = <>
              FieldName = 'ACCU_INTEGRAL'
              Footers = <>
              Title.Caption = #32047#35745#31215#20998
              Width = 35
            end
            item
              EditButtons = <>
              FieldName = 'RULE_INTEGRAL'
              Footers = <>
              Title.Caption = #20351#29992#31215#20998
              Width = 35
            end
            item
              EditButtons = <>
              FieldName = 'INTEGRAL'
              Footers = <>
              Title.Caption = #21487#29992#31215#20998
              Width = 35
            end
            item
              EditButtons = <>
              FieldName = 'BALANCE'
              Footers = <>
              Title.Caption = #21487#29992#20313#39069
              Width = 35
            end
            item
              DisplayFormat = '0000-00-00'
              EditButtons = <>
              FieldName = 'NEAR_BUY_DATE'
              Footers = <>
              Title.Caption = #36141#20080#26085#26399
              Width = 75
            end
            item
              DisplayFormat = '0'#22825'/'#27425
              EditButtons = <>
              FieldName = 'FREQUENCY'
              Footers = <>
              Title.Caption = #36141#20080#39057#27425
              Width = 60
            end>
        end
      end
      object TabSalesList: TRzTabSheet
        Color = clWhite
        Caption = #26368#36817'90'#22825#28040#36153#35760#24405
        object DBGridEh5: TDBGridEh
          Left = 0
          Top = 0
          Width = 521
          Height = 185
          Align = alClient
          AllowedOperations = []
          Color = clWhite
          Ctl3D = True
          DataSource = DsCustSalesList
          FixedColor = clWhite
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
          FooterRowCount = 1
          FrozenCols = 2
          ImeName = #26497#21697#20116#31508#36755#20837#27861
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          RowHeight = 20
          SumList.Active = True
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
          OnDrawColumnCell = DBGridEh5DrawColumnCell
          OnGetFooterParams = DBGridEh5GetFooterParams
          Columns = <
            item
              Alignment = taCenter
              EditButtons = <>
              FieldName = 'SEQNO'
              Footers = <>
              Title.Caption = #24207#21495
              Width = 30
            end
            item
              DisplayFormat = '0000-00-00'
              EditButtons = <>
              FieldName = 'SALES_DATE'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #26085#26399
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'GODS_NAME'
              Footers = <>
              Title.Caption = #21830#21697#21517#31216
              Width = 126
            end
            item
              EditButtons = <>
              FieldName = 'UNIT_NAME'
              Footers = <>
              Title.Caption = #21333#20301
              Width = 30
            end
            item
              Alignment = taRightJustify
              DisplayFormat = '#0.###'
              EditButtons = <>
              FieldName = 'AMOUNT'
              Footer.DisplayFormat = '#0.###'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #25968#37327
              Width = 56
            end
            item
              Alignment = taRightJustify
              DisplayFormat = '#0.00#'
              EditButtons = <>
              FieldName = 'APRICE'
              Footers = <>
              Title.Caption = #23454#38469#21806#20215
              Width = 66
            end
            item
              Alignment = taRightJustify
              DisplayFormat = '#0.00'
              EditButtons = <>
              FieldName = 'AMONEY'
              Footer.DisplayFormat = '#0.00'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #38144#21806#39069
            end
            item
              EditButtons = <>
              FieldName = 'TREND_ID'
              Footers = <>
              Title.Caption = #36141#20080#29992#36884
              Width = 60
            end
            item
              EditButtons = <>
              FieldName = 'CREA_USER_TEXT'
              Footers = <>
              Title.Caption = #21046#21333#20154
              Width = 53
            end>
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 374
      Width = 525
      Height = 35
      BorderColor = clWhite
      Color = clWhite
      DesignSize = (
        525
        35)
      object Btn_Save: TRzBitBtn
        Left = 353
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
        Left = 444
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
      Width = 525
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
        Caption = #20250#21592#21345#21495
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
        Caption = #25340#38899#30721#13
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
      object RzLabel33: TRzLabel
        Left = 471
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
      object cmbCUST_CODE: TcxTextEdit
        Left = 113
        Top = 1
        Width = 121
        Height = 20
        Properties.MaxLength = 20
        Properties.OnChange = cmbCUST_CODEPropertiesChange
        TabOrder = 0
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object cmbCUST_NAME: TcxTextEdit
        Left = 113
        Top = 25
        Width = 121
        Height = 20
        Properties.MaxLength = 30
        Properties.OnChange = edtCUST_NAMEPropertiesChange
        TabOrder = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      end
      object cmbCUST_SPELL: TcxTextEdit
        Left = 348
        Top = 25
        Width = 121
        Height = 20
        TabStop = False
        Properties.MaxLength = 30
        TabOrder = 5
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
        DropWidth = 130
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
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        TabOrder = 7
      end
      object cmbMOVE_TELE: TcxTextEdit
        Left = 113
        Top = 108
        Width = 121
        Height = 20
        Properties.MaxLength = 30
        Properties.OnChange = edtCUST_NAMEPropertiesChange
        TabOrder = 4
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
        DropWidth = 130
        DropHeight = 180
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
          end>
        DropWidth = 130
        DropHeight = 180
        ShowTitle = True
        AutoFitColWidth = False
        OnAddClick = cmbSHOP_IDAddClick
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
  object dsUnionCard: TDataSource
    DataSet = cdsUnionCard
    Left = 483
    Top = 325
  end
  object cdsUnionCard: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 402
    Top = 310
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 463
    Top = 132
  end
  object cdsCustomerExt: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 370
    Top = 310
  end
  object CustSalesList: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 442
    Top = 206
  end
  object DsCustSalesList: TDataSource
    DataSet = CustSalesList
    Left = 475
    Top = 205
  end
end
