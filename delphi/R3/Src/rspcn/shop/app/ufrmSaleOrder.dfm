inherited frmSaleOrder: TfrmSaleOrder
  Left = 238
  Top = 96
  Caption = #21830#21697#38144#21806
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    inherited webForm: TRzPanel
      inherited PageControl: TRzPageControl
        FixedDimension = 21
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#24405#20837
          inherited order_input: TRzPanel
            Height = 149
            inherited RzPanel2: TRzPanel
              Height = 129
              DesignSize = (
                884
                129)
              inherited lblHint: TLabel
                Width = 279
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
              end
              object RzLabel5: TRzLabel [2]
                Left = 663
                Top = 16
                Width = 176
                Height = 15
                Anchors = [akTop, akRight]
                Caption = #21333#21495':000413031500002'
                Font.Charset = GB2312_CHARSET
                Font.Color = clPurple
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object h11: TLabel [3]
                Left = 386
                Top = 104
                Width = 124
                Height = 15
                Cursor = crHandPoint
                Caption = #25910#38134#32467#36134'  [ + ] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clRed
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label21: TLabel [4]
                Left = 18
                Top = 80
                Width = 109
                Height = 15
                Cursor = crHandPoint
                Caption = #23548' '#36141' '#21592'  [F9]'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel [9]
                Left = 149
                Top = 55
                Width = 116
                Height = 15
                Cursor = crHandPoint
                Caption = #36192#36865'/'#20817#25442' [F5] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel [10]
                Left = 149
                Top = 80
                Width = 116
                Height = 15
                Cursor = crHandPoint
                Hint = #30452#25509#36755#20837'[=]+['#25968#37327']'#20063#21487#23436#25104#36755#20837
                Caption = #20250#21592#21345#21495'  [F6] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
              end
              object Label4: TLabel [11]
                Left = 149
                Top = 105
                Width = 117
                Height = 15
                Cursor = crHandPoint
                Caption = #23548' '#36141' '#21592'  [F7] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel [12]
                Left = 282
                Top = 80
                Width = 86
                Height = 15
                Cursor = crHandPoint
                Hint = #30452#25509#36755#20837'[=]+['#25968#37327']'#20063#21487#23436#25104#36755#20837
                Caption = #25346#21333'  [F9] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
              end
              object Label6: TLabel [13]
                Left = 282
                Top = 55
                Width = 86
                Height = 15
                Cursor = crHandPoint
                Caption = #28165#23631'  [F8] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label7: TLabel [14]
                Left = 282
                Top = 105
                Width = 94
                Height = 15
                Cursor = crHandPoint
                Caption = #21462#21333'  [F10] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label12: TLabel [15]
                Left = 386
                Top = 80
                Width = 124
                Height = 15
                Cursor = crHandPoint
                Caption = #25910#27454#26041#24335'  [ * ] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clRed
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label13: TLabel [16]
                Left = 386
                Top = 55
                Width = 124
                Height = 15
                Cursor = crHandPoint
                Hint = #30452#25509#36755#20837'[=]+['#25968#37327']'#20063#21487#23436#25104#36755#20837
                Caption = #25972#21333#35843#20215'  [F11] '
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
              end
              inherited edtInput: TcxTextEdit
                Tag = -1
              end
            end
          end
          inherited order_header: TRzPanel
            Top = 149
            Height = 27
            object customerInfo: TLabel
              Left = 324
              Top = 10
              Width = 325
              Height = 12
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object RzPanel5: TRzPanel
              Left = 10
              Top = 6
              Width = 99
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #23458#25143#21517#31216
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 2
            end
            object edtCLIENT_ID: TzrComboBoxList
              Left = 106
              Top = 5
              Width = 214
              Height = 23
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              TabOrder = 0
              InGrid = False
              KeyValue = Null
              FilterFields = 'CLIENT_NAME;CLIENT_SPELL;CLIENT_CODE;LICENSE_CODE;TELEPHONE2'
              KeyField = 'CLIENT_ID'
              ListField = 'CLIENT_NAME'
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_CODE'
                  Footers = <>
                  Title.Caption = #23458#25143#21495
                  Width = 60
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #23458#25143#21517#31216
                  Width = 150
                end
                item
                  EditButtons = <>
                  FieldName = 'LINKMAN'
                  Footers = <>
                  Title.Caption = #32852#31995#20154
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'TELEPHONE2'
                  Footers = <>
                  Title.Caption = #32852#31995#30005#35805
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'LICENSE_CODE'
                  Footers = <>
                  Title.Caption = #35777#20214#21495
                  Width = 70
                end
                item
                  EditButtons = <>
                  FieldName = 'ADDRESS'
                  Footers = <>
                  Title.Caption = #22320#22336
                  Width = 150
                end>
              DropWidth = 314
              DropHeight = 281
              ShowTitle = True
              AutoFitColWidth = False
              ShowButton = True
              LocateStyle = lsDark
              Buttons = [zbNew, zbFind]
              DropListStyle = lsFixed
              MultiSelect = False
            end
            object RzPanel7: TRzPanel
              Left = 658
              Top = 6
              Width = 99
              Height = 21
              Anchors = [akTop, akRight]
              BorderOuter = fsFlatRounded
              Caption = #38144#21806#26085#26399
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 3
            end
            object edtSALES_DATE: TcxDateEdit
              Left = 754
              Top = 5
              Width = 141
              Height = 23
              Anchors = [akTop, akRight]
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              TabOrder = 1
            end
          end
          inherited order_grid: TRzPanel
            Top = 176
            Height = 164
            inherited DBGridEh1: TDBGridEh
              Height = 143
              FrozenCols = 1
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
                  OnBeforeShowControl = DBGridEh1Columns1BeforeShowControl
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
                  DisplayFormat = '#0.###'
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #25968#37327
                  Width = 49
                  OnUpdateData = DBGridEh1Columns5UpdateData
                end
                item
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'APRICE'
                  Footers = <>
                  Title.Caption = #21333#20215
                  Width = 60
                  OnUpdateData = DBGridEh1Columns6UpdateData
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #37329#39069
                  Width = 68
                end
                item
                  DisplayFormat = '#00.0%'
                  EditButtons = <>
                  FieldName = 'AGIO_RATE'
                  Footers = <>
                  Title.Caption = #25240#25187
                  Width = 46
                  OnUpdateData = DBGridEh1Columns8UpdateData
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AGIO_MONEY'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #35753#21033
                  Width = 69
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 111
                end>
            end
            inherited fndGODS_ID: TzrComboBoxList
              Left = 320
              Top = 107
              Style.BorderStyle = ebsFlat
              Style.ButtonStyle = btsUltraFlat
            end
            inherited fndUNIT_ID: TcxComboBox
              Top = 112
              Style.BorderStyle = ebsFlat
              Style.ButtonStyle = btsUltraFlat
            end
          end
          inherited order_footer: TRzPanel
            Top = 340
            Height = 114
            object Label1: TLabel
              Left = 314
              Top = 34
              Width = 8
              Height = 15
              Caption = '%'
            end
            object RzPanel10: TRzPanel
              Left = 213
              Top = 32
              Width = 51
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #25240#25187
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 9
            end
            object RzPanel6: TRzPanel
              Left = 10
              Top = 0
              Width = 99
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #35828'    '#26126
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 6
            end
            object RzPanel3: TRzPanel
              Left = 0
              Top = 67
              Width = 904
              Height = 47
              Align = alBottom
              BorderOuter = fsFlat
              BorderSides = [sdTop]
              FlatColor = 6447714
              TabOrder = 5
              object RzPanel4: TRzPanel
                Left = 535
                Top = 1
                Width = 369
                Height = 46
                Align = alRight
                BorderOuter = fsNone
                TabOrder = 0
                DesignSize = (
                  369
                  46)
                object btnSave: TRzBitBtn
                  Left = 23
                  Top = 6
                  Width = 113
                  Height = 28
                  Anchors = [akTop]
                  Caption = #20445#23384#24182#26032#22686
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
                  OnClick = btnSaveClick
                  NumGlyphs = 2
                  Spacing = 5
                end
                object btnSPreview: TRzBitBtn
                  Left = 215
                  Top = 6
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
                object btnSPrint: TRzBitBtn
                  Left = 148
                  Top = 6
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
                object btnNew: TRzBitBtn
                  Left = 272
                  Top = 6
                  Width = 70
                  Height = 28
                  Anchors = [akTop]
                  Caption = #28165#31354
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
                  OnClick = btnNewClick
                  NumGlyphs = 2
                  Spacing = 5
                end
              end
            end
            object edtREMARK: TcxTextEdit
              Left = 106
              Top = -1
              Width = 543
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object RzPanel8: TRzPanel
              Left = 658
              Top = 0
              Width = 99
              Height = 21
              Anchors = [akTop, akRight]
              BorderOuter = fsFlatRounded
              Caption = #23548' '#36141' '#21592
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 7
            end
            object edtGUIDE_USER: TzrComboBoxList
              Left = 754
              Top = -1
              Width = 141
              Height = 23
              Anchors = [akTop, akRight]
              Properties.AutoSelect = False
              Properties.Buttons = <
                item
                  Default = True
                end>
              Properties.ReadOnly = True
              TabOrder = 1
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
            object RzPanel9: TRzPanel
              Left = 10
              Top = 32
              Width = 99
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #32467#31639#37329#39069
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 8
            end
            object edtACCT_MNY: TcxTextEdit
              Left = 106
              Top = 31
              Width = 110
              Height = 23
              TabOrder = 2
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object edtAGIO_RATE: TcxTextEdit
              Left = 261
              Top = 31
              Width = 52
              Height = 23
              TabOrder = 3
              Text = '100.0'
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object payment: TRzPanel
              Left = 658
              Top = 32
              Width = 99
              Height = 21
              Anchors = [akTop, akRight]
              BorderOuter = fsFlatRounded
              Caption = #29616#37329#25903#20184
              Color = 16185078
              FlatColor = clMenuHighlight
              Font.Charset = GB2312_CHARSET
              Font.Color = clMaroon
              Font.Height = -15
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
            end
            object edtPAY_TOTAL: TcxTextEdit
              Left = 754
              Top = 31
              Width = 110
              Height = 23
              Anchors = [akTop, akRight]
              ParentFont = False
              Style.Font.Charset = GB2312_CHARSET
              Style.Font.Color = clMaroon
              Style.Font.Height = -15
              Style.Font.Name = #23435#20307
              Style.Font.Style = [fsBold]
              TabOrder = 4
              Text = '34866.55'
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clWhite
          Caption = #21382#21490#21333#25454
          object RzPanel11: TRzPanel
            Left = 0
            Top = 0
            Width = 904
            Height = 65
            Align = alTop
            BorderOuter = fsNone
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object RzPanel13: TRzPanel
              Left = 10
              Top = 10
              Width = 884
              Height = 45
              Align = alClient
              BorderOuter = fsFlatRounded
              TabOrder = 0
              DesignSize = (
                884
                45)
              object RzPanel15: TRzPanel
                Left = 16
                Top = 12
                Width = 353
                Height = 22
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsFlatRounded
                BorderColor = clBtnShadow
                Color = clWindow
                FlatColor = clWindowFrame
                TabOrder = 0
                DesignSize = (
                  353
                  22)
                object serachText: TEdit
                  Tag = -1
                  Left = 6
                  Top = 2
                  Width = 342
                  Height = 18
                  Hint = #35831#36755#20837#21333#21495#25110#23458#25143#21517#31216#25110#21830#21697#21517#31216#25110#22791#27880#35828#26126
                  Anchors = [akLeft, akTop, akRight]
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  BorderStyle = bsNone
                  TabOrder = 0
                end
              end
              object RzPanel16: TRzPanel
                Left = 387
                Top = 12
                Width = 402
                Height = 22
                Anchors = [akTop, akRight]
                BorderOuter = fsFlatRounded
                BorderColor = clBtnShadow
                Color = clWindow
                FlatColor = clWindowFrame
                TabOrder = 1
                object Label8: TLabel
                  Left = 14
                  Top = 3
                  Width = 30
                  Height = 15
                  Caption = #26085#26399
                end
                object Label9: TLabel
                  Left = 257
                  Top = 3
                  Width = 15
                  Height = 15
                  Caption = #33267
                end
                object dateFlag: TcxComboBox
                  Tag = -1
                  Left = 56
                  Top = -1
                  Width = 73
                  Height = 23
                  Properties.DropDownListStyle = lsFixedList
                  Properties.Items.Strings = (
                    #20170#26085
                    #26412#26376
                    #26412#24180
                    #33258#23450#20041)
                  Properties.OnChange = dateFlagPropertiesChange
                  Style.BorderColor = clWindowFrame
                  Style.BorderStyle = ebsUltraFlat
                  Style.Edges = [bLeft, bRight]
                  TabOrder = 0
                end
                object D1: TcxDateEdit
                  Tag = -1
                  Left = 133
                  Top = -1
                  Width = 121
                  Height = 23
                  Style.BorderStyle = ebsUltraFlat
                  Style.Edges = [bLeft, bRight]
                  TabOrder = 1
                end
                object D2: TcxDateEdit
                  Tag = -1
                  Left = 277
                  Top = -1
                  Width = 121
                  Height = 23
                  Style.BorderStyle = ebsUltraFlat
                  Style.Edges = [bLeft, bRight]
                  TabOrder = 2
                end
              end
              object btnFind: TRzBitBtn
                Left = 800
                Top = 8
                Width = 65
                Height = 28
                Anchors = [akTop, akRight]
                Caption = #26597#35810
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
                OnClick = btnFindClick
                NumGlyphs = 2
                Spacing = 5
              end
            end
          end
          object RzPanel14: TRzPanel
            Left = 0
            Top = 65
            Width = 904
            Height = 389
            Align = alClient
            BorderInner = fsFlat
            BorderOuter = fsNone
            BorderSides = [sdLeft, sdTop, sdRight]
            BorderColor = clWhite
            BorderWidth = 10
            Color = clWhite
            TabOrder = 1
            object zrComboBoxList1: TzrComboBoxList
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
              Style.BorderStyle = ebsFlat
              Style.Edges = [bBottom]
              Style.ButtonStyle = btsUltraFlat
              Style.ButtonTransparency = ebtHideInactive
              TabOrder = 0
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
            object cxComboBox1: TcxComboBox
              Left = 216
              Top = 112
              Width = 49
              Height = 23
              Properties.DropDownListStyle = lsFixedList
              Properties.OnChange = fndUNIT_IDPropertiesChange
              Style.BorderStyle = ebsFlat
              Style.Edges = [bBottom]
              Style.ButtonStyle = btsUltraFlat
              Style.ButtonTransparency = ebtHideInactive
              TabOrder = 1
              Visible = False
              OnEnter = fndUNIT_IDEnter
              OnExit = fndUNIT_IDExit
              OnKeyDown = fndUNIT_IDKeyDown
              OnKeyPress = fndUNIT_IDKeyPress
            end
            object DBGridEh2: TDBGridEh
              Left = 11
              Top = 11
              Width = 882
              Height = 368
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              AutoFitColWidths = True
              BorderStyle = bsNone
              Color = clWhite
              DataSource = dsList
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBlack
              FooterFont.Height = -15
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 1
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghHighlightFocus, dghClearSelection]
              ReadOnly = True
              RowHeight = 25
              SumList.Active = True
              TabOrder = 2
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = -15
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              TitleHeight = 20
              UseMultiTitle = True
              IsDrawNullRow = False
              CurrencySymbol = #65509
              DecimalNumber = 2
              DigitalNumber = 12
              OnDblClick = DBGridEh2DblClick
              OnDrawColumnCell = DBGridEh2DrawColumnCell
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 29
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 112
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'SALES_DATE'
                  Footers = <>
                  Title.Caption = #38144#21806#26085#26399
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #23458#25143#21517#31216
                  Width = 160
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'SALE_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #38144#21806#37329#39069
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'ACCT_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #32467#31639#37329#39069
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'RECV_MNY'
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #25910#27454#37329#39069
                  Width = 66
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23548#36141#21592
                  Width = 49
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #35828#26126
                  Width = 87
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Caption = #25805#20316
                  Width = 146
                end>
            end
            object rowToolNav: TRzToolbar
              Left = 594
              Top = 194
              Width = 153
              Align = alNone
              AutoStyle = False
              Margin = 0
              TopMargin = 0
              TextOptions = ttoCustom
              BorderInner = fsNone
              BorderOuter = fsNone
              BorderSides = [sdTop]
              BorderWidth = 0
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Visible = False
              ToolbarControls = (
                RzToolButton2
                RzToolButton3
                RzSpacer1
                RzToolButton1
                RzToolButton4)
              object RzToolButton1: TRzToolButton
                Left = 75
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #21024#38500
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
                OnClick = RzToolButton1Click
              end
              object RzToolButton2: TRzToolButton
                Left = 0
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #20462#25913
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
                OnClick = RzToolButton2Click
              end
              object RzToolButton3: TRzToolButton
                Left = 35
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #35814#32454
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
                OnClick = RzToolButton3Click
              end
              object RzSpacer1: TRzSpacer
                Left = 70
                Top = 0
                Width = 5
              end
              object RzToolButton4: TRzToolButton
                Left = 110
                Top = 0
                Width = 35
                Cursor = crHandPoint
                ShowCaption = True
                UseToolbarButtonSize = False
                UseToolbarShowCaption = False
                Caption = #36864#36135
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsBold, fsUnderline]
                ParentFont = False
              end
            end
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    inherited lblCaption: TRzLabel
      Caption = #21830#21697#38144#21806
    end
    inherited RzPanel12: TRzPanel
      Left = 384
      Width = 520
      DesignSize = (
        520
        47)
      inherited btnNav: TRzBitBtn
        Left = 432
        Width = 74
        Anchors = [akTop]
        Caption = #26597#35810#21333#25454
        OnClick = btnNavClick
      end
      inherited btnPrint: TRzBitBtn
        Left = 213
      end
      inherited btnPreview: TRzBitBtn
        Left = 280
      end
      inherited btnExport: TRzBitBtn
        Left = 340
      end
    end
  end
  inherited edtTable: TZQuery
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
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'APRICE'
        DataType = ftFloat
      end
      item
        Name = 'AMONEY'
        DataType = ftFloat
      end
      item
        Name = 'COST_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'ORG_PRICE'
        DataType = ftFloat
      end
      item
        Name = 'AGIO_RATE'
        DataType = ftFloat
      end
      item
        Name = 'AGIO_MONEY'
        DataType = ftFloat
      end
      item
        Name = 'POLICY_TYPE'
        DataType = ftInteger
      end
      item
        Name = 'BARTER_INTEGRAL'
        DataType = ftInteger
      end
      item
        Name = 'HAS_INTEGRAL'
        DataType = ftInteger
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'CALC_MONEY'
        DataType = ftFloat
      end
      item
        Name = 'REMARK'
        DataType = ftString
        Size = 100
      end>
    AfterPost = edtTableAfterPost
  end
  inherited edtProperty: TZQuery
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
      end
      item
        Name = 'CALC_AMOUNT'
        DataType = ftFloat
      end
      item
        Name = 'AMOUNT'
        DataType = ftFloat
      end>
  end
  object cdsHeader: TZQuery [6]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 192
  end
  object cdsDetail: TZQuery [7]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 224
  end
  object cdsICGlide: TZQuery [8]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 120
    Top = 264
  end
  object dsList: TDataSource [9]
    DataSet = cdsList
    Left = 104
    Top = 392
  end
  object cdsList: TZQuery [10]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 144
    Top = 392
  end
end
