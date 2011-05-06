inherited frmStorageTracking: TfrmStorageTracking
  Left = 214
  Top = 140
  Width = 1073
  Height = 604
  Caption = #24211#23384#26597#35810
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 1057
    Height = 530
    inherited RzPanel2: TRzPanel
      Width = 1047
      Height = 520
      inherited RzPage: TRzPageControl
        Width = 1041
        Height = 514
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #24211#23384#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 1039
            Height = 487
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 1029
              Height = 477
              Align = alClient
              BorderOuter = fsNone
              BorderWidth = 5
              TabOrder = 0
              object Splitter1: TSplitter
                Left = 182
                Top = 73
                Height = 399
              end
              object RzPanel7: TRzPanel
                Left = 5
                Top = 73
                Width = 177
                Height = 399
                Align = alLeft
                BorderOuter = fsNone
                TabOrder = 0
                object rzTree: TRzTreeView
                  Left = 0
                  Top = 0
                  Width = 177
                  Height = 399
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
                Width = 839
                Height = 399
                Align = alClient
                BorderOuter = fsNone
                TabOrder = 1
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 839
                  Height = 399
                  Align = alClient
                  Caption = 'Panel1'
                  TabOrder = 0
                  object stbPanel: TPanel
                    Left = 1
                    Top = 379
                    Width = 837
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
                    Width = 837
                    Height = 378
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
                    FrozenCols = 1
                    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
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
                        Footer.Value = #35760#24405#25968#65306
                        Footer.ValueType = fvtStaticText
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #36135#21495
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'GODS_NAME'
                        Footer.ValueType = fvtCount
                        Footers = <>
                        ReadOnly = True
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
                        ReadOnly = True
                        Title.Caption = #21333#20301
                        Width = 40
                      end
                      item
                        EditButtons = <>
                        FieldName = 'PROPERTY_01_TEXT'
                        Footers = <>
                        Title.Caption = #23610#30721
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'PROPERTY_02_TEXT'
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
                        ReadOnly = True
                        Title.Caption = #24211#23384#37327
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
                        Width = 66
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
                        Title.Caption = #38144#21806#37329#39069
                        Width = 67
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
                Left = 5
                Top = 5
                Width = 1019
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
                  Width = 839
                  Height = 66
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
                    TabOrder = 0
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
                    TabOrder = 1
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
                    TabOrder = 2
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
                    ShowButton = True
                    LocateStyle = lsDark
                    Buttons = [zbClear]
                    DropListStyle = lsFixed
                    MultiSelect = False
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
                    TabOrder = 6
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
                    Buttons = [zbClear]
                    DropListStyle = lsFixed
                    MultiSelect = False
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
                    TabOrder = 8
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
    Width = 1057
    inherited Image1: TImage
      Left = 208
      Width = 829
    end
    inherited Image3: TImage
      Left = 208
      Width = 829
    end
    inherited Image14: TImage
      Left = 1037
    end
    inherited rzPanel5: TPanel
      Left = 208
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#24211#23384#26597#35810
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 188
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 188
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 188
        ButtonWidth = 43
        object ToolButton4: TToolButton
          Left = 0
          Top = 0
          Action = actFind
        end
        object ToolButton5: TToolButton
          Left = 43
          Top = 0
          Width = 8
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton1: TToolButton
          Left = 51
          Top = 0
          Action = actPrint
        end
        object ToolButton3: TToolButton
          Left = 94
          Top = 0
          Action = actPreview
        end
        object ToolButton6: TToolButton
          Left = 137
          Top = 0
          Width = 8
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton2: TToolButton
          Left = 145
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
  end
  object CdsStorage: TZQuery
    FieldDefs = <>
    AfterScroll = CdsStorageAfterScroll
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
    Page.RightMargin = 2.000000000000000000
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
end
