inherited frmDeposit: TfrmDeposit
  Left = 506
  Top = 241
  Caption = #20805#20540#31649#29702
  ClientHeight = 292
  ClientWidth = 496
  Color = clWhite
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 496
    Height = 292
    BorderColor = clWhite
    Color = clWhite
    inherited RzPage: TRzPageControl
      Width = 486
      Height = 242
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20805#20540
        inherited RzPanel2: TRzPanel
          Width = 482
          Height = 215
          BorderColor = clWhite
          Color = clWhite
          object edt: TRzLabel
            Left = 232
            Top = 38
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20805#20540#21069#20313#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel2: TRzLabel
            Left = 3
            Top = 144
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25688'    '#35201
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel1: TRzLabel
            Left = 232
            Top = 66
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20805#20540#21518#20313#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel3: TRzLabel
            Left = 3
            Top = 66
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20805#20540#37329#39069
            Font.Charset = GB2312_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RzLabel4: TRzLabel
            Left = 3
            Top = 15
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20250' '#21592' '#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel5: TRzLabel
            Left = 3
            Top = 38
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
          object RzLabel6: TRzLabel
            Left = 3
            Top = 118
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25903#20184#26041#24335
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RzLabel7: TRzLabel
            Left = 231
            Top = 118
            Width = 100
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25903#20184#29616#37329
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 55
            Top = 92
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #25910#27454#24080#25143
          end
          object Label2: TLabel
            Left = 283
            Top = 92
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #25910#25903#31185#30446
          end
          object edtBALANCE: TcxTextEdit
            Tag = 1
            Left = 341
            Top = 34
            Width = 100
            Height = 20
            TabStop = False
            TabOrder = 8
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtGLIDE_INFO: TcxMemo
            Left = 112
            Top = 141
            Width = 249
            Height = 65
            TabOrder = 7
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtIC_AMONEY: TcxTextEdit
            Left = 112
            Top = 62
            Width = 121
            Height = 20
            ParentFont = False
            Properties.OnChange = edtIC_AMONEYPropertiesChange
            Style.Font.Charset = GB2312_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -12
            Style.Font.Name = #23435#20307
            Style.Font.Style = [fsBold]
            TabOrder = 2
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            OnExit = edtIC_AMONEYExit
          end
          object edtNewBALANCE: TcxTextEdit
            Tag = 1
            Left = 341
            Top = 62
            Width = 100
            Height = 20
            TabStop = False
            TabOrder = 9
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtCUST_CODE: TcxTextEdit
            Tag = 1
            Left = 112
            Top = 11
            Width = 121
            Height = 20
            TabOrder = 0
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtCUST_NAME: TcxTextEdit
            Tag = 1
            Left = 112
            Top = 34
            Width = 121
            Height = 20
            TabOrder = 1
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtPAY: TcxTextEdit
            Left = 341
            Top = 114
            Width = 121
            Height = 20
            Properties.OnChange = edtPAYPropertiesChange
            TabOrder = 6
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
          end
          object edtPAY_CASH: TcxComboBox
            Left = 112
            Top = 114
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            Properties.DropDownListStyle = lsFixedList
            Properties.OnChange = edtPAY_CASHPropertiesChange
            TabOrder = 4
          end
          object edtACCOUNT_ID: TzrComboBoxList
            Left = 112
            Top = 88
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 3
            InGrid = False
            KeyValue = Null
            FilterFields = 'ACCOUNT_ID;ACCT_NAME;ACCT_SPELL'
            KeyField = 'ACCOUNT_ID'
            ListField = 'ACCT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'ACCT_NAME'
                Footers = <>
                Title.Caption = #24080#25143#21517#31216
                Width = 60
              end>
            DropWidth = 157
            DropHeight = 180
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtACCOUNT_IDAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            OnSaveValue = edtACCOUNT_IDSaveValue
            MultiSelect = False
          end
          object edtITEM_ID: TzrComboBoxList
            Left = 341
            Top = 88
            Width = 121
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 5
            InGrid = False
            KeyValue = Null
            FilterFields = 'CODE_NAME;CODE_SPELL'
            KeyField = 'CODE_ID'
            ListField = 'CODE_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'CODE_NAME'
                Footers = <>
                Title.Caption = #24080#25143#21517#31216
                Width = 60
              end>
            DropWidth = 180
            DropHeight = 180
            ShowTitle = True
            AutoFitColWidth = True
            OnAddClick = edtITEM_IDAddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            MultiSelect = False
          end
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 247
      Width = 486
      BorderColor = clWhite
      Color = clWhite
      object btnOk: TRzBitBtn
        Left = 316
        Top = 9
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
        OnClick = btnOkClick
        NumGlyphs = 2
        Spacing = 5
      end
      object btnClose: TRzBitBtn
        Left = 410
        Top = 9
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
        OnClick = btnCloseClick
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 56
    Top = 344
  end
  inherited actList: TActionList
    Left = 104
    Top = 344
  end
  object cdsTable1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 85
    Top = 247
  end
  object cdsTable: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 53
    Top = 247
  end
end
