inherited frmSaleAnaly: TfrmSaleAnaly
  Left = 237
  Top = 127
  Width = 984
  Height = 614
  Caption = #30408#21033#20998#26512#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 976
    Height = 550
    inherited RzPanel2: TRzPanel
      Width = 966
      Height = 540
      inherited RzPage: TRzPageControl
        Width = 960
        Height = 534
        ActivePage = TabSheet2
        FixedDimension = 25
        object TabSheet2: TRzTabSheet [0]
          Caption = #30408#21033#20998#26512
          object RzPanel1: TRzPanel
            Left = 0
            Top = 0
            Width = 958
            Height = 507
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 5
            TabOrder = 0
            object Panel1: TPanel
              Left = 5
              Top = 5
              Width = 948
              Height = 497
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPnl2: TRzPanel
                Left = 0
                Top = 0
                Width = 948
                Height = 74
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  948
                  74)
                object Label8: TLabel
                  Left = 17
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38376#24215#32676#32452
                end
                object Label9: TLabel
                  Left = 17
                  Top = 53
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#25351#26631
                end
                object Label10: TLabel
                  Left = 300
                  Top = 31
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#20998#31867
                end
                object Label12: TLabel
                  Left = 301
                  Top = 52
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #32479#35745#31867#22411
                end
                object Label14: TLabel
                  Left = 17
                  Top = 10
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object RzLabel1: TRzLabel
                  Left = 298
                  Top = 11
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24320#22987#26085#26399
                end
                object RzLabel4: TRzLabel
                  Left = 441
                  Top = 10
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label17: TLabel
                  Left = 811
                  Top = 54
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object fndP2_TYPE_ID: TcxComboBox
                  Left = 69
                  Top = 49
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 0
                end
                object fndP2_SHOP_TYPE: TcxComboBox
                  Left = 69
                  Top = 28
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 1
                end
                object fndP2_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 153
                  Top = 28
                  Width = 134
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
                object fndP2_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 153
                  Top = 49
                  Width = 134
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
                object fndP2_SORT_ID: TcxButtonEdit
                  Left = 350
                  Top = 26
                  Width = 194
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP2_SORT_IDPropertiesButtonClick
                  TabOrder = 4
                  OnKeyPress = fndP2_SORT_IDKeyPress
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 553
                  Top = 40
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
                  TabOrder = 5
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzPanel10: TRzPanel
                  Left = 351
                  Top = 48
                  Width = 192
                  Height = 19
                  BorderInner = fsFlat
                  BorderOuter = fsNone
                  Color = clWhite
                  FlatColor = 6956042
                  GridColor = clGray
                  TabOrder = 6
                  object P2_RB_Money: TcxRadioButton
                    Left = 68
                    Top = 1
                    Width = 58
                    Height = 17
                    Caption = #38144#21806#39069
                    TabOrder = 0
                    OnClick = P2_RB_MoneyClick
                  end
                  object P2_RB_PRF: TcxRadioButton
                    Left = 6
                    Top = 1
                    Width = 46
                    Height = 17
                    Caption = #27611#21033
                    Checked = True
                    TabOrder = 1
                    TabStop = True
                    OnClick = P2_RB_PRFClick
                  end
                  object P2_RB_AMT: TcxRadioButton
                    Left = 142
                    Top = 1
                    Width = 45
                    Height = 17
                    Caption = #38144#37327
                    TabOrder = 2
                    OnClick = P2_RB_AMTClick
                  end
                end
                object fndP2_DEPT_ID: TzrComboBoxList
                  Left = 69
                  Top = 6
                  Width = 218
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
                object P2_D1: TcxDateEdit
                  Left = 350
                  Top = 6
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 8
                end
                object P2_D2: TcxDateEdit
                  Left = 462
                  Top = 6
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 9
                end
                object fndP1UNIT_ID: TcxComboBox
                  Left = 861
                  Top = 50
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
                inline P2_DateControl: TfrmDateControl
                  Left = 545
                  Top = 7
                  Width = 170
                  Height = 20
                  TabOrder = 11
                end
              end
              object PnlSB2: TRzPanel
                Left = 0
                Top = 74
                Width = 948
                Height = 423
                Align = alClient
                BorderOuter = fsNone
                BorderSides = []
                Color = clWhite
                TabOrder = 1
                object PnlS: TRzPanel
                  Left = 947
                  Top = 0
                  Width = 1
                  Height = 423
                  Align = alRight
                  BorderOuter = fsNone
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 0
                end
                object SB2: TScrollBox
                  Left = 0
                  Top = 0
                  Width = 947
                  Height = 423
                  HorzScrollBar.Style = ssFlat
                  HorzScrollBar.Tracking = True
                  VertScrollBar.Tracking = True
                  Align = alClient
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  Color = clWhite
                  Ctl3D = False
                  ParentColor = False
                  ParentCtl3D = False
                  TabOrder = 1
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet [1]
          Caption = #28508#21147#20998#26512
          object RzPanel11: TRzPanel
            Left = 0
            Top = 0
            Width = 958
            Height = 507
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 5
            TabOrder = 0
            object Panel2: TPanel
              Left = 5
              Top = 5
              Width = 948
              Height = 497
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPnl3: TRzPanel
                Left = 0
                Top = 0
                Width = 948
                Height = 74
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                DesignSize = (
                  948
                  74)
                object Label13: TLabel
                  Left = 17
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38376#24215#32676#32452
                end
                object Label15: TLabel
                  Left = 17
                  Top = 53
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#25351#26631
                end
                object Label16: TLabel
                  Left = 300
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#20998#31867
                end
                object Label18: TLabel
                  Left = 17
                  Top = 11
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object RzLabel5: TRzLabel
                  Left = 299
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24320#22987#26085#26399
                end
                object RzLabel6: TRzLabel
                  Left = 442
                  Top = 11
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label11: TLabel
                  Left = 301
                  Top = 53
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #32479#35745#31867#22411
                end
                object Label19: TLabel
                  Left = 795
                  Top = 54
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #26174#31034#21333#20301
                end
                object Label20: TLabel
                  Left = 795
                  Top = 31
                  Width = 48
                  Height = 12
                  Anchors = [akTop, akRight]
                  Caption = #37329#39069#21333#20301
                end
                object fndP3_TYPE_ID: TcxComboBox
                  Left = 69
                  Top = 49
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 0
                end
                object fndP3_SHOP_TYPE: TcxComboBox
                  Left = 69
                  Top = 28
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 1
                end
                object fndP3_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 153
                  Top = 28
                  Width = 134
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
                object fndP3_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 153
                  Top = 49
                  Width = 134
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
                object fndP3_SORT_ID: TcxButtonEdit
                  Left = 351
                  Top = 28
                  Width = 196
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP3_SORT_IDPropertiesButtonClick
                  TabOrder = 4
                  OnKeyPress = fndP3_SORT_IDKeyPress
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 565
                  Top = 40
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
                  TabOrder = 5
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP3_DEPT_ID: TzrComboBoxList
                  Left = 69
                  Top = 7
                  Width = 218
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
                object P3_D1: TcxDateEdit
                  Left = 351
                  Top = 7
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 7
                end
                object P3_D2: TcxDateEdit
                  Left = 465
                  Top = 7
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 8
                end
                object EdtvType: TcxComboBox
                  Left = 351
                  Top = 49
                  Width = 196
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #38144#21806#39069' '#8212' '#27611#21033
                    #38144#37327' '#8212' '#27611#21033
                    #38144#37327' '#8212' '#38144#21806#39069)
                  TabOrder = 9
                end
                object fndP2UNIT_ID: TcxComboBox
                  Left = 845
                  Top = 50
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  TabOrder = 10
                end
                object edtMoneyUnit: TcxComboBox
                  Left = 845
                  Top = 27
                  Width = 80
                  Height = 20
                  Anchors = [akTop, akRight]
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #20803
                    #19975#20803)
                  Properties.OnChange = fndP1_Sale_UNITPropertiesChange
                  TabOrder = 11
                end
                inline P3_DateControl: TfrmDateControl
                  Left = 552
                  Top = 8
                  Width = 170
                  Height = 20
                  TabOrder = 12
                end
              end
              object PnlSB3: TRzPanel
                Left = 0
                Top = 74
                Width = 948
                Height = 423
                Align = alClient
                BorderOuter = fsNone
                BorderSides = []
                Color = clWhite
                TabOrder = 1
                object PnlSB: TRzPanel
                  Left = 947
                  Top = 0
                  Width = 1
                  Height = 423
                  Align = alRight
                  BorderOuter = fsNone
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 0
                end
                object SB3: TScrollBox
                  Left = 0
                  Top = 0
                  Width = 947
                  Height = 423
                  HorzScrollBar.Style = ssFlat
                  HorzScrollBar.Tracking = True
                  VertScrollBar.Style = ssHotTrack
                  VertScrollBar.Tracking = True
                  Align = alClient
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  BevelKind = bkSoft
                  Color = clWhite
                  Ctl3D = False
                  ParentColor = False
                  ParentCtl3D = False
                  TabOrder = 1
                end
              end
            end
          end
        end
        inherited TabSheet1: TRzTabSheet
          Caption = #32463#33829#27010#20917
          inherited RzPanel3: TRzPanel
            Width = 958
            Height = 507
            inherited Panel4: TPanel
              Width = 948
              Height = 497
              inherited w1: TRzPanel
                Width = 948
                Height = 97
                Color = clBtnFace
                object RzLabel2: TRzLabel
                  Left = 315
                  Top = 11
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #24320#22987#26085#26399
                end
                object Label5: TLabel
                  Left = 25
                  Top = 34
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38376#24215#32676#32452
                end
                object Label7: TLabel
                  Left = 25
                  Top = 54
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#25351#26631
                end
                object RzLabel3: TRzLabel
                  Left = 452
                  Top = 11
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label6: TLabel
                  Left = 317
                  Top = 32
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#20998#31867
                end
                object Label31: TLabel
                  Left = 25
                  Top = 77
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21830#21697#21517#31216
                end
                object Label1: TLabel
                  Left = 317
                  Top = 75
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #26597#30475#26041#24335
                end
                object Label3: TLabel
                  Left = 317
                  Top = 54
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #38144#21806#31867#22411
                end
                object Label32: TLabel
                  Left = 26
                  Top = 11
                  Width = 48
                  Height = 12
                  Caption = #25152#23646#37096#38376
                end
                object fndP1_TYPE_ID: TcxComboBox
                  Left = 78
                  Top = 51
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #20027#20379#24212#21830
                    #21697#29260#21517#31216)
                  TabOrder = 0
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 78
                  Top = 30
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#22320#21306
                    #31649#29702#32676#32452)
                  TabOrder = 1
                end
                object P1_D1: TcxDateEdit
                  Left = 368
                  Top = 7
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 2
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 162
                  Top = 30
                  Width = 136
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
                object fndP1_STAT_ID: TzrComboBoxList
                  Tag = -1
                  Left = 162
                  Top = 51
                  Width = 136
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
                object P1_D2: TcxDateEdit
                  Left = 466
                  Top = 7
                  Width = 82
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Properties.DateButtons = [btnToday]
                  TabOrder = 5
                end
                object fndP1_GODS_ID: TzrComboBoxList
                  Tag = 100
                  Left = 78
                  Top = 72
                  Width = 220
                  Height = 20
                  TabStop = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 6
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
                object fndP1_SORT_ID: TcxButtonEdit
                  Left = 368
                  Top = 28
                  Width = 180
                  Height = 20
                  Properties.Buttons = <
                    item
                      Default = True
                      Kind = bkEllipsis
                    end>
                  Properties.ReadOnly = True
                  Properties.OnButtonClick = fndP1_SORT_IDPropertiesButtonClick
                  TabOrder = 7
                  OnKeyPress = fndP1_SORT_IDKeyPress
                end
                object btnOk: TRzBitBtn
                  Left = 553
                  Top = 64
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
                  TabOrder = 8
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzPanel9: TRzPanel
                  Left = 369
                  Top = 71
                  Width = 178
                  Height = 20
                  BorderInner = fsFlat
                  BorderOuter = fsNone
                  Color = clWhite
                  FlatColor = 6956042
                  GridColor = clGray
                  TabOrder = 9
                  object RB_hour: TcxRadioButton
                    Left = 3
                    Top = 2
                    Width = 61
                    Height = 17
                    Caption = #25353#23567#26102
                    Checked = True
                    TabOrder = 0
                    TabStop = True
                  end
                  object RB_week: TcxRadioButton
                    Left = 83
                    Top = 2
                    Width = 57
                    Height = 17
                    Caption = #25353#26143#26399
                    TabOrder = 1
                  end
                end
                object RzPanel6: TRzPanel
                  Left = 369
                  Top = 49
                  Width = 178
                  Height = 20
                  BorderInner = fsFlat
                  BorderOuter = fsNone
                  Color = clWhite
                  FlatColor = 6956042
                  GridColor = clGray
                  TabOrder = 10
                  object RB_all: TcxRadioButton
                    Left = 3
                    Top = 2
                    Width = 45
                    Height = 17
                    Caption = #20840#37096
                    Checked = True
                    TabOrder = 0
                    TabStop = True
                  end
                  object RB_sale: TcxRadioButton
                    Left = 59
                    Top = 2
                    Width = 44
                    Height = 17
                    Caption = #38646#21806
                    TabOrder = 1
                  end
                  object RB_batch: TcxRadioButton
                    Left = 116
                    Top = 2
                    Width = 45
                    Height = 17
                    Caption = #25209#21457
                    TabOrder = 2
                  end
                end
                object fndP1_DEPT_ID: TzrComboBoxList
                  Left = 78
                  Top = 7
                  Width = 220
                  Height = 20
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 11
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
                inline P1_DateControl: TfrmDateControl
                  Left = 556
                  Top = 8
                  Width = 170
                  Height = 20
                  TabOrder = 12
                end
              end
              inherited RzPanel7: TRzPanel
                Top = 97
                Width = 948
                Height = 400
                OnResize = RzPanel7Resize
                object Pnl_Mm: TRzPanel
                  Left = 2
                  Top = 265
                  Width = 944
                  Height = 133
                  Align = alClient
                  BorderOuter = fsGroove
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 0
                  object AnalyInfo: TcxMemo
                    Left = 0
                    Top = 24
                    Width = 944
                    Height = 109
                    Align = alClient
                    Properties.ReadOnly = True
                    TabOrder = 0
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  end
                  object RzTool: TRzPanel
                    Left = 0
                    Top = 0
                    Width = 944
                    Height = 24
                    Align = alTop
                    BorderOuter = fsGroove
                    BorderSides = []
                    TabOrder = 1
                    object Label2: TLabel
                      Left = 25
                      Top = 6
                      Width = 60
                      Height = 12
                      Caption = #32479#35745#31867#22411#65306
                    end
                    object Label4: TLabel
                      Left = 313
                      Top = 7
                      Width = 72
                      Height = 12
                      Caption = #38144#21806#39069#21333#20301#65306
                    end
                    object fndP1_Sale_UNIT: TcxComboBox
                      Left = 382
                      Top = 3
                      Width = 95
                      Height = 20
                      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                      Properties.DropDownListStyle = lsFixedList
                      Properties.Items.Strings = (
                        #20803
                        #19975#20803)
                      Properties.OnChange = fndP1_Sale_UNITPropertiesChange
                      TabOrder = 0
                    end
                    object RzPanel8: TRzPanel
                      Left = 89
                      Top = 3
                      Width = 207
                      Height = 20
                      BorderInner = fsFlat
                      BorderOuter = fsNone
                      Color = clWhite
                      FlatColor = 6956042
                      GridColor = clGray
                      TabOrder = 1
                      object RB_SaleMoney: TcxRadioButton
                        Left = 6
                        Top = 2
                        Width = 60
                        Height = 17
                        Caption = #38144#21806#39069
                        Checked = True
                        TabOrder = 0
                        TabStop = True
                        OnClick = RB_SaleMoneyClick
                      end
                      object RB_SaleMount: TcxRadioButton
                        Left = 72
                        Top = 2
                        Width = 59
                        Height = 17
                        Caption = #38144#21806#37327
                        TabOrder = 1
                        OnClick = RB_SaleMoneyClick
                      end
                      object RB_PRF: TcxRadioButton
                        Left = 141
                        Top = 2
                        Width = 50
                        Height = 17
                        Caption = #27611#21033
                        TabOrder = 2
                        OnClick = RB_SaleMoneyClick
                      end
                    end
                    object CB_Color: TCheckBox
                      Left = 488
                      Top = 5
                      Width = 96
                      Height = 17
                      Caption = #26174#31034#19981#21516#39068#33394
                      Checked = True
                      State = cbChecked
                      TabOrder = 2
                      OnClick = CB_ColorClick
                    end
                  end
                end
                object Pnl_Char: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 944
                  Height = 263
                  Align = alTop
                  BorderOuter = fsGroove
                  BorderSides = []
                  Color = clWhite
                  TabOrder = 1
                  object Chart1: TChart
                    Left = 0
                    Top = 0
                    Width = 944
                    Height = 263
                    BackWall.Brush.Color = clWhite
                    BackWall.Brush.Style = bsClear
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clBlue
                    Title.Font.Height = -16
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = [fsBold]
                    Title.Text.Strings = (
                      '')
                    Title.Visible = False
                    Legend.Alignment = laBottom
                    Legend.TextStyle = ltsRightValue
                    Legend.Visible = False
                    View3D = False
                    Align = alClient
                    BevelOuter = bvLowered
                    Color = clWhite
                    TabOrder = 0
                    object BarSeries1: TBarSeries
                      ColorEachPoint = True
                      Marks.ArrowLength = 20
                      Marks.Style = smsValue
                      Marks.Visible = False
                      SeriesColor = clRed
                      Title = #38144#37327
                      MultiBar = mbNone
                      XValues.DateTime = False
                      XValues.Name = 'X'
                      XValues.Multiplier = 1.000000000000000000
                      XValues.Order = loAscending
                      YValues.DateTime = False
                      YValues.Name = 'Bar'
                      YValues.Multiplier = 1.000000000000000000
                      YValues.Order = loNone
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 976
    inherited Image14: TImage
      Left = 956
    end
    inherited Image1: TImage
      Width = 606
    end
    inherited CoolBar1: TCoolBar
      inherited ToolBar1: TToolBar
        inherited ToolButton5: TToolButton
          Visible = False
        end
        inherited ToolButton3: TToolButton
          Visible = False
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 16
    Top = 464
  end
  inherited actList: TActionList
    Left = 48
    Top = 464
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  inherited dsadoReport1: TDataSource
    Left = 41
    Top = 242
  end
  inherited SaveDialog1: TSaveDialog
    Left = 389
    Top = 4
  end
  inherited adoReport1: TZQuery
    Left = 40
    Top = 204
  end
  object AnalyQry1: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 40
    Top = 172
  end
  object adoReport2: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 88
    Top = 203
  end
  object dsadoReport2: TDataSource
    DataSet = adoReport2
    Left = 89
    Top = 234
  end
  object adoReport3: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 204
  end
  object dsadoReport3: TDataSource
    DataSet = adoReport3
    Left = 121
    Top = 234
  end
end
