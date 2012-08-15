inherited frmStorageDayReport: TfrmStorageDayReport
  Left = 191
  Width = 1083
  Height = 622
  Caption = #21830#21697#24211#23384#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1075
    Height = 558
    inherited RzPanel2: TRzPanel
      Width = 1065
      Height = 548
      inherited RzPage: TRzPageControl
        Width = 860
        Height = 542
        ActivePage = TabSheet4
        Color = clCream
        ParentColor = False
        TabIndex = 3
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = #22320#21306#24211#23384#27719#24635#34920
          inherited RzPanel3: TRzPanel
            Width = 858
            Height = 515
            inherited Panel4: TPanel
              Width = 848
              Height = 505
              inherited w1: TRzPanel
                Width = 848
                Height = 80
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24211#23384#26085#26399
                end
                object Label6: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label7: TLabel
                  Left = 24
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label8: TLabel
                  Left = 702
                  Top = 57
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label5: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object P1_D1: TcxDateEdit
                  Left = 154
                  Top = 9
                  Width = 119
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object btnOk: TRzBitBtn
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
                  TabOrder = 8
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 53
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 4
                end
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 752
                  Top = 53
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 7
                end
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 53
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 5
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 344
                  Top = 53
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 6
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 31
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP1_ReckType: TcxComboBox
                  Left = 80
                  Top = 9
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #24403#21069#24211#23384
                    #26085#32467#24211#23384)
                  TabOrder = 0
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 80
                Width = 848
                Height = 425
                inherited DBGridEh1: TDBGridEh
                  Width = 844
                  Height = 421
                  FrozenCols = 3
                  TitleHeight = 22
                  UseMultiTitle = False
                  OnDblClick = DBGridEh1DblClick
                  OnGetFooterParams = DBGridEh1GetFooterParams
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
                      FieldName = 'REGION_ID'
                      Footers = <>
                      Title.Caption = #22320#21306#20195#30721
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #22320#21306#21517#31216
                      Width = 153
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25968#37327
                      Width = 100
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_PRC'
                      Footer.DisplayFormat = '#0.00#'
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 91
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25104#26412
                      Width = 97
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_OUTPRC'
                      Footer.DisplayFormat = '#0.00#'
                      Footers = <>
                      Title.Caption = #38646#21806#22343#20215
                      Width = 79
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 97
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clCream
          Caption = #38376#24215#24211#23384#27719#24635#34920
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 858
            Height = 515
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel1: TPanel
              Left = 5
              Top = 5
              Width = 848
              Height = 505
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 848
                Height = 80
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  848
                  80)
                object RzLabel4: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24211#23384#26085#26399
                end
                object Label10: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label13: TLabel
                  Left = 288
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label14: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label15: TLabel
                  Left = 697
                  Top = 56
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object P2_D1: TcxDateEdit
                  Left = 154
                  Top = 8
                  Width = 119
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP2_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 30
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 478
                  Top = 41
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
                  TabOrder = 8
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
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 4
                end
                object fndP2_UNIT_ID: TcxComboBox
                  Left = 753
                  Top = 52
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 7
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
                  TabOrder = 5
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP2_SORT_ID: TcxButtonEdit
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
                  Properties.OnButtonClick = fndP2_SORT_IDPropertiesButtonClick
                  TabOrder = 6
                  OnKeyPress = fndP2_SORT_IDKeyPress
                end
                object fndP2_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP2_ReckType: TcxComboBox
                  Left = 80
                  Top = 8
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #24403#21069#24211#23384
                    #26085#32467#24211#23384)
                  TabOrder = 0
                end
              end
              object RzPanel10: TRzPanel
                Left = 0
                Top = 80
                Width = 848
                Height = 425
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh2: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 844
                  Height = 421
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
                  TitleHeight = 22
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDblClick = DBGridEh2DblClick
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
                  OnGetFooterParams = DBGridEh2GetFooterParams
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
                      FieldName = 'SHOP_CODE'
                      Footers = <>
                      Title.Caption = #38376#24215#20195#30721
                      Width = 59
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 146
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25968#37327
                      Width = 100
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_PRC'
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 91
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footers = <>
                      Title.Caption = #24211#23384#25104#26412
                      Width = 97
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_OUTPRC'
                      Footers = <>
                      Title.Caption = #38646#21806#22343#20215
                      Width = 79
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 97
                    end>
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clCream
          Caption = #20998#31867#24211#23384#27719#24635#34920
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 858
            Height = 515
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel3: TPanel
              Left = 5
              Top = 5
              Width = 848
              Height = 505
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel11: TRzPanel
                Left = 0
                Top = 0
                Width = 848
                Height = 80
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  848
                  80)
                object RzLabel6: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24211#23384#26085#26399
                end
                object Label9: TLabel
                  Left = 24
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label19: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = #25253#34920#31867#22411
                end
                object Label20: TLabel
                  Left = 705
                  Top = 57
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label11: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object P3_D1: TcxDateEdit
                  Left = 154
                  Top = 8
                  Width = 119
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 478
                  Top = 43
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
                object fndP3_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 53
                  Width = 193
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
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL;SEQ_NO'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP3_REPORT_FLAG: TcxComboBox
                  Left = 344
                  Top = 53
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP3_REPORT_FLAGPropertiesChange
                  TabOrder = 5
                end
                object fndP3_UNIT_ID: TcxComboBox
                  Left = 755
                  Top = 53
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 6
                end
                object fndP3_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 30
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP3_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP3_ReckType: TcxComboBox
                  Left = 80
                  Top = 8
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #24403#21069#24211#23384
                    #26085#32467#24211#23384)
                  TabOrder = 0
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 80
                Width = 848
                Height = 425
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh3: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 844
                  Height = 421
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
                  TitleHeight = 22
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDblClick = DBGridEh3DblClick
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
                  OnGetFooterParams = DBGridEh3GetFooterParams
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
                      FieldName = 'SORT_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #20998#31867#21517#31216
                      Width = 171
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25968#37327
                      Width = 100
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_PRC'
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 91
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25104#26412
                      Width = 97
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_OUTPRC'
                      Footers = <>
                      Title.Caption = #38646#21806#20215
                      Width = 79
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 97
                    end>
                end
              end
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Color = clCream
          Caption = #21830#21697#24211#23384#27719#24635#34920
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 858
            Height = 515
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel6: TPanel
              Left = 5
              Top = 5
              Width = 848
              Height = 505
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel14: TRzPanel
                Left = 0
                Top = 0
                Width = 848
                Height = 101
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  848
                  101)
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24211#23384#26085#26399
                end
                object Label21: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label24: TLabel
                  Left = 289
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label25: TLabel
                  Left = 24
                  Top = 78
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label26: TLabel
                  Left = 701
                  Top = 78
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label12: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label4: TLabel
                  Left = 289
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #24211#23384#25968#37327
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label38: TLabel
                  Left = 289
                  Top = 78
                  Width = 48
                  Height = 12
                  Caption = #32479#35745#31867#22411
                end
                object P4_D1: TcxDateEdit
                  Left = 154
                  Top = 8
                  Width = 119
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object RzBitBtn3: TRzBitBtn
                  Left = 478
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
                  TabOrder = 11
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP4_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 74
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 7
                end
                object fndP4_UNIT_ID: TcxComboBox
                  Left = 751
                  Top = 74
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 10
                end
                object fndP4_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 74
                  Width = 119
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 8
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
                  TabOrder = 6
                  OnKeyPress = fndP4_SORT_IDKeyPress
                end
                object fndP4_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 52
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 5
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL;SEQ_NO'
                  KeyField = 'SHOP_ID'
                  ListField = 'SHOP_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
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
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP4_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 154
                  Top = 30
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbClear, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
                object fndP4_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP4_ReckType: TcxComboBox
                  Left = 80
                  Top = 8
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #24403#21069#24211#23384
                    #26085#32467#24211#23384)
                  TabOrder = 0
                end
                object fndP4_STOR_AMT: TcxComboBox
                  Left = 344
                  Top = 30
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20840#37096
                    #19981#20026#38646
                    #22823#20110#38646
                    #31561#20110#38646
                    #23567#20110#38646)
                  TabOrder = 4
                end
                object fndP4_RPTTYPE: TcxComboBox
                  Left = 344
                  Top = 74
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #38376#24215#36827#38144#23384#32479#35745#34920
                    #21830#21697#36827#38144#23384#32479#35745#34920
                    #32676#32452#36827#38144#23384#32479#35745#34920
                    #20379#24212#21830#36827#38144#23384#32479#35745#34920)
                  TabOrder = 9
                end
                object Button1: TButton
                  Left = 568
                  Top = 32
                  Width = 75
                  Height = 25
                  Caption = 'Button1'
                  TabOrder = 12
                  OnClick = Button1Click
                end
              end
              object RzPanel15: TRzPanel
                Left = 0
                Top = 101
                Width = 848
                Height = 404
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh4: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 844
                  Height = 400
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
                  TitleHeight = 22
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = DBGridEh4DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
                  OnGetFooterParams = DBGridEh4GetFooterParams
                  OnTitleClick = DBGridEh4TitleClick
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
                      FieldName = 'GODS_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 153
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 82
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 82
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
                      FieldName = 'BAL_AMT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25968#37327
                      Width = 100
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_PRC'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 91
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#25104#26412
                      Width = 97
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_OUTPRC'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #38646#21806#20215
                      Width = 79
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 97
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 863
        Height = 542
        inherited Panel2: TPanel
          Height = 499
          inherited RzPanel1: TRzPanel [3]
          end
          inherited Panel5: TPanel [4]
            Height = 384
            inherited rzShowColumns: TRzCheckList
              Height = 380
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1075
    inherited Image14: TImage
      Left = 1055
    end
    inherited Image1: TImage
      Width = 705
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 72
        Caption = #21830#21697#24211#23384#25253#34920
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 136
    Top = 448
  end
  inherited actList: TActionList
    Left = 168
    Top = 448
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 41
    Top = 354
  end
  inherited SaveDialog1: TSaveDialog
    Left = 237
    Top = 220
  end
  inherited adoReport1: TZQuery
    Left = 41
    Top = 321
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
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
    Left = 89
    Top = 321
  end
  object adoReport3: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 137
    Top = 321
  end
  object adoReport4: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 185
    Top = 321
  end
end
