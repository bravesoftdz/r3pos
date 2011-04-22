inherited frmPosMain: TfrmPosMain
  Left = 287
  Top = 152
  BorderIcons = []
  BorderStyle = bsNone
  Caption = #30005#23376#25910#27454#26426
  ClientHeight = 570
  ClientWidth = 802
  Color = clBlack
  OldCreateOrder = True
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel3: TRzPanel [0]
    Left = 0
    Top = 275
    Width = 802
    Height = 199
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdRight, sdBottom]
    BorderColor = clBlack
    Color = clBlack
    FlatColor = clWhite
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 1
      Top = 0
      Width = 800
      Height = 198
      Align = alClient
      BorderOuter = fsNone
      BorderSides = [sdLeft, sdRight, sdBottom]
      BorderColor = clBlack
      BorderWidth = 5
      Color = clBlack
      TabOrder = 0
      object rzinfo1: TRzGroupBox
        Left = 5
        Top = 5
        Width = 400
        Height = 188
        Align = alLeft
        Caption = #36164#26009
        Color = clBlack
        Font.Charset = GB2312_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ThemeAware = False
        object Label2: TLabel
          Left = 17
          Top = 110
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #20250#21592#21345#21495
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 209
          Top = 110
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #23458#25143#21517#31216
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 18
          Top = 25
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #38144#21806#21333#21495
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 209
          Top = 25
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #38144#21806#26085#26399
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 17
          Top = 79
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #21512#35745#37329#39069
          Font.Charset = GB2312_CHARSET
          Font.Color = clLime
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 209
          Top = 79
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #25240#35753#37329#39069
          Font.Charset = GB2312_CHARSET
          Font.Color = clLime
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 17
          Top = 48
          Width = 53
          Height = 12
          Alignment = taRightJustify
          Caption = #25910' '#38134' '#21592
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label30: TLabel
          Left = 209
          Top = 155
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #21487#29992#31215#20998
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label31: TLabel
          Left = 17
          Top = 155
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #26412#21333#31215#20998
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label32: TLabel
          Left = 208
          Top = 48
          Width = 53
          Height = 12
          Alignment = taRightJustify
          Caption = #23548' '#36141' '#21592
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 209
          Top = 132
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #21487#29992#20313#39069
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 17
          Top = 132
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #23458#25143#31561#32423
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object fndCLIENT_CODE: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 106
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 0
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndCLIENT_CODEEnter
        end
        object fndCLIENT_ID_TEXT: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 106
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 1
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndCLIENT_CODEEnter
        end
        object fndGLIDE_NO: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 21
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 2
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndCLIENT_CODEEnter
        end
        object fndSALES_DATE: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 21
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 3
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndCLIENT_CODEEnter
        end
        object edtAMONEY: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 75
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clLime
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 4
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object edtAGIO_MONEY: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 75
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clLime
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 5
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object fndCREA_USER: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 44
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 6
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object fndACCU_INTEGRAL: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 151
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 7
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object edtINTEGRAL: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 151
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 8
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object fndGUIDE_USER: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 44
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 9
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object fndBALANCE: TcxTextEdit
          Tag = 1
          Left = 267
          Top = 128
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 10
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndBARCODEEnter
        end
        object fndPRICE_ID: TcxTextEdit
          Tag = 1
          Left = 75
          Top = 128
          Width = 116
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 11
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = fndCLIENT_CODEEnter
        end
        object Panel1: TPanel
          Left = 1
          Top = 13
          Width = 398
          Height = 7
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 12
        end
        object DBGridEh2: TDBGridEh
          Left = 1
          Top = 20
          Width = 398
          Height = 167
          Align = alClient
          AllowedOperations = [alopUpdateEh]
          AutoFitColWidths = True
          Color = clBlack
          DataSource = dsGodsInfo
          Enabled = False
          FixedColor = clBlack
          Flat = True
          FooterColor = clBlack
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWhite
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FrozenCols = 1
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
          RowHeight = 23
          TabOrder = 13
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWhite
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          UseMultiTitle = True
          Visible = False
          IsDrawNullRow = False
          CurrencySymbol = #65509
          DecimalNumber = 2
          DigitalNumber = 12
          Columns = <
            item
              EditButtons = <>
              FieldName = 'GODS_CODE'
              Footer.Value = #35760#24405#25968#65306
              Footer.ValueType = fvtStaticText
              Footers = <>
              ReadOnly = True
              Title.Caption = #36135#21495
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'GODS_NAME'
              Footer.ValueType = fvtCount
              Footers = <>
              ReadOnly = True
              Title.Caption = #21830#21697#21517#31216
              Width = 122
            end
            item
              EditButtons = <>
              FieldName = 'BARCODE'
              Footers = <>
              Title.Caption = #26465#30721
              Width = 83
            end
            item
              EditButtons = <>
              FieldName = 'NEW_OUTPRICE'
              Footers = <>
              Title.Caption = #26631#20934#21806#20215
              Width = 54
            end
            item
              EditButtons = <>
              FieldName = 'NEW_LOWPRICE'
              Footers = <>
              Title.Caption = #26368#20302#21806#20215
              Width = 52
            end>
        end
      end
      object RzPanel5: TRzPanel
        Left = 405
        Top = 5
        Width = 5
        Height = 188
        Align = alLeft
        BorderOuter = fsNone
        Color = clBlack
        TabOrder = 1
      end
      object RzGroupBox1: TRzGroupBox
        Left = 410
        Top = 5
        Width = 385
        Height = 188
        Align = alClient
        Caption = #25805#20316
        Color = clBlack
        Font.Charset = GB2312_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblPAY_1: TLabel
          Left = 19
          Top = 59
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #29616#37329#25903#20184
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label12: TLabel
          Left = 19
          Top = 28
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #25273#38646#37329#39069
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDIBS: TLabel
          Left = 198
          Top = 108
          Width = 93
          Height = 29
          Caption = #25214#38646#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -29
          Font.Name = #40657#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCASH: TLabel
          Left = 198
          Top = 68
          Width = 93
          Height = 29
          Caption = #29616#37329#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -29
          Font.Name = #40657#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPAY_2: TLabel
          Left = 19
          Top = 80
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #29616#37329#25903#20184
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblPAY_3: TLabel
          Left = 19
          Top = 101
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #29616#37329#25903#20184
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblPAY_4: TLabel
          Left = 19
          Top = 123
          Width = 52
          Height = 12
          Alignment = taRightJustify
          Caption = #29616#37329#25903#20184
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblACCT_MNY: TLabel
          Left = 198
          Top = 18
          Width = 93
          Height = 29
          Caption = #32467#31639#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -29
          Font.Name = #40657#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rckPAY_1: TcxTextEdit
          Tag = 1
          Left = 77
          Top = 55
          Width = 104
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 0
          Visible = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = rckPAY_1Enter
        end
        object priPAY_DIBS: TcxTextEdit
          Tag = 1
          Left = 77
          Top = 24
          Width = 104
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 1
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = rckPAY_1Enter
        end
        object pnlBarCode: TRzPanel
          Left = 1
          Top = 150
          Width = 383
          Height = 37
          Align = alBottom
          BorderOuter = fsFlat
          BorderSides = [sdTop]
          Color = clBlack
          TabOrder = 2
          object lblInput: TLabel
            Left = 13
            Top = 9
            Width = 84
            Height = 20
            Caption = #26465#30721#36755#20837
            Font.Charset = GB2312_CHARSET
            Font.Color = clWhite
            Font.Height = -20
            Font.Name = #40657#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object rzHint: TLabel
            Left = 246
            Top = 14
            Width = 6
            Height = 12
          end
          object edtInput: TcxTextEdit
            Tag = -1
            Left = 103
            Top = 6
            Width = 138
            Height = 27
            ParentFont = False
            Properties.OnChange = edtInputPropertiesChange
            Style.BorderStyle = ebsThick
            Style.Color = 16777088
            Style.Font.Charset = GB2312_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -19
            Style.Font.Name = #40657#20307
            Style.Font.Style = [fsBold]
            TabOrder = 0
            ImeMode = imClose
            OnKeyDown = edtInputKeyDown
            OnKeyPress = edtInputKeyPress
          end
        end
        object rckPAY_2: TcxTextEdit
          Tag = 1
          Left = 77
          Top = 76
          Width = 104
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 3
          Visible = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = rckPAY_1Enter
        end
        object rckPAY_3: TcxTextEdit
          Tag = 1
          Left = 77
          Top = 97
          Width = 104
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 4
          Visible = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = rckPAY_1Enter
        end
        object rckPAY_4: TcxTextEdit
          Tag = 1
          Left = 77
          Top = 119
          Width = 104
          Height = 20
          Enabled = False
          ParentFont = False
          Style.Color = 14671839
          Style.Font.Charset = GB2312_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = #23435#20307
          Style.Font.Style = [fsBold]
          TabOrder = 5
          Visible = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          OnEnter = rckPAY_1Enter
        end
      end
    end
  end
  object RzPanel6: TRzPanel [1]
    Left = 0
    Top = 26
    Width = 802
    Height = 249
    Align = alClient
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdTop, sdRight]
    BorderColor = clWhite
    FlatColor = clWhite
    TabOrder = 1
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 1
      Width = 800
      Height = 248
      Align = alClient
      AllowedOperations = [alopUpdateEh]
      AutoFitColWidths = True
      BorderStyle = bsNone
      Color = clBlack
      DataSource = DataSource1
      Enabled = False
      FixedColor = clBlack
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      FooterColor = clBlack
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWhite
      FooterFont.Height = -12
      FooterFont.Name = #23435#20307
      FooterFont.Style = [fsBold]
      FooterRowCount = 1
      FrozenCols = 1
      HorzScrollBar.Visible = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection]
      ParentFont = False
      ReadOnly = True
      RowHeight = 30
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = [fsBold]
      TitleHeight = 25
      VertScrollBar.VisibleMode = sbNeverShowEh
      IsDrawNullRow = False
      CurrencySymbol = #65509
      DecimalNumber = 2
      DigitalNumber = 12
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      OnDrawFooterCell = DBGridEh1DrawFooterCell
      OnGetCellParams = DBGridEh1GetCellParams
      Columns = <
        item
          EditButtons = <>
          FieldName = 'SEQNO'
          Footers = <>
          Title.Caption = #24207#21495
          Width = 31
        end
        item
          EditButtons = <>
          FieldName = 'GODS_NAME'
          Footers = <>
          Title.Caption = #21830#21697#21517#31216
          Title.Hint = #25903#25345' "'#36135#21495#12289#21830#21697#21517#31216#12289#25340#38899#30721'" '#26597#35810
          Width = 123
        end
        item
          EditButtons = <>
          FieldName = 'GODS_CODE'
          Footers = <>
          Title.Caption = #36135#21495
          Width = 59
        end
        item
          EditButtons = <>
          FieldName = 'BARCODE'
          Footers = <>
          Title.Caption = #26465#30721
          Width = 88
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'PROPERTY_01'
          Footers = <>
          Title.Caption = #23610#30721
          Width = 31
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'PROPERTY_02'
          Footers = <>
          Title.Caption = #39068#33394
          Width = 40
        end
        item
          Alignment = taRightJustify
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'AMOUNT'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #25968#37327
          Width = 31
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'UNIT_ID'
          Footers = <>
          Title.Caption = #21333#20301
          Title.Hint = #25353' "'#31354#26684#38190'(SPACE)" '#36827#34892#21333#20301#36716#25442
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'ORG_PRICE'
          Footers = <>
          Title.Caption = #21407#21333#20215
          Width = 51
        end
        item
          Alignment = taRightJustify
          DisplayFormat = '#0%'
          EditButtons = <>
          FieldName = 'AGIO_RATE'
          Footers = <>
          Title.Caption = #25240#25187#29575
          Width = 47
        end
        item
          Alignment = taRightJustify
          EditButtons = <>
          FieldName = 'APRICE'
          Footers = <>
          Title.Caption = #29616#21333#20215
          Width = 51
        end
        item
          Alignment = taRightJustify
          EditButtons = <>
          FieldName = 'AMONEY'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #37329#39069
          Width = 61
        end
        item
          EditButtons = <>
          FieldName = 'BATCH_NO'
          Footers = <>
          Title.Caption = #25209#21495
          Width = 82
        end
        item
          EditButtons = <>
          FieldName = 'LOCUS_NO'
          Footers = <>
          Title.Caption = #29289#27969#36319#36394#30721
          Width = 88
        end>
    end
  end
  object RzPanel7: TRzPanel [2]
    Left = 0
    Top = 0
    Width = 802
    Height = 26
    Align = alTop
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdTop, sdRight]
    Color = clNavy
    FlatColor = clWhite
    TabOrder = 2
    object RzStatusPane1: TRzStatusPane
      Left = 1
      Top = 1
      Height = 25
      Align = alLeft
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Alignment = taCenter
      Caption = #32852#26426#29366#24577
    end
    object RzStatusPane2: TRzStatusPane
      Left = 101
      Top = 1
      Width = 606
      Height = 25
      Align = alClient
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Alignment = taCenter
    end
    object RzStatusPane5: TRzStatusPane
      Left = 754
      Top = 1
      Width = 47
      Height = 25
      Cursor = crHandPoint
      Align = alRight
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = RzStatusPane5Click
      Alignment = taCenter
      Caption = #36864#20986
    end
    object RzStatusPane7: TRzStatusPane
      Left = 707
      Top = 1
      Width = 47
      Height = 25
      Cursor = crHandPoint
      Align = alRight
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = RzStatusPane7Click
      Alignment = taCenter
      Caption = #26368#23567#21270
    end
  end
  object RzPanel8: TRzPanel [3]
    Left = 0
    Top = 544
    Width = 802
    Height = 26
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdRight, sdBottom]
    Color = clNavy
    FlatColor = clWhite
    TabOrder = 3
    object lblHint: TRzStatusPane
      Left = 201
      Top = 0
      Width = 484
      Height = 25
      Align = alClient
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Alignment = taCenter
    end
    object RzStatusPane4: TRzStatusPane
      Left = 1
      Top = 0
      Height = 25
      Align = alLeft
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Alignment = taCenter
    end
    object RzStatusPane3: TRzStatusPane
      Left = 101
      Top = 0
      Height = 25
      Align = alLeft
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = RzStatusPane3Click
      Alignment = taCenter
      Caption = #25346#21333#25968':5'#21333
    end
    object RzClockStatus1: TRzClockStatus
      Left = 685
      Top = 0
      Width = 116
      Height = 25
      Align = alRight
      Color = 8404992
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object rzHelp: TRzPanel [4]
    Left = 0
    Top = 474
    Width = 802
    Height = 70
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdLeft, sdRight, sdBottom]
    Color = clBlack
    TabOrder = 4
    object h2: TLabel
      Left = 137
      Top = 8
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #28165#23631'  [Insert]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h6: TLabel
      Left = 21
      Top = 28
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #20250#21592#21345#21495'  [F5]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h5: TLabel
      Left = 364
      Top = 28
      Width = 72
      Height = 12
      Cursor = crHandPoint
      Caption = #36864#36135'  [F10] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h11: TLabel
      Left = 700
      Top = 27
      Width = 72
      Height = 12
      Cursor = crHandPoint
      Caption = #32467#24080'  [ + ] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h12: TLabel
      Left = 700
      Top = 47
      Width = 66
      Height = 12
      Cursor = crHandPoint
      Caption = #21462#28040'  [Esc]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h9: TLabel
      Left = 137
      Top = 28
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #29289#27969#36319#36394#30721'[F7]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object h10: TLabel
      Left = 137
      Top = 47
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #25209#21495#36755#20837'  [F8]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 580
      Top = 8
      Width = 72
      Height = 12
      Cursor = crHandPoint
      Caption = #38065#31665'  [Home]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 580
      Top = 28
      Width = 78
      Height = 12
      Cursor = crHandPoint
      Caption = #38145#23631'  [Pause]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 247
      Top = 28
      Width = 90
      Height = 12
      Cursor = crHandPoint
      Caption = #21024#38500#21333#21697'  [ - ]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 364
      Top = 47
      Width = 72
      Height = 12
      Cursor = crHandPoint
      Caption = #35843#20215'  [F12] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 21
      Top = 47
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #23548' '#36141' '#21592'  [F9]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 247
      Top = 8
      Width = 96
      Height = 12
      Cursor = crHandPoint
      Caption = #21333#20301#20999#25442'  [F11] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 451
      Top = 28
      Width = 102
      Height = 12
      Cursor = crHandPoint
      Caption = #19978#19968#21333'  [Page Up]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 451
      Top = 47
      Width = 114
      Height = 12
      Cursor = crHandPoint
      Caption = #19979#19968#21333'  [Page Down]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 579
      Top = 47
      Width = 96
      Height = 12
      Cursor = crHandPoint
      Caption = #23567#31080'  [Ctrl + P]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 364
      Top = 8
      Width = 66
      Height = 12
      Cursor = crHandPoint
      Caption = #25968#37327'  [F3] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 21
      Top = 8
      Width = 84
      Height = 12
      Cursor = crHandPoint
      Caption = #21151#33021#33756#21333'  [F2]'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 453
      Top = 7
      Width = 96
      Height = 12
      Cursor = crHandPoint
      Caption = #36192#36865'/'#20817#25442'  [F4] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 247
      Top = 47
      Width = 90
      Height = 12
      Cursor = crHandPoint
      Caption = #25972#21333#35843#20215'  [F6] '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
  inherited actList: TActionList
    object actNew: TAction
      Caption = 'actNew'
      OnExecute = actNewExecute
    end
    object actSave: TAction
      Caption = 'actSave'
      OnExecute = actSaveExecute
    end
    object actDelete: TAction
      Caption = 'actDelete'
      OnExecute = actDeleteExecute
    end
    object actPrint: TAction
      Caption = 'actPrint'
      OnExecute = actPrintExecute
    end
    object actAudit: TAction
      Caption = 'actAudit'
      OnExecute = actAuditExecute
    end
    object actPrior: TAction
      Caption = 'actPrior'
      OnExecute = actPriorExecute
    end
    object actNext: TAction
      Caption = 'actNext'
      OnExecute = actNextExecute
    end
    object actCancel: TAction
      Caption = 'actCancel'
      OnExecute = actCancelExecute
    end
    object actFind: TAction
      Caption = 'actFind'
    end
    object actInfo: TAction
      Caption = 'actInfo'
    end
    object actPreview: TAction
      Caption = 'actPreview'
    end
    object actEdit: TAction
      Caption = 'actEdit'
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsTable
    Left = 184
    Top = 217
  end
  object cdsHeader: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 144
    Top = 186
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    AfterPost = cdsTableAfterPost
    Params = <>
    Left = 144
    Top = 218
  end
  object dsGodsInfo: TDataSource
    Left = 198
    Top = 392
  end
  object cdsLocusNo: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    AfterPost = cdsTableAfterPost
    Params = <>
    Left = 144
    Top = 253
  end
end
