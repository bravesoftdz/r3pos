inherited frmJxcTotalReport: TfrmJxcTotalReport
  Left = 193
  Top = 105
  Width = 928
  Height = 627
  Caption = '进销存统计表'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 920
    Height = 570
    inherited RzPanel2: TRzPanel
      Width = 910
      Height = 560
      inherited RzPage: TRzPageControl
        Width = 705
        Height = 554
        ActivePage = TabSheet4
        Color = clCream
        ParentColor = False
        TabIndex = 3
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Color = clCream
          Caption = '地区进销存统计表'
          inherited RzPanel3: TRzPanel
            Width = 703
            Height = 527
            BorderColor = clBtnFace
            inherited Panel4: TPanel
              Width = 693
              Height = 517
              inherited w1: TRzPanel
                Width = 693
                Height = 83
                object Label6: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = '商品分类'
                end
                object RzLabel2: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = '所属月份'
                end
                object RzLabel3: TRzLabel
                  Left = 171
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = '至'
                end
                object Label7: TLabel
                  Left = 24
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = '商品指标'
                end
                object Label8: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = '显示单位'
                end
                object Label5: TLabel
                  Left = 24
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = '门店群组'
                end
                object btnOk: TRzBitBtn
                  Left = 476
                  Top = 42
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = '查询'
                  Color = clSilver
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = '宋体'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                object fndP1_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 32
                  Width = 76
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    '行政区域'
                    '管理群组')
                  TabOrder = 7
                end
                object fndP1_SHOP_VALUE: TzrComboBoxList
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                Width = 693
                Height = 434
                inherited DBGridEh1: TDBGridEh
                  Width = 689
                  Height = 430
                  FrozenCols = 3
                  OnDblClick = DBGridEh1DblClick
                  Columns = <
                    item
                      Alignment = taCenter
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = '序号'
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'REGION_ID'
                      Footers = <>
                      Title.Caption = '地区代码'
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_NAME'
                      Footers = <>
                      Title.Caption = '地区名称'
                      Width = 153
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|金额'
                      Width = 62
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|可销售额'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|数量'
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进货金额'
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|未税金额'
                      Width = 68
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进项税额'
                      Width = 59
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销售金额'
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|未税金额'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销项税额'
                      Width = 67
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|成本'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|毛利'
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footers = <>
                      Title.Caption = '销售|毛利率'
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBIN_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBIN_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBOUT_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBOUT_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|金额'
                      Width = 77
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|可销售额'
                    end>
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clCream
          Caption = '门店进销存统计表'
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 703
            Height = 527
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel1: TPanel
              Left = 5
              Top = 5
              Width = 693
              Height = 517
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 693
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
                  Caption = '门店群组'
                end
                object Label13: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = '商品分类'
                end
                object RzLabel4: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = '所属月份'
                end
                object RzLabel5: TRzLabel
                  Left = 171
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = '至'
                end
                object Label14: TLabel
                  Left = 24
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = '商品指标'
                end
                object Label15: TLabel
                  Left = 288
                  Top = 57
                  Width = 48
                  Height = 12
                  Caption = '显示单位'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                  Caption = '查询'
                  Color = clSilver
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = '宋体'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                object fndP2_SHOP_TYPE: TcxComboBox
                  Left = 80
                  Top = 31
                  Width = 73
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    '行政区域'
                    '管理群组')
                  TabOrder = 8
                end
              end
              object RzPanel10: TRzPanel
                Left = 0
                Top = 81
                Width = 693
                Height = 436
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh2: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 689
                  Height = 432
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
                  Font.Name = '宋体'
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = '宋体'
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
                  ImeName = '极品五笔输入法'
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
                  TitleFont.Name = '宋体'
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = '￥'
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
                      Title.Caption = '序号'
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_CODE'
                      Footers = <>
                      Title.Caption = '门店代码'
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = '门店名称'
                      Width = 153
                    end
                    item
                      DisplayFormat = '#0.0#'
                      EditButtons = <>
                      FieldName = 'ORG_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|金额'
                      Width = 62
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|可销售额'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|数量'
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进货金额'
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|未税金额'
                      Width = 68
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进项税额'
                      Width = 59
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销售金额'
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|未税金额'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销项税额'
                      Width = 67
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|成本'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|毛利'
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footers = <>
                      Title.Caption = '销售|毛利率'
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBIN_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBIN_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBOUT_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBOUT_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|金额'
                      Width = 77
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|可销售额'
                    end>
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Color = clCream
          Caption = '分类进销存统计表'
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 703
            Height = 527
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel3: TPanel
              Left = 5
              Top = 5
              Width = 693
              Height = 517
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel11: TRzPanel
                Left = 0
                Top = 0
                Width = 693
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
                  Caption = '门店名称'
                end
                object RzLabel6: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = '所属月份'
                end
                object RzLabel7: TRzLabel
                  Left = 172
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = '至'
                end
                object Label19: TLabel
                  Left = 288
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = '统计类型'
                end
                object Label20: TLabel
                  Left = 288
                  Top = 58
                  Width = 48
                  Height = 12
                  Caption = '显示单位'
                end
                object Label11: TLabel
                  Left = 24
                  Top = 36
                  Width = 48
                  Height = 12
                  Caption = '门店群组'
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
                      FieldName = 'SHOP_NAME'
                      Footers = <>
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQ_NO'
                      Footers = <>
                      Title.Caption = '代码'
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
                  Caption = '查询'
                  Color = clSilver
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = '宋体'
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
                object fndP3_REPORT_FLAG: TcxComboBox
                  Left = 344
                  Top = 32
                  Width = 121
                  Height = 20
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    '主供应商'
                    '品牌名称')
                  Properties.OnChange = fndP3_REPORT_FLAGPropertiesChange
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                    '行政区域'
                    '管理群组')
                  TabOrder = 7
                end
              end
              object RzPanel12: TRzPanel
                Left = 0
                Top = 84
                Width = 693
                Height = 433
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh3: TDBGridEh
                  Tag = 1
                  Left = 2
                  Top = 2
                  Width = 689
                  Height = 429
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
                  Font.Name = '宋体'
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = '宋体'
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
                  ImeName = '极品五笔输入法'
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
                  TitleFont.Name = '宋体'
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = '￥'
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
                      Title.Caption = '序号'
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SORT_ID'
                      Footers = <>
                      Title.Caption = '分类代码'
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SORT_NAME'
                      Footers = <>
                      Title.Caption = '分类名称'
                      Width = 168
                    end
                    item
                      DisplayFormat = '#0.0#'
                      EditButtons = <>
                      FieldName = 'ORG_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|金额'
                      Width = 62
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|可销售额'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|数量'
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进货金额'
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|未税金额'
                      Width = 68
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进项税额'
                      Width = 59
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销售金额'
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|未税金额'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销项税额'
                      Width = 67
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|成本'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|毛利'
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footers = <>
                      Title.Caption = '销售|毛利率'
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBIN_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBIN_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBOUT_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBOUT_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|金额'
                      Width = 77
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|可销售额'
                    end>
                end
              end
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Color = clCream
          Caption = '商品进销存统计表'
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 703
            Height = 527
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Panel6: TPanel
              Left = 5
              Top = 5
              Width = 693
              Height = 517
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              object RzPanel14: TRzPanel
                Left = 0
                Top = 0
                Width = 693
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
                  Caption = '门店名称'
                end
                object Label24: TLabel
                  Left = 288
                  Top = 56
                  Width = 48
                  Height = 12
                  Caption = '商品分类'
                end
                object RzLabel8: TRzLabel
                  Left = 24
                  Top = 14
                  Width = 48
                  Height = 12
                  Alignment = taRightJustify
                  Caption = '所属月份'
                end
                object RzLabel9: TRzLabel
                  Left = 175
                  Top = 14
                  Width = 12
                  Height = 12
                  Caption = '至'
                end
                object Label25: TLabel
                  Left = 24
                  Top = 79
                  Width = 48
                  Height = 12
                  Caption = '商品指标'
                end
                object Label26: TLabel
                  Left = 288
                  Top = 80
                  Width = 48
                  Height = 12
                  Caption = '显示单位'
                end
                object Label3: TLabel
                  Left = 24
                  Top = 35
                  Width = 48
                  Height = 12
                  Caption = '门店群组'
                end
                object RzBitBtn3: TRzBitBtn
                  Left = 480
                  Top = 64
                  Width = 67
                  Height = 32
                  Action = actFind
                  Caption = '查询'
                  Color = clSilver
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = '宋体'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'COMP_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                      Title.Caption = '名称'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'CODE_ID'
                      Footers = <>
                      Title.Caption = '代码'
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
                    '行政区域'
                    '管理群组')
                  TabOrder = 9
                end
              end
              object RzPanel15: TRzPanel
                Left = 0
                Top = 105
                Width = 693
                Height = 412
                Align = alClient
                BorderOuter = fsGroove
                Color = clWhite
                TabOrder = 1
                object DBGridEh4: TDBGridEh
                  Left = 2
                  Top = 2
                  Width = 689
                  Height = 408
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
                  Font.Name = '宋体'
                  Font.Style = []
                  FooterColor = clWhite
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = '宋体'
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 3
                  ImeName = '极品五笔输入法'
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
                  TitleFont.Name = '宋体'
                  TitleFont.Style = [fsBold]
                  TitleHeight = 30
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = '￥'
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
                      Title.Caption = '序号'
                      Width = 30
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = '条码'
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = '货号'
                      Width = 62
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footers = <>
                      Title.Caption = '商品名称'
                      Width = 153
                    end
                    item
                      EditButtons = <>
                      FieldName = 'UNIT_NAME'
                      Footers = <>
                      Title.Caption = '单位'
                    end
                    item
                      DisplayFormat = '#0.0#'
                      EditButtons = <>
                      FieldName = 'ORG_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|金额'
                      Width = 62
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'ORG_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期初|可销售额'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|数量'
                      Width = 61
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进货金额'
                      Width = 69
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|未税金额'
                      Width = 68
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'STOCK_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '进货|进项税额'
                      Width = 59
                    end
                    item
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'SALE_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销售金额'
                      Width = 76
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_MNY'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|未税金额'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_TAX'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|销项税额'
                      Width = 67
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|成本'
                      Width = 72
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'SALE_PRF'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '销售|毛利'
                      Width = 73
                    end
                    item
                      DisplayFormat = '#0.00%'
                      EditButtons = <>
                      FieldName = 'SALE_RATE'
                      Footers = <>
                      Title.Caption = '销售|毛利率'
                      Width = 52
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBIN_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBIN_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调入|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'DBOUT_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'DBOUT_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '调出|金额'
                      Width = 74
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_AMT'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|数量'
                      Width = 60
                    end
                    item
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'BAL_CST'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|金额'
                      Width = 77
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BAL_RTL'
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = '期未|可销售额'
                    end>
                end
              end
            end
          end
        end
      end
      inherited PanelColumnS: TPanel
        Left = 708
        Height = 554
        inherited Panel2: TPanel
          Height = 504
          inherited RzPanel1: TRzPanel [3]
          end
          inherited Panel5: TPanel [4]
            Height = 389
            inherited rzShowColumns: TRzCheckList
              Height = 385
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 920
    inherited Image1: TImage
      Width = 405
    end
    inherited Image14: TImage
      Left = 911
    end
    inherited Image3: TImage
      Width = 405
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 72
        Caption = '进销存统计表'
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
      '销售汇总表')
    PageHeader.Font.Charset = GB2312_CHARSET
    PageHeader.Font.Height = -16
    PageHeader.Font.Name = '宋体'
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
