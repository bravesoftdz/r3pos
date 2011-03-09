inherited frmJxcTotalReport: TfrmJxcTotalReport
  Left = 193
  Top = 105
  Width = 953
  Height = 597
  Caption = #36827#38144#23384#32479#35745#34920
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 945
    Height = 540
    inherited RzPanel2: TRzPanel
      Width = 935
      Height = 530
      inherited RzPage: TRzPageControl
        Width = 730
        Height = 524
        Color = clCream
        ParentColor = False
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = #22320#21306#36827#38144#23384#32479#35745#34920
          inherited RzPanel3: TRzPanel
            Width = 728
            Height = 497
            BorderColor = clBtnFace
            inherited Panel4: TPanel
              Width = 718
              Height = 487
              inherited w1: TRzPanel
                Width = 718
                Height = 83
                object Label6: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #25152#23646#26376#20221
                end
                object RzLabel3: TRzLabel
                  Left = 171
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label7: TLabel
                  Left = 24
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label8: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object Label5: TLabel
                  Left = 24
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object btnOk: TRzBitBtn
                  Left = 476
                  Top = 42
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = #26597#35810
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
                  TabOrder = 6
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 54
                  Width = 76
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP1_TYPE_IDPropertiesChange
                  TabOrder = 2
                end
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 344
                  Top = 54
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 5
                end
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 156
                  Top = 54
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 3
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 344
                  Top = 32
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 4
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object P1_D1: TzrMonthEdit
                  Left = 80
                  Top = 10
                  Width = 76
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object P1_D2: TzrMonthEdit
                  Left = 198
                  Top = 10
                  Width = 77
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object RadioButton1: TRadioButton
                  Left = 287
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#26376
                  TabOrder = 7
                end
                object RadioButton2: TRadioButton
                  Left = 343
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #19978#26376
                  TabOrder = 8
                end
                object RadioButton3: TRadioButton
                  Left = 399
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#23395
                  TabOrder = 9
                end
                object RadioButton4: TRadioButton
                  Left = 455
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#24180
                  TabOrder = 10
                end
                object fndP1_GROUP_ID: TcxComboBox
                  Left = 80
                  Top = 32
                  Width = 76
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP1_GROUP_IDPropertiesChange
                  TabOrder = 11
                end
                object fndP1_GROUP_LIST: TzrComboBoxList
                  Tag = -1
                  Left = 156
                  Top = 32
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 12
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 83
                Width = 718
                Height = 404
                inherited DBGridEh1: TDBGridEh
                  Width = 714
                  Height = 400
                  FrozenCols = 3
                  OnDblClick = DBGridEh1DblClick
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
                      EditButtons = <>
                      FieldName = 'GROUP_ID'
                      Footers = <>
                      Title.Caption = #22320#21306#20195#30721
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GROUP_NAME'
                      Footers = <>
                      Title.Caption = #22320#21306#21517#31216
                      Width = 153
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'ORG_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#37329#39069
                      Width = 79
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMOUNT'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#25968#37327
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'IN_AMONEY'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#37329#39069
                      Width = 81
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'IN_TAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#31246#39069
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'IN_NOTAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMOUNT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SAL_AMONEY'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#37329#39069
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SAL_TAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#31246#39069
                      Width = 67
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SAL_NOTAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SAL_COST'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25104#26412
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SAL_PROFIT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'PROFIT_RATE'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033#29575
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMOUNT'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'COMB_AMONEY'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'RCK_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#37329#39069
                      Width = 77
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clCream
          Caption = #38376#24215#36827#38144#23384#32479#35745#34920
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 728
            Height = 497
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel1: TPanel
              Left = 5
              Top = 5
              Width = 718
              Height = 487
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 718
                Height = 81
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                Color = clWhite
                TabOrder = 0
                object Label10: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label13: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object RzLabel4: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #25152#23646#26376#20221
                end
                object RzLabel5: TRzLabel
                  Left = 171
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label14: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label15: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object fndP2_GROUP_LIST: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 31
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 478
                  Top = 40
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = #26597#35810
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
                  TabOrder = 7
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP2_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 52
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP2_TYPE_IDPropertiesChange
                  TabOrder = 3
                end
                object fndP2_UNIT_ID: TcxComboBox
                  Left = 344
                  Top = 53
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 6
                end
                object fndP2_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 52
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 4
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP2_SORT_ID: TcxButtonEdit
                  Left = 344
                  Top = 32
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP2_SORT_IDPropertiesButtonClick
                  TabOrder = 5
                  OnKeyPress = fndP2_SORT_IDKeyPress
                end
                object P2_D2: TzrMonthEdit
                  Left = 197
                  Top = 10
                  Width = 76
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object P2_D1: TzrMonthEdit
                  Left = 80
                  Top = 10
                  Width = 78
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object RadioButton5: TRadioButton
                  Left = 287
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#26376
                  TabOrder = 8
                end
                object RadioButton6: TRadioButton
                  Left = 343
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #19978#26376
                  TabOrder = 9
                end
                object RadioButton7: TRadioButton
                  Left = 399
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#23395
                  TabOrder = 10
                end
                object RadioButton8: TRadioButton
                  Left = 455
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#24180
                  TabOrder = 11
                end
                object fndP2_GROUP_ID: TcxComboBox
                  Left = 80
                  Top = 31
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP2_GROUP_IDPropertiesChange
                  TabOrder = 12
                end
              end
              object RzPanel10: TRzPanel
                Left = 0
                Top = 81
                Width = 718
                Height = 406
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh2: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 714
                  Height = 402
                  Align = alClient
                  AllowedOperations = []
                  BorderStyle = bsNone
                  Color = clWhite
                  Ctl3D = True
                  DataSource = dsadoReport2
                  Flat = True
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
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
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDblClick = DBGridEh2DblClick
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
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
                      EditButtons = <>
                      FieldName = 'COMP_ID'
                      Footers = <>
                      Title.Caption = #38376#24215#20195#30721
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMP_NAME'
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 153
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#37329#39069
                      Width = 79
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMOUNT'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMONEY'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#37329#39069
                      Width = 81
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_TAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#31246#39069
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_NOTAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMOUNT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMONEY'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#37329#39069
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_TAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#31246#39069
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_NOTAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_COST'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25104#26412
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_PROFIT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'PROFIT_RATE'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033#29575
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#37329#39069
                      Width = 70
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#37329#39069
                      Width = 73
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMOUNT'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMONEY'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#37329#39069
                      Width = 77
                    end>
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clCream
          Caption = #20998#31867#36827#38144#23384#32479#35745#34920
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 728
            Height = 497
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel3: TPanel
              Left = 5
              Top = 5
              Width = 718
              Height = 487
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel11: TRzPanel
                Left = 0
                Top = 0
                Width = 718
                Height = 84
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                Color = clWhite
                TabOrder = 0
                object Label9: TLabel
                  Left = 24
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object RzLabel6: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #25152#23646#26376#20221
                end
                object RzLabel7: TRzLabel
                  Left = 172
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label19: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #25253#34920#31867#22411
                end
                object Label20: TLabel
                  Left = 288
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object Label11: TLabel
                  Left = 24
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object fndP3_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 54
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'COMP_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMP_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 478
                  Top = 42
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = #26597#35810
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
                  TabOrder = 5
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP3_TYPE_ID: TcxComboBox
                  Left = 344
                  Top = 32
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 3
                end
                object fndP3_UNIT_ID: TcxComboBox
                  Left = 344
                  Top = 54
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 4
                end
                object P3_D2: TzrMonthEdit
                  Left = 196
                  Top = 10
                  Width = 77
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object P3_D1: TzrMonthEdit
                  Left = 80
                  Top = 10
                  Width = 79
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object RadioButton9: TRadioButton
                  Left = 287
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#26376
                  TabOrder = 6
                end
                object RadioButton10: TRadioButton
                  Left = 343
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #19978#26376
                  TabOrder = 7
                end
                object RadioButton11: TRadioButton
                  Left = 399
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#23395
                  TabOrder = 8
                end
                object RadioButton12: TRadioButton
                  Left = 455
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#24180
                  TabOrder = 9
                end
                object fndP3_GROUP_LIST: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 32
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 10
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP3_GROUP_ID: TcxComboBox
                  Left = 80
                  Top = 32
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP3_GROUP_IDPropertiesChange
                  TabOrder = 11
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 84
                Width = 718
                Height = 403
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh3: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 714
                  Height = 399
                  Align = alClient
                  AllowedOperations = []
                  BorderStyle = bsNone
                  Color = clWhite
                  Ctl3D = True
                  DataSource = dsadoReport3
                  Flat = True
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
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
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDblClick = DBGridEh3DblClick
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
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
                      EditButtons = <>
                      FieldName = 'SORT_ID'
                      Footers = <>
                      Title.Caption = #20998#31867#20195#30721
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SORT_NAME'
                      Footers = <>
                      Title.Caption = #20998#31867#21517#31216
                      Width = 209
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#37329#39069
                      Width = 79
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMOUNT'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMONEY'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#37329#39069
                      Width = 81
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_TAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#31246#39069
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_NOTAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMOUNT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMONEY'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#37329#39069
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_TAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#31246#39069
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_NOTAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_COST'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25104#26412
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_PROFIT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'PROFIT_RATE'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033#29575
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMOUNT'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMONEY'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#37329#39069
                      Width = 77
                    end>
                end
              end
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Color = clCream
          Caption = #21830#21697#36827#38144#23384#32479#35745#34920
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 728
            Height = 497
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel6: TPanel
              Left = 5
              Top = 5
              Width = 718
              Height = 487
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel14: TRzPanel
                Left = 0
                Top = 0
                Width = 718
                Height = 105
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                Color = clWhite
                TabOrder = 0
                object Label21: TLabel
                  Left = 24
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label24: TLabel
                  Left = 288
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #25152#23646#26376#20221
                end
                object RzLabel9: TRzLabel
                  Left = 175
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label25: TLabel
                  Left = 24
                  Top = 79
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label26: TLabel
                  Left = 288
                  Top = 80
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                end
                object Label3: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object RzBitBtn3: TRzBitBtn
                  Left = 480
                  Top = 64
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = #26597#35810
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
                  TabOrder = 7
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP4_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 76
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP4_TYPE_IDPropertiesChange
                  TabOrder = 3
                end
                object fndP4_UNIT_ID: TcxComboBox
                  Left = 344
                  Top = 76
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 6
                end
                object fndP4_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 76
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 4
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP4_SORT_ID: TcxButtonEdit
                  Left = 344
                  Top = 52
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP4_SORT_IDPropertiesButtonClick
                  TabOrder = 5
                  OnKeyPress = fndP4_SORT_IDKeyPress
                end
                object fndP4_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 54
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'COMP_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMP_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object P4_D2: TzrMonthEdit
                  Left = 199
                  Top = 10
                  Width = 74
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object P4_D1: TzrMonthEdit
                  Left = 80
                  Top = 10
                  Width = 81
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 0
                  Text = '2010-01'
                  Year = 0
                  Month = 0
                  asString = '000000'
                  asFormatString = '0000-00'
                end
                object RadioButton13: TRadioButton
                  Left = 287
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#26376
                  TabOrder = 8
                end
                object RadioButton14: TRadioButton
                  Left = 343
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #19978#26376
                  TabOrder = 9
                end
                object RadioButton15: TRadioButton
                  Left = 399
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#23395
                  TabOrder = 10
                end
                object RadioButton16: TRadioButton
                  Left = 455
                  Top = 12
                  Width = 53
                  Height = 17
                  Caption = #26412#24180
                  TabOrder = 11
                end
                object fndP4_GROUP_LIST: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 32
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 12
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
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = #20195#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP4_GROUP_ID: TcxComboBox
                  Left = 80
                  Top = 32
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP4_GROUP_IDPropertiesChange
                  TabOrder = 13
                end
              end
              object RzPanel15: TRzPanel
                Left = 0
                Top = 105
                Width = 718
                Height = 382
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh4: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 714
                  Height = 378
                  Align = alClient
                  AllowedOperations = []
                  BorderStyle = bsNone
                  Color = clWhite
                  Ctl3D = True
                  DataSource = dsadoReport4
                  Flat = True
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
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
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
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
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 153
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#21021'|'#37329#39069
                      Width = 79
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMOUNT'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_AMONEY'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#37329#39069
                      Width = 81
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_TAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#31246#39069
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'IN_NOTAX'
                      Footers = <>
                      Title.Caption = #36827#36135'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMOUNT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25968#37327
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_AMONEY'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#37329#39069
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SAL_TAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#31246#39069
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_NOTAX'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#19981#21547#31246#37329#39069
                      Visible = False
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_COST'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#25104#26412
                      Width = 72
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SAL_PROFIT'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'PROFIT_RATE'
                      Footers = <>
                      Title.Caption = #38144#21806'|'#27611#21033#29575
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEIN_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20837'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMOUNT'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'MOVEOUT_AMONEY'
                      Footers = <>
                      Title.Caption = #35843#20986'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMOUNT'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMB_AMONEY'
                      Footers = <>
                      Title.Caption = #25414#32465#25286#21368'|'#37329#39069
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMOUNT'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#25968#37327
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RCK_AMONEY'
                      Footers = <>
                      Title.Caption = #26399#26410'|'#37329#39069
                      Width = 77
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 733
        Height = 524
        inherited Panel2: TPanel
          Height = 474
          inherited RzPanel1: TRzPanel [3]
          end
          inherited Panel5: TPanel [4]
            Height = 359
            inherited rzShowColumns: TRzCheckList
              Height = 355
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 945
    inherited Image1: TImage
      Width = 430
    end
    inherited Image14: TImage
      Left = 936
    end
    inherited Image3: TImage
      Width = 430
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 72
        Caption = #36827#38144#23384#32479#35745#34920
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 128
    Top = 400
  end
  inherited actList: TActionList
    Left = 192
    Top = 392
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 41
    Top = 354
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    PageHeader.CenterText.Strings = (
      #38144#21806#27719#24635#34920)
    PageHeader.Font.Charset = GB2312_CHARSET
    PageHeader.Font.Height = -16
    PageHeader.Font.Name = #23435#20307
    PageHeader.Font.Style = [fsBold]
    Left = 80
    Top = 256
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C6C616E67323035325C66305C6673323420255B7768725D5C6631
      5C66733136200D0A5C706172207D0D0A00}
  end
  inherited adoReport1: TZQuery
    Left = 41
    Top = 321
  end
  object dsadoReport2: TDataSource
    DataSet = adoReport2
    Left = 89
    Top = 354
  end
  object dsadoReport3: TDataSource
    DataSet = adoReport3
    Left = 137
    Top = 354
  end
  object dsadoReport4: TDataSource
    DataSet = adoReport4
    Left = 185
    Top = 354
  end
  object adoReport2: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 90
    Top = 322
  end
  object adoReport3: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 138
    Top = 322
  end
  object adoReport4: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 186
    Top = 323
  end
end
