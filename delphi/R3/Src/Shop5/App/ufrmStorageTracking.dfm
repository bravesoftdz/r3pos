inherited frmStorageTracking: TfrmStorageTracking
  Left = 249
  Top = 148
  Width = 1073
  Height = 604
  Caption = #24211#23384#26597#35810
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1065
    Height = 541
    inherited RzPanel2: TRzPanel
      Width = 1055
      Height = 531
      inherited RzPage: TRzPageControl
        Width = 1049
        Height = 525
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24211#23384#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 1047
            Height = 498
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 1037
              Height = 488
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object Splitter1: TSplitter
                Left = 182
                Top = 73
                Height = 410
              end
              object RzPanel7: TRzPanel
                Left = 5
                Top = 73
                Width = 177
                Height = 410
                Align = alLeft
                BorderOuter = fsNone
                TabOrder = 0
                object rzTree: TRzTreeView
                  Left = 0
                  Top = 0
                  Width = 177
                  Height = 410
                  SelectionPen.Color = clBtnShadow
                  Align = alClient
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
                Left = 185
                Top = 73
                Width = 847
                Height = 410
                Align = alClient
                BorderOuter = fsNone
                TabOrder = 1
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 847
                  Height = 410
                  Align = alClient
                  Caption = 'Panel1'
                  TabOrder = 0
                  object stbPanel: TPanel
                    Left = 1
                    Top = 390
                    Width = 845
                    Height = 19
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
                    object Label1: TLabel
                      Left = 4
                      Top = 8
                      Width = 7
                      Height = 12
                    end
                  end
                  object Grid: TDBGridEh
                    Left = 1
                    Top = 1
                    Width = 845
                    Height = 389
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
                    FrozenCols = 1
                    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
                    RowHeight = 23
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
                    OnDrawColumnCell = GridDrawColumnCell
                    OnGetCellParams = GridGetCellParams
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
                        Title.Color = clWhite
                        Visible = False
                        Width = 21
                      end
                      item
                        EditButtons = <>
                        FieldName = 'SEQ_NO'
                        Footers = <>
                        Title.Caption = #24207#21495
                        Title.Color = clWhite
                        Width = 40
                      end
                      item
                        EditButtons = <>
                        FieldName = 'GODS_CODE'
                        Footer.Value = #35760#24405#25968#65306
                        Footer.ValueType = fvtStaticText
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #36135#21495
                        Title.Color = clWhite
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'GODS_NAME'
                        Footer.ValueType = fvtCount
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #21830#21697#21517#31216
                        Title.Color = clWhite
                        Width = 122
                      end
                      item
                        EditButtons = <>
                        FieldName = 'BARCODE'
                        Footers = <>
                        Title.Caption = #26465#30721
                        Title.Color = clWhite
                        Width = 100
                      end
                      item
                        EditButtons = <>
                        FieldName = 'UNIT_ID'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #35745#37327#21333#20301
                        Title.Color = clWhite
                        Width = 55
                      end
                      item
                        EditButtons = <>
                        FieldName = 'BATCH_NO'
                        Footers = <>
                        Title.Caption = #25209#21495
                        Title.Color = clWhite
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'AMOUNT'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #24211#23384#37327
                        Title.Color = clWhite
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'PROPERTY_01_TEXT'
                        Footers = <>
                        Title.Caption = #23610#30721
                        Title.Color = clWhite
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'PROPERTY_02_TEXT'
                        Footers = <>
                        Title.Caption = #39068#33394
                        Title.Color = clWhite
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'AMONEY'
                        Footers = <>
                        Title.Caption = #25104#26412#37329#39069
                        Title.Color = clWhite
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'COST_PRICE'
                        Footers = <>
                        Title.Caption = #25104#26412#21333#20215
                        Title.Color = clWhite
                        Width = 80
                      end>
                  end
                end
              end
              object RzPanel9: TRzPanel
                Left = 5
                Top = 5
                Width = 1027
                Height = 68
                Align = alTop
                BorderOuter = fsNone
                BorderWidth = 1
                TabOrder = 2
                object Panel3: TPanel
                  Left = 1
                  Top = 1
                  Width = 178
                  Height = 66
                  Align = alLeft
                  BevelInner = bvLowered
                  Caption = #24211#23384#26597#35810#21450#36319#36394#39044#35686
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
                  Left = 179
                  Top = 1
                  Width = 847
                  Height = 66
                  Align = alClient
                  Alignment = taLeftJustify
                  BevelInner = bvLowered
                  ParentColor = True
                  TabOrder = 1
                  object Label20: TLabel
                    Left = 480
                    Top = 15
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
                    Left = 271
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
                    Top = 40
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
                    Left = 271
                    Top = 41
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
                  object btnOk: TRzBitBtn
                    Left = 586
                    Top = 34
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
                    TabOrder = 0
                    TextStyle = tsRaised
                    ThemeAware = False
                    ImageIndex = 12
                    NumGlyphs = 2
                    Spacing = 5
                  end
                  object edtUNIT_ID: TcxComboBox
                    Left = 532
                    Top = 10
                    Width = 121
                    Height = 20
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.Items.Strings = (
                      #40664#35748#21333#20301
                      #35745#37327#21333#20301
                      #21253#35013'1'
                      #21253#35013'2')
                    TabOrder = 1
                  end
                  object edtGoods_Type: TcxComboBox
                    Left = 62
                    Top = 36
                    Width = 73
                    Height = 20
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.OnChange = edtGoods_TypePropertiesChange
                    TabOrder = 2
                  end
                  object edtGoods_ID: TzrComboBoxList
                    Tag = -1
                    Left = 136
                    Top = 36
                    Width = 119
                    Height = 20
                    ParentFont = False
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
                  object edtSHOP_ID: TzrComboBoxList
                    Tag = -1
                    Left = 323
                    Top = 10
                    Width = 149
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
                        Width = 115
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
                  object edtSHOP_TYPE: TcxComboBox
                    Left = 62
                    Top = 9
                    Width = 73
                    Height = 20
                    ParentFont = False
                    Properties.DropDownListStyle = lsEditFixedList
                    Properties.Items.Strings = (
                      #34892#25919#21306#22495
                      #31649#29702#32676#32452)
                    Properties.OnChange = edtSHOP_TYPEPropertiesChange
                    TabOrder = 6
                  end
                  object edtGoodsName: TzrComboBoxList
                    Left = 323
                    Top = 36
                    Width = 149
                    Height = 20
                    TabStop = False
                    Properties.AutoSelect = False
                    Properties.Buttons = <
                      item
                        Default = True
                      end>
                    Properties.ReadOnly = False
                    TabOrder = 7
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
                    Buttons = []
                    DropListStyle = lsFixed
                    MultiSelect = False
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
    Width = 1065
    inherited Image1: TImage
      Left = 192
      Width = 853
    end
    inherited Image3: TImage
      Left = 192
      Width = 853
    end
    inherited Image14: TImage
      Left = 1045
    end
    inherited rzPanel5: TPanel
      Left = 192
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#24211#23384#26597#35810
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 172
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 172
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 172
        ButtonWidth = 43
        object ToolButton4: TToolButton
          Left = 0
          Top = 0
          Caption = #26597#35810
          ImageIndex = 15
        end
        object ToolButton1: TToolButton
          Left = 43
          Top = 0
          Caption = #25171#21360
          ImageIndex = 0
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Caption = #39044#35272
          ImageIndex = 14
        end
        object ToolButton2: TToolButton
          Left = 129
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
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  object CdsStorage: TZQuery
    FieldDefs = <>
    AfterScroll = CdsStorageAfterScroll
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 413
  end
  object DsStorage: TDataSource
    DataSet = CdsStorage
    Left = 295
    Top = 410
  end
end
