inherited frmOrderForm: TfrmOrderForm
  Left = 186
  Top = 134
  ActiveControl = edtInput
  Caption = #21333#25454#22522#31867
  ClientHeight = 542
  ClientWidth = 904
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 904
    Height = 495
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 904
      Height = 495
      Align = alClient
      Color = clWhite
      object PageControl: TRzPageControl
        Left = 0
        Top = 0
        Width = 904
        Height = 495
        ActivePage = TabSheet1
        Align = alClient
        ShowCardFrame = False
        ShowFocusRect = False
        ShowFullFrame = False
        ShowShadow = False
        TabIndex = 0
        TabOrder = 0
        FixedDimension = 21
        object TabSheet1: TRzTabSheet
          Color = clWhite
          Caption = #21333#25454
          object order_input: TRzPanel
            Left = 0
            Top = 0
            Width = 904
            Height = 129
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
              Height = 109
              Align = alClient
              BorderOuter = fsFlatRounded
              TabOrder = 0
              DesignSize = (
                884
                109)
              object lblInput: TLabel
                Left = 16
                Top = 12
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
                Top = 16
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
              object edtInput: TcxTextEdit
                Left = 109
                Top = 9
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
                OnEnter = edtInputEnter
                OnExit = edtInputExit
                OnKeyPress = edtInputKeyPress
              end
              object RzBmpButton2: TRzBmpButton
                Left = 812
                Top = 8
                Width = 49
                AllowAllUp = True
                GroupIndex = 2
                Bitmaps.TransparentColor = clOlive
                Color = clBtnFace
                Anchors = [akTop, akRight]
                TabOrder = 1
                OnClick = RzBmpButton2Click
              end
            end
          end
          object order_header: TRzPanel
            Left = 0
            Top = 129
            Width = 904
            Height = 32
            Align = alTop
            BorderOuter = fsNone
            Color = clWhite
            TabOrder = 1
          end
          object order_grid: TRzPanel
            Left = 0
            Top = 161
            Width = 904
            Height = 244
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
              Height = 224
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
              Style.Edges = [bBottom]
              Style.ButtonTransparency = ebtHideInactive
              TabOrder = 2
              Visible = False
            end
          end
          object order_footer: TRzPanel
            Left = 0
            Top = 405
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
  inherited RzPanel1: TRzPanel
    Width = 904
    object RzLabel1: TRzLabel
      Left = 14
      Top = 7
      Width = 100
      Height = 24
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
      object RzBitBtn5: TRzBitBtn
        Left = 222
        Top = 6
        Width = 113
        Height = 28
        Caption = #26597#35810#21382#21490#21333#25454
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
end
