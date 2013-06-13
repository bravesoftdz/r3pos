inherited frmOrderForm: TfrmOrderForm
  Left = 202
  Top = 186
  Caption = #21333#25454#22522#31867
  ClientHeight = 522
  ClientWidth = 904
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 704
    Height = 475
    inherited webForm: TRzPanel
      Left = 0
      Top = 0
      Width = 704
      Height = 475
      Align = alClient
      Color = clWhite
      object PageControl: TRzPageControl
        Left = 0
        Top = 0
        Width = 704
        Height = 475
        ActivePage = TabSheet1
        Align = alClient
        ShowCardFrame = False
        ShowFocusRect = False
        ShowFullFrame = False
        ShowShadow = False
        TabOrder = 0
        OnChange = PageControlChange
        FixedDimension = 0
        object TabSheet1: TRzTabSheet
          Color = clWhite
          TabVisible = False
          Caption = #21333#25454
          object order_input: TRzPanel
            Left = 0
            Top = 0
            Width = 704
            Height = 150
            Align = alTop
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderColor = 15461355
            BorderWidth = 10
            Color = 15461355
            TabOrder = 0
            object RzPanel2: TRzPanel
              Left = 11
              Top = 11
              Width = 682
              Height = 128
              Align = alClient
              BorderOuter = fsNone
              BorderColor = 15461355
              BorderShadow = 15461355
              Color = 14606046
              FlatColor = clGray
              GridColor = clBackground
              TabOrder = 0
              DesignSize = (
                682
                128)
              object RzBorder1: TRzBorder
                Left = 18
                Top = 45
                Width = 644
                Height = 2
                BorderColor = clBlack
                BorderShadow = 394758
                FlatColor = 657930
                Anchors = [akLeft, akTop, akRight]
              end
              object lblInput: TRzLabel
                Left = 20
                Top = 9
                Width = 85
                Height = 29
                Caption = #26465#30721#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -21
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object lblHint: TRzLabel
                Left = 329
                Top = 13
                Width = 145
                Height = 20
                Caption = #24320#22987#25195#30721#38144#21806#35831#25353' Pause'
                Font.Charset = GB2312_CHARSET
                Font.Color = 8158332
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object help: TRzBmpButton
                Left = 650
                Top = 16
                Width = 16
                Height = 16
                AllowAllUp = True
                GroupIndex = 3
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
                TabOrder = 0
                Visible = False
                OnClick = helpClick
              end
              object barcode: TRzPanel
                Left = 115
                Top = 8
                Width = 203
                Height = 29
                BorderOuter = fsNone
                TabOrder = 1
                object barcode_input_left: TImage
                  Left = 0
                  Top = 0
                  Width = 6
                  Height = 29
                  Align = alLeft
                  AutoSize = True
                  Picture.Data = {
                    07544269746D61707A020000424D7A0200000000000036000000280000000600
                    00001D000000010018000000000044020000C30E0000C30E0000000000000000
                    0000DEDEDEDEDEDEDEDEDEE6E6E6F5F5F5FCFCFC0000DEDEDEDEDEDEE1E1E1E9
                    E9E9F4F4F4FBFBFB0000DEDEDECBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
                    CBCACACAF4F4F4FFFFFFFFFFFFFFFFFF0000ABABABD9D9D9FCFCFCFFFFFFFFFF
                    FFFFFFFF0000A1A1A1DDDDDDFEFEFEFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
                    FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
                    00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
                    FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
                    9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
                    FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDE
                    FFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF
                    00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFF
                    FFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E
                    9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFF
                    FFFFFFFF00009E9E9EDEDEDEFFFFFFFFFFFFFFFFFFFFFFFF00009D9D9DDDDDDD
                    FEFEFEFFFFFFFFFFFFFFFFFF00009B9B9BD9D9D9FCFCFCFFFFFFFFFFFFFFFFFF
                    0000979797C9C9C9F4F4F4FFFFFFFFFFFFFFFFFF00009B9B9BADADADE0E0E0FA
                    FAFAFFFFFFFFFFFF0000DEDEDE929292B9B9B9DFDFDFF3F3F3FBFBFB0000DEDE
                    DEDEDEDE919191ACACACC6C6C6D6D6D60000DEDEDEDEDEDEDEDEDEA2A2A29999
                    999999990000}
                end
                object barcode_input_right: TImage
                  Left = 198
                  Top = 0
                  Width = 5
                  Height = 29
                  Align = alRight
                  AutoSize = True
                  Picture.Data = {
                    07544269746D617006020000424D060200000000000036000000280000000500
                    00001D0000000100180000000000D0010000120B0000120B0000000000000000
                    0000FCFCFCF5F5F5DEDEDEDEDEDEDEDEDE00FCFCFCFCFCFCFFFFFFDEDEDEDEDE
                    DE00FFFFFFFFFFFFFDFDFDFFFFFFDEDEDE00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
                    F700FFFFFFFFFFFFFFFFFFFDFDFDFDFDFD00FFFFFFFFFFFFFFFFFFFEFEFEFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FF00FFFFFFFFFFFFFFFFFFFEFEFEFFFFFF00FFFFFFFFFFFFFFFFFFFCFCFCFDFD
                    FD00FFFFFFFFFFFFFFFFFFF5F5F5F7F7F700FFFFFFFFFFFFFAFAFAE7E7E7E6E6
                    E600FBFBFBF3F3F3DFDFDFE2E2E2DEDEDE00D6D6D6C6C6C6CBCBCBDEDEDEDEDE
                    DE00AEAEAECBCBCBDEDEDEDEDEDEDEDEDE00}
                end
                object barcode_input_line: TImage
                  Left = 6
                  Top = 0
                  Width = 192
                  Height = 29
                  Align = alClient
                  AutoSize = True
                  Picture.Data = {
                    07544269746D61707A020000424D7A0200000000000036000000280000000600
                    00001D0000000100180000000000440200000000000000000000000000000000
                    0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000DEDE
                    DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00009E9E9E9E9E9E9E9E9E9E9E9E9E9E
                    9E9E9E9E0000}
                  Stretch = True
                end
                object edtInput: TcxTextEdit
                  Left = 4
                  Top = 2
                  Width = 194
                  Height = 24
                  ParentFont = False
                  Style.BorderStyle = ebsNone
                  Style.Font.Charset = GB2312_CHARSET
                  Style.Font.Color = clBlack
                  Style.Font.Height = -16
                  Style.Font.Name = #23435#20307
                  Style.Font.Style = [fsBold]
                  Style.HotTrack = False
                  Style.LookAndFeel.Kind = lfStandard
                  Style.LookAndFeel.NativeStyle = False
                  Style.Shadow = False
                  TabOrder = 0
                  ImeMode = imClose
                  OnEnter = edtInputEnter
                  OnExit = edtInputExit
                  OnKeyDown = edtInputKeyDown
                  OnKeyPress = edtInputKeyPress
                end
              end
              object helpPanel: TRzPanel
                Left = 196
                Top = 53
                Width = 465
                Height = 68
                Anchors = [akTop, akRight]
                BorderOuter = fsNone
                BorderColor = 15461355
                Color = 14606046
                TabOrder = 2
                object lblModifyUnit: TRzLabel
                  Tag = 2
                  Left = 17
                  Top = 0
                  Width = 88
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20462#25913#21333#20301'  [F2] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object lblModifyAmt: TRzLabel
                  Tag = 3
                  Left = 17
                  Top = 24
                  Width = 88
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20462#25913#25968#37327'  [F3] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object lblModifyPrice: TRzLabel
                  Tag = 4
                  Left = 17
                  Top = 48
                  Width = 88
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20462#25913#21333#20215'  [F4] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
            end
          end
          object order_header: TRzPanel
            Left = 0
            Top = 150
            Width = 704
            Height = 32
            Align = alTop
            BorderOuter = fsNone
            Color = 15461355
            TabOrder = 1
          end
          object order_grid: TRzPanel
            Left = 0
            Top = 182
            Width = 704
            Height = 224
            Align = alClient
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderColor = 15461355
            BorderShadow = 10591380
            BorderWidth = 10
            Color = clWhite
            FlatColor = 10591380
            GridColor = 10591380
            TabOrder = 2
            object DBGridEh1: TDBGridEh
              Left = 11
              Top = 11
              Width = 682
              Height = 202
              Align = alClient
              AllowedOperations = [alopUpdateEh, alopAppendEh]
              AutoFitColWidths = True
              BorderStyle = bsNone
              Color = 16185078
              DataSource = dsTable
              Flat = True
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = []
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
              ParentFont = False
              PopupMenu = PopupMenu1
              RowHeight = 30
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = -15
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 30
              IsDrawNullRow = True
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
                  Footer.Alignment = taCenter
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
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
              Tag = -1
              Left = 288
              Top = 139
              Width = 121
              Height = 23
              TabStop = False
              ParentFont = False
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              Style.Edges = [bLeft, bTop, bRight, bBottom]
              Style.ButtonTransparency = ebtAlways
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
              OnFindClick = fndGODS_IDFindClick
              ShowButton = True
              LocateStyle = lsDark
              Buttons = [zbFind]
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
            object row_order_nav: TToolBar
              Left = 459
              Top = 88
              Width = 86
              Height = 26
              Cursor = crHandPoint
              Align = alNone
              ButtonHeight = 37
              ButtonWidth = 27
              EdgeBorders = []
              Flat = True
              Font.Charset = GB2312_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsUnderline]
              Images = Images
              ParentFont = False
              TabOrder = 3
              object toolDelete: TToolButton
                Left = 0
                Top = 0
                AutoSize = True
                Caption = #21024#38500
                ImageIndex = 0
                OnClick = toolDeleteClick
              end
              object toolReturn: TToolButton
                Left = 27
                Top = 0
                AutoSize = True
                Caption = #36864#36135
                ImageIndex = 1
                OnClick = toolReturnClick
              end
              object toolPresent: TToolButton
                Left = 54
                Top = 0
                Caption = 'toolPresent'
                ImageIndex = 2
                OnClick = toolPresentClick
              end
            end
          end
          object order_footer: TRzPanel
            Left = 0
            Top = 406
            Width = 704
            Height = 69
            Align = alBottom
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderColor = 15461355
            BorderWidth = 10
            Color = 14606046
            TabOrder = 3
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 904
    object lblCaption: TRzLabel
      Left = 0
      Top = 0
      Width = 598
      Height = 47
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = #21333#25454#21517#31216
      Font.Charset = GB2312_CHARSET
      Font.Color = 2889728
      Font.Height = -24
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      LightTextStyle = True
      ShadowColor = 16382457
      ShadowDepth = 1
      TextStyle = tsShadow
    end
    object RzPanel12: TRzPanel
      Left = 598
      Top = 0
      Width = 272
      Height = 47
      Align = alRight
      BorderOuter = fsNone
      Color = 12040119
      TabOrder = 0
      object btnPrint: TRzBmpButton
        Left = 7
        Top = 9
        Width = 72
        Height = 31
        Bitmaps.TransparentColor = clFuchsia
        Bitmaps.Up.Data = {
          5E1A0000424D5E1A0000000000003600000028000000480000001F0000000100
          180000000000281A000000000000000000000000000000000000B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B6B6B6B3B3B3ACAC
          ACA5A5A5A1A1A19F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A2A2A2A8A8A8B0B0
          B0B6B6B6B7B7B7B7B7B7B7B7B7B6B6B6B0B0B0A0A0A08B8B8B7B7B7B74747471
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          71717171717171717171717171727272767676828282959595A9A9A9B4B4B4B7
          B7B7B7B7B7B1B1B19C9C9CAAAAAAC3C3C3DADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADACECECEB4B4B48080807171718C8C8CA9A9A9B6B6B6B6B6B6ACACAC
          CCCCCCDADADADADADADBDBDBDADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADA989898717171959595B0B0B0B1B1B1D4D4D4DCDCDCDADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD8D8
          D87E7E7E808080A7A7A7BCBCBCE7E7E7DBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADABBBBBB757575A1
          A1A1C9C9C9E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAD4D4D4717171A0A0A0CBCBCBE7E7E7
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA737373A1A1A1CDCDCDE8E8E8DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DAD9D9D9797979A4A4A4CACACAECECECDBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADACBCBCB8A8A8AAC
          ACACBBBBBBEEEEEEE3E3E3DADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAAEAEAE9F9F9FB3B3B3B7B7B7CDCDCD
          EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADACECECE9E9E9EB1B1B1B6B6B6B7B7B7B7B7B7CDCDCDE9E9E9E7E7
          E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1DEDEDEC7C7C7ACAC
          ACB1B1B1B6B6B6B7B7B7B7B7B7B7B7B7B7B7B7BBBBBBC3C3C3C6C6C6C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4B8B8B8B3B3B3B6B6B6B7B7B7B7B7B7B7
          B7B7}
        Color = clBtnFace
        Caption = #25171#21360
        TabOrder = 0
      end
      object btnNav: TRzBmpButton
        Left = 160
        Top = 10
        Width = 106
        Height = 29
        Bitmaps.TransparentColor = clFuchsia
        Bitmaps.Up.Data = {
          76240000424D762400000000000036000000280000006A0000001D0000000100
          1800000000004024000000000000000000000000000000000000B7B7B7B6B6B6
          B2B2B2A9A9A9A2A2A2A0A0A09F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9FA0A0A0A2A2A2A9A9A9B2B2B2B6B6B6B7B7B70000B6B6B6AEAEAE
          9B9B9B8585857777777272727171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717272727777778585859B9B9BAEAEAEB6B6B60000B1B1B1A1A1A1
          BABABACFCFCFDADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADACECECEB1B1B17070707979799A9A9AB1B1B10000B2B2B2D6D6D6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADAD1D1D1777777838383A9A9A90000D2D2D2DFDFDF
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADAB2B2B2767676A2A2A20000E8E8E8DBDBDB
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADAD4D4D4717171A0A0A00000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA7171719F9F9F0000EEEEEEDADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA717171A0A0A00000EEEEEEDBDBDB
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADA767676A2A2A20000ECECECDFDFDF
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADAD4D4D4838383A9A9A90000DDDDDDE9E9E9
          DBDBDBDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADABBBBBB9A9A9AB1B1B10000BFBFBFEBEBEB
          E8E8E8E0E0E0DCDCDCDADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADAD4D4D4A5A5A5AEAEAEB6B6B60000B7B7B7BCBCBC
          D8D8D8E1E1E1E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
          E6E6E6E5E5E5DCDCDCCACACAAEAEAEB2B2B2B6B6B6B7B7B70000}
        Color = clBtnFace
        Caption = #21382#21490#21333#25454
        TabOrder = 1
      end
      object btnPreview: TRzBmpButton
        Left = 83
        Top = 9
        Width = 72
        Height = 31
        Bitmaps.TransparentColor = clFuchsia
        Bitmaps.Up.Data = {
          5E1A0000424D5E1A0000000000003600000028000000480000001F0000000100
          180000000000281A000000000000000000000000000000000000B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
          B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B6B6B6B3B3B3ACAC
          ACA5A5A5A1A1A19F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
          9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A2A2A2A8A8A8B0B0
          B0B6B6B6B7B7B7B7B7B7B7B7B7B6B6B6B0B0B0A0A0A08B8B8B7B7B7B74747471
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          7171717171717171717171717171717171717171717171717171717171717171
          71717171717171717171717171727272767676828282959595A9A9A9B4B4B4B7
          B7B7B7B7B7B1B1B19C9C9CAAAAAAC3C3C3DADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADACECECEB4B4B48080807171718C8C8CA9A9A9B6B6B6B6B6B6ACACAC
          CCCCCCDADADADADADADBDBDBDADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADA989898717171959595B0B0B0B1B1B1D4D4D4DCDCDCDADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD8D8
          D87E7E7E808080A7A7A7BCBCBCE7E7E7DBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADABBBBBB757575A1
          A1A1C9C9C9E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAD4D4D4717171A0A0A0CBCBCBE7E7E7
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADA7171719F9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADA7171719F
          9F9FCBCBCBE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADA7171719F9F9FCBCBCBE6E6E6
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADA737373A1A1A1CDCDCDE8E8E8DADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DAD9D9D9797979A4A4A4CACACAECECECDBDBDBDADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADACBCBCB8A8A8AAC
          ACACBBBBBBEEEEEEE3E3E3DADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADAAEAEAE9F9F9FB3B3B3B7B7B7CDCDCD
          EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
          DADADADADADACECECE9E9E9EB1B1B1B6B6B6B7B7B7B7B7B7CDCDCDE9E9E9E7E7
          E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
          E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1DEDEDEC7C7C7ACAC
          ACB1B1B1B6B6B6B7B7B7B7B7B7B7B7B7B7B7B7BBBBBBC3C3C3C6C6C6C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
          C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4B8B8B8B3B3B3B6B6B6B7B7B7B7B7B7B7
          B7B7}
        Color = clBtnFace
        Caption = #39044#35272
        TabOrder = 2
      end
    end
    object RzPanel18: TRzPanel
      Left = 870
      Top = 0
      Width = 34
      Height = 47
      Align = alRight
      BorderOuter = fsNone
      BorderSides = [sdLeft]
      Color = 12040119
      TabOrder = 1
    end
  end
  object photoPanel: TRzPanel
    Left = 704
    Top = 47
    Width = 200
    Height = 475
    Align = alRight
    BorderOuter = fsNone
    BorderColor = 15461355
    BorderWidth = 6
    Color = clWhite
    FlatColor = 15461355
    TabOrder = 2
    object adv_photo_left_line: TImage
      Left = 6
      Top = 10
      Width = 4
      Height = 455
      Align = alLeft
      AutoSize = True
      Picture.Data = {
        07544269746D61705A000000424D5A0000000000000036000000280000000400
        000003000000010018000000000024000000120B0000120B0000000000000000
        0000E8E8E8E1E1E1D8D8D8CBCBCBE8E8E8E1E1E1D8D8D8CBCBCBE8E8E8E1E1E1
        D8D8D8CBCBCB}
      Stretch = True
    end
    object adv_photo_right_line: TImage
      Left = 190
      Top = 10
      Width = 4
      Height = 455
      Align = alRight
      AutoSize = True
      Picture.Data = {
        07544269746D61705A000000424D5A0000000000000036000000280000000400
        000003000000010018000000000024000000120B0000120B0000000000000000
        0000CBCBCBD8D8D8E1E1E1E8E8E8CBCBCBD8D8D8E1E1E1E8E8E8CBCBCBD8D8D8
        E1E1E1E8E8E8}
      Stretch = True
    end
    object adv_top: TRzPanel
      Left = 6
      Top = 6
      Width = 188
      Height = 4
      Align = alTop
      BorderOuter = fsNone
      Color = 14606046
      TabOrder = 0
      object adv_photo_top_left: TImage
        Left = 0
        Top = 0
        Width = 4
        Height = 4
        Align = alLeft
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000400
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000EAEAEAE7E7E7E4E4E4DEDEDEEAEAEAE9E9E9E6E6E6E4E4E4EBEBEBEAEAEA
          E9E9E9E7E7E7EBEBEBEBEBEBEAEAEAEAEAEA}
      end
      object adv_photo_top_right: TImage
        Left = 184
        Top = 0
        Width = 4
        Height = 4
        Align = alRight
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000400
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000DEDEDEE4E4E4E7E7E7EAEAEAE4E4E4E6E6E6E9E9E9EAEAEAE7E7E7E9E9E9
          EAEAEAEBEBEBEAEAEAEAEAEAEBEBEBEBEBEB}
      end
      object adv_photo_top_line: TImage
        Left = 4
        Top = 0
        Width = 180
        Height = 4
        Align = alClient
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000300
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000CBCBCBCBCBCBCBCBCB000000D8D8D8D8D8D8D8D8D8000000E1E1E1E1E1E1
          E1E1E1000000E8E8E8E8E8E8E8E8E8000000}
        Stretch = True
      end
    end
    object adv_bottom: TRzPanel
      Left = 6
      Top = 465
      Width = 188
      Height = 4
      Align = alBottom
      BorderOuter = fsNone
      Color = 14606046
      TabOrder = 1
      object adv_photo_bottom_left: TImage
        Left = 0
        Top = 0
        Width = 4
        Height = 4
        Align = alLeft
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000400
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000EBEBEBEBEBEBEAEAEAEAEAEAEBEBEBEAEAEAE9E9E9E7E7E7EAEAEAE9E9E9
          E6E6E6E4E4E4EAEAEAE7E7E7E4E4E4DEDEDE}
      end
      object adv_photo_bottom_right: TImage
        Left = 184
        Top = 0
        Width = 4
        Height = 4
        Align = alRight
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000400
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000EAEAEAEAEAEAEBEBEBEBEBEBE7E7E7E9E9E9EAEAEAEBEBEBE4E4E4E6E6E6
          E9E9E9EAEAEADEDEDEE4E4E4E7E7E7EAEAEA}
      end
      object adv_photo_bottom_line: TImage
        Left = 4
        Top = 0
        Width = 180
        Height = 4
        Align = alClient
        AutoSize = True
        Picture.Data = {
          07544269746D617066000000424D660000000000000036000000280000000300
          000004000000010018000000000030000000120B0000120B0000000000000000
          0000E8E8E8E8E8E8E8E8E8000000E1E1E1E1E1E1E1E1E1000000D8D8D8D8D8D8
          D8D8D8000000CBCBCBCBCBCBCBCBCB000000}
        Stretch = True
      end
    end
    object RzPanel1: TRzPanel
      Left = 10
      Top = 10
      Width = 180
      Height = 455
      Align = alClient
      BorderOuter = fsNone
      BorderColor = 16316664
      BorderWidth = 5
      TabOrder = 2
      object adv01: TImage
        Left = 5
        Top = 5
        Width = 170
        Height = 241
        Align = alTop
      end
      object adv02: TImage
        Left = 5
        Top = 251
        Width = 170
        Height = 199
        Align = alClient
      end
      object RzPanel17: TRzPanel
        Left = 5
        Top = 246
        Width = 170
        Height = 5
        Align = alTop
        BorderOuter = fsNone
        BorderColor = 16316664
        Color = 16316664
        TabOrder = 0
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
    AfterOpen = edtTableAfterOpen
    CachedUpdates = True
    AfterDelete = edtTableAfterDelete
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
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #22797#21046#24403#21069#34892
      Visible = False
    end
    object N3: TMenuItem
      Caption = #21024#38500#24403#21069#34892
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #28165#31354#24403#21069#34892
      OnClick = N4Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #36192#36865#27492#21830#21697
      OnClick = N5Click
    end
    object mnuReturn: TMenuItem
      Caption = #36864#25442#27492#21830#21697
      OnClick = mnuReturnClick
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 352
    Top = 152
  end
  object Images: TImageList
    BlendColor = clWhite
    BkColor = clFuchsia
    Height = 20
    Width = 20
    Left = 480
    Top = 365
    Bitmap = {
      494C010103000400040014001400FF00FF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      000000000000000000000000000000000000FF00FF00A8BAE8003463D0000034
      C400093EC600043FC400063FC600063FC500073FC500083FC600073DC600073E
      C700093DC600083CC700073DC800063DC600053AC4005981D900C5D3F200E8EB
      F900FF00FF00A8BAE8003463D0000034C400093EC600043FC400063FC600063F
      C500073FC500083FC600073DC600073EC700093DC600083CC700073DC800063D
      C600053AC4005981D900C5D3F200E8EBF900FF00FF00A8BAE8003463D0000034
      C400093EC600043FC400063FC600063FC500073FC500083FC600073DC600073E
      C700093DC600083CC700073DC800063DC600053AC4005981D900C5D3F200E8EB
      F900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7D3F0008DA6E6003C6BD9001D4F
      D5002053D6001D52D3001F54D7001F53D5001F53D4002054D5001F52D5001F53
      D6002252D6002152D6001F52D6002153D5002154D500557CDF00A8BCED00C8D3
      F200C7D3F0008DA6E6003C6BD9001D4FD5002053D6001D52D3001F54D7001F53
      D5001F53D4002054D5001F52D5001F53D6002252D6002152D6001F52D6002153
      D5002154D500557CDF00A8BCED00C8D3F200C7D3F0008DA6E6003C6BD9001D4F
      D5002053D6001D52D3001F54D7001F53D5001F53D4002054D5001F52D5001F53
      D6002252D6002152D6001F52D6002153D5002154D500557CDF00A8BCED00C8D3
      F200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005C81DA004F7AE3004272EC00114D
      E700114DE700114DE700114DE700114DE700114DE700114DE700114DE700114D
      E700114DE700114DE700114DE700114DE700114DE7004874EB00577EE0005C83
      DB005C81DA004F7AE3004272EC00114DE700114DE700114DE700114DE700114D
      E700114DE700114DE700114DE700114DE700114DE700114DE700114DE700114D
      E700114DE7004874EB00577EE0005C83DB005C81DA004F7AE3004272EC00114D
      E700114DE700114DE700114DE700114DE700114DE700114DE700114DE700114D
      E700114DE700114DE700114DE700114DE700114DE7004874EB00577EE0005C83
      DB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000033EC7003B6EE7002F65EF000C53
      E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53
      E8000C53E8000C53E8000C53E8000C53E8000C53E8003F74EF002059D8000040
      C800033EC7003B6EE7002F65EF000C53E8000C53E8000C53E8000C53E8000C53
      E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53
      E8000C53E8003F74EF002059D8000040C800033EC7003B6EE7002F65EF000C53
      E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53E8000C53
      E8000C53E8000C53E8000C53E8000C53E8000C53E8003F74EF002059D8000040
      C800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000642CB00366CE5002767ED000E59
      E8000E59E800FDFFFF00FDFFFF000E59E8000E59E800FDFFFF00FDFFFF000E59
      E8000E59E800FDFFFF00FDFFFF000E59E8000E59E8003B73F0002058DA000541
      CC000642CB00366CE5002767ED000E59E800FDFFFF000E59E8000E59E8000E59
      E800FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF000E59
      E8000E59E8003B73F0002058DA000541CC000642CB00366CE5002767ED000E59
      E800FDFFFF000E59E8000E59E8000E59E800FDFFFF00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00FDFFFF000E59E8000E59E8000E59E8003B73F0002058DA000541
      CC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000746CD003A71E6002E6FEE001261
      EB00FDFFFF001261EB00FDFFFF001261EB00FDFFFF001261EB00FDFFFF001261
      EB001261EB001261EB00FDFFFF001261EB001261EB003774F100235DDC000745
      CE000746CD003A71E6002E6FEE001261EB001261EB00FDFFFF001261EB00FDFF
      FF001261EB001261EB001261EB001261EB001261EB001261EB001261EB001261
      EB001261EB003774F100235DDC000745CE000746CD003A71E6002E6FEE001261
      EB001261EB00FDFFFF001261EB00FDFFFF001261EB00FDFFFF001261EB001261
      EB001261EB00FDFFFF001261EB001261EB001261EB003774F100235DDC000745
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000748CF003C78E700246EEF001769
      EE00FDFFFF001769EE00FDFFFF001769EE00FDFFFF001769EE00FDFFFF001769
      EE001769EE001769EE00FDFFFF001769EE001769EE003D7DF1002563DB000749
      CE000748CF003C78E700246EEF001769EE001769EE001769EE00FDFFFF001769
      EE00FDFFFF001769EE001769EE001769EE001769EE00FDFFFF001769EE001769
      EE001769EE003D7DF1002563DB000749CE000748CF003C78E700246EEF001769
      EE001769EE001769EE00FDFFFF001769EE001769EE00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00FDFFFF001769EE001769EE001769EE003D7DF1002563DB000749
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000074AD1003C7DE900176CF0001C71
      EF00FDFFFF001C71EF00FDFFFF001C71EF00FDFFFF001C71EF00FDFFFF001C71
      EF00FDFFFF001C71EF00FDFFFF001C71EF001C71EF004688F3002566DD00064B
      D000074AD1003C7DE900176CF0001C71EF001C71EF001C71EF00FDFFFF001C71
      EF00FDFFFF00FDFFFF001C71EF001C71EF001C71EF00FDFFFF001C71EF001C71
      EF001C71EF004688F3002566DD00064BD000074AD1003C7DE900176CF0001C71
      EF00FDFFFF001C71EF00FDFFFF001C71EF00FDFFFF00FDFFFF001C71EF001C71
      EF001C71EF00FDFFFF001C71EF001C71EF001C71EF004688F3002566DD00064B
      D000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000074BD2004082EA002379F2001F7A
      F000FDFFFF001F7AF000FDFFFF001F7AF000FDFFFF001F7AF000FDFFFF001F7A
      F000FDFFFF001F7AF000FDFFFF001F7AF0001F7AF0004A92F400256AE200054B
      D500074BD2004082EA002379F2001F7AF0001F7AF0001F7AF000FDFFFF001F7A
      F000FDFFFF001F7AF000FDFFFF001F7AF000FDFFFF001F7AF0001F7AF0001F7A
      F0001F7AF0004A92F400256AE200054BD500074BD2004082EA002379F2001F7A
      F000FDFFFF001F7AF000FDFFFF001F7AF000FDFFFF00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00FDFFFF001F7AF0001F7AF0001F7AF0004A92F400256AE200054B
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000074ED4004287EC003A8EF4002383
      F100FDFFFF002383F100FDFFFF002383F100FDFFFF002383F100FDFFFF002383
      F100FDFFFF002383F100FDFFFF002383F1002383F1004B99F600266EE200064F
      D500074ED4004287EC003A8EF4002383F1002383F1002383F100FDFFFF002383
      F100FDFFFF002383F1002383F100FDFFFF002383F100FDFFFF002383F1002383
      F1002383F1004B99F600266EE200064FD500074ED4004287EC003A8EF4002383
      F100FDFFFF002383F100FDFFFF002383F100FDFFFF002383F1002383F1002383
      F1002383F1002383F1002383F1002383F1002383F1004B99F600266EE200064F
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000850D600448EED003F98F400278B
      F400FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00278BF400FDFFFF00278BF400278BF40052A1F8002B71E400084F
      D7000850D600448EED003F98F400278BF400278BF400278BF400FDFFFF00278B
      F400FDFFFF00278BF400FDFFFF00278BF400278BF400278BF400FDFFFF00278B
      F400278BF40052A1F8002B71E400084FD7000850D600448EED003F98F400278B
      F400FDFFFF00278BF400FDFFFF00278BF400FDFFFF00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00FDFFFF00FDFFFF00278BF400278BF40052A1F8002B71E400084F
      D700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000753D8004793EE00439EF7002C92
      F600FDFFFF002C92F600FDFFFF002C92F600FDFFFF002C92F600FDFFFF002C92
      F600FDFFFF002C92F600FDFFFF002C92F6002C92F60057A9F9002D75E6000A51
      DA000753D8004793EE00439EF7002C92F600FDFFFF00FDFFFF00FDFFFF002C92
      F600FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF002C92F6002C92
      F6002C92F60057A9F9002D75E6000A51DA000753D8004793EE00439EF7002C92
      F600FDFFFF002C92F600FDFFFF002C92F600FDFFFF002C92F6002C92F600FDFF
      FF002C92F6002C92F600FDFFFF002C92F6002C92F60057A9F9002D75E6000A51
      DA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000755DB004A97F00048A6F9002F98
      F600FDFFFF002F98F600FDFFFF002F98F600FDFFFF002F98F600FDFFFF002F98
      F600FDFFFF002F98F600FDFFFF002F98F6002F98F6005AB0F9002D7AE6000855
      DB000755DB004A97F00048A6F9002F98F6002F98F6002F98F6002F98F6002F98
      F600FDFFFF002F98F6002F98F6002F98F6002F98F600FDFFFF002F98F6002F98
      F6002F98F6005AB0F9002D7AE6000855DB000755DB004A97F00048A6F9002F98
      F600FDFFFF002F98F600FDFFFF002F98F600FDFFFF00FDFFFF002F98F600FDFF
      FF002F98F600FDFFFF00FDFFFF002F98F6002F98F6005AB0F9002D7AE6000855
      DB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000857DF004B9DF1004BADF900329F
      F700FDFFFF00329FF700FDFFFF00329FF700FDFFFF00329FF700FDFFFF00329F
      F700FDFFFF00329FF700FDFFFF00329FF700329FF7005CB5F9002D7EE6000658
      DC000857DF004B9DF1004BADF900329FF700329FF700329FF700329FF700329F
      F700FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00329FF700329F
      F700329FF7005CB5F9002D7EE6000658DC000857DF004B9DF1004BADF900329F
      F700FDFFFF00329FF700329FF700329FF700FDFFFF00329FF700329FF700FDFF
      FF00329FF700329FF700FDFFFF00329FF700329FF7005CB5F9002D7EE6000658
      DC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000658DF004DA1F2004FB3FA0036A7
      FA00FDFFFF00FDFFFF00FDFFFF0036A7FA00FDFFFF00FDFFFF00FDFFFF0036A7
      FA0036A7FA0036A7FA00FDFFFF0036A7FA0036A7FA005DBDFB002E7FE9000957
      DF000658DF004DA1F2004FB3FA0036A7FA0036A7FA0036A7FA00FDFFFF0036A7
      FA00FDFFFF0036A7FA0036A7FA0036A7FA0036A7FA00FDFFFF0036A7FA0036A7
      FA0036A7FA005DBDFB002E7FE9000957DF000658DF004DA1F2004FB3FA0036A7
      FA00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFF
      FF00FDFFFF00FDFFFF00FDFFFF0036A7FA0036A7FA005DBDFB002E7FE9000957
      DF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000859E1004FA6F30052BAFC0039AF
      FB0039AFFB0039AFFB0039AFFB0039AFFB0039AFFB0039AFFB0039AFFB0039AF
      FB0039AFFB0039AFFB00FDFFFF0039AFFB0039AFFB0060C2FB003183EC000B5B
      E3000859E1004FA6F30052BAFC0039AFFB0039AFFB00FDFFFF0039AFFB0039AF
      FB00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF00FDFFFF0039AFFB0039AF
      FB0039AFFB0060C2FB003183EC000B5BE3000859E1004FA6F30052BAFC0039AF
      FB0039AFFB0039AFFB0039AFFB0039AFFB0039AFFB00FDFFFF0039AFFB0039AF
      FB0039AFFB00FDFFFF0039AFFB0039AFFB0039AFFB0060C2FB003183EC000B5B
      E300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000054DE0053AAF60054C2FE0038B4
      FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4
      FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0067CBFE002983EB000056
      E1000054DE0053AAF60054C2FE0038B4FA0038B4FA0038B4FA0038B4FA0038B4
      FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4
      FA0038B4FA0067CBFE002983EB000056E1000054DE0053AAF60054C2FE0038B4
      FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4
      FA0038B4FA0038B4FA0038B4FA0038B4FA0038B4FA0067CBFE002983EB000056
      E100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003079E5005DADF40066CAFE0056C7
      FE0055C4FD0055C4FD0056C4FD0057C5FD004DC1FD0041BCFD0042BCFC0053C4
      FD0056C5FD0055C5FD0056C6FD0059C5FF0059C6FF006BC8FD004794EC002E79
      E5003079E5005DADF40066CAFE0056C7FE0055C4FD0055C4FD0056C4FD0057C5
      FD004DC1FD0041BCFD0042BCFC0053C4FD0056C5FD0055C5FD0056C6FD0059C5
      FF0059C6FF006BC8FD004794EC002E79E5003079E5005DADF40066CAFE0056C7
      FE0055C4FD0055C4FD0056C4FD0057C5FD004DC1FD0041BCFD0042BCFC0053C4
      FD0056C5FD0055C5FD0056C6FD0059C5FF0059C6FF006BC8FD004794EC002E79
      E500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0BFF0007BB3F0005FAFF50056AF
      F70051AFF60052AFF60052AFF60052AFF60052AFF60052AFF60052AFF60052AF
      F60052AFF60051B0F50050AFF50054AFF70056B1F80064ADF5008DB8F0009FBD
      EF00A0BFF0007BB3F0005FAFF50056AFF70051AFF60052AFF60052AFF60052AF
      F60052AFF60052AFF60052AFF60052AFF60052AFF60051B0F50050AFF50054AF
      F70056B1F80064ADF5008DB8F0009FBDEF00A0BFF0007BB3F0005FAFF50056AF
      F70051AFF60052AFF60052AFF60052AFF60052AFF60052AFF60052AFF60052AF
      F60052AFF60051B0F50050AFF50054AFF70056B1F80064ADF5008DB8F0009FBD
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3E8F1009DBEF000317AE8000059
      E2000961E4000961E4000961E4000961E4000961E4000961E4000961E4000961
      E4000961E4000961E4000861E400045FE300025EE300568FEC00C3D2F200E6E8
      F300E3E8F1009DBEF000317AE8000059E2000961E4000961E4000961E4000961
      E4000961E4000961E4000961E4000961E4000961E4000961E4000861E400045F
      E300025EE300568FEC00C3D2F200E6E8F300E3E8F1009DBEF000317AE8000059
      E2000961E4000961E4000961E4000961E4000961E4000961E4000961E4000961
      E4000961E4000961E4000861E400045FE300025EE300568FEC00C3D2F200E6E8
      F300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF0080000800008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
