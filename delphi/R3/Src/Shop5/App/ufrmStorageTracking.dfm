inherited frmStorageTracking: TfrmStorageTracking
  Left = 169
  Top = 154
  Width = 934
  Height = 604
  Caption = #21830#21697#24211#23384
  Menu = MainMenu1
  WindowState = wsNormal
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 918
    Height = 529
    inherited RzPanel2: TRzPanel
      Width = 908
      Height = 519
      inherited RzPage: TRzPageControl
        Width = 902
        Height = 513
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24211#23384#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 900
            Height = 486
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 890
              Height = 476
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 0
              object Splitter1: TSplitter
                Left = 177
                Top = 68
                Height = 408
              end
              object RzPanel7: TRzPanel
                Left = 0
                Top = 68
                Width = 177
                Height = 408
                Align = alLeft
                BorderOuter = fsNone
                TabOrder = 0
                object rzTree: TRzTreeView
                  Left = 0
                  Top = 0
                  Width = 177
                  Height = 408
                  SelectionPen.Color = clBtnShadow
                  Align = alClient
                  FrameSides = [sdLeft, sdRight, sdBottom]
                  FrameStyle = fsGroove
                  FrameVisible = True
                  HideSelection = False
                  Indent = 19
                  ReadOnly = True
                  RowSelect = True
                  TabOrder = 0
                  OnChange = rzTreeChange
                end
              end
              object RzPanel6: TRzPanel
                Left = 180
                Top = 68
                Width = 710
                Height = 408
                Align = alClient
                BorderOuter = fsNone
                TabOrder = 1
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 710
                  Height = 408
                  Align = alClient
                  Caption = 'Panel1'
                  TabOrder = 0
                  object Grid: TDBGridEh
                    Left = 1
                    Top = 1
                    Width = 708
                    Height = 406
                    Align = alClient
                    AllowedOperations = [alopUpdateEh]
                    DataSource = DsStorage
                    Flat = True
                    FooterColor = clWindow
                    FooterFont.Charset = GB2312_CHARSET
                    FooterFont.Color = clWindowText
                    FooterFont.Height = -12
                    FooterFont.Name = #23435#20307
                    FooterFont.Style = []
                    FooterRowCount = 1
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                    ReadOnly = True
                    RowHeight = 23
                    SumList.Active = True
                    TabOrder = 0
                    TitleFont.Charset = GB2312_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -12
                    TitleFont.Name = #23435#20307
                    TitleFont.Style = []
                    UseMultiTitle = True
                    IsDrawNullRow = False
                    CurrencySymbol = #65509
                    DecimalNumber = 2
                    DigitalNumber = 12
                    OnDrawColumnCell = GridDrawColumnCell
                    OnGetCellParams = GridGetCellParams
                    OnGetFooterParams = GridGetFooterParams
                    Columns = <
                      item
                        Checkboxes = True
                        EditButtons = <>
                        FieldName = 'A'
                        Footers = <>
                        KeyList.Strings = (
                          '1'
                          '0')
                        PickList.Strings = (
                          '0'
                          '1')
                        Tag = -1
                        Title.Caption = #36873#25321
                        Visible = False
                        Width = 21
                      end
                      item
                        EditButtons = <>
                        FieldName = 'SEQNO'
                        Footers = <>
                        Title.Caption = #24207#21495
                        Width = 27
                      end
                      item
                        EditButtons = <>
                        FieldName = 'GODS_CODE'
                        Footers = <>
                        Title.Caption = #36135#21495
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'GODS_NAME'
                        Footer.ValueType = fvtCount
                        Footers = <>
                        Title.Caption = #21830#21697#21517#31216
                        Width = 122
                      end
                      item
                        EditButtons = <>
                        FieldName = 'BARCODE'
                        Footers = <>
                        Title.Caption = #26465#30721
                        Width = 100
                      end
                      item
                        EditButtons = <>
                        FieldName = 'UNIT_ID'
                        Footers = <>
                        Title.Caption = #21333#20301
                        Width = 26
                      end
                      item
                        EditButtons = <>
                        FieldName = 'PROPERTY_02'
                        Footers = <>
                        Title.Caption = #39068#33394
                        Width = 50
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.###'
                        EditButtons = <>
                        FieldName = 'AMOUNT'
                        Footer.Alignment = taRightJustify
                        Footer.DisplayFormat = '#0.###'
                        Footer.ValueType = fvtSum
                        Footers = <>
                        Title.Caption = #24211#23384#37327
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'ROAD_AMT'
                        Footer.ValueType = fvtSum
                        Footers = <>
                        Title.Caption = #22312#36884#37327
                        Visible = False
                        Width = 60
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00#'
                        EditButtons = <>
                        FieldName = 'NEW_OUTPRICE'
                        Footer.Alignment = taRightJustify
                        Footer.DisplayFormat = '#0.00#'
                        Footers = <>
                        Title.Caption = #24403#21069#21806#20215
                        Width = 55
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#,##0.00'
                        EditButtons = <>
                        FieldName = 'SALE_MNY'
                        Footer.Alignment = taRightJustify
                        Footer.DisplayFormat = '#,##0.00'
                        Footer.ValueType = fvtSum
                        Footers = <>
                        Title.Caption = #38144#21806#37329#39069
                        Width = 63
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00#'
                        EditButtons = <>
                        FieldName = 'NEW_INPRICE'
                        Footer.Alignment = taRightJustify
                        Footers = <>
                        Title.Caption = #26368#26032#36827#20215
                        Width = 57
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00'
                        EditButtons = <>
                        FieldName = 'STOCK_MNY'
                        Footer.Alignment = taRightJustify
                        Footer.ValueType = fvtSum
                        Footers = <>
                        Title.Caption = #36827#36135#25104#26412
                        Width = 59
                      end
                      item
                        EditButtons = <>
                        FieldName = 'SHOP_NAME'
                        Footers = <>
                        Title.Caption = #38376#24215#21517#31216
                        Width = 83
                      end
                      item
                        EditButtons = <>
                        FieldName = 'BATCH_NO'
                        Footers = <>
                        Title.Caption = #25209#21495
                        Width = 102
                      end>
                  end
                end
              end
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 890
                Height = 68
                Align = alTop
                BorderOuter = fsNone
                BorderSides = [sdBottom]
                TabOrder = 2
                object Panel3: TPanel
                  Left = 0
                  Top = 0
                  Width = 178
                  Height = 68
                  Align = alLeft
                  BevelInner = bvLowered
                  Caption = #24211#23384#26597#35810
                  Color = 12698049
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object Panel2: TPanel
                  Left = 178
                  Top = 0
                  Width = 712
                  Height = 68
                  Align = alClient
                  Alignment = taLeftJustify
                  BevelInner = bvLowered
                  ParentColor = True
                  TabOrder = 1
                  object Label20: TLabel
                    Left = 472
                    Top = 42
                    Width = 48
                    Height = 12
                    Caption = #26174#31034#21333#20301
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label21: TLabel
                    Left = 263
                    Top = 13
                    Width = 48
                    Height = 12
                    Caption = #38376#24215#21517#31216
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label25: TLabel
                    Left = 10
                    Top = 42
                    Width = 48
                    Height = 12
                    Caption = #21830#21697#25351#26631
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label12: TLabel
                    Left = 10
                    Top = 13
                    Width = 48
                    Height = 12
                    Caption = #38376#24215#32676#32452
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label2: TLabel
                    Left = 263
                    Top = 42
                    Width = 48
                    Height = 12
                    Caption = #21830#21697#21517#31216
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label3: TLabel
                    Left = 472
                    Top = 13
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
                  object btnOk: TRzBitBtn
                    Left = 638
                    Top = 36
                    Width = 67
                    Height = 24
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
                  object edtUNIT_ID: TcxComboBox
                    Left = 524
                    Top = 38
                    Width = 101
                    Height = 20
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.Items.Strings = (
                      #40664#35748#21333#20301
                      #35745#37327#21333#20301
                      #21253#35013'1'
                      #21253#35013'2')
                    TabOrder = 7
                  end
                  object edtGoods_Type: TcxComboBox
                    Left = 62
                    Top = 38
                    Width = 73
                    Height = 20
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.OnChange = edtGoods_TypePropertiesChange
                    TabOrder = 4
                  end
                  object edtGoods_ID: TzrComboBoxList
                    Tag = -1
                    Left = 136
                    Top = 38
                    Width = 119
                    Height = 20
                    ParentFont = False
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
                  object edtSHOP_ID: TzrComboBoxList
                    Tag = -1
                    Left = 315
                    Top = 9
                    Width = 149
                    Height = 20
                    ParentFont = False
                    Properties.AutoSelect = False
                    Properties.Buttons = <
                      item
                        Default = True
                      end>
                    Properties.ReadOnly = False
                    TabOrder = 2
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
                        Width = 145
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
                  object edtSHOP_VALUE: TzrComboBoxList
                    Tag = -1
                    Left = 136
                    Top = 9
                    Width = 119
                    Height = 20
                    ParentFont = False
                    Properties.AutoSelect = False
                    Properties.Buttons = <
                      item
                        Default = True
                      end>
                    Properties.ReadOnly = False
                    TabOrder = 1
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
                        Width = 115
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
                  object edtSHOP_TYPE: TcxComboBox
                    Left = 62
                    Top = 9
                    Width = 73
                    Height = 20
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.Items.Strings = (
                      #34892#25919#21306#22495
                      #31649#29702#32676#32452)
                    Properties.OnChange = edtSHOP_TYPEPropertiesChange
                    TabOrder = 0
                  end
                  object edtGoodsName: TzrComboBoxList
                    Left = 315
                    Top = 38
                    Width = 149
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
                    Buttons = [zbClear]
                    DropListStyle = lsFixed
                    MultiSelect = False
                    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                  end
                  object edtSTOR_AMT: TcxComboBox
                    Left = 524
                    Top = 9
                    Width = 101
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
                    TabOrder = 3
                  end
                end
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #34917#36135#38656#27714
          object RzPanel8: TRzPanel
            Left = 0
            Top = 0
            Width = 900
            Height = 486
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Splitter2: TSplitter
              Left = 182
              Top = 73
              Height = 408
            end
            object RzPanel10: TRzPanel
              Left = 5
              Top = 73
              Width = 177
              Height = 408
              Align = alLeft
              BorderOuter = fsNone
              TabOrder = 0
              object rzP2_Tree: TRzTreeView
                Left = 0
                Top = 0
                Width = 177
                Height = 408
                SelectionPen.Color = clBtnShadow
                Align = alClient
                FrameSides = [sdLeft, sdRight, sdBottom]
                FrameStyle = fsGroove
                FrameVisible = True
                HideSelection = False
                Indent = 19
                ReadOnly = True
                RowSelect = True
                TabOrder = 0
                OnChange = rzP2_TreeChange
              end
            end
            object RzPanel11: TRzPanel
              Left = 185
              Top = 73
              Width = 710
              Height = 408
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 1
              object Panel4: TPanel
                Left = 0
                Top = 0
                Width = 710
                Height = 408
                Align = alClient
                Caption = 'Panel1'
                TabOrder = 0
                object Panel5: TPanel
                  Left = 1
                  Top = 377
                  Width = 708
                  Height = 30
                  Align = alBottom
                  BevelOuter = bvNone
                  Color = clWhite
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object Label4: TLabel
                    Left = 4
                    Top = 8
                    Width = 7
                    Height = 12
                  end
                  object RzStatusPane3: TRzStatusPane
                    Left = 118
                    Top = 2
                    Width = 88
                    Height = 25
                    FillColor = clMaroon
                    ParentFillColor = False
                    Color = clYellow
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Alignment = taCenter
                    Caption = #20302#20110#19979#38480
                  end
                  object RzStatusPane4: TRzStatusPane
                    Left = 214
                    Top = 2
                    Width = 88
                    Height = 25
                    Color = clRed
                    ParentColor = False
                    Alignment = taCenter
                    Caption = #39640#20110#19978#38480
                  end
                  object RzStatusPane5: TRzStatusPane
                    Left = 22
                    Top = 2
                    Width = 88
                    Height = 25
                    FillColor = clPurple
                    ParentFillColor = False
                    Color = clYellow
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Alignment = taCenter
                    Caption = #26032#21697#19978#24066
                  end
                end
                object DBGridEh1: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 708
                  Height = 376
                  Align = alClient
                  AllowedOperations = [alopUpdateEh]
                  DataSource = dsdemand
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                  ReadOnly = True
                  RowHeight = 23
                  SumList.Active = True
                  TabOrder = 1
                  TitleFont.Charset = GB2312_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -12
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = DBGridEh1DrawColumnCell
                  OnGetCellParams = DBGridEh1GetCellParams
                  OnGetFooterParams = DBGridEh1GetFooterParams
                  Columns = <
                    item
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'A'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '0')
                      PickList.Strings = (
                        '0'
                        '1')
                      Tag = -1
                      Title.Caption = #36873#25321
                      Visible = False
                      Width = 21
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 27
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 122
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 100
                    end
                    item
                      EditButtons = <>
                      FieldName = 'UNIT_ID'
                      Footers = <>
                      Title.Caption = #21333#20301
                      Width = 26
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'AMOUNT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#37327
                      Width = 58
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'ROAD_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #22312#36884#37327
                      Width = 55
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.#'
                      EditButtons = <>
                      FieldName = 'CAN_SALE_DAY'
                      Footers = <>
                      Title.Caption = #38144#21806#22825#25968
                      Width = 32
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'UPPER_AMOUNT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #21512#29702#24211#23384
                      Width = 57
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'LOWER_AMOUNT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #23433#20840#24211#23384
                      Width = 57
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'DAY_SALE_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26085#22343#38144#37327
                      Width = 56
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'NEAR_SALE_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #36817#26399#38144#37327
                      Width = 58
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'STOCK_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24314#35758#34917#36135
                      Width = 55
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00#'
                      EditButtons = <>
                      FieldName = 'NEW_INPRICE'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00#'
                      Footers = <>
                      Title.Caption = #21442#32771#36827#20215
                      Width = 52
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'STOCK_MNY'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #34917#36135#37329#39069
                      Width = 67
                    end>
                end
              end
            end
            object RzPanel12: TRzPanel
              Left = 5
              Top = 5
              Width = 890
              Height = 68
              Align = alTop
              BorderOuter = fsNone
              BorderSides = [sdBottom]
              TabOrder = 2
              object Panel6: TPanel
                Left = 0
                Top = 0
                Width = 178
                Height = 68
                Align = alLeft
                BevelInner = bvLowered
                Caption = #38656#27714#20998#26512
                Color = 12698049
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Panel7: TPanel
                Left = 178
                Top = 0
                Width = 712
                Height = 68
                Align = alClient
                Alignment = taLeftJustify
                BevelInner = bvLowered
                ParentColor = True
                TabOrder = 1
                object Label5: TLabel
                  Left = 472
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label6: TLabel
                  Left = 263
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label7: TLabel
                  Left = 10
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label8: TLabel
                  Left = 10
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label9: TLabel
                  Left = 263
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#21517#31216
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzBitBtn1: TRzBitBtn
                  Left = 638
                  Top = 36
                  Width = 67
                  Height = 24
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
                object edtP2_UNIT_ID: TcxComboBox
                  Left = 524
                  Top = 38
                  Width = 101
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #40664#35748#21333#20301
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 6
                end
                object edtP2_Goods_Type: TcxComboBox
                  Left = 62
                  Top = 38
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = edtP2_Goods_TypePropertiesChange
                  TabOrder = 3
                end
                object edtP2_Goods_ID: TzrComboBoxList
                  Tag = -1
                  Left = 136
                  Top = 38
                  Width = 119
                  Height = 20
                  ParentFont = False
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
                object edtP2_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 315
                  Top = 9
                  Width = 149
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
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
                      Width = 145
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
                object edtP2_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 136
                  Top = 9
                  Width = 119
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
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
                      Width = 115
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
                object edtP2_SHOP_TYPE: TcxComboBox
                  Left = 62
                  Top = 9
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  Properties.OnChange = edtP2_SHOP_TYPEPropertiesChange
                  TabOrder = 0
                end
                object edtP2_GoodsName: TzrComboBoxList
                  Left = 315
                  Top = 38
                  Width = 149
                  Height = 20
                  TabStop = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 5
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
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
              end
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Caption = #23384#38144#27604#30417#25511
          object RzPanel13: TRzPanel
            Left = 0
            Top = 0
            Width = 900
            Height = 486
            Align = alClient
            BorderOuter = fsNone
            BorderWidth = 5
            TabOrder = 0
            object Splitter3: TSplitter
              Left = 182
              Top = 73
              Height = 408
            end
            object RzPanel14: TRzPanel
              Left = 5
              Top = 73
              Width = 177
              Height = 408
              Align = alLeft
              BorderOuter = fsNone
              TabOrder = 0
              object rzP3_Tree: TRzTreeView
                Left = 0
                Top = 0
                Width = 177
                Height = 408
                SelectionPen.Color = clBtnShadow
                Align = alClient
                FrameSides = [sdLeft, sdRight, sdBottom]
                FrameStyle = fsGroove
                FrameVisible = True
                HideSelection = False
                Indent = 19
                ReadOnly = True
                RowSelect = True
                TabOrder = 0
                OnChange = rzP3_TreeChange
              end
            end
            object RzPanel15: TRzPanel
              Left = 185
              Top = 73
              Width = 710
              Height = 408
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 1
              object Panel8: TPanel
                Left = 0
                Top = 0
                Width = 710
                Height = 408
                Align = alClient
                Caption = 'Panel1'
                TabOrder = 0
                object Panel9: TPanel
                  Left = 1
                  Top = 377
                  Width = 708
                  Height = 30
                  Align = alBottom
                  BevelOuter = bvNone
                  Color = clWhite
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object Label11: TLabel
                    Left = 4
                    Top = 8
                    Width = 7
                    Height = 12
                  end
                  object RzStatusPane1: TRzStatusPane
                    Left = 118
                    Top = 2
                    Width = 88
                    Height = 25
                    Color = clMaroon
                    ParentColor = False
                    Alignment = taCenter
                    Caption = #20302#20110#19979#38480
                  end
                  object RzStatusPane2: TRzStatusPane
                    Left = 214
                    Top = 2
                    Width = 88
                    Height = 25
                    Color = clRed
                    ParentColor = False
                    Alignment = taCenter
                    Caption = #39640#20110#19978#38480
                  end
                  object RzStatusPane6: TRzStatusPane
                    Left = 22
                    Top = 2
                    Width = 88
                    Height = 25
                    FillColor = clPurple
                    ParentFillColor = False
                    Color = clYellow
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = #23435#20307
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Alignment = taCenter
                    Caption = #26032#21697#19978#24066
                  end
                end
                object DBGridEh2: TDBGridEh
                  Left = 1
                  Top = 1
                  Width = 708
                  Height = 376
                  Align = alClient
                  AllowedOperations = [alopUpdateEh]
                  DataSource = dsRate
                  Flat = True
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -12
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  FooterRowCount = 1
                  FrozenCols = 1
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                  ReadOnly = True
                  RowHeight = 23
                  SumList.Active = True
                  TabOrder = 1
                  TitleFont.Charset = GB2312_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -12
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
                  UseMultiTitle = True
                  IsDrawNullRow = False
                  CurrencySymbol = #65509
                  DecimalNumber = 2
                  DigitalNumber = 12
                  OnDrawColumnCell = DBGridEh2DrawColumnCell
                  OnGetCellParams = DBGridEh2GetCellParams
                  OnGetFooterParams = DBGridEh2GetFooterParams
                  Columns = <
                    item
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'A'
                      Footers = <>
                      KeyList.Strings = (
                        '1'
                        '0')
                      PickList.Strings = (
                        '0'
                        '1')
                      Tag = -1
                      Title.Caption = #36873#25321
                      Visible = False
                      Width = 21
                    end
                    item
                      EditButtons = <>
                      FieldName = 'SEQNO'
                      Footers = <>
                      Title.Caption = #24207#21495
                      Width = 27
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_CODE'
                      Footers = <>
                      Title.Caption = #36135#21495
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'GODS_NAME'
                      Footer.ValueType = fvtCount
                      Footers = <>
                      Title.Caption = #21830#21697#21517#31216
                      Width = 122
                    end
                    item
                      EditButtons = <>
                      FieldName = 'BARCODE'
                      Footers = <>
                      Title.Caption = #26465#30721
                      Width = 100
                    end
                    item
                      EditButtons = <>
                      FieldName = 'UNIT_ID'
                      Footers = <>
                      Title.Caption = #21333#20301
                      Width = 26
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'AMOUNT'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.###'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24211#23384#37327
                      Width = 58
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.###'
                      EditButtons = <>
                      FieldName = 'MTH_SALE_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #24403#26376#38144#37327
                      Width = 60
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.#'
                      EditButtons = <>
                      FieldName = 'DAY_SALE_AMT'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #26085#22343#38144#37327
                      Width = 58
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.#'
                      EditButtons = <>
                      FieldName = 'CAN_SALE_DAY'
                      Footers = <>
                      Title.Caption = #38144#21806#22825#25968
                      Width = 33
                    end
                    item
                      Alignment = taRightJustify
                      DisplayFormat = '#0.00'
                      EditButtons = <>
                      FieldName = 'RATE'
                      Footer.Alignment = taRightJustify
                      Footer.DisplayFormat = '#0.00'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #23384#38144#27604
                      Width = 46
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'LOWER_RATE'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #23384#38144#27604#19979#38480
                      Width = 44
                    end
                    item
                      Alignment = taRightJustify
                      EditButtons = <>
                      FieldName = 'UPPER_RATE'
                      Footer.ValueType = fvtSum
                      Footers = <>
                      Title.Caption = #23384#38144#27604#19978#38480
                      Width = 44
                    end>
                end
              end
            end
            object RzPanel16: TRzPanel
              Left = 5
              Top = 5
              Width = 890
              Height = 68
              Align = alTop
              BorderOuter = fsNone
              BorderSides = [sdBottom]
              TabOrder = 2
              object Panel10: TPanel
                Left = 0
                Top = 0
                Width = 178
                Height = 68
                Align = alLeft
                BevelInner = bvLowered
                Caption = #23384#38144#27604#30417#25511
                Color = 12698049
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Panel11: TPanel
                Left = 178
                Top = 0
                Width = 712
                Height = 68
                Align = alClient
                Alignment = taLeftJustify
                BevelInner = bvLowered
                ParentColor = True
                TabOrder = 1
                object Label13: TLabel
                  Left = 472
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #26174#31034#21333#20301
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label14: TLabel
                  Left = 263
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#21517#31216
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label15: TLabel
                  Left = 10
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#25351#26631
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label16: TLabel
                  Left = 10
                  Top = 13
                  Width = 48
                  Height = 12
                  Caption = #38376#24215#32676#32452
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label17: TLabel
                  Left = 263
                  Top = 42
                  Width = 48
                  Height = 12
                  Caption = #21830#21697#21517#31216
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object RzBitBtn2: TRzBitBtn
                  Left = 638
                  Top = 36
                  Width = 67
                  Height = 24
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
                object edtP3_UNIT_ID: TcxComboBox
                  Left = 524
                  Top = 38
                  Width = 101
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #40664#35748#21333#20301
                    #35745#37327#21333#20301
                    #21253#35013'1'
                    #21253#35013'2')
                  TabOrder = 6
                end
                object edtP3_Goods_Type: TcxComboBox
                  Left = 62
                  Top = 38
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.OnChange = edtP3_Goods_TypePropertiesChange
                  TabOrder = 3
                end
                object edtP3_Goods_ID: TzrComboBoxList
                  Tag = -1
                  Left = 136
                  Top = 38
                  Width = 119
                  Height = 20
                  ParentFont = False
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
                object edtP3_SHOP_ID: TzrComboBoxList
                  Tag = -1
                  Left = 315
                  Top = 9
                  Width = 149
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 2
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
                      Width = 145
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
                object edtP3_SHOP_VALUE: TzrComboBoxList
                  Tag = -1
                  Left = 136
                  Top = 9
                  Width = 119
                  Height = 20
                  ParentFont = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 1
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
                      Width = 115
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
                object edtP3_SHOP_TYPE: TcxComboBox
                  Left = 62
                  Top = 9
                  Width = 73
                  Height = 20
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  ParentFont = False
                  Properties.DropDownListStyle = lsEditFixedList
                  Properties.Items.Strings = (
                    #34892#25919#21306#22495
                    #31649#29702#32676#32452)
                  Properties.OnChange = edtP3_SHOP_TYPEPropertiesChange
                  TabOrder = 0
                end
                object edtP3_GoodsName: TzrComboBoxList
                  Left = 315
                  Top = 38
                  Width = 149
                  Height = 20
                  TabStop = False
                  Properties.AutoSelect = False
                  Properties.Buttons = <
                    item
                      Default = True
                    end>
                  Properties.ReadOnly = False
                  TabOrder = 5
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
                  Buttons = [zbClear]
                  DropListStyle = lsFixed
                  MultiSelect = False
                  ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                end
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 918
    inherited Image3: TImage
      Left = 294
      Width = 0
    end
    inherited Image14: TImage
      Left = 898
    end
    inherited Image1: TImage
      Left = 286
      Width = 612
    end
    inherited rzPanel5: TPanel
      Left = 294
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#24211#23384#26597#35810
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 274
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 274
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 274
        ButtonWidth = 43
        object ToolButton8: TToolButton
          Left = 0
          Top = 0
          Action = actSetup
        end
        object ToolButton7: TToolButton
          Left = 43
          Top = 0
          Action = actfrmCalc
        end
        object ToolButton4: TToolButton
          Left = 86
          Top = 0
          Action = actFind
        end
        object ToolButton5: TToolButton
          Left = 129
          Top = 0
          Width = 8
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton1: TToolButton
          Left = 137
          Top = 0
          Action = actPrint
        end
        object ToolButton3: TToolButton
          Left = 180
          Top = 0
          Action = actPreview
        end
        object ToolButton6: TToolButton
          Left = 223
          Top = 0
          Width = 8
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton2: TToolButton
          Left = 231
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 96
    Top = 472
  end
  inherited actList: TActionList
    Left = 128
    Top = 472
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    object actfrmCalc: TAction
      Caption = #27979#31639
      ImageIndex = 36
      OnExecute = actfrmCalcExecute
    end
    object actSetup: TAction
      Caption = #35774#32622
      ImageIndex = 40
      OnExecute = actSetupExecute
    end
  end
  object CdsStorage: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 410
  end
  object DsStorage: TDataSource
    DataSet = CdsStorage
    Left = 295
    Top = 410
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 0.500000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -24
    PageHeader.Font.Name = #23435#20307
    PageHeader.Font.Style = [fsBold]
    Units = MM
    Left = 359
    Top = 410
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B5365636F6E645469746C
      655D5C66315C66733136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7D0D0A5C766965776B696E64345C7563315C706172645C7172
      5C6C616E67323035325C66305C667332305C2762345C2766325C2764335C2761
      315C2763615C2762315C2762635C2765340D0A5C706172207D0D0A00}
  end
  object cdsDemand: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 378
  end
  object dsdemand: TDataSource
    DataSet = cdsDemand
    Left = 295
    Top = 378
  end
  object cdsRate: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 346
  end
  object dsRate: TDataSource
    DataSet = cdsRate
    Left = 295
    Top = 346
  end
  object MainMenu1: TMainMenu
    Left = 466
    Top = 279
  end
end
