inherited frmBatchAdjustPrice: TfrmBatchAdjustPrice
  Left = 397
  Top = 153
  Width = 930
  Height = 564
  Caption = #25209#37327#35843#20215
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 922
    Height = 500
    inherited RzPanel2: TRzPanel
      Width = 912
      Height = 490
      inherited RzPage: TRzPageControl
        Width = 906
        Height = 484
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          inherited RzPanel3: TRzPanel
            Width = 904
            Height = 457
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 894
              Height = 447
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 0
              object RzPanel6: TRzPanel
                Left = 0
                Top = 68
                Width = 894
                Height = 379
                Align = alClient
                BorderOuter = fsNone
                TabOrder = 0
                object Panel1: TPanel
                  Left = 0
                  Top = 0
                  Width = 894
                  Height = 379
                  Align = alClient
                  Caption = 'Panel1'
                  TabOrder = 0
                  object Grid: TDBGridEh
                    Left = 1
                    Top = 35
                    Width = 892
                    Height = 343
                    Align = alClient
                    AllowedOperations = [alopUpdateEh]
                    DataSource = dsPrice
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
                    OnCellClick = GridCellClick
                    OnDrawColumnCell = GridDrawColumnCell
                    Columns = <
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
                        Width = 180
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
                        FieldName = 'SHOP_NAME'
                        Footers = <>
                        Title.Caption = #38376#24215#21517#31216
                        Width = 138
                      end
                      item
                        EditButtons = <>
                        FieldName = 'UNIT_ID'
                        Footers = <>
                        Title.Caption = #21333#20301
                        Width = 30
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00'
                        EditButtons = <>
                        FieldName = 'NEW_OUTPRICE_1'
                        Footer.Alignment = taRightJustify
                        Footer.DisplayFormat = '#0.00#'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #26631#20934#21806#20215
                        Width = 60
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00#'
                        EditButtons = <>
                        FieldName = 'NEW_OUTPRICE_A'
                        Footer.Alignment = taRightJustify
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #24403#21069#21806#20215'|'#21806#20215
                        Width = 57
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00'
                        EditButtons = <>
                        FieldName = 'OUTPRICE_A_RATE'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #24403#21069#21806#20215'|'#25240#25187#29575
                        Width = 57
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00'
                        EditButtons = <>
                        FieldName = 'NEW_OUTPRICE'
                        Footers = <>
                        Title.Caption = #35843#25972#21518#21806#20215'|'#21806#20215
                        Width = 57
                        OnUpdateData = GridColumns9UpdateData
                      end
                      item
                        Alignment = taRightJustify
                        DisplayFormat = '#0.00%'
                        EditButtons = <>
                        FieldName = 'NEW_OUTPRICE_RATE'
                        Footers = <>
                        Title.Caption = #35843#25972#21518#21806#20215'|'#25240#25187#29575
                        Width = 57
                        OnUpdateData = GridColumns10UpdateData
                      end
                      item
                        EditButtons = <>
                        FieldName = 'LOOK'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #26597#30475
                        Width = 60
                      end>
                  end
                  object RzPanel7: TRzPanel
                    Left = 1
                    Top = 1
                    Width = 892
                    Height = 34
                    Align = alTop
                    BorderOuter = fsNone
                    TabOrder = 1
                    object Label3: TLabel
                      Left = 24
                      Top = 9
                      Width = 156
                      Height = 16
                      Caption = #21806#20215' = '#26631#20934#21806#20215' * '
                      Font.Charset = GB2312_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -16
                      Font.Name = #23435#20307
                      Font.Style = [fsBold]
                      ParentFont = False
                    end
                    object Label1: TLabel
                      Left = 274
                      Top = 9
                      Width = 9
                      Height = 16
                      Caption = '%'
                      Font.Charset = GB2312_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -16
                      Font.Name = #23435#20307
                      Font.Style = [fsBold]
                      ParentFont = False
                    end
                    object edtValue: TcxTextEdit
                      Left = 182
                      Top = 4
                      Width = 84
                      Height = 27
                      ParentFont = False
                      Style.BorderStyle = ebsThick
                      Style.Font.Charset = GB2312_CHARSET
                      Style.Font.Color = clNavy
                      Style.Font.Height = -19
                      Style.Font.Name = #40657#20307
                      Style.Font.Style = [fsBold]
                      TabOrder = 0
                    end
                    object Btn_OK: TRzBitBtn
                      Left = 288
                      Top = 4
                      Width = 67
                      Height = 26
                      Caption = #30830#23450
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
                      OnClick = Btn_OKClick
                      NumGlyphs = 2
                      Spacing = 5
                    end
                  end
                end
              end
              object RzPanel9: TRzPanel
                Left = 0
                Top = 0
                Width = 894
                Height = 68
                Align = alTop
                BorderOuter = fsNone
                BorderSides = [sdBottom]
                TabOrder = 1
                object Panel2: TPanel
                  Left = 0
                  Top = 0
                  Width = 894
                  Height = 68
                  Align = alClient
                  Alignment = taLeftJustify
                  BevelInner = bvLowered
                  ParentColor = True
                  TabOrder = 0
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
                  object btnOk: TRzBitBtn
                    Left = 478
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
                    TabOrder = 6
                    TextStyle = tsRaised
                    ThemeAware = False
                    ImageIndex = 12
                    NumGlyphs = 2
                    Spacing = 5
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
                    TabOrder = 3
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
  end
  inherited RzPanel4: TRzPanel
    Width = 922
    inherited Image3: TImage
      Left = 212
      Width = 670
    end
    inherited Image14: TImage
      Left = 902
    end
    inherited Image1: TImage
      Left = 882
    end
    inherited rzPanel5: TPanel
      Left = 212
    end
    inherited CoolBar1: TCoolBar
      Width = 192
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 192
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 192
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Width = 10
          Caption = 'ToolButton2'
          ImageIndex = 1
          Style = tbsDivider
        end
        object ToolButton3: TToolButton
          Left = 53
          Top = 0
          Action = actSave
        end
        object ToolButton6: TToolButton
          Left = 96
          Top = 0
          Action = actCancel
        end
        object ToolButton4: TToolButton
          Left = 139
          Top = 0
          Width = 10
          Caption = 'ToolButton4'
          ImageIndex = 15
          Style = tbsDivider
        end
        object ToolButton5: TToolButton
          Left = 149
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 296
    Top = 376
  end
  inherited actList: TActionList
    Left = 328
    Top = 376
    inherited actNew: TAction
      Caption = #35843#20215
      OnExecute = actNewExecute
    end
    inherited actSave: TAction
      OnExecute = actSaveExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
  end
  object cdsPrice: TZQuery
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 326
    Top = 410
  end
  object dsPrice: TDataSource
    DataSet = cdsPrice
    Left = 295
    Top = 410
  end
end
