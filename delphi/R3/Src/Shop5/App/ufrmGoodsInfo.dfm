inherited frmGoodsInfo: TfrmGoodsInfo
  Left = 257
  Top = 153
  ActiveControl = edtGODS_CODE
  Caption = #21830#21697#26723#26696
  ClientHeight = 426
  ClientWidth = 528
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label32: TLabel [0]
    Left = 276
    Top = 41
    Width = 100
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #25442#25104#35745#37327#21333#20301#31995#25968
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label33: TLabel [1]
    Left = 284
    Top = 49
    Width = 100
    Height = 12
    Alignment = taRightJustify
    AutoSize = False
    Caption = #25442#25104#35745#37327#21333#20301#31995#25968
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  inherited bgPanel: TRzPanel
    Width = 528
    Height = 426
    BorderColor = clWhite
    inherited RzPage: TRzPageControl
      Top = 145
      Width = 518
      Height = 232
      ActivePage = TabSheet3
      BackgroundColor = clWhite
      Color = clWhite
      UseColoredTabs = True
      ParentBackgroundColor = False
      ParentColor = False
      TabIndex = 2
      TabOrder = 1
      OnChange = RzPageChange
      FixedDimension = 20
      inherited TabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#21253#35013
        inherited RzPanel2: TRzPanel
          Width = 514
          Height = 205
          BorderColor = clWhite
          BorderShadow = clWhite
          Color = clWhite
          FlatColor = clWhite
          object LblColorGroup: TLabel
            Left = 36
            Top = 15
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #39068#33394#32452
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object lblSizeGroup: TLabel
            Left = 287
            Top = 15
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #23610#30721#32452
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object edtSORT_ID7: TzrComboBoxList
            Left = 79
            Top = 11
            Width = 133
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 0
            Visible = False
            InGrid = False
            KeyValue = Null
            FilterFields = 'SORT_NAME;SORT_SPELL;SORT_ID'
            KeyField = 'SORT_ID'
            ListField = 'SORT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SORT_NAME'
                Footers = <>
                Title.Caption = #39068#33394#32452
              end>
            DropWidth = 100
            DropHeight = 120
            ShowTitle = False
            AutoFitColWidth = True
            OnAddClick = edtSORT_ID7AddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            OnSaveValue = edtSORT_ID7SaveValue
            MultiSelect = False
          end
          object edtSORT_ID8: TzrComboBoxList
            Left = 330
            Top = 11
            Width = 138
            Height = 20
            Properties.AutoSelect = False
            Properties.Buttons = <
              item
                Default = True
              end>
            Properties.ReadOnly = True
            TabOrder = 1
            Visible = False
            InGrid = False
            KeyValue = Null
            FilterFields = 'SORT_NAME;SORT_SPELL;SORT_ID'
            KeyField = 'SORT_ID'
            ListField = 'SORT_NAME'
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SORT_NAME'
                Footers = <>
                Title.Caption = #23610#30721#32452
              end>
            DropWidth = 100
            DropHeight = 120
            ShowTitle = False
            AutoFitColWidth = True
            OnAddClick = edtSORT_ID8AddClick
            ShowButton = True
            LocateStyle = lsDark
            Buttons = [zbNew]
            DropListStyle = lsFixed
            OnSaveValue = edtSORT_ID8SaveValue
            MultiSelect = False
          end
          object GB_Small: TGroupBox
            Left = 26
            Top = 34
            Width = 466
            Height = 75
            Caption = #23567#21253#35013
            TabOrder = 2
            object Label25: TLabel
              Left = 25
              Top = 23
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #21253#35013#21333#20301
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label26: TLabel
              Left = 250
              Top = 23
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #25442#31639#31995#25968
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label38: TLabel
              Left = 25
              Top = 47
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #21253#35013#26465#30721
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 237
              Top = 48
              Width = 61
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #26412#24215#21806#20215
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object edtSMALL_UNITS: TzrComboBoxList
              Left = 80
              Top = 19
              Width = 120
              Height = 20
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              Properties.OnChange = edtSMALL_UNITSPropertiesChange
              TabOrder = 0
              OnExit = edtSMALL_UNITSExit
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
              OnAddClick = edtSMALL_UNITSAddClick
              ShowButton = True
              LocateStyle = lsDark
              Buttons = [zbNew, zbClear]
              DropListStyle = lsFixed
              OnSaveValue = edtSMALL_UNITSSaveValue
              MultiSelect = False
            end
            object edtSMALLTO_CALC: TcxTextEdit
              Left = 304
              Top = 19
              Width = 100
              Height = 20
              Properties.OnChange = edtSMALLTO_CALCPropertiesChange
              TabOrder = 1
              OnKeyPress = edtNEW_OUTPRICEKeyPress
            end
            object edtBARCODE2: TcxTextEdit
              Left = 80
              Top = 43
              Width = 120
              Height = 20
              TabOrder = 2
            end
            object edtMY_OUTPRICE1: TcxTextEdit
              Left = 304
              Top = 44
              Width = 100
              Height = 20
              TabOrder = 3
              OnKeyPress = edtMY_OUTPRICE1KeyPress
            end
          end
          object GB_Big: TGroupBox
            Left = 26
            Top = 116
            Width = 466
            Height = 77
            Caption = #22823#21253#35013
            TabOrder = 3
            object Label1: TLabel
              Left = 25
              Top = 24
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #21253#35013#21333#20301
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 249
              Top = 24
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #25442#31639#31995#25968
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label15: TLabel
              Left = 25
              Top = 48
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #21253#35013#26465#30721
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 236
              Top = 47
              Width = 61
              Height = 12
              Alignment = taRightJustify
              AutoSize = False
              Caption = #26412#24215#21806#20215
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object edtBIG_UNITS: TzrComboBoxList
              Left = 80
              Top = 20
              Width = 120
              Height = 20
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              Properties.OnChange = edtBIG_UNITSPropertiesChange
              TabOrder = 0
              OnExit = edtBIG_UNITSExit
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
              OnAddClick = edtBIG_UNITSAddClick
              ShowButton = True
              LocateStyle = lsDark
              Buttons = [zbNew, zbClear]
              DropListStyle = lsFixed
              OnSaveValue = edtBIG_UNITSSaveValue
              MultiSelect = False
            end
            object edtBIGTO_CALC: TcxTextEdit
              Left = 303
              Top = 20
              Width = 100
              Height = 20
              Properties.OnChange = edtBIGTO_CALCPropertiesChange
              TabOrder = 1
              OnKeyPress = edtNEW_OUTPRICEKeyPress
            end
            object edtBARCODE3: TcxTextEdit
              Left = 80
              Top = 44
              Width = 120
              Height = 20
              TabOrder = 2
            end
            object edtMY_OUTPRICE2: TcxTextEdit
              Left = 303
              Top = 44
              Width = 100
              Height = 20
              TabOrder = 3
              OnKeyPress = edtMY_OUTPRICE2KeyPress
            end
          end
        end
      end
      object TabGoodPrice: TRzTabSheet
        Color = clWhite
        Caption = ' '#20250#21592#20215' '
        object RzPnl_Price: TRzPanel
          Left = 11
          Top = 16
          Width = 491
          Height = 175
          BorderOuter = fsFlat
          BorderColor = clGray
          TabOrder = 0
          object PriceGrid: TDBGridEh
            Left = 1
            Top = 1
            Width = 489
            Height = 173
            Align = alClient
            AllowedOperations = [alopUpdateEh]
            AutoFitColWidths = True
            DataSource = PRICEPrice_DS
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FrozenCols = 2
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
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
            OnDrawColumnCell = PriceGridDrawColumnCell
            OnExit = PriceGridExit
            OnKeyPress = PriceGridKeyPress
            Columns = <
              item
                EditButtons = <>
                FieldName = 'SEQNO'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 29
              end
              item
                EditButtons = <>
                FieldName = 'PRICE_Name'
                Footers = <>
                ReadOnly = True
                Title.Caption = #20250#21592#31561#32423
                Width = 83
              end
              item
                Alignment = taRightJustify
                DisplayFormat = '#0%'
                EditButtons = <>
                FieldName = 'PROFIT_RATE'
                Footers = <>
                Title.Caption = #25240#25187#29575
                Width = 62
              end
              item
                EditButtons = <>
                FieldName = 'NEW_OUTPRICE'
                Footers = <>
                Title.Caption = #35745#37327#21333#20301#21806#20215
                Width = 86
              end
              item
                EditButtons = <>
                FieldName = 'NEW_OUTPRICE1'
                Footers = <>
                Title.Caption = #23567#21253#35013#21806#20215
                Width = 93
              end
              item
                EditButtons = <>
                FieldName = 'NEW_OUTPRICE2'
                Footers = <>
                Title.Caption = #22823#21253#35013#21806#20215
                Width = 86
              end>
          end
        end
      end
      object TabSheet3: TRzTabSheet
        Color = clWhite
        Caption = #21830#21697#36873#39033
        object Label20: TLabel
          Left = 31
          Top = 12
          Width = 72
          Height = 12
          Alignment = taRightJustify
          Caption = #24211#23384#31649#29702#36873#39033
        end
        object Label27: TLabel
          Left = 290
          Top = 12
          Width = 84
          Height = 12
          Alignment = taRightJustify
          Caption = #20250#21592#25240#25187#29575#36873#39033
        end
        object Label18: TLabel
          Left = 31
          Top = 75
          Width = 72
          Height = 12
          Alignment = taRightJustify
          Caption = #25209#21495#31649#29702#36873#39033
        end
        object Label28: TLabel
          Left = 290
          Top = 75
          Width = 72
          Height = 12
          Alignment = taRightJustify
          Caption = #20250#21592#31215#20998#36873#39033
        end
        object Label45: TLabel
          Left = 33
          Top = 136
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #31215#20998#25442#36141
        end
        object edtGODS_TYPE: TRadioGroup
          Left = 30
          Top = 25
          Width = 200
          Height = 40
          Columns = 2
          Items.Strings = (
            #31649#29702#24211#23384
            #19981#31649#24211#23384)
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
        end
        object edtUSING_PRICE: TRadioGroup
          Left = 288
          Top = 25
          Width = 200
          Height = 40
          Columns = 2
          Items.Strings = (
            #21551#29992
            #31105#29992)
          TabOrder = 1
        end
        object edtUSING_BATCH_NO: TRadioGroup
          Left = 30
          Top = 88
          Width = 200
          Height = 40
          Columns = 2
          Items.Strings = (
            #21551#29992
            #31105#29992)
          TabOrder = 2
        end
        object edtHAS_INTEGRAL: TRadioGroup
          Left = 288
          Top = 88
          Width = 200
          Height = 40
          Columns = 2
          Items.Strings = (
            #21487#31215#20998
            #19981#31215#20998)
          TabOrder = 3
        end
        object edtUSING_BARTER: TGroupBox
          Left = 29
          Top = 151
          Width = 458
          Height = 40
          TabOrder = 4
          object RB_USING_BARTER: TRadioButton
            Left = 81
            Top = 14
            Width = 100
            Height = 17
            Caption = #21551#29992#20817#25442#31215#20998#65306
            TabOrder = 0
            OnClick = RB_NotUSING_BARTERClick
          end
          object RB_NotUSING_BARTER: TRadioButton
            Left = 8
            Top = 14
            Width = 48
            Height = 17
            Caption = #31105#29992
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = RB_NotUSING_BARTERClick
          end
          object edtBARTER_INTEGRAL: TcxSpinEdit
            Left = 181
            Top = 12
            Width = 64
            Height = 20
            Properties.ImmediatePost = True
            Properties.MaxValue = 99999999.000000000000000000
            Properties.ValueType = vtFloat
            TabOrder = 2
            ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          end
          object RB_USING_BARTER2: TRadioButton
            Left = 284
            Top = 14
            Width = 99
            Height = 17
            Caption = #21551#29992#25442#36141#31215#20998#65306
            TabOrder = 3
            OnClick = RB_NotUSING_BARTERClick
          end
          object edtBARTER_INTEGRAL2: TcxSpinEdit
            Left = 383
            Top = 12
            Width = 64
            Height = 20
            Properties.ImmediatePost = True
            Properties.MaxValue = 99999999.000000000000000000
            Properties.ValueType = vtFloat
            TabOrder = 4
            ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          end
        end
      end
      object tabProperty: TRzTabSheet
        Color = clWhite
        Caption = #32479#35745#25351#26631
        object Label17: TLabel
          Left = 35
          Top = 63
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #21830#21697#31867#21035
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label40: TLabel
          Left = 47
          Top = 85
          Width = 36
          Height = 12
          Alignment = taRightJustify
          Caption = #30465#20869#22806
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 35
          Top = 20
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #20027#20379#24212#21830
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 35
          Top = 43
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #25152#23646#21697#29260
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label44: TLabel
          Left = 35
          Top = 108
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #37325#28857#21697#29260
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtSORT_ID6: TzrComboBoxList
          Left = 87
          Top = 83
          Width = 162
          Height = 20
          Properties.AutoSelect = False
          Properties.Buttons = <
            item
              Default = True
            end>
          Properties.ReadOnly = True
          TabOrder = 4
          InGrid = False
          KeyValue = Null
          FilterFields = 'SORT_NAME;SORT_SPELL;SORT_ID'
          KeyField = 'SORT_ID'
          ListField = 'SORT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SORT_NAME'
              Footers = <>
              Title.Caption = #20998#31867#21517#31216
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'SORT_ID'
              Footers = <>
              Title.Caption = #20195#30721
              Visible = False
              Width = 50
            end>
          DropWidth = 100
          DropHeight = 120
          ShowTitle = False
          AutoFitColWidth = True
          OnAddClick = edtSORT_ID6AddClick
          ShowButton = True
          LocateStyle = lsDark
          Buttons = [zbNew]
          DropListStyle = lsEditFixed
          OnSaveValue = edtSORT_ID6SaveValue
          MultiSelect = False
        end
        object edtSORT_ID2: TzrComboBoxList
          Left = 87
          Top = 61
          Width = 162
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
          FilterFields = 'SORT_NAME;SORT_SPELL;SORT_ID'
          KeyField = 'SORT_ID'
          ListField = 'SORT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SORT_NAME'
              Footers = <>
              Title.Caption = #20998#31867#21517#31216
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'SORT_ID'
              Footers = <>
              Title.Caption = #20195#30721
              Visible = False
              Width = 50
            end>
          DropWidth = 100
          DropHeight = 120
          ShowTitle = False
          AutoFitColWidth = True
          OnAddClick = edtSORT_ID2AddClick
          ShowButton = True
          LocateStyle = lsDark
          Buttons = [zbNew]
          DropListStyle = lsEditFixed
          OnSaveValue = edtSORT_ID2SaveValue
          MultiSelect = False
        end
        object edtSORT_ID5: TzrComboBoxList
          Left = 87
          Top = 105
          Width = 162
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
          FilterFields = 'SORT_NAME;SORT_ID;SORT_SPELL'
          KeyField = 'SORT_ID'
          ListField = 'SORT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SORT_ID'
              Footers = <>
              Title.Caption = #21697#29260#20195#30721
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'SORT_NAME'
              Footers = <>
              Title.Caption = #21697#29260#21517#31216
            end
            item
              EditButtons = <>
              FieldName = 'SORT_SPELL'
              Footers = <>
              Title.Caption = #25340#38899#30721
              Visible = False
            end>
          DropWidth = 160
          DropHeight = 200
          ShowTitle = True
          AutoFitColWidth = True
          OnAddClick = edtSORT_ID5AddClick
          ShowButton = True
          LocateStyle = lsDark
          Buttons = [zbNew, zbClear]
          DropListStyle = lsFixed
          OnSaveValue = edtSORT_ID5SaveValue
          MultiSelect = False
        end
        object edtSORT_ID4: TzrComboBoxList
          Left = 87
          Top = 39
          Width = 162
          Height = 20
          Properties.AutoSelect = False
          Properties.Buttons = <
            item
              Default = True
            end>
          Properties.ReadOnly = True
          TabOrder = 1
          InGrid = False
          KeyValue = Null
          FilterFields = 'SORT_NAME;SORT_ID;SORT_SPELL'
          KeyField = 'SORT_ID'
          ListField = 'SORT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'SORT_ID'
              Footers = <>
              Title.Caption = #21697#29260#20195#30721
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'SORT_NAME'
              Footers = <>
              Title.Caption = #21697#29260#21517#31216
            end
            item
              EditButtons = <>
              FieldName = 'SORT_SPELL'
              Footers = <>
              Title.Caption = #25340#38899#30721
              Visible = False
            end>
          DropWidth = 160
          DropHeight = 200
          ShowTitle = True
          AutoFitColWidth = True
          OnAddClick = edtSORT_ID4AddClick
          ShowButton = True
          LocateStyle = lsDark
          Buttons = [zbNew, zbClear]
          DropListStyle = lsFixed
          OnSaveValue = edtSORT_ID4SaveValue
          MultiSelect = False
        end
        object edtSORT_ID3: TzrComboBoxList
          Left = 87
          Top = 17
          Width = 162
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
          FilterFields = 'CLIENT_ID;CLIENT_NAME;CLIENT_SPELL'
          KeyField = 'CLIENT_ID'
          ListField = 'CLIENT_NAME'
          Columns = <
            item
              EditButtons = <>
              FieldName = 'CLIENT_ID'
              Footers = <>
              Title.Caption = #38376#24215#20195#30721
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'CLIENT_CODE'
              Footers = <>
              Title.Caption = #20379#24212#21830#20195#30721
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'CLIENT_NAME'
              Footers = <>
              Title.Caption = #20379#24212#21830#21517#31216
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'CLIENT_SPELL'
              Footers = <>
              Title.Caption = #25340#38899#30721
              Visible = False
            end>
          DropWidth = 170
          DropHeight = 170
          ShowTitle = True
          AutoFitColWidth = True
          OnAddClick = edtSORT_ID3AddClick
          ShowButton = True
          LocateStyle = lsDark
          Buttons = [zbNew, zbClear]
          DropListStyle = lsFixed
          OnSaveValue = edtSORT_ID3SaveValue
          MultiSelect = False
        end
      end
    end
    inherited btPanel: TRzPanel
      Top = 377
      Width = 518
      Height = 44
      Color = clWhite
      TabOrder = 2
      DesignSize = (
        518
        44)
      object btnOk: TRzBitBtn
        Left = 342
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
        Left = 434
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
    object RzPanel1: TRzPanel
      Left = 5
      Top = 5
      Width = 518
      Height = 140
      Align = alTop
      BorderOuter = fsNone
      BorderColor = clWhite
      Color = clWhite
      TabOrder = 0
      object Label11: TLabel
        Left = 55
        Top = 30
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #36135#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 329
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #25340' '#38899' '#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 487
        Top = 51
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
      object Label3: TLabel
        Left = 31
        Top = 51
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21830#21697#21517#31216
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 260
        Top = 51
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
      object Label8: TLabel
        Left = 31
        Top = 95
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26631#20934#21806#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 329
        Top = 95
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26412#24215#21806#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label42: TLabel
        Left = 188
        Top = 30
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
      object Label30: TLabel
        Left = 31
        Top = 73
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #35745#37327#21333#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label41: TLabel
        Left = 188
        Top = 74
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
      object Label5: TLabel
        Left = 43
        Top = 10
        Width = 36
        Height = 12
        Alignment = taRightJustify
        Caption = #26465#24418#30721
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 188
        Top = 95
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
      object Label23: TLabel
        Left = 133
        Top = 117
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21442#32771#36827#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblPROFIT_RATE: TLabel
        Left = 122
        Top = 117
        Width = 6
        Height = 12
        Caption = '%'
      end
      object Label43: TLabel
        Left = 31
        Top = 117
        Width = 48
        Height = 12
        Caption = #36827#36135#25240#25187
      end
      object Label19: TLabel
        Left = 188
        Top = 9
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
      object Label12: TLabel
        Left = 329
        Top = 73
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #21830#21697#20998#31867
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Lbl_1: TLabel
        Left = 487
        Top = 73
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
      object Label31: TLabel
        Left = 329
        Top = 118
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = #26368#20302#21806#20215
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtGODS_SPELL: TcxTextEdit
        Left = 385
        Top = 47
        Width = 100
        Height = 20
        TabStop = False
        TabOrder = 3
      end
      object edtGODS_NAME: TcxTextEdit
        Left = 86
        Top = 47
        Width = 172
        Height = 20
        Properties.OnChange = edtGODS_NAMEPropertiesChange
        TabOrder = 2
      end
      object edtGODS_CODE: TcxTextEdit
        Left = 86
        Top = 26
        Width = 100
        Height = 20
        TabOrder = 1
        OnKeyPress = edtGODS_CODEKeyPress
      end
      object edtNEW_OUTPRICE: TcxTextEdit
        Left = 86
        Top = 91
        Width = 100
        Height = 20
        Properties.OnChange = edtNEW_OUTPRICEPropertiesChange
        TabOrder = 6
        OnKeyPress = edtNEW_OUTPRICEKeyPress
      end
      object edtMY_OUTPRICE: TcxTextEdit
        Left = 385
        Top = 91
        Width = 100
        Height = 20
        Properties.OnChange = edtMY_OUTPRICEPropertiesChange
        TabOrder = 7
        OnKeyPress = edtNEW_OUTPRICEKeyPress
      end
      object edtCALC_UNITS: TzrComboBoxList
        Left = 86
        Top = 69
        Width = 100
        Height = 20
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
          end>
        Properties.ReadOnly = True
        Properties.OnChange = edtCALC_UNITSPropertiesChange
        TabOrder = 4
        OnExit = edtCALC_UNITSExit
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
        OnAddClick = edtCALC_UNITSAddClick
        ShowButton = True
        LocateStyle = lsDark
        Buttons = [zbNew]
        DropListStyle = lsFixed
        OnSaveValue = edtCALC_UNITSSaveValue
        MultiSelect = False
      end
      object edtBARCODE1: TcxTextEdit
        Left = 86
        Top = 5
        Width = 100
        Height = 20
        TabOrder = 0
        OnKeyPress = edtBARCODE1KeyPress
      end
      object edtNEW_INPRICE: TcxTextEdit
        Left = 183
        Top = 113
        Width = 76
        Height = 20
        Properties.OnChange = edtNEW_INPRICEPropertiesChange
        TabOrder = 9
        OnKeyPress = edtNEW_OUTPRICEKeyPress
      end
      object edtPROFIT_RATE: TcxMaskEdit
        Left = 86
        Top = 113
        Width = 33
        Height = 20
        Properties.OnChange = edtPROFIT_RATEPropertiesChange
        TabOrder = 8
        OnKeyPress = edtPROFIT_RATEKeyPress
      end
      object edtNEW_LOWPRICE: TcxTextEdit
        Left = 385
        Top = 113
        Width = 100
        Height = 20
        Properties.OnChange = edtMY_OUTPRICEPropertiesChange
        TabOrder = 10
        OnKeyPress = edtNEW_LOWPRICEKeyPress
      end
      object edtSORT_ID1: TcxButtonEdit
        Left = 385
        Top = 69
        Width = 100
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Properties.OnButtonClick = edtSORT_ID1PropertiesButtonClick
        TabOrder = 5
        OnKeyPress = edtSORT_ID1KeyPress
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 432
  end
  inherited actList: TActionList
    Left = 48
    Top = 440
    object CtrlUp1: TAction
      Caption = #21521#19978
    end
    object CtrlDown1: TAction
      Caption = #21521#19979
    end
    object CtrlUp2: TAction
      Caption = #21521#19978
    end
    object CtrlDown2: TAction
      Caption = #21521#19979
    end
  end
  object BarCode: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,COMP_ID fro' +
        'm VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      
        'and (COMP_ID=:COMP_ID or COMP_ID='#39'----'#39' or COMP_ID in (select UP' +
        'COMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_TYPE=2)'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID=:COMP' +
        '_ID and COMP_TYPE=2 and COMM not in ('#39'02'#39','#39'12'#39'))'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID in (s' +
        'elect UPCOMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_' +
        'TYPE=2) and COMP_TYPE=2)'
      ') order by ACCOUNT')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
    Left = 47
    Top = 386
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
  end
  object cdsGoods: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,COMP_ID fro' +
        'm VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      
        'and (COMP_ID=:COMP_ID or COMP_ID='#39'----'#39' or COMP_ID in (select UP' +
        'COMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_TYPE=2)'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID=:COMP' +
        '_ID and COMP_TYPE=2 and COMM not in ('#39'02'#39','#39'12'#39'))'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID in (s' +
        'elect UPCOMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_' +
        'TYPE=2) and COMP_TYPE=2)'
      ') order by ACCOUNT')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
    Left = 7
    Top = 386
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
  end
  object CdsMemberPrice: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    SQL.Strings = (
      
        'select USER_ID,USER_SPELL,USER_NAME,ACCOUNT,DUTY_IDS,COMP_ID fro' +
        'm VIW_USERS where COMM not in ('#39'02'#39','#39'12'#39')'
      
        'and (COMP_ID=:COMP_ID or COMP_ID='#39'----'#39' or COMP_ID in (select UP' +
        'COMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_TYPE=2)'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID=:COMP' +
        '_ID and COMP_TYPE=2 and COMM not in ('#39'02'#39','#39'12'#39'))'
      ' or'
      
        'COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID in (s' +
        'elect UPCOMP_ID from CA_COMPANY where COMP_ID=:COMP_ID and COMP_' +
        'TYPE=2) and COMP_TYPE=2)'
      ') order by ACCOUNT')
    Params = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
    Left = 89
    Top = 389
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COMP_ID'
        ParamType = ptUnknown
      end>
  end
  object PRICEPrice_DS: TDataSource
    DataSet = CdsMemberPrice
    Left = 117
    Top = 393
  end
end
