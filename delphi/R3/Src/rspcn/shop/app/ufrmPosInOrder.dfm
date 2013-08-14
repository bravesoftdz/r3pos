inherited frmPosInOrder: TfrmPosInOrder
  Left = 60
  Top = 97
  Caption = #21830#21697#20837#24211
  ClientHeight = 593
  ClientWidth = 1100
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 900
    Height = 546
    inherited webForm: TRzPanel
      Width = 900
      Height = 546
      inherited PageControl: TRzPageControl
        Width = 900
        Height = 546
        FixedDimension = 0
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#24405#20837
          inherited order_input: TRzPanel
            Width = 900
            Height = 149
            inherited RzPanel2: TRzPanel
              Width = 878
              Height = 127
              DesignSize = (
                878
                127)
              inherited RzBorder1: TRzBorder
                Width = 840
              end
              inherited lblHint: TRzLabel
                Left = 337
                ShadowColor = 16185078
              end
              inherited help: TRzBmpButton
                Left = 846
              end
              inherited barcode: TRzPanel
                inherited edtInput: TcxTextEdit
                  Tag = -1
                end
              end
              inherited helpPanel: TRzPanel
                Left = 447
                Width = 417
                inherited lblModifyUnit: TRzLabel
                  Left = 31
                  Top = 2
                  ShadowColor = 15921906
                end
                inherited lblModifyAmt: TRzLabel
                  Left = 199
                  Top = 55
                  Visible = False
                  ShadowColor = 15921906
                end
                inherited lblModifyPrice: TRzLabel
                  Left = 31
                  Top = 23
                  ShadowColor = 15921906
                end
                object RzLabel1: TRzLabel
                  Tag = 5
                  Left = 173
                  Top = 2
                  Width = 90
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #21830#21697'/'#36192#21697' [F5] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel2: TRzLabel
                  Tag = 6
                  Left = 31
                  Top = 43
                  Width = 83
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20379' '#24212' '#21830'  [F6] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel3: TRzLabel
                  Tag = 7
                  Left = 165
                  Top = 60
                  Width = 83
                  Height = 20
                  Caption = #25910' '#36135' '#21592'  [F7] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  Visible = False
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel12: TRzLabel
                  Tag = 10
                  Left = 173
                  Top = 44
                  Width = 70
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #21462#21333'  [F10] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel4: TRzLabel
                  Tag = 9
                  Left = 173
                  Top = 23
                  Width = 62
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #25346#21333'  [F9] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel5: TRzLabel
                  Tag = 8
                  Left = 289
                  Top = 58
                  Width = 62
                  Height = 20
                  Caption = #28165#23631'  [F8] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  Visible = False
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel13: TRzLabel
                  Tag = 11
                  Left = 319
                  Top = 2
                  Width = 96
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #25972#21333#35843#20215'  [F11] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel14: TRzLabel
                  Tag = 12
                  Left = 319
                  Top = 23
                  Width = 95
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20184#27454#26041#24335'  [ *   ] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 6570814
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel15: TRzLabel
                  Tag = 13
                  Left = 318
                  Top = 44
                  Width = 95
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20445#23384#21333#25454'  [ +  ] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 6572100
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15921906
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object RzPanel19: TRzPanel
                Left = 16
                Top = 59
                Width = 442
                Height = 56
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                BorderColor = clGray
                Caption = #23454#25910#65306'1000 '#25214#38646#65306'90'
                Color = 14606046
                Font.Charset = GB2312_CHARSET
                Font.Color = clRed
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                DesignSize = (
                  442
                  56)
                object Image5: TImage
                  Left = 5
                  Top = 0
                  Width = 432
                  Height = 56
                  Align = alClient
                  AutoSize = True
                  Picture.Data = {
                    07544269746D617016020000424D160200000000000036000000280000000200
                    00003C0000000100180000000000E0010000120B0000120B0000000000000000
                    0000FFFFFFFFFFFF0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC0000ECECECECECEC
                    0000ECECECECECEC0000ECECECECECEC0000CDCDCDCDCDCD0000929292929292
                    0000}
                  Stretch = True
                end
                object MarqueeStatus: TRzMarqueeStatus
                  Left = 5
                  Top = 2
                  Width = 431
                  Height = 52
                  FrameStyle = fsNone
                  Anchors = [akLeft, akTop, akRight]
                  Color = 15461355
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clMaroon
                  Font.Height = -24
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentColor = False
                  ParentFont = False
                  Caption = #24744#29616#22312#21487#20197#25195#30721#20837#24211#20102
                  ScrollType = stNone
                end
                object Image6: TImage
                  Left = 0
                  Top = 0
                  Width = 5
                  Height = 56
                  Align = alLeft
                  AutoSize = True
                  Picture.Data = {
                    07544269746D6170F6030000424DF60300000000000036000000280000000500
                    00003C0000000100180000000000C0030000120B0000120B0000000000000000
                    0000DEDEDEDEDEDEDEDEDEE6E6E6F5F5F500DEDEDEDEDEDEDDDDDDDDDDDDE4E4
                    E400DEDEDEC5C5C5CFCFCFE7E7E7ECECEC00C9C9C9BBBBBBE2E2E2ECECECECEC
                    EC00A2A2A2C9C9C9E9E9E9ECECECECECEC00969696CDCDCDEBEBEBECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00929292CDCDCDECECECECECECECEC
                    EC00929292CDCDCDECECECECECECECECEC00919191CDCDCDEBEBEBECECECECEC
                    EC008F8F8FC9C9C9E9E9E9ECECECECECEC008D8D8DBABABAE2E2E2ECECECECEC
                    EC00949494A0A0A0CFCFCFE7E7E7ECECEC00C4C4C4878787ABABABCECECEE1E1
                    E100DEDEDEAEAEAE8686869F9F9FB7B7B700DEDEDEDEDEDEC4C4C49B9B9B8F8F
                    8F00}
                  Stretch = True
                end
                object Image7: TImage
                  Left = 437
                  Top = 0
                  Width = 5
                  Height = 56
                  Align = alRight
                  AutoSize = True
                  Picture.Data = {
                    07544269746D6170F6030000424DF60300000000000036000000280000000500
                    00003C0000000100180000000000C0030000120B0000120B0000000000000000
                    0000FCFCFCF5F5F5E6E6E6DEDEDEDEDEDE00EFEFEFF8F8F8FFFFFFEEEEEEDEDE
                    DE00ECECECECECECF4F4F4FFFFFFE6E6E600ECECECECECECECECECF8F8F8F7F7
                    F700ECECECECECECECECECEEEEEEFDFDFD00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECECECECFFFF
                    FF00ECECECECECECECECECECECECFFFFFF00ECECECECECECECECECEBEBEBFFFF
                    FF00ECECECECECECECECECE9E9E9FDFDFD00ECECECECECECECECECE4E4E4F7F7
                    F700ECECECECECECE7E7E7DADADAE6E6E600E8E8E8E1E1E1CFCFCFDEDEDEDEDE
                    DE00C6C6C6B7B7B7C5C5C5DEDEDEDEDEDE00A6A6A6C8C8C8DEDEDEDEDEDEDEDE
                    DE00}
                  Stretch = True
                end
              end
            end
          end
          inherited order_header: TRzPanel
            Top = 149
            Width = 900
            Height = 31
            object customerInfo: TLabel
              Left = 324
              Top = 10
              Width = 337
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
            object edtBK_CLIENT_ID: TRzPanel
              Left = 10
              Top = 0
              Width = 499
              Height = 31
              Anchors = [akLeft, akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 0
              object RzPanel21: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel6: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #20379' '#24212' '#21830
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtCLIENT_ID: TzrComboBoxList
                Left = 104
                Top = 4
                Width = 213
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Style.HotTrack = False
                Style.ButtonTransparency = ebtInactive
                TabOrder = 1
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
                OnAddClick = edtCLIENT_IDAddClick
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbNew]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object edtBK_SALES_DATE: TRzPanel
              Left = 642
              Top = 0
              Width = 248
              Height = 31
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              DesignSize = (
                248
                31)
              object RzPanel20: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel7: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #36827#36135#26085#26399
                  Transparent = True
                  Layout = tlCenter
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtSTOCK_DATE: TcxDateEdit
                Left = 104
                Top = 4
                Width = 142
                Height = 23
                Anchors = [akTop, akRight]
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Style.HotTrack = False
                Style.ButtonTransparency = ebtInactive
                TabOrder = 1
              end
            end
          end
          inherited order_grid: TRzPanel
            Top = 180
            Width = 519
            Height = 269
            inherited DBGridEh1: TDBGridEh
              Width = 497
              Height = 247
              FixedColor = 16448239
              FooterColor = 8643839
              FrozenCols = 1
              OnCellClick = DBGridEh1CellClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #24207#21495
                  Title.Color = 15787416
                  Width = 37
                end
                item
                  EditButtons = <>
                  FieldName = 'GODS_NAME'
                  Footer.Alignment = taCenter
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #21830#21697#21517#31216
                  Title.Color = 15787416
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
                  Title.Alignment = taCenter
                  Title.Caption = #36135#21495
                  Title.Color = 15787416
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #26465#30721
                  Title.Color = 15787416
                  Width = 104
                end
                item
                  EditButtons = <>
                  FieldName = 'UNIT_ID'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #21333#20301
                  Title.Color = 15787416
                  Width = 35
                  Control = fndUNIT_ID
                  OnBeforeShowControl = DBGridEh1Columns4BeforeShowControl
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
                  Title.Alignment = taCenter
                  Title.Caption = #25968#37327
                  Title.Color = 15787416
                  Width = 49
                  OnUpdateData = DBGridEh1Columns5UpdateData
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'APRICE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #21333#20215
                  Title.Color = 15787416
                  Width = 60
                  OnUpdateData = DBGridEh1Columns6UpdateData
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #37329#39069
                  Title.Color = 15787416
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Caption = #25805#20316
                  Width = 55
                end>
            end
            inherited fndGODS_ID: TzrComboBoxList
              Left = 312
              Top = 107
              Style.BorderStyle = ebsFlat
              Style.Edges = []
              Style.ButtonStyle = btsUltraFlat
            end
            inherited fndUNIT_ID: TcxComboBox
              Left = 248
              Top = 104
              Style.BorderStyle = ebsFlat
              Style.ButtonStyle = btsUltraFlat
            end
          end
          inherited order_footer: TRzPanel
            Top = 449
            Width = 900
            Height = 97
            object edtBK_ACCT_MNY: TRzPanel
              Left = 20
              Top = 19
              Width = 318
              Height = 57
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 0
              object RzLabel9: TRzLabel
                Left = 307
                Top = 2
                Width = 9
                Height = 53
                Align = alRight
                Alignment = taCenter
                Caption = '%'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ShadowColor = 16250871
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzPanel7: TRzPanel
                Left = 2
                Top = 2
                Width = 75
                Height = 53
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel10: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 74
                  Height = 53
                  Align = alClient
                  Alignment = taCenter
                  Caption = #24212#25910#37329#39069
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtACCT_MNY: TcxTextEdit
                Left = 76
                Top = 1
                Width = 148
                Height = 56
                ParentFont = False
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clBlack
                Style.Font.Height = -48
                Style.Font.Name = #23435#20307
                Style.Font.Style = []
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtACCT_MNYKeyPress
              end
              object edtAGIO_RATE: TcxTextEdit
                Left = 259
                Top = 17
                Width = 47
                Height = 23
                Properties.Alignment.Horz = taRightJustify
                TabOrder = 2
                Text = '100.0'
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnExit = edtAGIO_RATEExit
                OnKeyPress = edtAGIO_RATEKeyPress
              end
              object RzPanel8: TRzPanel
                Left = 223
                Top = 2
                Width = 37
                Height = 54
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdRight]
                TabOrder = 3
                object RzLabel11: TRzLabel
                  Left = 2
                  Top = 0
                  Width = 33
                  Height = 54
                  Align = alClient
                  Alignment = taCenter
                  Caption = #25240#25187
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
            end
            object btnSave: TRzBmpButton
              Left = 528
              Top = 19
              Width = 119
              Height = 58
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                C6510000424DC6510000000000003600000028000000770000003A0000000100
                1800000000009051000000000000000000000000000000000000DEDEDED8D8D8
                BEBEBE9797977575755E5E5E5656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565671717100
                0000DADADABDBDBD879BA174ACBC72C4DC72CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000CECECE91BBC774C6DE72CCE674CDE673CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000BDCDD297D4E57BCFE873CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000BFD9E19BD7E9
                78CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C3DDE49AD7E978CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C6DFE69CD9EA78CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000CEE3E9ABDEED
                7ACFE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C3DDE49AD7E978CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000C4DDE49AD7E977CEE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E977CEE772CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C4DDE49AD7E9
                77CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE656565600
                0000C6DFE69CD9EA78CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE6565656000000CEE3E9ABDEED7ACFE772CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE6565656000000D8E2E5C4E7F193D8EC76CEE772CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000DEDEDED4E6EB
                BCE5F1A3DEEF89D4EA78CEE772CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE671717100
                0000DEDEDEDEDEDED6E0E3C3E1E9AEDFEDA2DDEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE72CCE6B6B6B6000000}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #20445#23384#24182#26032#22686
              TabOrder = 1
              OnClick = btnSaveClick
            end
            object btnHangup: TRzBmpButton
              Left = 647
              Top = 18
              Width = 81
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                CE1C0000424DCE1C0000000000003600000028000000510000001E0000000100
                180000000000981C000000000000000000000000000000000000BCBCBCC4C4C4
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C4C4C4C8C8C8D0D0D0D7D7
                D7DCDCDCDEDEDEDEDEDEDEDEDE007B7B7B8E8E8E8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8D8D8D979797A6A6A6BABABACDCDCDDADADADEDEDEDEDE
                DE00D9D9D9DBDBDBDADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADBDBDBDBDBDBD4D4D4C2C2C2
                9F9F9F888888919191ABABABC9C9C9DADADADCDCDC00DBDBDBDADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADCDCDCDEDEDEC8C8C89595958A8A8A
                B0B0B0CDCDCDD5D5D500DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADEDEDEC6C6C68D8D8D969696BFBFBFCBCBCB00DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADB
                DBDBDCDCDCBBBBBB888888B9B9B9C4C4C400DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADAE1E1E1CDCDCD838383B8
                B8B8C2C2C200DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2
                E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1
                C100DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2
                828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD9
                D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8
                B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2
                E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1
                C100DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2
                828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD9
                D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8
                B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2848484B9B9B9C3C3C300DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E1E1
                E1D1D1D18A8A8AC0C0C0C6C6C600DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADFDFDFC6C6C69C9C9CCDCDCDD0D0
                D000DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADCDCDCD8D8D8B7B7B7B6B6B6DBDBDBDADADA00DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADBDBDBDEDEDEBEBEBEBEBEBE
                D8D8D8DDDDDDDDDDDD00E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E1E1E1D9D9D9C7C7C7D0D0D0D8D8D8DEDEDEDEDEDEDEDEDE00DDDD
                DDDCDCDCDBDBDBDADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADDDDDDD7D7D7D2D2D2DE
                DEDEDCDCDCDEDEDEDEDEDEDEDEDEDEDEDE00}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #25346#21333
              TabOrder = 2
              OnClick = btnHangupClick
            end
            object btnPickUp: TRzBmpButton
              Left = 647
              Top = 48
              Width = 81
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                CE1C0000424DCE1C0000000000003600000028000000510000001E0000000100
                180000000000981C000000000000000000000000000000000000BCBCBCC4C4C4
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C4C4C4C8C8C8D0D0D0D7D7
                D7DCDCDCDEDEDEDEDEDEDEDEDE007B7B7B8E8E8E8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8D8D8D979797A6A6A6BABABACDCDCDDADADADEDEDEDEDE
                DE00D9D9D9DBDBDBDADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADBDBDBDBDBDBD4D4D4C2C2C2
                9F9F9F888888919191ABABABC9C9C9DADADADCDCDC00DBDBDBDADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADCDCDCDEDEDEC8C8C89595958A8A8A
                B0B0B0CDCDCDD5D5D500DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADEDEDEC6C6C68D8D8D969696BFBFBFCBCBCB00DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADB
                DBDBDCDCDCBBBBBB888888B9B9B9C4C4C400DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADAE1E1E1CDCDCD838383B8
                B8B8C2C2C200DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2
                E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1
                C100DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2
                828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD9
                D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8
                B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2
                E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1
                C100DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2
                828282B8B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADAD9
                D9D9E2E2E2D2D2D2828282B8B8B8C1C1C100DADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADAD9D9D9E2E2E2D2D2D2828282B8
                B8B8C1C1C100DADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADAD9D9D9E2E2E2D2D2D2848484B9B9B9C3C3C300DADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD9D9D9E1E1
                E1D1D1D18A8A8AC0C0C0C6C6C600DADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADFDFDFC6C6C69C9C9CCDCDCDD0D0
                D000DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADCDCDCD8D8D8B7B7B7B6B6B6DBDBDBDADADA00DADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADBDBDBDEDEDEBEBEBEBEBEBE
                D8D8D8DDDDDDDDDDDD00E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E1E1E1D9D9D9C7C7C7D0D0D0D8D8D8DEDEDEDEDEDEDEDEDE00DDDD
                DDDCDCDCDBDBDBDADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADDDDDDD7D7D7D2D2D2DE
                DEDEDCDCDCDEDEDEDEDEDEDEDEDEDEDEDE00}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #21462#21333
              TabOrder = 3
              OnClick = btnPickUpClick
            end
            object RzBmpButton6: TRzBmpButton
              Left = 767
              Top = 48
              Width = 72
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                86190000424D86190000000000003600000028000000480000001E0000000100
                1800000000005019000000000000000000000000000000000000DEDEDEDEDEDE
                DDDDDDDADADAD1D1D1C8C8C8C3C3C3C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C2C2C2
                C5C5C5CCCCCCD5D5D5DCDCDCDEDEDEDEDEDEDEDEDEDDDDDDD5D5D5C2C2C2A9A9
                A99696968C8C8C8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A9090909E9E9EB5B5
                B5CDCDCDDBDBDBDEDEDEDEDEDED6D6D6BCBCBCB8B8B8C8C8C8DADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADAD0D0D0BABABA8F8F8F898989AAAAAACDCDCDDC
                DCDCDCDCDCCACACAD0D0D0DADADADADADADBDBDBDADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADAA2A2A2898989B4B4B4D5D5D5D7D7D7DBDBDB
                DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADAD9D9D98E8E8E9C9C9CCBCBCBD8D8D8E7E7E7DBDBDBDADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DAC0C0C08E8E8EC4C4C4DEDEDEE7E7E7DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D58A8A8AC2
                C2C2DFDFDFE7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8B8B8BC3C3C3E1E1E1E8E8E8
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADAD9D9D9939393C6C6C6E2E2E2ECECECDBDBDBDADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DACECECEA7A7A7D0D0D0DFDFDFEFEFEFE3E3E3DADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADABABABAC1C1C1DA
                DADADEDEDEE4E4E4EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADAD2D2D2BEBEBED6D6D6DDDDDDDEDEDEDEDEDE
                E3E3E3EBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
                DEDEDED1D1D1CBCBCBD7D7D7DDDDDDDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDFDF
                DFDCDCDCDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDADADAD6D6D6D9D9D9DCDC
                DCDEDEDEDEDEDEDEDEDE}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #23548#20837
              TabOrder = 4
              OnClick = RzBmpButton6Click
            end
            object btnNew: TRzBmpButton
              Left = 767
              Top = 18
              Width = 72
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                86190000424D86190000000000003600000028000000480000001E0000000100
                1800000000005019000000000000000000000000000000000000DEDEDEDEDEDE
                DDDDDDDADADAD1D1D1C8C8C8C3C3C3C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1
                C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C1C2C2C2
                C5C5C5CCCCCCD5D5D5DCDCDCDEDEDEDEDEDEDEDEDEDDDDDDD5D5D5C2C2C2A9A9
                A99696968C8C8C8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
                8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A9090909E9E9EB5B5
                B5CDCDCDDBDBDBDEDEDEDEDEDED6D6D6BCBCBCB8B8B8C8C8C8DADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADAD0D0D0BABABA8F8F8F898989AAAAAACDCDCDDC
                DCDCDCDCDCCACACAD0D0D0DADADADADADADBDBDBDADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADAA2A2A2898989B4B4B4D5D5D5D7D7D7DBDBDB
                DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADAD9D9D98E8E8E9C9C9CCBCBCBD8D8D8E7E7E7DBDBDBDADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DAC0C0C08E8E8EC4C4C4DEDEDEE7E7E7DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D58A8A8AC2
                C2C2DFDFDFE7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADA8A8A8AC1C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADA8A8A8AC1
                C1C1DFDFDFE6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADA8B8B8BC3C3C3E1E1E1E8E8E8
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADAD9D9D9939393C6C6C6E2E2E2ECECECDBDBDBDADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DACECECEA7A7A7D0D0D0DFDFDFEFEFEFE3E3E3DADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADABABABAC1C1C1DA
                DADADEDEDEE4E4E4EEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADAD2D2D2BEBEBED6D6D6DDDDDDDEDEDEDEDEDE
                E3E3E3EBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
                DEDEDED1D1D1CBCBCBD7D7D7DDDDDDDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDFDF
                DFDCDCDCDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDADADAD6D6D6D9D9D9DCDC
                DCDEDEDEDEDEDEDEDEDE}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #28165#31354
              TabOrder = 5
              OnClick = btnNewClick
            end
          end
          object RzPanel4: TRzPanel
            Left = 519
            Top = 180
            Width = 381
            Height = 269
            Align = alRight
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderColor = 15461355
            BorderWidth = 10
            Color = clWhite
            FlatColor = 15461355
            TabOrder = 4
            UseDockManager = False
            object RzPanel16: TRzPanel
              Left = 11
              Top = 11
              Width = 359
              Height = 247
              Align = alClient
              BorderOuter = fsNone
              BorderColor = 16316664
              BorderWidth = 5
              Color = 15461355
              TabOrder = 0
              object GodsRzPageControl: TRzPageControl
                Left = 5
                Top = 5
                Width = 349
                Height = 21
                ActivePage = GodsGrid_1
                Align = alTop
                BackgroundColor = 16316664
                Color = 14606046
                FlatColor = clGray
                ParentBackgroundColor = False
                ParentColor = False
                TabColors.HighlightBar = 15461355
                TabColors.Shadow = 15461355
                TabIndex = 0
                TabOrder = 0
                OnChange = GodsRzPageControlChange
                FixedDimension = 21
                object GodsGrid_1: TRzTabSheet
                  Color = 14606046
                  Caption = #21367#28895
                end
                object GodsGrid_2: TRzTabSheet
                  Color = 14606046
                  Caption = #29983#40092
                end
                object GodsGrid_3: TRzTabSheet
                  Color = 14606046
                  Caption = #20854#20182
                end
              end
              object GodsStringGrid: TAdvStringGrid
                Left = 5
                Top = 26
                Width = 349
                Height = 216
                Cursor = crDefault
                Align = alClient
                Color = 15724527
                ColCount = 4
                Ctl3D = True
                DefaultRowHeight = 21
                DefaultDrawing = False
                FixedCols = 0
                RowCount = 8
                FixedRows = 0
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                GridLineWidth = 1
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
                ParentCtl3D = False
                ParentFont = False
                PopupMenu = DelGodsShortCust
                ScrollBars = ssNone
                TabOrder = 1
                GridLineColor = clSilver
                ActiveCellShow = False
                ActiveCellFont.Charset = DEFAULT_CHARSET
                ActiveCellFont.Color = clWindowText
                ActiveCellFont.Height = -11
                ActiveCellFont.Name = 'MS Sans Serif'
                ActiveCellFont.Style = [fsBold]
                ActiveCellColor = clGray
                Bands.PrimaryColor = clInfoBk
                Bands.PrimaryLength = 1
                Bands.SecondaryColor = clWindow
                Bands.SecondaryLength = 1
                Bands.Print = False
                AutoNumAlign = False
                AutoSize = False
                VAlignment = vtaTop
                EnhTextSize = False
                EnhRowColMove = False
                SizeWithForm = False
                Multilinecells = True
                OnGetCellBorder = GodsStringGridGetCellBorder
                OnGetAlignment = GodsStringGridGetAlignment
                OnClickCell = GodsStringGridClickCell
                OnDblClickCell = GodsStringGridDblClickCell
                DragDropSettings.OleAcceptFiles = True
                DragDropSettings.OleAcceptText = True
                SortSettings.AutoColumnMerge = False
                SortSettings.Column = 0
                SortSettings.Show = False
                SortSettings.IndexShow = False
                SortSettings.IndexColor = clYellow
                SortSettings.Full = True
                SortSettings.SingleColumn = False
                SortSettings.IgnoreBlanks = False
                SortSettings.BlankPos = blFirst
                SortSettings.AutoFormat = True
                SortSettings.Direction = sdAscending
                SortSettings.FixedCols = False
                SortSettings.NormalCellsOnly = False
                SortSettings.Row = 0
                FloatingFooter.Color = clBtnFace
                FloatingFooter.Column = 0
                FloatingFooter.FooterStyle = fsFixedLastRow
                FloatingFooter.Visible = False
                ControlLook.Color = clBlack
                ControlLook.CheckSize = 15
                ControlLook.RadioSize = 10
                ControlLook.ControlStyle = csClassic
                ControlLook.FlatButton = False
                EnableBlink = False
                EnableHTML = True
                EnableWheel = True
                Flat = False
                HintColor = clInfoBk
                SelectionColor = clWindow
                SelectionTextColor = clHighlightText
                SelectionRectangle = False
                SelectionResizer = False
                SelectionRTFKeep = False
                HintShowCells = False
                HintShowLargeText = False
                HintShowSizing = False
                PrintSettings.FooterSize = 0
                PrintSettings.HeaderSize = 0
                PrintSettings.Time = ppNone
                PrintSettings.Date = ppNone
                PrintSettings.DateFormat = 'dd/mm/yyyy'
                PrintSettings.PageNr = ppNone
                PrintSettings.Title = ppNone
                PrintSettings.Font.Charset = DEFAULT_CHARSET
                PrintSettings.Font.Color = clWindowText
                PrintSettings.Font.Height = -11
                PrintSettings.Font.Name = 'MS Sans Serif'
                PrintSettings.Font.Style = []
                PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
                PrintSettings.HeaderFont.Color = clWindowText
                PrintSettings.HeaderFont.Height = -11
                PrintSettings.HeaderFont.Name = 'MS Sans Serif'
                PrintSettings.HeaderFont.Style = []
                PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
                PrintSettings.FooterFont.Color = clWindowText
                PrintSettings.FooterFont.Height = -11
                PrintSettings.FooterFont.Name = 'MS Sans Serif'
                PrintSettings.FooterFont.Style = []
                PrintSettings.Borders = pbNoborder
                PrintSettings.BorderStyle = psSolid
                PrintSettings.Centered = False
                PrintSettings.RepeatFixedRows = False
                PrintSettings.RepeatFixedCols = False
                PrintSettings.LeftSize = 0
                PrintSettings.RightSize = 0
                PrintSettings.ColumnSpacing = 0
                PrintSettings.RowSpacing = 0
                PrintSettings.TitleSpacing = 0
                PrintSettings.Orientation = poPortrait
                PrintSettings.PageNumberOffset = 0
                PrintSettings.MaxPagesOffset = 0
                PrintSettings.FixedWidth = 0
                PrintSettings.FixedHeight = 0
                PrintSettings.UseFixedHeight = False
                PrintSettings.UseFixedWidth = False
                PrintSettings.FitToPage = fpNever
                PrintSettings.PageNumSep = '/'
                PrintSettings.NoAutoSize = False
                PrintSettings.NoAutoSizeRow = False
                PrintSettings.PrintGraphics = False
                HTMLSettings.Width = 100
                HTMLSettings.XHTML = False
                Navigation.AdvanceDirection = adLeftRight
                Navigation.InsertPosition = pInsertBefore
                Navigation.HomeEndKey = heFirstLastColumn
                Navigation.TabToNextAtEnd = False
                Navigation.TabAdvanceDirection = adLeftRight
                ColumnSize.Location = clRegistry
                CellNode.Color = clSilver
                CellNode.NodeColor = clBlack
                CellNode.ShowTree = False
                MaxEditLength = 0
                IntelliPan = ipVertical
                URLColor = clBlue
                URLShow = False
                URLFull = False
                URLEdit = False
                ScrollType = ssNormal
                ScrollColor = clNone
                ScrollWidth = 17
                ScrollSynch = False
                ScrollProportional = False
                ScrollHints = shNone
                OemConvert = False
                FixedFooters = 0
                FixedRightCols = 0
                FixedColWidth = 20
                FixedRowHeight = 21
                FixedFont.Charset = DEFAULT_CHARSET
                FixedFont.Color = clWindowText
                FixedFont.Height = -11
                FixedFont.Name = 'Tahoma'
                FixedFont.Style = []
                FixedAsButtons = False
                FloatFormat = '%.2f'
                IntegralHeight = False
                WordWrap = True
                Lookup = False
                LookupCaseSensitive = False
                LookupHistory = False
                ShowSelection = False
                BackGround.Top = 0
                BackGround.Left = 0
                BackGround.Display = bdTile
                BackGround.Cells = bcNormal
                Filter = <>
                ColWidths = (
                  20
                  20
                  20
                  20)
              end
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = clWhite
          TabVisible = False
          Caption = #21382#21490#21333#25454
          object RzPanel11: TRzPanel
            Left = 0
            Top = 0
            Width = 900
            Height = 60
            Align = alTop
            BorderOuter = fsNone
            BorderColor = 15461355
            Color = clWhite
            TabOrder = 0
            object RzPanel3: TRzPanel
              Left = 0
              Top = 0
              Width = 900
              Height = 60
              Align = alClient
              BorderOuter = fsNone
              BorderColor = 15461355
              BorderShadow = 15461355
              Color = 15461355
              FlatColor = clGray
              GridColor = clBackground
              TabOrder = 0
              DesignSize = (
                900
                60)
              object RzPanel6: TRzPanel
                Left = 411
                Top = 19
                Width = 387
                Height = 31
                Anchors = [akTop, akRight]
                BorderOuter = fsStatus
                BorderWidth = 1
                Color = clWhite
                FlatColor = 9145227
                TabOrder = 0
                object RzPanel9: TRzPanel
                  Left = 2
                  Top = 2
                  Width = 63
                  Height = 27
                  Align = alLeft
                  BorderOuter = fsFlat
                  BorderSides = [sdRight]
                  FlatColor = clGray
                  TabOrder = 0
                  object RzLabel17: TRzLabel
                    Left = 0
                    Top = 0
                    Width = 31
                    Height = 16
                    Align = alClient
                    Alignment = taCenter
                    Caption = #26085#26399
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clBlack
                    Font.Height = -15
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                    Transparent = True
                    Layout = tlCenter
                    ShadowColor = 16250871
                    ShadowDepth = 1
                    TextStyle = tsShadow
                  end
                end
                object dateFlag: TcxComboBox
                  Tag = -1
                  Left = 64
                  Top = 4
                  Width = 55
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
                  Style.Edges = []
                  Style.HotTrack = False
                  Style.ButtonTransparency = ebtInactive
                  TabOrder = 1
                end
                object D1: TcxDateEdit
                  Tag = -1
                  Left = 121
                  Top = 4
                  Width = 120
                  Height = 23
                  Style.BorderStyle = ebsUltraFlat
                  Style.Edges = []
                  Style.HotTrack = False
                  Style.ButtonTransparency = ebtInactive
                  TabOrder = 2
                end
                object RzPanel23: TRzPanel
                  Left = 119
                  Top = 1
                  Width = 3
                  Height = 28
                  BorderOuter = fsGroove
                  BorderSides = [sdLeft, sdRight]
                  TabOrder = 3
                end
                object RzPanel22: TRzPanel
                  Left = 241
                  Top = 2
                  Width = 26
                  Height = 27
                  BorderOuter = fsGroove
                  BorderSides = [sdLeft, sdRight]
                  TabOrder = 4
                  object RzLabel16: TRzLabel
                    Left = 2
                    Top = 0
                    Width = 16
                    Height = 16
                    Align = alClient
                    Alignment = taCenter
                    Caption = #33267
                    Font.Charset = GB2312_CHARSET
                    Font.Color = clBlack
                    Font.Height = -15
                    Font.Name = #23435#20307
                    Font.Style = []
                    ParentFont = False
                    Transparent = True
                    Layout = tlCenter
                    ShadowColor = 16250871
                    ShadowDepth = 1
                    TextStyle = tsShadow
                  end
                end
                object D2: TcxDateEdit
                  Tag = -1
                  Left = 266
                  Top = 5
                  Width = 119
                  Height = 23
                  Style.BorderStyle = ebsUltraFlat
                  Style.Edges = []
                  Style.HotTrack = False
                  Style.ButtonTransparency = ebtInactive
                  TabOrder = 5
                end
              end
              object RzPanel5: TRzPanel
                Left = 11
                Top = 20
                Width = 381
                Height = 29
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                TabOrder = 1
                DesignSize = (
                  381
                  29)
                object Image1: TImage
                  Left = 0
                  Top = 0
                  Width = 6
                  Height = 29
                  Align = alLeft
                  AutoSize = True
                  Picture.Data = {
                    07544269746D61707A020000424D7A0200000000000036000000280000000600
                    00001D000000010018000000000044020000C30E0000C30E0000000000000000
                    0000EBEBEBEBEBEBEBEBEBE6E6E6F5F5F5FCFCFC0000EBEBEBEBEBEBE1E1E1E9
                    E9E9F4F4F4FBFBFB0000EBEBEBCBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
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
                    FAFAFFFFFFFFFFFF0000EBEBEB929292B9B9B9DFDFDFF3F3F3FBFBFB0000EBEB
                    EBEBEBEB919191ACACACC6C6C6D6D6D60000EBEBEBEBEBEBEBEBEBA2A2A29999
                    999999990000}
                end
                object Image3: TImage
                  Left = 376
                  Top = 0
                  Width = 5
                  Height = 29
                  Align = alRight
                  AutoSize = True
                  Picture.Data = {
                    07544269746D617006020000424D060200000000000036000000280000000500
                    00001D0000000100180000000000D0010000120B0000120B0000000000000000
                    0000FCFCFCF5F5F5EBEBEBEBEBEBEBEBEB00FCFCFCFCFCFCFFFFFFEBEBEBEBEB
                    EB00FFFFFFFFFFFFFDFDFDFFFFFFEBEBEB00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
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
                    E600FBFBFBF3F3F3DFDFDFE2E2E2EBEBEB00D6D6D6C6C6C6CBCBCBEBEBEBEBEB
                    EB00AEAEAECBCBCBEBEBEBEBEBEBEBEBEB00}
                end
                object Image4: TImage
                  Left = 6
                  Top = 0
                  Width = 370
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
                object serachText: TEdit
                  Tag = -1
                  Left = 6
                  Top = 6
                  Width = 370
                  Height = 18
                  Hint = #35831#36755#20837#21333#21495#25110#23458#25143#21517#31216#25110#22791#27880#35828#26126
                  Anchors = [akLeft, akTop, akRight]
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  BorderStyle = bsNone
                  TabOrder = 0
                  Text = #35831#36755#20837#21333#21495#25110#23458#25143#21517#31216#25110#22791#27880#35828#26126
                  OnChange = serachTextChange
                  OnEnter = serachTextEnter
                  OnExit = serachTextExit
                  OnKeyPress = serachTextKeyPress
                end
              end
              object btnFind: TRzBmpButton
                Left = 818
                Top = 19
                Width = 72
                Bitmaps.TransparentColor = clFuchsia
                Bitmaps.Up.Data = {
                  86190000424D86190000000000003600000028000000480000001E0000000100
                  1800000000005019000000000000000000000000000000000000EBEBEBEBEBEB
                  EAEAEAE6E6E6DDDDDDD4D4D4CECECECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                  CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                  CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                  CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                  CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                  CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCECECE
                  D0D0D0D8D8D8E2E2E2E9E9E9EBEBEBEBEBEBEBEBEBEAEAEAE2E2E2CECECEB3B3
                  B39F9F9F94949492929292929292929292929292929292929292929292929292
                  9292929292929292929292929292929292929292929292929292929292929292
                  9292929292929292929292929292929292929292929292929292929292929292
                  9292929292929292929292929292929292929292929292929292929292929292
                  9292929292929292929292929292929292929292929292929292929292929292
                  929292929292929292929292929292929292929292939393989898A7A7A7C0C0
                  C0D9D9D9E7E7E7EBEBEBEBEBEBE3E3E3C7C7C7BCBCBCC9C9C9DADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADAD0D0D0BCBCBC959595919191B4B4B4D9D9D9E9
                  E9E9E9E9E9D4D4D4D2D2D2DADADADADADADBDBDBDADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADAA6A6A6919191BFBFBFE2E2E2E4E4E4DDDDDD
                  DCDCDCDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADAD9D9D9939393A5A5A5D7D7D7E2E2E2E7E7E7DBDBDBDADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DAC1C1C1969696CFCFCFE4E4E4E7E7E7DADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADAD5D5D5929292CE
                  CECEE5E5E5E7E7E7DADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
                  CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
                  CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
                  CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADA929292CDCDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADA929292CD
                  CDCDE5E5E5E6E6E6DADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADA939393CECECEE8E8E8E8E8E8
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADAD9D9D99C9C9CD2D2D2EAEAEAECECECDBDBDBDADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DACFCFCFB1B1B1DCDCDCEBEBEBF0F0F0E3E3E3DADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADABFBFBFCDCDCDE6
                  E6E6EBEBEBECECECEEEEEEE3E3E3DBDBDBDADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                  DADADADADADADADADADADADADADAD3D3D3C9C9C9E3E3E3EAEAEAEBEBEBEBEBEB
                  EBEBEBEBEBEBE7E7E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1
                  DEDEDED4D4D4D6D6D6E4E4E4EAEAEAEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAE7E7
                  E7E4E4E4E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2
                  E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E2E1E1E1E1E1E1E5E5E5E9E9
                  E9EBEBEBEBEBEBEBEBEB}
                Color = clBtnFace
                Anchors = [akTop, akRight]
                Caption = #26597#35810
                TabOrder = 2
                OnClick = btnFindClick
              end
            end
          end
          object RzPanel14: TRzPanel
            Left = 0
            Top = 60
            Width = 900
            Height = 486
            Align = alClient
            BorderInner = fsStatus
            BorderOuter = fsNone
            BorderColor = 15461355
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
              Width = 878
              Height = 464
              Align = alClient
              AllowedOperations = [alopUpdateEh]
              AutoFitColWidths = True
              BorderStyle = bsNone
              Color = 16185078
              DataSource = dsList
              FixedColor = 16448239
              Flat = True
              FooterColor = 8643839
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
              IsDrawNullRow = True
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
                  Title.Color = 15787416
                  Width = 29
                end
                item
                  Alignment = taCenter
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footer.Alignment = taCenter
                  Footer.Value = #21512#35745
                  Footer.ValueType = fvtStaticText
                  Footers = <>
                  Title.Caption = #21333#21495
                  Title.Color = 15787416
                  Width = 106
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'STOCK_DATE'
                  Footers = <>
                  Title.Caption = #36827#36135#26085#26399
                  Title.Color = 15787416
                  Width = 71
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #23458#25143#21517#31216
                  Title.Color = 15787416
                  Width = 160
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
                  Title.Caption = #36827#36135#37329#39069
                  Title.Color = 15787416
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'ACCT_MNY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #24212#20184#37329#39069
                  Title.Color = 15787416
                end
                item
                  Alignment = taRightJustify
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'RECV_MNY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #20184#27454#37329#39069
                  Title.Color = 15787416
                  Width = 65
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #25910#36135#21592
                  Title.Color = 15787416
                  Width = 49
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #35828#26126
                  Title.Color = 15787416
                  Width = 221
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Caption = #25805#20316
                  Title.Color = 15787416
                  Width = 165
                end>
            end
            object rowToolNav: TRzToolbar
              Left = 594
              Top = 194
              Width = 146
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
                Font.Style = [fsUnderline]
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
                Font.Style = [fsUnderline]
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
                Font.Style = [fsUnderline]
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
                Width = 36
                ShowCaption = True
                UseToolbarShowCaption = False
                Caption = #36864#36135
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = [fsUnderline]
                ParentFont = False
                OnClick = RzToolButton4Click
              end
            end
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 1100
    inherited lblCaption: TRzLabel
      Width = 788
      Caption = #21830#21697#20837#24211
    end
    inherited RzPanel12: TRzPanel
      Left = 788
      Width = 278
      inherited btnPrint: TRzBmpButton
        Left = 11
        OnClick = btnPrintClick
      end
      inherited btnNav: TRzBmpButton
        Left = 165
        OnClick = btnNavClick
      end
      inherited btnPreview: TRzBmpButton
        Left = 88
        OnClick = btnPreviewClick
      end
    end
    inherited RzPanel18: TRzPanel
      Left = 1066
    end
  end
  inherited photoPanel: TRzPanel
    Left = 900
    Height = 546
    inherited adv_photo_left_line: TImage
      Height = 526
    end
    inherited adv_photo_right_line: TImage
      Height = 526
    end
    inherited adv_bottom: TRzPanel
      Top = 536
    end
    inherited RzPanel1: TRzPanel
      Height = 526
      inherited adv02: TImage
        Height = 270
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
      end
      item
        Name = 'TAX_RATE'
        DataType = ftFloat
      end>
    AfterPost = edtTableAfterPost
    Left = 760
    Top = 128
  end
  inherited dsTable: TDataSource
    Left = 760
    Top = 96
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
    Left = 760
    Top = 168
  end
  object cdsHeader: TZQuery [6]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 720
    Top = 96
  end
  object cdsDetail: TZQuery [7]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 720
    Top = 272
  end
  object dsList: TDataSource [8]
    DataSet = cdsList
    Left = 760
    Top = 232
  end
  object cdsList: TZQuery [9]
    FieldDefs = <>
    BeforeOpen = cdsListBeforeOpen
    CachedUpdates = True
    Params = <>
    Left = 760
    Top = 200
  end
  inherited PopupMenu1: TPopupMenu
    Left = 720
    Top = 197
  end
  inherited Timer1: TTimer
    Left = 720
    Top = 128
  end
  inherited Images: TImageList
    Left = 720
    Top = 165
  end
  object PrintDBGridEh1: TPrintDBGridEh
    DBGridEh = DBGridEh1
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
    PageHeader.CenterText.Strings = (
      #35843#25972#27719#24635#34920)
    PageHeader.Font.Charset = GB2312_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -16
    PageHeader.Font.Name = #23435#20307
    PageHeader.Font.Style = [fsBold]
    Units = MM
    Left = 720
    Top = 232
    BeforeGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C6C616E67323035325C66305C6673323020255B7768725D5C66315C6673
      3136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C616E73696370673933365C64656666305C646566
      6C616E67313033335C6465666C616E676665323035327B5C666F6E7474626C7B
      5C66305C666E696C5C6663686172736574313334205C2763625C2763655C2763
      635C2765353B7D7B5C66315C666E696C5C6663686172736574313334204D5320
      53616E732053657269663B7D7D0D0A5C766965776B696E64345C7563315C7061
      72645C71725C66305C667332305C2762345C2766325C2764335C2761315C2763
      615C2762315C2762635C2765345C6C616E67323035325C66315C66733136200D
      0A5C706172207D0D0A00}
  end
  object frfStockOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfStockOrderGetValue
    OnUserFunction = frfStockOrderUserFunction
    Left = 760
    Top = 273
    ReportForm = {
      18000000321E0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A4000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      500100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001300696E7428285B5345
      514E4F5D2D31292F31352900000000000000FFFF000000000002000000010000
      000000000001000000C800000014000000010000000000000200370200000700
      B7D6D7E9BDC5310002010000000012010000F602000045000000300011000100
      0000000000000000FFFFFF1F0000000000000000000007000500626567696E0D
      1E0020696620436F756E74284D61737465724461746131293C3135207468656E
      0D060020626567696E0D260020202020666F7220693A3D436F756E74284D6173
      74657244617461312920746F20313420646F0D15002020202053686F7742616E
      64284368696C6431293B0D050020656E643B0D0300656E6400FFFF0000000000
      02000000010000000000000001000000C8000000140000000100000000000002
      009D02000006006368696C643100020100000000CC000000F602000013000000
      3000150001000000000000000000FFFFFF1F00000000000000000000000000FF
      FF000000000002000000010000000000000001000000C8000000140000000100
      000000000000002A03000006004D656D6F31380002001A020000A40000009C00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000001
      000F005B52454D41524B5F44455441494C5D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000090000008600020000
      000000FFFFFF0000000002000000000000000000EA03000006004D656D6F3230
      000200F1000000A4000000D10000001300000001000F00010000000000000000
      00FFFFFF1F2E020000000000010042005B474F44535F4E414D455D205B50524F
      50455254595F30315F544558545D5B50524F50455254595F30325F544558545D
      205B49535F50524553454E545F544558545D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000080000008600020000
      000000FFFFFF00000000020000000000000000007404000005004D656D6F3900
      02007500000033000000E5000000120000000100020001000000000000000000
      FFFFFF1F2E02000000000001000D005B434C49454E545F4E414D455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000008600020000000000FFFFFF0000000002000000000000000000FE04
      000006004D656D6F343000020088010000330000008B00000012000000010002
      0001000000000000000000FFFFFF1F2E02000000000001000C005B53544F434B
      5F444154455D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000008600020000000000FFFFFF000000000200
      00000000000000008705000006004D656D6F3233000200C2010000A400000024
      0000001300000001000F0001000000000000000000FFFFFF1F2E020000000000
      01000B005B554E49545F4E414D455D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000000000000000A0000008600020000000000
      FFFFFF00000000020000000000000000002306000005004D656D6F33000200E6
      010000A4000000340000001300000001000F0001000000000000000000FFFFFF
      1F2E02000000000001001F005B666F726D6174466C6F6174282723302E232327
      2C5B414D4F554E545D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      00000002000000000000000000AA06000006004D656D6F31320002002F000000
      3300000046000000120000000100000001000000000000000000FFFFFF1F2E02
      000000000001000900B9A920D3A620C9CC3A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF00000000020000000000000000002E07000006004D656D6F3133
      0002005B010000330000002D0000001200000001000000010000000000000000
      00FFFFFF1F2E02000000000001000600C8D5C6DAA3BA00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000800000086
      00020000000000FFFFFF0000000002000000000000000000B407000006004D65
      6D6F3336000200F100000070000000D10000001600000001000F000100000000
      0000000000FFFFFF1F2E02000000000001000800C9CCC6B7C3FBB3C600000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF00000000020000000000000000003608
      000006004D656D6F3337000200E601000070000000340000001600000001000F
      0001000000000000000000FFFFFF1F2E02000000000001000400CAFDC1BF0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      B808000006004D656D6F3338000200C201000070000000240000001600000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000400B5A5CEBB
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      00004C09000006004D656D6F3431000200310000002901000081000000120000
      000100000001000000000000000000FFFFFF1F2E02000000000001001600D6C6
      B5A5A3BA5B435245415F555345525F544558545D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000002000000000008000000860002
      0000000000FFFFFF0000000002000000000000000000D009000006004D656D6F
      34350002001A020000700000009C0000001600000001000F0001000000000000
      000000FFFFFF1F2E02000000000001000600B1B82020D7A200000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000550A00000600
      4D656D6F353400020030000000A40000001B0000001300000001000F00010000
      00000000000000FFFFFF1F2E020000000000010007005B5345514E4F5D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      00000A0000008600020000000000FFFFFF0000000002000000000000000000D4
      0A000006004D656D6F353500020030000000700000001B000000160000000100
      0F0001000000000000000000FFFFFF1F2E020000000000010001004100000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000550B
      000005004D656D6F370002004B00000070000000420000001600000001000F00
      01000000000000000000FFFFFF1F2E02000000000001000400BBF5BAC5000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      00000A0000000100020000000000FFFFFF0000000002000000000000000000DD
      0B000005004D656D6F380002004B000000A4000000420000001300000001000F
      0001000000000000000000FFFFFF1F2E02000000000001000B005B474F44535F
      434F44455D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000000100020000000000FFFFFF00000000020000
      00000000000000B40C000006004D656D6F3131000200A9010000120100000D01
      00001300000001000B0001000000000000000000FFFFFF1F2E02000000000001
      005900D7DCCAFDC1BFA3BA5B666F726D6174466C6F6174282723302E2323272C
      5B53544F434B5F414D545D295D20B1BED2B3D0A1BCC6A3BA5B666F726D617446
      6C6F6174282723302E2323272C73756D285B414D4F554E545D29295D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF0000000002000000000000000000370D
      000006004D656D6F31360002003000000012010000250000001300000001000E
      0001000000000000000000FFFFFF1F2E02000000000001000500BACFBCC63A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00BA0D000006004D656D6F333200020013020000330000002800000012000000
      0100000001000000000000000000FFFFFF1F2E02000000000001000500B5A5BA
      C53A00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00020000000000080000008600020000000000FFFFFF00000000020000000000
      00000000420E000006004D656D6F35380002003B020000330000007B00000012
      0000000100020001000000000000000000FFFFFF1F2E02000000000001000A00
      5B474C4944455F4E4F5D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000000000008600020000000000FFFFFF0000
      000002000000000000000000D30E000005004D656D6F32000200300000001900
      000086020000180000000100000001000000000000000500FFFFFF1F2E020000
      000000010014005BC6F3D2B5C3FBB3C65DBDF8BBF5C8EBBFE2B5A500000000FF
      FF00000000000200000001000000000400CBCECCE50010000000020000000000
      0A0000008600020000000000FFFFFF0000000002000000000000000000690F00
      0006004D656D6F32340002005C0200001B0000007A0000000F00000001000000
      01000000000000000000FFFFFF1F2E02000000000001001800B5DA5B50414745
      235D2F5B544F54414C50414745535DD2B300000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000009000000860002000000
      0000FFFFFF0000000002000000000000000000FB0F000005004D656D6F310002
      00F20000002801000080000000140000000100000001000000000000000000FF
      FFFF1F2E02000000000001001500C9F3BACBA3BA5B43484B5F555345525F5445
      58545D00000000010000000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      00000000007910000006004D656D6F3433000200550000001201000054010000
      1300000001000A0001000000000000000000FFFFFF1F2E020000000000010000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000008600020000000000FFFFFF0000000002000000000000
      0000000011000006004D656D6F33310002002E00000047000000480000001200
      00000300000001000000000000000000FFFFFF1F2E02000000000001000900B5
      D820202020D6B73A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000000100020000000000FFFFFF00000000
      020000000000000000008711000006004D656D6F353000020074000000470000
      00E7000000120000000300020001000000000000000000FFFFFF1F2E02000000
      0000010009005B414444524553535D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000000100020000000000
      FFFFFF00000000020000000000000000000B12000006004D656D6F3536000200
      5B010000470000002D000000120000000300000001000000000000000000FFFF
      FF1F2E02000000000001000600B5E7BBB0A3BA00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000001000200
      00000000FFFFFF00000000020000000000000000009412000006004D656D6F35
      3700020088010000470000008A00000012000000030002000100000000000000
      0000FFFFFF1F2E02000000000001000B005B4D4F56455F54454C455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000000100020000000000FFFFFF00000000020000000000000000001613
      000006004D656D6F34320002008D00000070000000640000001600000001000F
      0001000000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      0000000A0000000100020000000000FFFFFF0000000002000000000000000000
      9D13000006004D656D6F35390002008D000000A4000000640000001300000001
      000F0001000000000000000000FFFFFF1F2E020000000000010009005B424152
      434F44455D00000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000080000000100020000000000FFFFFF00000000020000
      000000000000001914000006004D656D6F36310002001A020000CC0000009C00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      0000009514000006004D656D6F3632000200F1000000CC000000D10000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000080000008600020000000000FFFFFF000000000200000000000000000013
      15000006004D656D6F3633000200C2010000CC00000024000000130000000100
      0F0001000000000000000000FFFFFF1F2E0200000000000100000000000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      0A0000008600020000000000FFFFFF00000000020000000000000000008F1500
      0006004D656D6F3634000200E6010000CC000000340000001300000001000F00
      01000000000000000000FFFFFF1F2E020000000000000000000000FFFF000000
      00000200000001000000000400CBCECCE5000A00000000000000000009000000
      8600020000000000FFFFFF00000000020000000000000000000D16000006004D
      656D6F363500020030000000CC0000001B0000001300000001000F0001000000
      000000000000FFFFFF1F2E0200000000000100000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000000000000000A0000008600
      020000000000FFFFFF00000000020000000000000000008B16000006004D656D
      6F36360002004B000000CC000000420000001300000001000F00010000000000
      00000000FFFFFF1F2E0200000000000100000000000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000001000200
      00000000FFFFFF00000000020000000000000000000717000006004D656D6F36
      370002008D000000CC000000640000001300000001000F000100000000000000
      0000FFFFFF1F2E020000000000000000000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000000100020000000000
      FFFFFF0000000002000000000000000000E717000006004D656D6F3638000200
      C10200007F00000014000000140100000300000001000000000000000000FFFF
      FF1F2E020000000000080000000D0C00B0D7C1AAB4E6B8F9202020200D00000D
      15002020202020202020202020202020202020202020200D0C00BAECC1AACAD5
      BBF5B7BD20200D00000D18002020202020202020202020202020202020202020
      202020200D0800BBC6C1AAB2C6CEF100000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000020000000000000000000100020000000000
      FFFFFF00000000020000000000000000006A18000006004D656D6F3130000200
      130200004700000028000000120000000300000001000000000000000000FFFF
      FF1F2E02000000000001000500BDE1CBE33A00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000000100020000
      000000FFFFFF0000000002000000000000000000FA18000006004D656D6F3135
      0002003B020000470000007B0000001200000003000200010000000000000000
      00FFFFFF1F2E020000000000010012005B534554544C455F434F44455F544558
      545D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      000000008019000005004D656D6F340002002F0000005B000000440000001200
      00000300000001000000000000000000FFFFFF1F2E02000000000001000900CA
      D5BBF5B5A5CEBB3A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000000100020000000000FFFFFF00000000
      02000000000000000000081A000005004D656D6F36000200730000005B000000
      E9000000120000000300020001000000000000000000FFFFFF1F2E0200000000
      0001000B005B53484F505F4E414D455D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000800000001000200000000
      00FFFFFF00000000020000000000000000008B1A000006004D656D6F31370002
      00130200005B00000028000000120000000300000001000000000000000000FF
      FFFF1F2E02000000000001000500B1B8D7A23A00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000001000200
      00000000FFFFFF0000000002000000000000000000111B000006004D656D6F31
      390002003B0200005B0000007B00000012000000030002000100000000000000
      0000FFFFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00000100020000000000FFFFFF0000000002000000000000000000971B000006
      004D656D6F323100020025020000290100003400000012000000010000000100
      0000000000000000FFFFFF1F2E02000000000001000800CAD5BBF5C8CBA3BA00
      000000010000000000000200000001000000000400CBCECCE5000A0000000200
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      00131C000006004D656D6F32320002005A020000290100005C00000012000000
      0100020001000000000000000000FFFFFF1F2E02000000000000000000000001
      0000000000000200000001000000000400CBCECCE5000A000000020000000000
      080000008600020000000000FFFFFF0000000002000000000000000000A81C00
      0006004D656D6F32350002003100000041010000880100001200000003000000
      01000000000000000000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BC
      E43A5B444154455D205B54494D455D00000000FFFF0000000000020000000100
      0000000500417269616C000A0000000000000000000000000001000200000000
      00FFFFFF00000000020000000000000000002B1D000005004D656D6F35000200
      5C0100005B0000002D000000120000000300000001000000000000000000FFFF
      FF1F2E02000000000001000600B6A9B5A5BAC500000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000800000001000200
      00000000FFFFFF0000000002000000000000000000B81D000006004D656D6F31
      34000200890100005B0000008A00000012000000030002000100000000000000
      0000FFFFFF1F2E02000000000001000F005B474C4944455F4E4F5F46524F4D5D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000080000000100020000000000FFFFFF000000000200000000000000
      FEFEFF060000000A00205661726961626C6573000000000200736C0014006364
      735F436867426F64792E22534C30303030220002006A650014006364735F4368
      67426F64792E224A4530303030220004006B68796800000000040079687A6800
      0000000200647A000000000000000000000000FDFF0100000000}
  end
  object DelGodsShortCust: TPopupMenu
    Left = 553
    Top = 343
    object DeleteShortCut: TMenuItem
      Caption = #21024#38500
      OnClick = DeleteShortCutClick
    end
  end
end
