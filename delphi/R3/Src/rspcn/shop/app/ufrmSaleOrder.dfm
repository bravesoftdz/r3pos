inherited frmSaleOrder: TfrmSaleOrder
  Left = 256
  Top = 154
  Caption = #21830#21697#38144#21806
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
              object RzLabel2: TRzLabel [2]
                Left = 11
                Top = 56
                Width = 106
                Height = 15
                Caption = #12304'F2'#12305#21830#21697#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzBorder1: TRzBorder [3]
                Left = 18
                Top = 45
                Width = 846
                Height = 2
                Anchors = [akLeft, akTop, akRight]
              end
              object RzLabel3: TRzLabel [4]
                Left = 11
                Top = 79
                Width = 106
                Height = 15
                Caption = #12304'F2'#12305#21830#21697#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object RzLabel4: TRzLabel [5]
                Left = 11
                Top = 102
                Width = 106
                Height = 15
                Caption = #12304'F2'#12305#21830#21697#36755#20837
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
            end
          end
          inherited order_header: TRzPanel
            Top = 149
            Height = 27
            object RzPanel5: TRzPanel
              Left = 10
              Top = 6
              Width = 99
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #23458#25143#21517#31216
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 1
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
              TabOrder = 2
            end
            object edtSALES_DATE: TcxDateEdit
              Left = 754
              Top = 5
              Width = 141
              Height = 23
              Anchors = [akTop, akRight]
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              TabOrder = 3
            end
          end
          inherited order_grid: TRzPanel
            Top = 176
            Height = 184
            inherited DBGridEh1: TDBGridEh
              Height = 164
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
            inherited fndGODS_ID: TzrComboBoxList
              OnFindClick = nil
              OnAddClick = nil
              OnSaveValue = nil
            end
            inherited fndUNIT_ID: TcxComboBox
              Properties.OnChange = nil
              OnEnter = nil
              OnExit = nil
              OnKeyDown = nil
              OnKeyPress = nil
            end
          end
          inherited order_footer: TRzPanel
            Top = 360
            Height = 114
            object RzPanel10: TRzPanel
              Left = 213
              Top = 32
              Width = 51
              Height = 21
              BorderOuter = fsFlatRounded
              Caption = #25240#25187
              Color = 16185078
              FlatColor = clMenuHighlight
              TabOrder = 7
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
              TabOrder = 2
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
              TabOrder = 0
              DesignSize = (
                904
                47)
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
                object RzBitBtn1: TRzBitBtn
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
                  NumGlyphs = 2
                  Spacing = 5
                end
                object RzBitBtn3: TRzBitBtn
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
                object RzBitBtn2: TRzBitBtn
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
                object RzBitBtn4: TRzBitBtn
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
                  NumGlyphs = 2
                  Spacing = 5
                end
              end
              object RzBitBtn6: TRzBitBtn
                Left = 23
                Top = 6
                Width = 76
                Height = 28
                Anchors = [akTop]
                Caption = #23548#20837'(&I)'
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
            end
            object edtREMARK: TcxTextEdit
              Left = 106
              Top = -1
              Width = 543
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
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
              TabOrder = 3
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
              TabOrder = 4
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
              TabOrder = 5
            end
            object cxTextEdit1: TcxTextEdit
              Left = 106
              Top = 31
              Width = 110
              Height = 23
              TabOrder = 6
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object cxTextEdit2: TcxTextEdit
              Left = 261
              Top = 31
              Width = 59
              Height = 23
              TabOrder = 8
              Text = '90.9%'
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object RzPanel11: TRzPanel
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
              TabOrder = 9
            end
            object cxTextEdit3: TcxTextEdit
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
              TabOrder = 10
              Text = '34866.55'
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clWhite
          Caption = #21382#21490#21333#25454
        end
      end
    end
  end
  inherited RzPanel1: TRzPanel
    inherited RzLabel1: TRzLabel
      Caption = #21830#21697#38144#21806
    end
    inherited RzPanel12: TRzPanel
      DesignSize = (
        352
        47)
      inherited RzBitBtn5: TRzBitBtn
        Left = 221
        Anchors = [akTop]
      end
    end
  end
end
