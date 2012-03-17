inherited frmSaleManSaleReport: TfrmSaleManSaleReport
  Left = 187
  Top = 103
  Width = 1093
  Height = 568
  Caption = #20154#21592#38144#21806#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1085
    Height = 504
    inherited RzPanel2: TRzPanel
      Width = 1075
      Height = 494
      inherited RzPage: TRzPageControl
        Width = 870
        Height = 488
        ActivePage = TabSheet2
        ParentColor = False
        TabIndex = 1
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #37096#38376#38144#21806#27719#24635#34920
          inherited RzPanel3: TRzPanel
            Width = 868
            Height = 461
            inherited Panel4: TPanel
              Width = 858
              Height = 451
              inherited w1: TRzPanel
                Width = 858
                Height = 122
                object RzLabel1: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26085#26399
                end
                object RzLabel12: TRzLabel
                  Left = 171
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label3: TLabel
                  Left = 288
                  Top = 78
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label4: TLabel
                  Left = 24
                  Top = 77
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label16: TLabel
                  Left = 716
                  Top = 101
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label23: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label32: TLabel
                  Left = 288
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object Label33: TLabel
                  Left = 24
                  Top = 99
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#21517#31216
                end
                object Label38: TLabel
                  Left = 24
                  Top = 55
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label39: TLabel
                  Left = 288
                  Top = 55
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #23548' '#36141' '#21592
                end
                object Label8: TLabel
                  Left = 288
                  Top = 99
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 187
                  Top = 8
                  Width = 86
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object BtnDept: TRzBitBtn
                  Left = 478
                  Top = 86
                  Width = 67
                  Height = 29
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
                  TabOrder = 13
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 74
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 7
                end
                object fndP1_UNIT_ID: TcxComboBox
                  Left = 766
                  Top = 97
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 12
                end
                object fndP1_STAT_ID: TzrComboBoxList
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
                end
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 344
                  Top = 74
                  Width = 121
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 9
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
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
                end
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 344
                  Top = 30
                  Width = 121
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
                  FilterFields = 'DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                  RangeField = 'DEPT_TYPE'
                  RangeValue = '1'
                end
                object fndP1_GODS_ID: TzrComboBoxList
                  Tag = 100
                  Left = 80
                  Top = 96
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 10
                  InGrid = True
                  KeyValue = Null
                  FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
                  KeyField = 'GODS_ID'
                  ListField = 'GODS_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 150
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 50
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 65
                    end>
                  DropWidth = 380
                  DropHeight = 250
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbNew, zbFind]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SHOP_ID: TzrComboBoxList
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 344
                  Top = 52
                  Width = 121
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 6
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #22995#21517
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USER_SPELL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP1_SALES_TYPE: TcxComboBox
                  Left = 344
                  Top = 96
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 11
                end
                inline P1_DateControl: TfrmDateControl
                  Left = 279
                  Top = 8
                  Width = 170
                  Height = 20
                  TabOrder = 14
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 122
                Width = 858
                Height = 329
                inherited DBGridEh1: TDBGridEh
                  Width = 854
                  Height = 325
                  OnDblClick = DBGridEh1DblClick
                  OnGetFooterParams = DBGridEh1GetFooterParams
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_ID'
                      Footers = <>
                      Title.Caption = #37096#38376#32534#30721
                      Visible = False
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #37096#38376#21517#31216
                      Width = 153
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25968#37327
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRC'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #22343#20215
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 84
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#39033#31246#39069
                      Width = 82
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#31246#37329#39069
                      Width = 76
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25104#26412
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_ALLPRF'
                      Footer.Alignment = taRightJustify
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #27611#21033
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #27611#21033#29575
                      Width = 49
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footers = <>
                      Title.Caption = #21333#20301#27611#21033
                      Width = 67
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #20154#21592#38144#21806#27719#24635#34920
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 868
            Height = 461
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object RzPanel9: TRzPanel
              Left = 5
              Top = 5
              Width = 858
              Height = 144
              Align = alTop
              Alignment = taRightJustify
              BorderOuter = fsGroove
              BorderSides = [sdLeft, sdTop, sdRight]
              TabOrder = 0
              DesignSize = (
                858
                144)
              object RzLabel4: TRzLabel
                Left = 24
                Top = 12
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38144#21806#26085#26399
              end
              object RzLabel5: TRzLabel
                Left = 170
                Top = 12
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label10: TLabel
                Left = 24
                Top = 34
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38376#24215#32676#32452
              end
              object Label13: TLabel
                Left = 24
                Top = 101
                Width = 48
                Height = 12
                Caption = #21830#21697#20998#31867
              end
              object Label14: TLabel
                Left = 24
                Top = 78
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21830#21697#25351#26631
              end
              object Label15: TLabel
                Left = 714
                Top = 123
                Width = 48
                Height = 12
                Anchors = [akTop, akRight]
                Caption = #26174#31034#21333#20301
              end
              object Label34: TLabel
                Left = 288
                Top = 56
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object Label30: TLabel
                Left = 24
                Top = 123
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #21830#21697#21517#31216
              end
              object Label41: TLabel
                Left = 288
                Top = 101
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #23548' '#36141' '#21592
              end
              object Label9: TLabel
                Left = 24
                Top = 56
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38376#24215#21517#31216
              end
              object Label31: TLabel
                Left = 290
                Top = 123
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #38144#21806#31867#22411
              end
              object Label46: TLabel
                Left = 287
                Top = 78
                Width = 48
                Height = 12
                Caption = #20154#21592#31867#21035
                Visible = False
              end
              object P2_D1: TcxDateEdit
                Left = 80
                Top = 8
                Width = 85
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object P2_D2: TcxDateEdit
                Left = 186
                Top = 8
                Width = 87
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
              end
              object BtnSort: TRzBitBtn
                Left = 478
                Top = 108
                Width = 67
                Height = 29
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
                TabOrder = 14
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndP2_TYPE_ID: TcxComboBox
                Left = 80
                Top = 74
                Width = 73
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsEditFixedList
                Properties.Items.Strings = (
                  #20027#20379#24212#21830
                  #21697#29260#21517#31216)
                TabOrder = 6
              end
              object fndP2_UNIT_ID: TcxComboBox
                Left = 764
                Top = 119
                Width = 80
                Height = 20
                Anchors = [akTop, akRight]
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsEditFixedList
                Properties.Items.Strings = (
                  #35745#37327#21333#20301
                  #21253#35013'1'
                  #21253#35013'2')
                TabOrder = 13
              end
              object fndP2_STAT_ID: TzrComboBoxList
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
                TabOrder = 7
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
                Left = 80
                Top = 97
                Width = 193
                Height = 20
                Properties.Buttons = <
                  item
                    Default = True
                    Kind = bkEllipsis
                  end>
                Properties.ReadOnly = True
                Properties.OnButtonClick = fndP2_SORT_IDPropertiesButtonClick
                TabOrder = 9
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
                  #34892#25919#22320#21306
                  #31649#29702#32676#32452)
                TabOrder = 2
              end
              object fndP2_DEPT_ID: TzrComboBoxList
                Left = 344
                Top = 52
                Width = 121
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
                FilterFields = 'DEPT_NAME;DEPT_SPELL'
                KeyField = 'DEPT_ID'
                ListField = 'DEPT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
                RangeField = 'DEPT_TYPE'
                RangeValue = '1'
              end
              object fndP2_GODS_ID: TzrComboBoxList
                Tag = 100
                Left = 80
                Top = 119
                Width = 193
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 11
                InGrid = True
                KeyValue = Null
                FilterFields = 'GODS_CODE;GODS_NAME;GODS_SPELL;BARCODE'
                KeyField = 'GODS_ID'
                ListField = 'GODS_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'GODS_NAME'
                    Footers = <>
                    Title.Caption = #21830#21697#21517#31216
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GODS_CODE'
                    Footers = <>
                    Title.Caption = #36135#21495
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'BARCODE'
                    Footers = <>
                    Title.Caption = #26465#30721
                    Width = 65
                  end>
                DropWidth = 380
                DropHeight = 250
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbNew, zbFind]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndP2_SHOP_ID: TzrComboBoxList
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
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndP2_GUIDE_USER: TzrComboBoxList
                Tag = -1
                Left = 344
                Top = 97
                Width = 122
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
                FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #22995#21517
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_SPELL'
                    Footers = <>
                    Title.Caption = #25340#38899#30721
                    Width = 20
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndP2_SALES_TYPE: TcxComboBox
                Left = 344
                Top = 119
                Width = 122
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsEditFixedList
                Properties.Items.Strings = (
                  #34892#25919#22320#21306
                  #31649#29702#32676#32452)
                TabOrder = 12
              end
              object RzGroupBox1: TRzGroupBox
                Left = 345
                Top = 71
                Width = 120
                Height = 24
                GroupStyle = gsStandard
                TabOrder = 8
                ThemeAware = False
                Visible = False
                object RB_SYY: TcxRadioButton
                  Left = 60
                  Top = 7
                  Width = 55
                  Height = 15
                  Caption = #25910#38134#21592
                  TabOrder = 0
                end
                object RB_DGY: TcxRadioButton
                  Left = 5
                  Top = 7
                  Width = 55
                  Height = 15
                  Caption = #23548#36141#21592
                  Checked = True
                  TabOrder = 1
                  TabStop = True
                  OnClick = RB_DGYClick
                end
              end
              inline P2_DateControl: TfrmDateControl
                Left = 281
                Top = 8
                Width = 170
                Height = 20
                TabOrder = 15
              end
            end
            object RzPanel10: TRzPanel
              Left = 5
              Top = 149
              Width = 858
              Height = 307
              Align = alClient
              BorderOuter = fsGroove
              Color = clWhite
              TabOrder = 1
              object DBGridEh2: TDBGridEh
                Left = 2
                Top = 2
                Width = 854
                Height = 303
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
                UseMultiTitle = True
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
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #29992#25143#36134#21495
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footer.ValueType = fvtCount
                    Footers = <>
                    Title.Caption = #29992#25143#21517#31216
                    Width = 153
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.###'
                    EditButtons = <>
                    FieldName = 'SALE_AMT'
                    Footer.DisplayFormat = '#0.###'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #38144#21806#25968#37327
                    Width = 63
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00#'
                    EditButtons = <>
                    FieldName = 'SALE_PRC'
                    Footers = <>
                    Title.Caption = #22343#20215
                    Width = 65
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_TTL'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #38144#21806#37329#39069
                    Width = 84
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_TAX'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #38144#39033#31246#39069
                    Width = 82
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_MNY'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #26410#31246#37329#39069
                    Width = 76
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_CST'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #38144#21806#25104#26412
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_ALLPRF'
                    Footer.DisplayFormat = '#0.00'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #27611#21033
                    Width = 80
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00%'
                    EditButtons = <>
                    FieldName = 'SALE_RATE'
                    Footers = <>
                    Title.Caption = #27611#21033#29575
                    Width = 49
                  end
                  item
                    Alignment = taRightJustify
                    DisplayFormat = '#0.00'
                    EditButtons = <>
                    FieldName = 'SALE_PRF'
                    Footers = <>
                    Title.Caption = #21333#20301#27611#21033
                    Width = 67
                  end>
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Caption = #20998#31867#38144#21806#27719#24635#34920
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 868
            Height = 461
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel3: TPanel
              Left = 5
              Top = 5
              Width = 858
              Height = 451
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel11: TRzPanel
                Left = 0
                Top = 0
                Width = 858
                Height = 100
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  858
                  100)
                object RzLabel6: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26085#26399
                end
                object RzLabel7: TRzLabel
                  Left = 170
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label5: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38376#24215#21517#31216
                end
                object Label19: TLabel
                  Left = 288
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #25253#34920#31867#22411
                end
                object Label20: TLabel
                  Left = 715
                  Top = 78
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
                  Alignment = taRightJustify
                  Caption = #38376#24215#32676#32452
                end
                object Label35: TLabel
                  Left = 288
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object Label42: TLabel
                  Left = 24
                  Top = 78
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #23548' '#36141' '#21592
                end
                object Label40: TLabel
                  Left = 288
                  Top = 78
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object P3_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P3_D2: TcxDateEdit
                  Left = 186
                  Top = 8
                  Width = 87
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 483
                  Top = 64
                  Width = 67
                  Height = 29
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
                  TabOrder = 10
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP3_SHOP_ID: TzrComboBoxList
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
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP3_REPORT_FLAG: TcxComboBox
                  Left = 344
                  Top = 52
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = fndP3_REPORT_FLAGPropertiesChange
                  TabOrder = 6
                end
                object fndP3_UNIT_ID: TcxComboBox
                  Left = 765
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
                  TabOrder = 9
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
                end
                object fndP3_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP3_DEPT_ID: TzrComboBoxList
                  Left = 344
                  Top = 30
                  Width = 121
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
                  FilterFields = 'DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                  RangeField = 'DEPT_TYPE'
                  RangeValue = '1'
                end
                object fndP3_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 74
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 7
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #22995#21517
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USER_SPELL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP3_SALES_TYPE: TcxComboBox
                  Left = 344
                  Top = 74
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 8
                end
                inline P3_DateControl: TfrmDateControl
                  Left = 280
                  Top = 9
                  Width = 170
                  Height = 20
                  TabOrder = 11
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 100
                Width = 858
                Height = 351
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh3: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 854
                  Height = 347
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
                  UseMultiTitle = True
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
                      Width = 185
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25968#37327
                      Width = 63
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRC'
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 65
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 84
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#39033#31246#39069
                      Width = 82
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#31246#37329#39069
                      Width = 76
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25104#26412
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_ALLPRF'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #27611#21033
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footers = <>
                      Title.Caption = #27611#21033#29575
                      Width = 49
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footers = <>
                      Title.Caption = #21333#20301#27611#21033
                      Width = 57
                    end>
                end
              end
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Caption = #21830#21697#38144#21806#27719#24635#34920
          object RzPanel14: TRzPanel
            Left = 0
            Top = 0
            Width = 868
            Height = 461
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel6: TPanel
              Left = 5
              Top = 5
              Width = 858
              Height = 451
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel15: TRzPanel
                Left = 0
                Top = 0
                Width = 858
                Height = 122
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  858
                  122)
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26085#26399
                end
                object RzLabel9: TRzLabel
                  Left = 171
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
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
                  Left = 713
                  Top = 100
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
                object Label36: TLabel
                  Left = 289
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object Label43: TLabel
                  Left = 24
                  Top = 100
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #23548' '#36141' '#21592
                end
                object Label6: TLabel
                  Left = 289
                  Top = 100
                  Width = 48
                  Height = 12
                  Caption = #32479#35745#31867#22411
                end
                object Label7: TLabel
                  Left = 289
                  Top = 79
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object P4_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 85
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P4_D2: TcxDateEdit
                  Left = 187
                  Top = 8
                  Width = 86
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object BtnSaleSum: TRzBitBtn
                  Left = 474
                  Top = 89
                  Width = 67
                  Height = 27
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
                  TabOrder = 13
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
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 7
                end
                object fndP4_UNIT_ID: TcxComboBox
                  Left = 763
                  Top = 96
                  Width = 81
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 12
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
                end
                object fndP4_SORT_ID: TcxButtonEdit
                  Left = 343
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
                end
                object fndP4_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 2
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP4_DEPT_ID: TzrComboBoxList
                  Left = 343
                  Top = 30
                  Width = 121
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
                  FilterFields = 'DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                  RangeField = 'DEPT_TYPE'
                  RangeValue = '1'
                end
                object fndP4_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 96
                  Width = 193
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
                  FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #22995#21517
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USER_SPELL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP4_RPTTYPE: TcxComboBox
                  Left = 343
                  Top = 96
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #38376#24215#36827#38144#23384#32479#35745#34920
                    #21830#21697#36827#38144#23384#32479#35745#34920
                    #32676#32452#36827#38144#23384#32479#35745#34920
                    #20379#24212#21830#36827#38144#23384#32479#35745#34920)
                  TabOrder = 11
                end
                object fndP4_SALES_TYPE: TcxComboBox
                  Left = 343
                  Top = 74
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 9
                end
                inline P4_DateControl: TfrmDateControl
                  Left = 280
                  Top = 8
                  Width = 170
                  Height = 20
                  TabOrder = 14
                end
              end
              object RzPanel21: TRzPanel
                Left = 0
                Top = 122
                Width = 858
                Height = 329
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh4: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 854
                  Height = 325
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
                  OnDblClick = DBGridEh4DblClick
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
                      Width = 95
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
                      FieldName = 'UNIT_ID'
                      Footers = <>
                      Title.Caption = #21333#20301
                      Width = 33
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25968#37327
                      Width = 63
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRC'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #22343#20215
                      Width = 65
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#37329#39069
                      Width = 84
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#39033#31246#39069
                      Width = 82
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#31246#37329#39069
                      Width = 76
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25104#26412
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_ALLPRF'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #27611#21033
                      Width = 80
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #27611#21033#29575
                      Width = 49
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footer.Alignment = taRightJustify
                      Footers = <>
                      Title.Caption = #21333#20301#27611#21033
                      Width = 67
                    end>
                end
              end
            end
          end
        end
        object TabSheet5: TRzTabSheet
          Caption = #38144#21806#21830#21697#26126#32454#34920
          object RzPanel16: TRzPanel
            Left = 0
            Top = 0
            Width = 868
            Height = 461
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel7: TPanel
              Left = 5
              Top = 5
              Width = 858
              Height = 451
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel17: TRzPanel
                Left = 0
                Top = 0
                Width = 858
                Height = 146
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                object RzLabel10: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#26085#26399
                end
                object RzLabel11: TRzLabel
                  Left = 167
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label17: TLabel
                  Left = 25
                  Top = 78
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label18: TLabel
                  Left = 287
                  Top = 100
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#20998#31867
                end
                object Label22: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                end
                object Label28: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label29: TLabel
                  Left = 24
                  Top = 124
                  Width = 48
                  Height = 12
                  Caption = #21333#25454#31867#22411
                end
                object Label37: TLabel
                  Left = 287
                  Top = 78
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object Label44: TLabel
                  Left = 287
                  Top = 56
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #23548' '#36141' '#21592
                end
                object Label45: TLabel
                  Left = 25
                  Top = 101
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object P5_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 83
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object BtnDetail: TRzBitBtn
                  Left = 479
                  Top = 110
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
                  TabOrder = 12
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object P5_D2: TcxDateEdit
                  Left = 183
                  Top = 8
                  Width = 90
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP5_TYPE_ID: TcxComboBox
                  Left = 80
                  Top = 52
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 4
                end
                object fndP5_STAT_ID: TzrComboBoxList
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
                end
                object fndP5_SORT_ID: TcxButtonEdit
                  Left = 343
                  Top = 96
                  Width = 122
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP5_SORT_IDPropertiesButtonClick
                  TabOrder = 10
                  OnKeyPress = fndP5_SORT_IDKeyPress
                end
                object fndP5_SHOP_VALUE: TzrComboBoxList
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
                end
                object fndP5_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP5_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 74
                  Width = 193
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 7
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object RzGB: TRzGroupBox
                  Left = 80
                  Top = 115
                  Width = 385
                  Height = 26
                  GroupStyle = gsStandard
                  TabOrder = 11
                  ThemeAware = False
                  object fndP5_ALL: TcxRadioButton
                    Left = 5
                    Top = 8
                    Width = 57
                    Height = 15
                    Caption = #20840#37096
                    Checked = True
                    TabOrder = 0
                    TabStop = True
                  end
                  object fndP5_SALEORDER: TcxRadioButton
                    Left = 72
                    Top = 8
                    Width = 63
                    Height = 15
                    Caption = #38144#21806#21333
                    TabOrder = 1
                  end
                  object fndP5_POSMAIN: TcxRadioButton
                    Left = 155
                    Top = 8
                    Width = 59
                    Height = 15
                    Caption = #38646#21806#21333
                    TabOrder = 2
                  end
                  object fndP5_SALRETU: TcxRadioButton
                    Left = 241
                    Top = 8
                    Width = 59
                    Height = 15
                    Caption = #36864#36135#21333
                    TabOrder = 3
                  end
                end
                object fndP5_DEPT_ID: TzrComboBoxList
                  Left = 343
                  Top = 74
                  Width = 122
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
                  FilterFields = 'DEPT_NAME;DEPT_SPELL'
                  KeyField = 'DEPT_ID'
                  ListField = 'DEPT_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'DEPT_NAME'
                      Footers = <>
                      Title.Caption = #21517#31216
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                  RangeField = 'DEPT_TYPE'
                  RangeValue = '1'
                end
                object fndP5_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 343
                  Top = 52
                  Width = 122
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 6
                  InGrid = False
                  KeyValue = Null
                  FilterFields = 'USER_ID;USER_SPELL;USER_NAME'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #22995#21517
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USER_SPELL'
                      Footers = <>
                      Title.Caption = #25340#38899#30721
                      Width = 20
                    end>
                  DropWidth = 185
                  DropHeight = 180
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP5_SALES_TYPE: TcxComboBox
                  Left = 80
                  Top = 96
                  Width = 193
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 9
                end
                inline P5_DateControl: TfrmDateControl
                  Left = 280
                  Top = 10
                  Width = 170
                  Height = 20
                  TabOrder = 13
                end
              end
              object RzPanel18: TRzPanel
                Left = 0
                Top = 146
                Width = 858
                Height = 305
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh5: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 854
                  Height = 301
                  Align = alClient
                  AllowedOperations = []
                  BorderStyle = bsNone
                  Color = clWhite
                  Ctl3D = True
                  DataSource = dsadoReport5
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
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
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
                      Footers = <>
                      Title.Caption = #26085#26399
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GLIDE_NO'
                      Footers = <>
                      Title.Caption = #21333#21495
                      Width = 92
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #23458#25143#21517#31216
                      Width = 134
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
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 153
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
                      FieldName = 'UNIT_ID'
                      Footers = <>
                      Title.Caption = #21333#20301
                      Width = 20
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ORG_PRICE'
                      Footers = <>
                      Title.Caption = #21407#21806#20215
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
                      Width = 63
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
                      Width = 76
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'NOTAX_MONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #19981#21547#31246#37329#39069
                      Width = 73
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'TAX_MONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#39033#31246#39069
                      Width = 66
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0%'
                      EditButtons = <>
                      FieldName = 'AGIO_RATE'
                      Footers = <>
                      Title.Caption = #25240#25187#29575
                      Width = 45
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'AGIO_MONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #35753#21033#37329#39069
                      Width = 68
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'COST_MONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #38144#21806#25104#26412
                      Width = 69
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'PROFIT_MONEY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #27611#21033
                      Width = 68
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'PROFIT_RATE'
                      Footers = <>
                      Title.Caption = #27611#21033#29575
                      Width = 46
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'AVG_PROFIT'
                      Footers = <>
                      Title.Caption = #21333#20301#27611#21033
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BATCH_NO'
                      Footers = <>
                      Title.Caption = #25209#21495
                      Width = 73
                    end
                    item
                      EditButtons = <>
                      FieldName = 'IS_PRESENT'
                      Footers = <>
                      Title.Caption = #36192#21697
                      Width = 35
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_USER_TEXT'
                      Footers = <>
                      Title.Caption = #21046#21333#20154
                      Width = 45
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CREA_DATE'
                      Footers = <>
                      Title.Caption = #21046#21333#26102#38388
                      Width = 135
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 873
        Height = 488
        inherited Panel2: TPanel
          Height = 456
          inherited Panel5: TPanel
            Height = 341
            inherited rzShowColumns: TRzCheckList
              Height = 337
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1085
    inherited Image14: TImage
      Left = 1065
    end
    inherited Image1: TImage
      Width = 715
    end
  end
  inherited mmMenu: TMainMenu
    Left = 117
    Top = 468
  end
  inherited actList: TActionList
    Left = 149
    Top = 468
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 25
    Top = 306
  end
  inherited SaveDialog1: TSaveDialog
    Left = 181
    Top = 468
  end
  inherited adoReport1: TZQuery
    Left = 24
    Top = 276
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    Left = 85
    Top = 468
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
  object adoReport2: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 56
    Top = 276
  end
  object dsadoReport2: TDataSource
    DataSet = adoReport2
    Left = 57
    Top = 306
  end
  object dsadoReport3: TDataSource
    DataSet = adoReport3
    Left = 89
    Top = 306
  end
  object adoReport3: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 88
    Top = 276
  end
  object dsadoReport4: TDataSource
    DataSet = adoReport4
    Left = 121
    Top = 306
  end
  object adoReport4: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 276
  end
  object dsadoReport5: TDataSource
    DataSet = adoReport5
    Left = 153
    Top = 306
  end
  object adoReport5: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 152
    Top = 276
  end
end
