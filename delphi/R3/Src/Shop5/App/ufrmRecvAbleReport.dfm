inherited frmRecvAbleReport: TfrmRecvAbleReport
  Top = 103
  Width = 1022
  Height = 611
  Caption = #24212#25910#27454#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1014
    Height = 547
    inherited RzPanel2: TRzPanel
      Width = 1004
      Height = 537
      inherited RzPage: TRzPageControl
        Width = 799
        Height = 531
        ActivePage = TabSheet4
        Color = clCream
        ParentColor = False
        TabIndex = 3
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = #22320#21306#24212#25910#27454#27719#24635#34920
          inherited RzPanel3: TRzPanel
            Width = 797
            Height = 504
            inherited Panel4: TPanel
              Width = 787
              Height = 494
              inherited w1: TRzPanel
                Width = 787
                Height = 79
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 12
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#26085#26399
                end
                object RzLabel3: TRzLabel
                  Left = 171
                  Top = 12
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label5: TLabel
                  Left = 24
                  Top = 34
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label18: TLabel
                  Left = 24
                  Top = 57
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#31867#22411
                end
                object Label44: TLabel
                  Left = 286
                  Top = 56
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994#21153#21592
                end
                object P1_D1: TcxDateEdit
                  Left = 80
                  Top = 8
                  Width = 85
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P1_D2: TcxDateEdit
                  Left = 187
                  Top = 8
                  Width = 86
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object btnOk: TRzBitBtn
                  Left = 462
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
                  TabOrder = 6
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 30
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 156
                  Top = 30
                  Width = 117
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
                inline P1_DateControl: TfrmDateControl
                  Left = 278
                  Top = 7
                  Width = 170
                  Height = 20
                  TabOrder = 7
                end
                object fndP1_RECV_TYPE: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 53
                  Width = 191
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
                  FilterFields = 'CODE_ID;CODE_NAME'
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
                      Title.Caption = #20195#30721
                      Width = 30
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
                object fndP1_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 327
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
              end
              inherited RzPanel7: TRzPanel
                Top = 79
                Width = 787
                Height = 415
                inherited DBGridEh1: TDBGridEh
                  Width = 783
                  Height = 411
                  FrozenCols = 3
                  TitleHeight = 22
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
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ACCT_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #36134#27454#37329#39069
                      Width = 120
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECV_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24050#32467#31639#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'REVE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #20914#36134#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#32467#31639#37329#39069
                      Width = 110
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clCream
          Caption = #38376#24215#24212#25910#27454#27719#24635#34920
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 797
            Height = 504
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel1: TPanel
              Left = 5
              Top = 5
              Width = 787
              Height = 494
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 787
                Height = 78
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                object RzLabel4: TRzLabel
                  Left = 24
                  Top = 13
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#26085#26399
                end
                object RzLabel5: TRzLabel
                  Left = 170
                  Top = 13
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label10: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label19: TLabel
                  Left = 24
                  Top = 57
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#31867#22411
                end
                object Label14: TLabel
                  Left = 286
                  Top = 57
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994#21153#21592
                end
                object P2_D1: TcxDateEdit
                  Left = 80
                  Top = 9
                  Width = 85
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P2_D2: TcxDateEdit
                  Left = 186
                  Top = 9
                  Width = 87
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object fndP2_SHOP_VALUE: TzrComboBoxList
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
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 462
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
                  TabOrder = 6
                  TextStyle = tsRaised
                  ThemeAware = False
                  ImageIndex = 12
                  NumGlyphs = 2
                  Spacing = 5
                end
                object fndP2_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 31
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                inline P2_DateControl: TfrmDateControl
                  Left = 280
                  Top = 9
                  Width = 170
                  Height = 20
                  TabOrder = 7
                end
                object fndP2_RECV_TYPE: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 53
                  Width = 192
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
                  FilterFields = 'CODE_ID;CODE_NAME'
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
                      Title.Caption = #20195#30721
                      Width = 30
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
                object fndP2_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 328
                  Top = 53
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
              end
              object RzPanel10: TRzPanel
                Left = 0
                Top = 78
                Width = 787
                Height = 416
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh2: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 783
                  Height = 412
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
                      FieldName = 'SHOP_CODE'
                      Footers = <>
                      Title.Caption = #38376#24215#20195#30721
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #38376#24215#21517#31216
                      Width = 153
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ACCT_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #36134#27454#37329#39069
                      Width = 120
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECV_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24050#32467#31639#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'REVE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #20914#36134#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#32467#31639#37329#39069
                      Width = 110
                    end>
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clCream
          Caption = #27599#26085#24212#25910#27454#27719#24635#34920
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 797
            Height = 504
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel3: TPanel
              Left = 5
              Top = 5
              Width = 787
              Height = 494
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel11: TRzPanel
                Left = 0
                Top = 0
                Width = 787
                Height = 80
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                object RzLabel6: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#26085#26399
                end
                object RzLabel7: TRzLabel
                  Left = 170
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label11: TLabel
                  Left = 24
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label9: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label20: TLabel
                  Left = 26
                  Top = 58
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#31867#22411
                end
                object Label15: TLabel
                  Left = 290
                  Top = 58
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994' '#21153' '#21592
                end
                object P3_D1: TcxDateEdit
                  Left = 80
                  Top = 10
                  Width = 85
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P3_D2: TcxDateEdit
                  Left = 186
                  Top = 10
                  Width = 87
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 478
                  Top = 39
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
                object fndP3_SHOP_VALUE: TzrComboBoxList
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
                  Top = 32
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP3_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 343
                  Top = 32
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
                inline P3_DateControl: TfrmDateControl
                  Left = 280
                  Top = 10
                  Width = 170
                  Height = 20
                  TabOrder = 8
                end
                object fndP3_RECV_TYPE: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 54
                  Width = 192
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
                  FilterFields = 'CODE_ID;CODE_NAME'
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
                      Title.Caption = #20195#30721
                      Width = 30
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
                object fndP3_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 342
                  Top = 54
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
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 80
                Width = 787
                Height = 414
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh3: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 783
                  Height = 410
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
                      DisplayFormat = '0000-00-00'
                      EditButtons = <>
                      FieldName = 'RECV_DATE'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #26085#26399
                      Width = 99
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ACCT_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #36134#27454#37329#39069
                      Width = 120
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECV_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24050#32467#31639#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'REVE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #20914#36134#37329#39069
                      Width = 110
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26410#32467#31639#37329#39069
                      Width = 110
                    end>
                end
              end
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Color = clCream
          Caption = #21046#21333#20154#24212#25910#27454#27719#24635#34920
          object RzPanel16: TRzPanel
            Left = 0
            Top = 0
            Width = 797
            Height = 80
            Align = alTop
            BorderOuter = fsGroove
            BorderSides = [sdLeft, sdTop, sdRight]
            TabOrder = 0
            object RzLabel1: TRzLabel
              Left = 24
              Top = 14
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #36134#27454#26085#26399
            end
            object RzLabel10: TRzLabel
              Left = 170
              Top = 14
              Width = 12
              Height = 12
              Caption = #33267
            end
            object Label4: TLabel
              Left = 24
              Top = 36
              Width = 48
              Height = 12
              Caption = #38376#24215#32676#32452
            end
            object Label6: TLabel
              Left = 292
              Top = 36
              Width = 48
              Height = 12
              Caption = #38376#24215#21517#31216
            end
            object Label21: TLabel
              Left = 24
              Top = 58
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #36134#27454#31867#22411
            end
            object Label16: TLabel
              Left = 292
              Top = 58
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #19994' '#21153' '#21592
            end
            object P4_D1: TcxDateEdit
              Left = 80
              Top = 10
              Width = 85
              Height = 20
              Properties.DateButtons = [btnToday]
              TabOrder = 0
            end
            object P4_D2: TcxDateEdit
              Left = 186
              Top = 10
              Width = 87
              Height = 20
              Properties.DateButtons = [btnToday]
              TabOrder = 1
            end
            object RzBitBtn4: TRzBitBtn
              Left = 502
              Top = 39
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
            object fndP4_SHOP_VALUE: TzrComboBoxList
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
              Top = 32
              Width = 73
              Height = 20
              Properties.DropDownListStyle = lsEditFixedList
              Properties.Items.Strings = (
                #34892#25919#21306#22495
                #31649#29702#32676#32452)
              TabOrder = 2
            end
            object fndP4_SHOP_ID: TzrComboBoxList
              Tag = -1
              Left = 348
              Top = 32
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
            inline P4_DateControl: TfrmDateControl
              Left = 292
              Top = 10
              Width = 170
              Height = 20
              TabOrder = 8
            end
            object fndP4_RECV_TYPE: TzrComboBoxList
              Tag = -1
              Left = 80
              Top = 54
              Width = 192
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
              FilterFields = 'CODE_ID;CODE_NAME'
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
                  Title.Caption = #20195#30721
                  Width = 30
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
            object fndP4_GUIDE_USER: TzrComboBoxList
              Tag = -1
              Left = 348
              Top = 54
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
          end
          object RzPanel17: TRzPanel
            Left = 0
            Top = 80
            Width = 797
            Height = 424
            Align = alClient
            BorderOuter = fsGroove
            Color = clWhite
            TabOrder = 1
            object DBGridEh4: TDBGridEh
              Tag = 1
              Left = 2
              Top = 2
              Width = 793
              Height = 420
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
              UseMultiTitle = True
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnDblClick = DBGridEh4DblClick
              OnDrawColumnCell = DBGridEh1DrawColumnCell
              OnGetCellParams = DBGridEh1GetCellParams
              OnGetFooterParams = DBGridEh4GetFooterParams
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
                  Title.Caption = #24037#21495
                  Width = 79
                end
                item
                  EditButtons = <>
                  FieldName = 'USER_NAME'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #21046#21333#20154
                  Width = 121
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'ACCT_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #36134#27454#37329#39069
                  Width = 120
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'RECV_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #24050#32467#31639#37329#39069
                  Width = 110
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'REVE_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #20914#36134#37329#39069
                  Width = 110
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'RECK_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #26410#32467#31639#37329#39069
                  Width = 110
                end>
            end
          end
        end
        object TabSheet5: TRzTabSheet
          Color = clCream
          Caption = #24212#25910#27454#26126#32454#34920
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 797
            Height = 504
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel6: TPanel
              Left = 5
              Top = 5
              Width = 787
              Height = 494
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel14: TRzPanel
                Left = 0
                Top = 0
                Width = 787
                Height = 103
                Align = alTop
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdTop, sdRight]
                TabOrder = 0
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#26085#26399
                end
                object RzLabel9: TRzLabel
                  Left = 171
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = #33267
                end
                object Label12: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                end
                object Label3: TLabel
                  Left = 24
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                end
                object Label7: TLabel
                  Left = 292
                  Top = 58
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #21046#21333#20154
                end
                object Label22: TLabel
                  Left = 24
                  Top = 81
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #36134#27454#31867#22411
                end
                object Label17: TLabel
                  Left = 292
                  Top = 81
                  Width = 36
                  Height = 12
                  Alignment = taRightJustify
                  Caption = #19994#21153#21592
                end
                object P5_D1: TcxDateEdit
                  Left = 80
                  Top = 10
                  Width = 85
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 0
                end
                object P5_D2: TcxDateEdit
                  Left = 187
                  Top = 10
                  Width = 86
                  Height = 20
                  Properties.DateButtons = [btnToday]
                  TabOrder = 1
                end
                object RzBitBtn3: TRzBitBtn
                  Left = 475
                  Top = 63
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
                object fndP5_SHOP_VALUE: TzrComboBoxList
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
                  Top = 32
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  TabOrder = 2
                end
                object fndP5_SHOP_ID: TzrComboBoxList
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
                  ShowButton = False
                  LocateStyle = lsDark
                  Buttons = []
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                object fndP5_USER_ID: TzrComboBoxList
                  Left = 331
                  Top = 54
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
                  FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
                  KeyField = 'USER_ID'
                  ListField = 'USER_NAME'
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'ACCOUNT'
                      Footers = <>
                      Title.Caption = #24080#21495
                    end
                    item
                      EditButtons = <>
                      FieldName = 'USER_NAME'
                      Footers = <>
                      Title.Caption = #22995#21517
                      Width = 130
                    end>
                  DropWidth = 180
                  DropHeight = 150
                  ShowTitle = True
                  AutoFitColWidth = True
                  ShowButton = True
                  LocateStyle = lsDark
                  Buttons = [zbNew]
                  DropListStyle = lsFixed
                  MultiSelect = False
                end
                inline P5_DateControl: TfrmDateControl
                  Left = 280
                  Top = 11
                  Width = 170
                  Height = 20
                  TabOrder = 9
                end
                object fndP5_RECV_TYPE: TzrComboBoxList
                  Tag = -1
                  Left = 80
                  Top = 77
                  Width = 193
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
                  FilterFields = 'CODE_ID;CODE_NAME'
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
                      Title.Caption = #20195#30721
                      Width = 30
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
                object fndP5_GUIDE_USER: TzrComboBoxList
                  Tag = -1
                  Left = 331
                  Top = 77
                  Width = 121
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
              end
              object RzPanel15: TRzPanel
                Left = 0
                Top = 103
                Width = 787
                Height = 391
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh5: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 783
                  Height = 387
                  Align = alClient
                  AllowedOperations = []
                  DataSource = dsadoReport5
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
                  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
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
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
                  OnGetFooterParams = DBGridEh5GetFooterParams
                  Columns = <
                    item
                      Color = clBtnFace
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #24207#21495
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 32
                    end
                    item
                      DisplayFormat = '0000-00-00'
                      EditButtons = <>
                      FieldName = 'ABLE_DATE'
                      Footer.ValueType = fvtStaticText
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #36134#27454#26085#26399
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 70
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CLIENT_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #23458#25143#21517#31216
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 139
                    end
                    item
                      EditButtons = <>
                      FieldName = 'RECV_TYPE'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #36134#27454#31867#22411
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 63
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ACCT_INFO'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25688#35201
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 208
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ACCT_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #36134#27454#37329#39069
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 72
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECV_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #24050#32467#31639#37329#39069
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 72
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'REVE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #20914#36134#37329#39069
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 72
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RECK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #26410#32467#31639#37329#39069
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 72
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'NEAR_DATE'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #26368#26032#25910#27454#26085#26399
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 105
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GUIDE_USER_TXT'
                      Footers = <>
                      Title.Caption = #19994#21153#21592
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_ID_TEXT'
                      Footers = <>
                      ReadOnly = True
                      Title.Caption = #25152#23646#38376#24215
                      Title.Font.Charset = GB2312_CHARSET
                      Title.Font.Color = clWindowText
                      Title.Font.Height = -12
                      Title.Font.Name = #23435#20307
                      Title.Font.Style = [fsBold]
                      Width = 97
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 802
        Height = 531
        inherited Panel2: TPanel
          Height = 488
          inherited RzPanel1: TRzPanel [3]
          end
          inherited Panel5: TPanel [4]
            Height = 373
            inherited rzShowColumns: TRzCheckList
              Height = 369
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 1014
    inherited Image14: TImage
      Left = 994
    end
    inherited Image1: TImage
      Width = 644
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 60
        Caption = #24212#25910#27454#25253#34920
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
  inherited SaveDialog1: TSaveDialog
    Left = 157
    Top = 196
  end
  inherited adoReport1: TZQuery
    Left = 41
    Top = 321
  end
  inherited PrintDBGridEh1: TPrintDBGridEh
    PageHeader.CenterText.Strings = (
      #25910#27454#27719#24635#34920)
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323420255B7768725D5C66315C6673
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
  object adoReport5: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 225
    Top = 321
  end
  object dsadoReport5: TDataSource
    DataSet = adoReport5
    Left = 225
    Top = 354
  end
end
