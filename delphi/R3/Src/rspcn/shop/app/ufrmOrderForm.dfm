inherited frmOrderForm: TfrmOrderForm
  Left = 315
  Top = 198
  ActiveControl = edtInput
  Caption = #21333#25454#22522#31867
  ClientHeight = 522
  ClientWidth = 904
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 904
    Height = 475
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 904
      Height = 475
      Align = alClient
      Color = clWhite
      object PageControl: TRzPageControl
        Left = 0
        Top = 0
        Width = 904
        Height = 475
        ActivePage = TabSheet1
        Align = alClient
        ShowCardFrame = False
        ShowFocusRect = False
        ShowFullFrame = False
        ShowShadow = False
        TabIndex = 0
        TabOrder = 0
        OnChange = PageControlChange
        FixedDimension = 21
        object TabSheet1: TRzTabSheet
          Color = clWhite
          Caption = #21333#25454
          object order_input: TRzPanel
            Left = 0
            Top = 0
            Width = 904
            Height = 150
            Align = alTop
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object RzPanel2: TRzPanel
              Left = 10
              Top = 10
              Width = 884
              Height = 130
              Align = alClient
              BorderOuter = fsFlatRounded
              TabOrder = 0
              DesignSize = (
                884
                130)
              object lblInput: TLabel
                Left = 16
                Top = 13
                Width = 84
                Height = 20
                Caption = #26465#30721#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -20
                Font.Name = #40657#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblHint: TLabel
                Left = 322
                Top = 17
                Width = 206
                Height = 12
                Caption = #35831#25353' [F2] '#20809#26631#28608#27963#26465#30721#36755#20837#26694'...'
                Font.Charset = GB2312_CHARSET
                Font.Color = clRed
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label26: TLabel
                Left = 17
                Top = 80
                Width = 116
                Height = 15
                Cursor = crHandPoint
                Hint = #30452#25509#36755#20837'[=]+['#25968#37327']'#20063#21487#23436#25104#36755#20837
                Caption = #20462#25913#25968#37327'  [F3] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
              end
              object Label20: TLabel
                Left = 17
                Top = 105
                Width = 116
                Height = 15
                Cursor = crHandPoint
                Caption = #20462#25913#21333#20215'  [F4] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label22: TLabel
                Left = 17
                Top = 55
                Width = 116
                Height = 15
                Cursor = crHandPoint
                Caption = #20462#25913#21333#20301'  [F2] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzBorder1: TRzBorder
                Left = 18
                Top = 46
                Width = 846
                Height = 2
                Anchors = [akLeft, akTop, akRight]
              end
              object edtInput: TcxTextEdit
                Left = 109
                Top = 10
                Width = 204
                Height = 27
                ParentFont = False
                Style.BorderStyle = ebsThick
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -19
                Style.Font.Name = #40657#20307
                Style.Font.Style = [fsBold]
                TabOrder = 0
                ImeMode = imAlpha
                OnEnter = edtInputEnter
                OnExit = edtInputExit
                OnKeyDown = edtInputKeyDown
                OnKeyPress = edtInputKeyPress
              end
              object help: TRzBmpButton
                Left = 852
                Top = 16
                Width = 16
                Height = 16
                AllowAllUp = True
                GroupIndex = 3
                Down = True
                Bitmaps.Down.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  D7CDC2BEAD9AB7A490B7A490B7A490B7A490B7A490B7A490B7A490B7A490BEAD
                  9AD7CDC2FF00FFFF00FFFF00FFB9A692DFD1C2F8EEE2FFF6EBFFF6EBFFF6EBFF
                  F6EBFFF6EBFFF6EBFFF6EBFFF6EBF8EEE2DFD1C2B9A692FF00FFD9CFC4DDD0C1
                  FFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7
                  ECFFF7ECDED1C2D8CEC3BDAB99F9F0E5FFF7EDFFF7ED7D66567D6656FFF7EDFF
                  F7EDFFF7EDFFF7ED7D66557D6655FFF7EDFFF7EDF9F0E5BDAB99B7A490FFF7EE
                  FFF7EEFFF7EEA78F7CA78F7C7D6656FFF7EEFFF7EE7C6655A78F7CA78F7CFFF7
                  EEFFF7EEFFF7EEB7A490B7A490FFF8EFFFF8EFFFF8EFFFF8EFA8907DA78F7C7C
                  66557D6656A78F7CA78F7CFFF8EFFFF8EFFFF8EFFFF8EFB7A490B7A490FFF8F0
                  FFF8F0FFF8F0FFF8F0FFF8F0A78F7CA8907DA78F7CA8907DFFF8F0FFF8F0FFF8
                  F0FFF8F0FFF8F0B7A490B7A490FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0A8
                  8F7CA78F7CFFF9F0FFF9F0FFF9F0FFF9F0FFF9F0FFF9F0B7A490B7A490FFF9F1
                  FFF9F1FFF9F17D66567D6656FFF9F1FFF9F1FFF9F1FFF9F17D66557D6655FFF9
                  F1FFF9F1FFF9F1B7A490B7A490FFF9F2FFF9F2FFF9F2A78F7CA78F7C7D6656FF
                  F9F2FFF9F27C6655A78F7CA78F7CFFF9F2FFF9F2FFF9F2B7A490B7A490FFFAF3
                  FFFAF3FFFAF3FFFAF3A8907DA78F7C7C66557D6656A78F7CA78F7CFFFAF3FFFA
                  F3FFFAF3FFFAF3B7A490B7A490FFFAF4FFFAF4FFFAF4FFFAF4FFFAF4A78F7CA8
                  907DA78F7CA8907DFFFAF4FFFAF4FFFAF4FFFAF4FFFAF4B7A490BDAB99F9F4ED
                  FFFBF5FFFBF5FFFBF5FFFBF5FFFBF5A88F7CA78F7CFFFBF5FFFBF5FFFBF5FFFB
                  F5FFFBF5F9F4EDBDAB99D9CFC4DDD2C6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FF
                  FBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6DDD2C6D9CFC4FF00FFB9A692
                  DCD1C5F7F2EBFFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6F7F2
                  EBDCD1C5B9A692FF00FFFF00FFFF00FFDAD0C6BFAE9CB7A490B7A490B7A490B7
                  A490B7A490B7A490B7A490B7A490BFAE9CDAD0C6FF00FFFF00FF}
                Bitmaps.TransparentColor = clOlive
                Bitmaps.Up.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                  D7CDC2BEAD9AB7A490B7A490B7A490B7A490B7A490B7A490B7A490B7A490BEAD
                  9AD7CDC2FF00FFFF00FFFF00FFB9A692DFD1C2F8EEE2FFF6EBFFF6EBFFF6EBFF
                  F6EBFFF6EBFFF6EBFFF6EBFFF6EBF8EEE2DFD1C2B9A692FF00FFD9CFC4DDD0C1
                  FFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7ECFFF7
                  ECFFF7ECDED1C2D8CEC3BDAB99F9F0E5FFF7EDFFF7EDFFF7EDFFF7EDFFF7EDA8
                  8F7CA78F7CFFF7EDFFF7EDFFF7EDFFF7EDFFF7EDF9F0E5BDAB99B7A490FFF7EE
                  FFF7EEFFF7EEFFF7EEFFF7EEA78F7CA8907DA78F7CA8907DFFF7EEFFF7EEFFF7
                  EEFFF7EEFFF7EEB7A490B7A490FFF8EFFFF8EFFFF8EFFFF8EFA8907DA78F7C7C
                  66557D6656A78F7CA78F7CFFF8EFFFF8EFFFF8EFFFF8EFB7A490B7A490FFF8F0
                  FFF8F0FFF8F0A78F7CA78F7C7D6656FFF8F0FFF8F07C6655A78F7CA78F7CFFF8
                  F0FFF8F0FFF8F0B7A490B7A490FFF9F0FFF9F0FFF9F07D66567D6656FFF9F0FF
                  F9F0FFF9F0FFF9F07D66557D6655FFF9F0FFF9F0FFF9F0B7A490B7A490FFF9F1
                  FFF9F1FFF9F1FFF9F1FFF9F1FFF9F1A88F7CA78F7CFFF9F1FFF9F1FFF9F1FFF9
                  F1FFF9F1FFF9F1B7A490B7A490FFF9F2FFF9F2FFF9F2FFF9F2FFF9F2A78F7CA8
                  907DA78F7CA8907DFFF9F2FFF9F2FFF9F2FFF9F2FFF9F2B7A490B7A490FFFAF3
                  FFFAF3FFFAF3FFFAF3A8907DA78F7C7C66557D6656A78F7CA78F7CFFFAF3FFFA
                  F3FFFAF3FFFAF3B7A490B7A490FFFAF4FFFAF4FFFAF4A78F7CA78F7C7D6656FF
                  FAF4FFFAF47C6655A78F7CA78F7CFFFAF4FFFAF4FFFAF4B7A490BDAB99F9F4ED
                  FFFBF5FFFBF57D66567D6656FFFBF5FFFBF5FFFBF5FFFBF57D66557D6655FFFB
                  F5FFFBF5F9F4EDBDAB99D9CFC4DDD2C6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FF
                  FBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6DDD2C6D9CFC4FF00FFB9A692
                  DCD1C5F7F2EBFFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6FFFBF6F7F2
                  EBDCD1C5B9A692FF00FFFF00FFFF00FFDAD0C6BFAE9CB7A490B7A490B7A490B7
                  A490B7A490B7A490B7A490B7A490BFAE9CDAD0C6FF00FFFF00FF}
                Color = clBtnFace
                Anchors = [akTop, akRight]
                TabOrder = 1
                OnClick = helpClick
              end
            end
          end
          object order_header: TRzPanel
            Left = 0
            Top = 150
            Width = 904
            Height = 32
            Align = alTop
            BorderOuter = fsNone
            Color = clWhite
            TabOrder = 1
          end
          object order_grid: TRzPanel
            Left = 0
            Top = 182
            Width = 904
            Height = 203
            Align = alClient
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 2
            object DBGridEh1: TDBGridEh
              Left = 10
              Top = 10
              Width = 884
              Height = 183
              Align = alClient
              AllowedOperations = [alopUpdateEh, alopAppendEh]
              AutoFitColWidths = True
              DataSource = dsTable
              FixedColor = clSilver
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBlack
              FooterFont.Height = -15
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghHighlightFocus, dghClearSelection]
              PopupMenu = PopupMenu1
              RowHeight = 25
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = -15
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 30
              UseMultiTitle = True
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnDrawColumnCell = DBGridEh1DrawColumnCell
              OnGetCellParams = DBGridEh1GetCellParams
              OnKeyDown = DBGridEh1KeyDown
              OnKeyPress = DBGridEh1KeyPress
              OnMouseDown = DBGridEh1MouseDown
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #24207#21495
                  Width = 37
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footers = <>
                  Title.Caption = #21830#21697#21517#31216
                  Width = 195
                  Control = fndGODS_ID
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_CODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #36135#21495
                end
                item
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #26465#30721
                  Width = 104
                end
                item
                  EditButtons = <>
                  FieldName = 'UNIT_ID'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #21333#20301
                  Width = 35
                  Control = fndUNIT_ID
                  OnBeforeShowControl = DBGridEh1Columns4BeforeShowControl
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #25968#37327
                  Width = 41
                end>
            end
            object fndGODS_ID: TzrComboBoxList
              Left = 288
              Top = 139
              Width = 121
              Height = 23
              TabStop = False
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              Style.Edges = [bBottom]
              Style.ButtonTransparency = ebtHideInactive
              TabOrder = 1
              Visible = False
              OnEnter = fndGODS_IDEnter
              OnExit = fndGODS_IDExit
              OnKeyDown = fndGODS_IDKeyDown
              OnKeyPress = fndGODS_IDKeyPress
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
              OnSaveValue = fndGODS_IDSaveValue
              MultiSelect = False
            end
            object fndUNIT_ID: TcxComboBox
              Left = 216
              Top = 168
              Width = 49
              Height = 23
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = fndUNIT_IDPropertiesChange
              Style.Edges = [bBottom]
              Style.ButtonTransparency = ebtHideInactive
              TabOrder = 2
              Visible = False
              OnEnter = fndUNIT_IDEnter
              OnExit = fndUNIT_IDExit
              OnKeyDown = fndUNIT_IDKeyDown
              OnKeyPress = fndUNIT_IDKeyPress
            end
          end
          object order_footer: TRzPanel
            Left = 0
            Top = 385
            Width = 904
            Height = 69
            Align = alBottom
            BorderOuter = fsNone
            Color = clWhite
            TabOrder = 3
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 904
    object lblCaption: TRzLabel
      Left = 14
      Top = 11
      Width = 100
      Height = 25
      Caption = #21333#25454#21517#31216
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RzPanel12: TRzPanel
      Left = 552
      Top = 0
      Width = 352
      Height = 47
      Align = alRight
      BorderOuter = fsNone
      Color = 8026232
      TabOrder = 0
      DesignSize = (
        352
        47)
      object btnNav: TRzBitBtn
        Left = 256
        Top = 8
        Width = 79
        Height = 28
        Caption = #21382#21490#21333#25454
        Color = 15461355
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        HighlightColor = 14276036
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 0
        TabStop = False
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
      object btnPrint: TRzBitBtn
        Left = 37
        Top = 8
        Width = 70
        Height = 28
        Anchors = [akTop]
        Caption = #25171#21360
        Color = 15461355
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        HighlightColor = 14276036
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 1
        TabStop = False
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
      object btnPreview: TRzBitBtn
        Left = 104
        Top = 8
        Width = 45
        Height = 28
        Anchors = [akTop]
        Caption = #39044#35272
        Color = 15461355
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        HighlightColor = 14276036
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 2
        TabStop = False
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
      object btnExport: TRzBitBtn
        Left = 164
        Top = 8
        Width = 76
        Height = 28
        Anchors = [akTop]
        Caption = #23548#20986'(&I)'
        Color = 15461355
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        HighlightColor = 14276036
        HotTrack = True
        HotTrackColor = 3983359
        HotTrackColorType = htctActual
        ParentFont = False
        TextShadowColor = clWhite
        TextShadowDepth = 4
        TabOrder = 3
        TabStop = False
        ThemeAware = False
        NumGlyphs = 2
        Spacing = 5
      end
    end
  end
  object edtTable: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BARCODE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IS_PRESENT'
        DataType = ftInteger
      end
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'BOM_ID'
        DataType = ftString
        Size = 36
      end>
    CachedUpdates = True
    Params = <>
    Left = 72
    Top = 264
  end
  object dsTable: TDataSource
    DataSet = edtTable
    Left = 104
    Top = 264
  end
  object edtProperty: TZQuery
    FieldDefs = <
      item
        Name = 'SEQNO'
        DataType = ftInteger
      end
      item
        Name = 'GODS_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'GODS_CODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GODS_NAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'UNIT_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BATCH_NO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'IS_PRESENT'
        DataType = ftInteger
      end
      item
        Name = 'LOCUS_NO'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'BOM_ID'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_01'
        DataType = ftString
        Size = 36
      end
      item
        Name = 'PROPERTY_02'
        DataType = ftString
        Size = 36
      end>
    CachedUpdates = True
    Params = <>
    Left = 72
    Top = 304
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 301
    object N1: TMenuItem
      Caption = #25554#20837#31354#30333#34892
    end
    object N2: TMenuItem
      Caption = #22797#21046#24403#21069#34892
    end
    object N3: TMenuItem
      Caption = #21024#38500#24403#21069#34892
    end
    object N4: TMenuItem
      Caption = #28165#31354#24403#21069#34892
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #36192#36865#27492#21830#21697
    end
  end
end
