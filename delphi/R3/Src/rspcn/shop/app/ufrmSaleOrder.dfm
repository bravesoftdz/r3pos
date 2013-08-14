inherited frmSaleOrder: TfrmSaleOrder
  Left = 220
  Top = 168
  Caption = #38144#21806#21333
  ClientHeight = 499
  ClientWidth = 1039
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 839
    Height = 452
    inherited webForm: TRzPanel
      Width = 839
      Height = 452
      inherited PageControl: TRzPageControl
        Width = 839
        Height = 452
        FixedDimension = 0
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#24405#20837
          inherited order_input: TRzPanel
            Width = 839
            Height = 149
            inherited RzPanel2: TRzPanel
              Width = 817
              Height = 127
              DesignSize = (
                817
                127)
              inherited RzBorder1: TRzBorder
                Left = 16
                Width = 789
              end
              inherited lblInput: TRzLabel
                Left = 17
                Top = 10
                Width = 77
                Height = 26
                Font.Height = -19
                LightTextStyle = True
                HighlightColor = clWhite
                ShadowColor = 16250871
              end
              inherited lblHint: TRzLabel
                ShadowColor = 15921906
              end
              inherited help: TRzBmpButton
                Left = 789
              end
              inherited barcode: TRzPanel
                TabOrder = 2
                inherited barcode_input_line: TImage
                  Hint = #25195#30721#25353' pause '#20581
                end
                inherited edtInput: TcxTextEdit
                  Tag = -1
                end
              end
              object RzPanel19: TRzPanel [5]
                Left = 16
                Top = 59
                Width = 353
                Height = 56
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                BorderColor = clGray
                Caption = #23454#25910#65306'1000 '#25214#38646#65306'90'
                Color = clBlack
                Font.Charset = GB2312_CHARSET
                Font.Color = clRed
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                DesignSize = (
                  353
                  56)
                object Image5: TImage
                  Left = 5
                  Top = 0
                  Width = 343
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
                  Width = 343
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
                  Caption = #24744#29616#22312#21487#20197#25195#30721#38144#21806#20102
                  ScrollType = stNone
                end
                object Image3: TImage
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
                object Image4: TImage
                  Left = 348
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
              inherited helpPanel: TRzPanel
                Left = 377
                Width = 430
                TabOrder = 3
                inherited lblModifyUnit: TRzLabel
                  Left = 9
                  Top = 2
                  ShadowColor = 15987699
                end
                inherited lblModifyAmt: TRzLabel
                  Left = 9
                  Top = 23
                  ShadowColor = 15987699
                end
                inherited lblModifyPrice: TRzLabel
                  Left = 9
                  Top = 44
                  ShadowColor = 15987699
                end
                object RzLabel7: TRzLabel
                  Tag = 5
                  Left = 127
                  Top = 2
                  Width = 90
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #38144#21806'/'#36192#36865' [F5] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel8: TRzLabel
                  Tag = 6
                  Left = 127
                  Top = 23
                  Width = 88
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #20250#21592#21345#21495'  [F6] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel9: TRzLabel
                  Tag = 7
                  Left = 127
                  Top = 44
                  Width = 83
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #23548' '#36141' '#21592'  [F7] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel12: TRzLabel
                  Tag = 10
                  Left = 235
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
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel11: TRzLabel
                  Tag = 9
                  Left = 235
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
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel10: TRzLabel
                  Tag = 8
                  Left = 235
                  Top = 2
                  Width = 62
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #28165#23631'  [F8] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel13: TRzLabel
                  Tag = 11
                  Left = 329
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
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel14: TRzLabel
                  Tag = 12
                  Left = 329
                  Top = 23
                  Width = 95
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #25910#27454#26041#24335'  [ *   ] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 6570814
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel15: TRzLabel
                  Tag = 13
                  Left = 329
                  Top = 44
                  Width = 95
                  Height = 20
                  Cursor = crHandPoint
                  Caption = #25910#38134#32467#36134'  [ +  ] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 6572100
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  OnClick = DoKeyClick
                  ShadowColor = 15987699
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
            end
          end
          inherited order_header: TRzPanel
            Top = 149
            Width = 839
            object edtBK_CLIENT_ID: TRzPanel
              Left = 10
              Top = 1
              Width = 319
              Height = 31
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
                object RzLabel1: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #23458#25143#21517#31216
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
                Left = 105
                Top = 4
                Width = 212
                Height = 23
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.Shadow = False
                Style.ButtonStyle = btsDefault
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
                OnSaveValue = edtCLIENT_IDSaveValue
                MultiSelect = False
              end
            end
            object edtBK_SALES_DATE: TRzPanel
              Left = 581
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
                object RzLabel2: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #38144#21806#26085#26399
                  Transparent = True
                  Layout = tlCenter
                  ShadowColor = 16250871
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtSALES_DATE: TcxDateEdit
                Left = 105
                Top = 4
                Width = 142
                Height = 23
                Anchors = [akTop, akRight]
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.ButtonTransparency = ebtInactive
                TabOrder = 1
              end
            end
          end
          inherited order_grid: TRzPanel
            Top = 181
            Width = 839
            Height = 159
            inherited DBGridEh1: TDBGridEh
              Width = 817
              Height = 137
              FixedColor = 16448239
              FooterColor = 8643839
              FrozenCols = 1
              Columns = <
                item
                  Color = clWhite
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
                  Color = clWhite
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
                  Color = clWhite
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
                  Color = clWhite
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
                  Alignment = taCenter
                  Color = clWhite
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
                  Color = clWhite
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
                  Color = clWhite
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'APRICE'
                  Footer.DisplayFormat = '#0.00#'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #21333#20215
                  Title.Color = 15787416
                  Width = 60
                  OnUpdateData = DBGridEh1Columns6UpdateData
                end
                item
                  Color = clWhite
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
                  Color = clWhite
                  DisplayFormat = '#00.0%'
                  EditButtons = <>
                  FieldName = 'AGIO_RATE'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #25240#25187
                  Title.Color = 15787416
                  Width = 46
                  OnUpdateData = DBGridEh1Columns8UpdateData
                end
                item
                  Color = clWhite
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AGIO_MONEY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #35753#21033
                  Title.Color = 15787416
                  Width = 69
                end
                item
                  Color = clWhite
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #22791#27880
                  Title.Color = 15787416
                  Width = 111
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
              Left = 320
              Top = 107
              Style.BorderStyle = ebsFlat
              Style.Edges = []
              Style.ButtonStyle = btsUltraFlat
              Style.ButtonTransparency = ebtInactive
            end
            inherited fndUNIT_ID: TcxComboBox
              Top = 112
              Style.BorderStyle = ebsFlat
              Style.Edges = []
              Style.ButtonStyle = btsUltraFlat
              Style.ButtonTransparency = ebtInactive
            end
          end
          inherited order_footer: TRzPanel
            Top = 340
            Width = 839
            Height = 112
            object Label1: TLabel
              Left = 314
              Top = 34
              Width = 8
              Height = 15
              Caption = '%'
            end
            object Image2: TImage
              Left = 17
              Top = 18
              Width = 318
              Height = 75
              AutoSize = True
              Picture.Data = {
                0A544A504547496D61676524410000FFD8FFE101364578696600004D4D002A00
                0000080007011200030000000100010000011A00050000000100000062011B00
                05000000010000006A012800030000000100020000013100020000001C000000
                7201320002000000140000008E8769000400000001000000A4000000D0000AFC
                8000002710000AFC800000271041646F62652050686F746F73686F7020435335
                2057696E646F777300323031333A30333A31392031343A35353A333100000000
                03A00100030000000100010000A0020004000000010000013EA0030004000000
                010000004B0000000000000006010300030000000100060000011A0005000000
                010000011E011B00050000000100000126012800030000000100020000020100
                04000000010000012E0202000400000001000000000000000000000048000000
                010000004800000001FFED084050686F746F73686F7020332E30003842494D04
                25000000000010000000000000000000000000000000003842494D043A000000
                000093000000100000000100000000000B7072696E744F757470757400000005
                00000000436C7253656E756D00000000436C7253000000005247424300000000
                496E7465656E756D00000000496E746500000000436C726D000000004D70426C
                626F6F6C010000000F7072696E745369787465656E426974626F6F6C00000000
                0B7072696E7465724E616D6554455854000000010000003842494D043B000000
                0001B200000010000000010000000000127072696E744F75747075744F707469
                6F6E7300000012000000004370746E626F6F6C0000000000436C6272626F6F6C
                00000000005267734D626F6F6C000000000043726E43626F6F6C000000000043
                6E7443626F6F6C00000000004C626C73626F6F6C00000000004E677476626F6F
                6C0000000000456D6C44626F6F6C0000000000496E7472626F6F6C0000000000
                42636B674F626A63000000010000000000005247424300000003000000005264
                2020646F7562406FE000000000000000000047726E20646F7562406FE0000000
                000000000000426C2020646F7562406FE000000000000000000042726454556E
                744623526C74000000000000000000000000426C6420556E744623526C740000
                0000000000000000000052736C74556E74462350786C40520000000000000000
                000A766563746F7244617461626F6F6C010000000050675073656E756D000000
                00506750730000000050675043000000004C656674556E744623526C74000000
                000000000000000000546F7020556E744623526C740000000000000000000000
                0053636C20556E74462350726340590000000000003842494D03ED0000000000
                10004800000001000200480000000100023842494D042600000000000E000000
                000000000000003F8000003842494D040D0000000000040000001E3842494D04
                190000000000040000001E3842494D03F3000000000009000000000000000001
                003842494D271000000000000A000100000000000000023842494D03F5000000
                000048002F66660001006C66660006000000000001002F6666000100A1999A00
                06000000000001003200000001005A0000000600000000000100350000000100
                2D000000060000000000013842494D03F80000000000700000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF03E800003842494D040000000000000200003842494D04020000000000
                04000000003842494D043000000000000201013842494D042D00000000000600
                01000000013842494D0408000000000010000000010000024000000240000000
                003842494D041E000000000004000000003842494D041A00000000034F000000
                0600000000000000000000004B0000013E0000000D0074006F006F006C005F00
                6200750074006F006E005F003800570000000100000000000000000000000000
                0000000000000100000000000000000000013E0000004B000000000000000000
                0000000000000001000000000000000000000000000000000000001000000001
                0000000000006E756C6C0000000200000006626F756E64734F626A6300000001
                000000000000526374310000000400000000546F70206C6F6E67000000000000
                00004C6566746C6F6E67000000000000000042746F6D6C6F6E670000004B0000
                0000526768746C6F6E670000013E00000006736C69636573566C4C7300000001
                4F626A6300000001000000000005736C6963650000001200000007736C696365
                49446C6F6E67000000000000000767726F757049446C6F6E6700000000000000
                066F726967696E656E756D0000000C45536C6963654F726967696E0000000D61
                75746F47656E6572617465640000000054797065656E756D0000000A45536C69
                63655479706500000000496D672000000006626F756E64734F626A6300000001
                000000000000526374310000000400000000546F70206C6F6E67000000000000
                00004C6566746C6F6E67000000000000000042746F6D6C6F6E670000004B0000
                0000526768746C6F6E670000013E0000000375726C5445585400000001000000
                0000006E756C6C54455854000000010000000000004D73676554455854000000
                01000000000006616C74546167544558540000000100000000000E63656C6C54
                657874497348544D4C626F6F6C010000000863656C6C54657874544558540000
                0001000000000009686F727A416C69676E656E756D0000000F45536C69636548
                6F727A416C69676E0000000764656661756C740000000976657274416C69676E
                656E756D0000000F45536C69636556657274416C69676E000000076465666175
                6C740000000B6267436F6C6F7254797065656E756D0000001145536C69636542
                47436F6C6F7254797065000000004E6F6E6500000009746F704F75747365746C
                6F6E67000000000000000A6C6566744F75747365746C6F6E6700000000000000
                0C626F74746F6D4F75747365746C6F6E67000000000000000B72696768744F75
                747365746C6F6E6700000000003842494D042800000000000C000000023FF000
                00000000003842494D0414000000000004000000043842494D04210000000000
                5500000001010000000F00410064006F00620065002000500068006F0074006F
                00730068006F00700000001300410064006F00620065002000500068006F0074
                006F00730068006F0070002000430053003500000001003842494D0406000000
                0000070008000000010100FFE10E23687474703A2F2F6E732E61646F62652E63
                6F6D2F7861702F312E302F003C3F787061636B657420626567696E3D22EFBBBF
                222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F
                3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D
                6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E
                302D633036302036312E3133343737372C20323031302F30322F31322D31373A
                33323A30302020202020202020223E203C7264663A52444620786D6C6E733A72
                64663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F3232
                2D7264662D73796E7461782D6E7323223E203C7264663A446573637269707469
                6F6E207264663A61626F75743D222220786D6C6E733A786D703D22687474703A
                2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D6C6E733A64
                633D22687474703A2F2F7075726C2E6F72672F64632F656C656D656E74732F31
                2E312F2220786D6C6E733A70686F746F73686F703D22687474703A2F2F6E732E
                61646F62652E636F6D2F70686F746F73686F702F312E302F2220786D6C6E733A
                786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F31
                2E302F6D6D2F2220786D6C6E733A73744576743D22687474703A2F2F6E732E61
                646F62652E636F6D2F7861702F312E302F73547970652F5265736F7572636545
                76656E74232220786D703A43726561746F72546F6F6C3D2241646F6265205068
                6F746F73686F70204353352057696E646F77732220786D703A43726561746544
                6174653D22323031332D30332D31395431313A33383A31302B30383A30302220
                786D703A4D6F64696679446174653D22323031332D30332D31395431343A3535
                3A33312B30383A30302220786D703A4D65746164617461446174653D22323031
                332D30332D31395431343A35353A33312B30383A3030222064633A666F726D61
                743D22696D6167652F6A706567222070686F746F73686F703A436F6C6F724D6F
                64653D2233222070686F746F73686F703A49434350726F66696C653D22735247
                422049454336313936362D322E312220786D704D4D3A496E7374616E63654944
                3D22786D702E6969643A43373344424245363544393045323131383735384435
                384332364546373241452220786D704D4D3A446F63756D656E7449443D22786D
                702E6469643A4336334442424536354439304532313138373538443538433236
                4546373241452220786D704D4D3A4F726967696E616C446F63756D656E744944
                3D22786D702E6469643A43363344424245363544393045323131383735384435
                38433236454637324145223E203C786D704D4D3A486973746F72793E203C7264
                663A5365713E203C7264663A6C692073744576743A616374696F6E3D22637265
                61746564222073744576743A696E7374616E636549443D22786D702E6969643A
                4336334442424536354439304532313138373538443538433236454637324145
                222073744576743A7768656E3D22323031332D30332D31395431313A33383A31
                302B30383A3030222073744576743A736F6674776172654167656E743D224164
                6F62652050686F746F73686F70204353352057696E646F7773222F3E203C7264
                663A6C692073744576743A616374696F6E3D22636F6E76657274656422207374
                4576743A706172616D65746572733D2266726F6D20696D6167652F626D702074
                6F20696D6167652F6A706567222F3E203C7264663A6C692073744576743A6163
                74696F6E3D227361766564222073744576743A696E7374616E636549443D2278
                6D702E6969643A43373344424245363544393045323131383735384435384332
                36454637324145222073744576743A7768656E3D22323031332D30332D313954
                31343A35353A33312B30383A3030222073744576743A736F6674776172654167
                656E743D2241646F62652050686F746F73686F70204353352057696E646F7773
                222073744576743A6368616E6765643D222F222F3E203C2F7264663A5365713E
                203C2F786D704D4D3A486973746F72793E203C2F7264663A4465736372697074
                696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E20202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                2020202020202020202020202020202020202020202020202020202020202020
                20202020202020202020202020202020202020202020202020202020203C3F78
                7061636B657420656E643D2277223F3EFFE20C584943435F50524F46494C4500
                010100000C484C696E6F021000006D6E74725247422058595A2007CE00020009
                000600310000616373704D534654000000004945432073524742000000000000
                0000000000010000F6D6000100000000D32D4850202000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000001163707274000001500000003364657363000001840000006C7774
                7074000001F000000014626B707400000204000000147258595A000002180000
                00146758595A0000022C000000146258595A0000024000000014646D6E640000
                025400000070646D6464000002C400000088767565640000034C000000867669
                6577000003D4000000246C756D69000003F8000000146D6561730000040C0000
                002474656368000004300000000C725452430000043C0000080C675452430000
                043C0000080C625452430000043C0000080C7465787400000000436F70797269
                676874202863292031393938204865776C6574742D5061636B61726420436F6D
                70616E790000646573630000000000000012735247422049454336313936362D
                322E31000000000000000000000012735247422049454336313936362D322E31
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000058595A20000000000000F3510001
                0000000116CC58595A200000000000000000000000000000000058595A200000
                000000006FA2000038F50000039058595A2000000000000062990000B7850000
                18DA58595A2000000000000024A000000F840000B6CF64657363000000000000
                001649454320687474703A2F2F7777772E6965632E6368000000000000000000
                00001649454320687474703A2F2F7777772E6965632E63680000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000064657363000000000000002E4945432036313936362D322E3120
                44656661756C742052474220636F6C6F7572207370616365202D207352474200
                000000000000000000002E4945432036313936362D322E312044656661756C74
                2052474220636F6C6F7572207370616365202D20735247420000000000000000
                000000000000000000000000000064657363000000000000002C526566657265
                6E63652056696577696E6720436F6E646974696F6E20696E2049454336313936
                362D322E3100000000000000000000002C5265666572656E6365205669657769
                6E6720436F6E646974696F6E20696E2049454336313936362D322E3100000000
                0000000000000000000000000000000000000000000076696577000000000013
                A4FE00145F2E0010CF140003EDCC0004130B00035C9E0000000158595A200000
                0000004C09560050000000571FE76D6561730000000000000001000000000000
                000000000000000000000000028F000000027369672000000000435254206375
                7276000000000000040000000005000A000F00140019001E00230028002D0032
                0037003B00400045004A004F00540059005E00630068006D00720077007C0081
                0086008B00900095009A009F00A400A900AE00B200B700BC00C100C600CB00D0
                00D500DB00E000E500EB00F000F600FB01010107010D01130119011F0125012B
                01320138013E0145014C0152015901600167016E0175017C0183018B0192019A
                01A101A901B101B901C101C901D101D901E101E901F201FA0203020C0214021D
                0226022F02380241024B0254025D02670271027A0284028E029802A202AC02B6
                02C102CB02D502E002EB02F50300030B03160321032D03380343034F035A0366
                0372037E038A039603A203AE03BA03C703D303E003EC03F9040604130420042D
                043B0448045504630471047E048C049A04A804B604C404D304E104F004FE050D
                051C052B053A05490558056705770586059605A605B505C505D505E505F60606
                06160627063706480659066A067B068C069D06AF06C006D106E306F507070719
                072B073D074F076107740786079907AC07BF07D207E507F8080B081F08320846
                085A086E0882089608AA08BE08D208E708FB09100925093A094F09640979098F
                09A409BA09CF09E509FB0A110A270A3D0A540A6A0A810A980AAE0AC50ADC0AF3
                0B0B0B220B390B510B690B800B980BB00BC80BE10BF90C120C2A0C430C5C0C75
                0C8E0CA70CC00CD90CF30D0D0D260D400D5A0D740D8E0DA90DC30DDE0DF80E13
                0E2E0E490E640E7F0E9B0EB60ED20EEE0F090F250F410F5E0F7A0F960FB30FCF
                0FEC1009102610431061107E109B10B910D710F511131131114F116D118C11AA
                11C911E81207122612451264128412A312C312E31303132313431363138313A4
                13C513E5140614271449146A148B14AD14CE14F01512153415561578159B15BD
                15E0160316261649166C168F16B216D616FA171D17411765178917AE17D217F7
                181B18401865188A18AF18D518FA19201945196B199119B719DD1A041A2A1A51
                1A771A9E1AC51AEC1B141B3B1B631B8A1BB21BDA1C021C2A1C521C7B1CA31CCC
                1CF51D1E1D471D701D991DC31DEC1E161E401E6A1E941EBE1EE91F131F3E1F69
                1F941FBF1FEA20152041206C209820C420F0211C2148217521A121CE21FB2227
                2255228222AF22DD230A23382366239423C223F0241F244D247C24AB24DA2509
                25382568259725C725F726272657268726B726E827182749277A27AB27DC280D
                283F287128A228D429062938296B299D29D02A022A352A682A9B2ACF2B022B36
                2B692B9D2BD12C052C392C6E2CA22CD72D0C2D412D762DAB2DE12E162E4C2E82
                2EB72EEE2F242F5A2F912FC72FFE3035306C30A430DB3112314A318231BA31F2
                322A3263329B32D4330D3346337F33B833F1342B3465349E34D83513354D3587
                35C235FD3637367236AE36E937243760379C37D738143850388C38C839053942
                397F39BC39F93A363A743AB23AEF3B2D3B6B3BAA3BE83C273C653CA43CE33D22
                3D613DA13DE03E203E603EA03EE03F213F613FA23FE24023406440A640E74129
                416A41AC41EE4230427242B542F7433A437D43C044034447448A44CE45124555
                459A45DE4622466746AB46F04735477B47C04805484B489148D7491D496349A9
                49F04A374A7D4AC44B0C4B534B9A4BE24C2A4C724CBA4D024D4A4D934DDC4E25
                4E6E4EB74F004F494F934FDD5027507150BB51065150519B51E65231527C52C7
                5313535F53AA53F65442548F54DB5528557555C2560F565C56A956F757445792
                57E0582F587D58CB591A596959B85A075A565AA65AF55B455B955BE55C355C86
                5CD65D275D785DC95E1A5E6C5EBD5F0F5F615FB36005605760AA60FC614F61A2
                61F56249629C62F06343639763EB6440649464E9653D659265E7663D669266E8
                673D679367E9683F689668EC6943699A69F16A486A9F6AF76B4F6BA76BFF6C57
                6CAF6D086D606DB96E126E6B6EC46F1E6F786FD1702B708670E0713A719571F0
                724B72A67301735D73B87414747074CC7528758575E1763E769B76F8775677B3
                7811786E78CC792A798979E77A467AA57B047B637BC27C217C817CE17D417DA1
                7E017E627EC27F237F847FE5804780A8810A816B81CD8230829282F4835783BA
                841D848084E3854785AB860E867286D7873B879F8804886988CE8933899989FE
                8A648ACA8B308B968BFC8C638CCA8D318D988DFF8E668ECE8F368F9E9006906E
                90D6913F91A89211927A92E3934D93B69420948A94F4955F95C99634969F970A
                977597E0984C98B89924999099FC9A689AD59B429BAF9C1C9C899CF79D649DD2
                9E409EAE9F1D9F8B9FFAA069A0D8A147A1B6A226A296A306A376A3E6A456A4C7
                A538A5A9A61AA68BA6FDA76EA7E0A852A8C4A937A9A9AA1CAA8FAB02AB75ABE9
                AC5CACD0AD44ADB8AE2DAEA1AF16AF8BB000B075B0EAB160B1D6B24BB2C2B338
                B3AEB425B49CB513B58AB601B679B6F0B768B7E0B859B8D1B94AB9C2BA3BBAB5
                BB2EBBA7BC21BC9BBD15BD8FBE0ABE84BEFFBF7ABFF5C070C0ECC167C1E3C25F
                C2DBC358C3D4C451C4CEC54BC5C8C646C6C3C741C7BFC83DC8BCC93AC9B9CA38
                CAB7CB36CBB6CC35CCB5CD35CDB5CE36CEB6CF37CFB8D039D0BAD13CD1BED23F
                D2C1D344D3C6D449D4CBD54ED5D1D655D6D8D75CD7E0D864D8E8D96CD9F1DA76
                DAFBDB80DC05DC8ADD10DD96DE1CDEA2DF29DFAFE036E0BDE144E1CCE253E2DB
                E363E3EBE473E4FCE584E60DE696E71FE7A9E832E8BCE946E9D0EA5BEAE5EB70
                EBFBEC86ED11ED9CEE28EEB4EF40EFCCF058F0E5F172F1FFF28CF319F3A7F434
                F4C2F550F5DEF66DF6FBF78AF819F8A8F938F9C7FA57FAE7FB77FC07FC98FD29
                FDBAFE4BFEDCFF6DFFFFFFEE000E41646F626500644000000001FFDB00840001
                0101010101010101010101010101010101010101010101010101010101010101
                0101010101010101010102020202020202020202020303030303030303030301
                0101010101010101010102020102020303030303030303030303030303030303
                0303030303030303030303030303030303030303030303030303030303030303
                FFC0001108004B013E03011100021101031101FFDD00040028FFC401A2000000
                0602030100000000000000000000070806050409030A0201000B010000060301
                0101000000000000000000060504030702080109000A0B100002010304010303
                0203030302060975010203041105120621071322000831144132231509514216
                612433175271811862912543A1B1F02634720A19C1D13527E1533682F192A244
                54734546374763285556571AB2C2D2E2F2648374938465A3B3C3D3E3293866F3
                752A393A48494A58595A6768696A767778797A85868788898A9495969798999A
                A4A5A6A7A8A9AAB4B5B6B7B8B9BAC4C5C6C7C8C9CAD4D5D6D7D8D9DAE4E5E6E7
                E8E9EAF4F5F6F7F8F9FA110002010302040403050404040606056D0102031104
                21120531060022134151073261147108428123911552A162163309B124C1D143
                72F017E18234259253186344F1A2B226351954364564270A7383934674C2D2E2
                F255657556378485A3B3C3D3E3F3291A94A4B4C4D4E4F495A5B5C5D5E5F52847
                576638768696A6B6C6D6E6F667778797A7B7C7D7E7F7485868788898A8B8C8D8
                E8F839495969798999A9B9C9D9E9F92A3A4A5A6A7A8A9AAABACADAEAFAFFDA00
                0C03010002110311003F00D9F7E397C72E8ACDF4575565B2DD55B2F2193C86CB
                C3D556D6D561E092A2AAA2482F24D34879791CFD4FE7DFBAF74357FB2BDF1E7F
                E7CF6C4FFCF1D3FBF75EEBDFECAF7C79FF009F3DB13FF3C74FEFDD7BAF7FB2BD
                F1E7FE7CF6C4FF00CF1D3FBF75EEBDFECAF7C79FF9F3DB13FF003C74FEFDD7BA
                F7FB2BDF1E7FE7CF6C4FFCF1D3FBF75EEBDFECAF7C79FF009F3DB13FF3C74FEF
                DD7BAF7FB2BDF1E7FE7CF6C4FF00CF1D3FBF75EEBDFECAF7C79FF9F3DB13FF00
                3C74FEFDD7BAF7FB2BDF1E7FE7CF6C4FFCF1D3FBF75EE94DBA218A9F736E2820
                8A3820833B97861861458E28628F215091C5146815238E34501540000161EFDD
                7BA62F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7
                BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EE
                BDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75E
                F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7FFFD0
                DB9FE2F7FD93CF4F7FE18983FF00DC7F7EEBDD2AFB9373E4F6875A6EDCE60776
                F5BEC8DC906324836C6E3EDCAE931DD7745B8AAD969F111EE6A987238AA95A1A
                AAC9162B453094BB0D2AE7D0DEEBDD124DD1F317B336664FE34D06E4C06CF4CE
                6F9A6DCB99ED9D99B6A8B39BA66C86C3864A7C76DEECCEB5DD986C8E476ED0ED
                FA9ACA7AA9E1A5AB96BE5C8A3471C330894D5BFBAF7429FC77F92F9EEECEE3EE
                1C1D75147B6360E1E9F0E3A7F0796DA3B931BBDF7463F14A29B7BEF6CE64EAE6
                5C3E330F3662BA0868285E15AB921B487495957DFBAF7475BDFBAF75EF7EEBDD
                177F95BDC3B87A13A1B7AF696D4C2623716E3C155ECAC5E1F139EA9ABA4C3CD5
                9BCF7F6D6D8E9539196807DE3536346E3352628D91A6F0F8F5C7AB5AFBAF7453
                F73FCAFF0092BD618BEEBC2760ECBE92CA76675857753D052E3F6B6677463F6D
                D3D47646E4C3625D33D535D599AA89852E37329508D0C905981560473EFDD7BA
                1A3A5BBCFB9373F75E43A93B3B19D20BF6BD7990DECB5DD4DBE2BB774B4D351E
                E1A2C2474391790CD4B01935CECD19292ADA36E558FBF75EE8E87BF75EE830DD
                DFF1F5EE7FFC38735FFBB2A9F7EEBDD27BDFBAF75EF7EEBDD7BDFBAF75EF7EEB
                DD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF
                7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF
                75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BD
                FBAF75EF7EEBDD7BDFBAF75FFFD1DB9FE2F7FD93CF4F7FE18983FF00DC7F7EEB
                DD70F94781DBF9FF008F3DC8BB8B6FE1371D3E17ADF7AEE8C6D1E7B174796A3A
                4CFEDBDB395CBE0F2D053D6C3347157E2F234A92C32A81246EB7523DFBAF755B
                B45BB27107C70EC7E8DED89B6BF66D6F5FF4BFC3DADC4E3BAE465E9293746F4A
                39F7F19B1B95CDD39C06486329BC8B5D0D1C53BD24B0C7149246D2E83EEBDD0F
                FF001EB37925EEEAEDF5DE7F22F21D87D839ADD3DCFF00137AC36C9EBFA5C141
                9AABE9ADC6DB8376E6FC9B5A93F8763604A7A6A897556AA8BC91C22A19DA347F
                75EEAC7FDFBAF75EF7EEBDD12DFE613435B91F897D874B8FA3AAAEAA6DCDD2F3
                2D351D3CB5550D152F79F5AD5D54A21811E431D352C0F248D6B2468CC6C013EF
                DD7BAAE5DE54FB2727B8FBD766F48EC7CC43B5FB1FB4FA0B6E75ED26E1A4DC94
                397DF798A2DC388CE6E0267DD9A6BE48FF0089E32487CB2B2C11C5229042B27B
                F75EE8E2FC7CDAD9FDA9F31F76D1EE0E9AEB6E879AAFA1E6C851EC8D83BA315B
                BA5CA51D46FBAC81378E67278A67869EAF272523511A7662EA31C1CF0E3DFBAF
                7564FEFDD7BA0C3777FC7D7B9FFF000E1CD7FEECAA7DFBAF749EF7EEBDD7BDFB
                AF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7
                BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EE
                BDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75E
                F7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7FFD2DB9FE2F7FD93CF4F7F
                E18983FF00DC7F7EEBDD0B9BA36DE2778ED9DC5B473F03D560B7560B2FB6F354
                D14F353495189CE63EA31991823A9A778E7A779A8EA9D43A32BA13704103DFBA
                F74096C8F8BDD5DB177B6CCDE58F4CED6D3757603F857556CEC96422A8DABB2F
                3B5F45F63B977F7DBFDB2D5E737AE7A28A2FF2BAB91FEDFC68230121A6483DD7
                BAC3B0FE2A7566C2EC87ED4A3C8F6266B7145BD3B6FB070F86CFEEBC7566C7DB
                BBB7BA66AA9379E5F0DB6A9F6D51CB0CF24753E381A5AB95D1628F53398D48F7
                5EE8C87BF75EEBDEFDD7BAED599195958AB290CACA4865606E1948B10411C1F7
                EEBDD00FB03E3FEDEDA1D899DEDFDD1BC7B0FB73B372393CDCDB6B39D95B823C
                AE2BAD30594ADAB9A976FF005EEDBA2A3A1C561A3A0A1A85805415795B419142
                48F2337BAF7503A87E346CAEA2DE39FEC75DEBDC7D9FD89B876953EC7A8DD9DC
                3BF28B79D5E3B6D53E71F70AE2F09152ED8C17F0DA41929A5648C3BA44279748
                0D23B37BAF7461BDFBAF74186EEFF8FAF73FFE1C39AFFDD954FBF75EE93DEFDD
                7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBD
                EFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75
                EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7
                BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAFFFD3DB9FE2F7FD
                93CF4F7FE18983FF00DC7F7EEBDD0F3EFDD7BAF7BF75EEBDEFDD7BAF7BF75EEB
                DEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BA2EBBE3B1F66E137165DB76
                EE5C16D1ABABC85556B43B9727498285DAB277A861435795928E9B2112B4B60D
                133F1F500DC0F75EE91BFE9A7A73FE7ECF59FF00E879B5BFFAEBEFDD7BAF7FA6
                9E9CFF009FB3D67FFA1E6D6FFEBAFBF75EEBDFE9A7A73FE7ECF59FFE879B5BFF
                00AEBEFDD7BAF7FA69E9CFF9FB3D67FF00A1E6D6FF00EBAFBF75EEBDFE9A7A73
                FE7ECF59FF00E879B5BFFAEBEFDD7BAF7FA69E9CFF009FB3D67FFA1E6D6FFEBA
                FBF75EEBDFE9A7A73FE7ECF59FFE879B5BFF00AEBEFDD7BAF7FA69E9CFF9FB3D
                67FF00A1E6D6FF00EBAFBF75EEBDFE9A7A73FE7ECF59FF00E879B5BFFAEBEFDD
                7BAF7FA69E9CFF009FB3D67FFA1E6D6FFEBAFBF75EEBDFE9A7A73FE7ECF59FFE
                879B5BFF00AEBEFDD7BAF7FA69E9CFF9FB3D67FF00A1E6D6FF00EBAFBF75EEBD
                FE9A7A73FE7ECF59FF00E879B5BFFAEBEFDD7BAF7FA69E9CFF009FB3D67FFA1E
                6D6FFEBAFBF75EEBDFE9A7A73FE7ECF59FFE879B5BFF00AEBEFDD7BAF7FA69E9
                CFF9FB3D67FF00A1E6D6FF00EBAFBF75EEBDFE9A7A73FE7ECF59FF00E879B5BF
                FAEBEFDD7BAF7FA69E9CFF009FB3D67FFA1E6D6FFEBAFBF75EEBDFE9A7A73FE7
                ECF59FFE879B5BFF00AEBEFDD7BAF7FA69E9CFF9FB3D67FF00A1E6D6FF00EBAF
                BF75EEBDFE9A7A73FE7ECF59FF00E879B5BFFAEBEFDD7BAF7FA69E9CFF009FB3
                D67FFA1E6D6FFEBAFBF75EEBDFE9A7A73FE7ECF59FFE879B5BFF00AEBEFDD7BA
                F7FA69E9CFF9FB3D67FF00A1E6D6FF00EBAFBF75EEBDFE9A7A73FE7ECF59FF00
                E879B5BFFAEBEFDD7BAF7FA69E9CFF009FB3D67FFA1E6D6FFEBAFBF75EEBDFE9
                A7A73FE7ECF59FFE879B5BFF00AEBEFDD7BAF7FA69E9CFF9FB3D67FF00A1E6D6
                FF00EBAFBF75EEA541DB9D5155156CF4BD9DD79530636952B723341BD36DCD15
                051C959498E4ABAD923C93252D2BE42BE080492154334F1A5F53A83EEBDD7FFF
                D4DB9FE2F7FD93CF4F7FE18983FF00DC7F7EEBDD0F3EFDD7BAF7BF75EEBDEFDD
                7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BAF7BF75EEBDEFDD7BA815B8BC664
                428C863A82BC2FE915B474F5417FE0BE78DEDEFDD7BA6FFEEA6D7FF9E6F01FF9
                E7C77FF537BF75EEBDFDD4DAFF00F3CDE03FF3CF8EFF00EA6F7EEBDD7BFBA9B5
                FF00E79BC07FE79F1DFF00D4DEFDD7BAF7F7536BFF00CF3780FF00CF3E3BFF00
                A9BDFBAF75EFEEA6D7FF009E6F01FF009E7C77FF00537BF75EEBDFDD4DAFFF00
                3CDE03FF003CF8EFFEA6F7EEBDD23379E5BA9FAFA9B1957BBA8F6EE2D3339383
                0D88823DB5FC4F2193C95402C94D418BC462EBF255463894C92B244C9044A649
                0AA02C3DD7BA5743B6B68D4451CF06DFDBB2C3322C914B1E231AC9246E032BAB
                0A7B15607DFBAF7597FBA9B5FF00E79BC07FE79F1DFF00D4DEFDD7BAF7F7536B
                FF00CF3780FF00CF3E3BFF00A9BDFBAF75EFEEA6D7FF009E6F01FF009E7C77FF
                00537BF75EEBDFDD4DAFFF003CDE03FF003CF8EFFEA6F7EEBDD7BFBA9B5FFE79
                BC07FE79F1DFFD4DEFDD7BAF7F7536BFFCF3780FFCF3E3BFFA9BDFBAF75EFEEA
                6D7FF9E6F01FF9E7C77FF537BF75EEBDFDD4DAFF00F3CDE03FF3CF8EFF00EA6F
                7EEBDD7BFBA9B5FF00E79BC07FE79F1DFF00D4DEFDD7BAF7F7536BFF00CF3780
                FF00CF3E3BFF00A9BDFBAF75EFEEA6D7FF009E6F01FF009E7C77FF00537BF75E
                EBDFDD4DAFFF003CDE03FF003CF8EFFEA6F7EEBDD7BFBA9B5FFE79BC07FE79F1
                DFFD4DEFDD7BAF7F7536BFFCF3780FFCF3E3BFFA9BDFBAF75EFEEA6D7FF9E6F0
                1FF9E7C77FF537BF75EEBDFDD4DAFF00F3CDE03FF3CF8EFF00EA6F7EEBDD7BFB
                A9B5FF00E79BC07FE79F1DFF00D4DEFDD7BAF7F7536BFF00CF3780FF00CF3E3B
                FF00A9BDFBAF75EFEEA6D7FF009E6F01FF009E7C77FF00537BF75EEBDFDD4DAF
                FF003CDE03FF003CF8EFFEA6F7EEBDD3BE376CEDC8E8F70247B7F091A4F88862
                9D531540AB34433D849C452AAC0049189E1470A6E35A29FA81EFDD7BAFFFD5DB
                9FE2F7FD93CF4F7FE18983FF00DC7F7EEBDD0B9B96AB234584AD9F115981A0C9
                AAC4B4555B9E4A88B0714B24F12135ED492455250C65828460C5EC3DFBAF740C
                E2B79763E5727BA71F1EF2E8A8E3DAD5985A0A8AC2BBADA1A9ABCC628E5C4318
                197050D2D2B47AAE4DFC83E9EFDD7BA58E4771E7F1DB0F2D909F7AF5343BB3C9
                534B84CACF2E4A9F622640C11CD8DA0CB9AACD52E45A6AA2928710D40744B3AA
                3E92ADEEBDD27F31D81BF3159FDBB29D8D9BA9DBD3EC95C96E6A2A0C24990FB3
                DD9999218B6BE2311BDA9F29FDDEADABABC946D432513C31CA0D5D3CDE45F543
                EFDD7BAE39ADE7D87B67A671B97DC18CA1C776FEE0186DAD8AC4D6E22BF19814
                EC7DE55D478DC3515351CF5B5191CB6DDDB5559889AB6A56488CF4B415335A05
                0DE3F75EE93392EC8ED1C8CF91CAED89BAE709B3692BBAE30D87ACDD18CDCF9C
                CD6E897B2FB3371EC0DB7B8D29F1197DBF4D82C3E568F154B90869DC5549E2AA
                03CC7F1EEBDD2ED375EF58765E4EB965D8F9FDE384DE791DB72D1D3BE536BE1B
                3E982CB522E5B1F86193ACCC5652E7AA31124A9462592685EB553C9A226629EE
                BDD30CDD99BEC6E0ED2836FF005DEE5DF78DDA34383A3C35060B04F45570EFBA
                9C063F3590DA194CECD93ACC46413ED73D8F9E5AAA74438E0F346F1CEC232DEE
                BDD4CCD6E8EC1A6DB9D3B418DCCECCC76EEDF59F9B6EEE9DCBBA36AE6A4DB38A
                A9DBDD7BD85BBF754F8DDAD49BC30D9261266760C94146B3655742CC2472E574
                37BAF748DADEDFDC34C368C357BF3A976D52D7613B4EBF37BB73DB7371CB88CA
                E43AEFB4BFD1B434DB6B090EF6A2A8A182BBEDAA2B6469B215BA515550B0F59F
                75EE866EB2DCF55BCB66D16E2AAC8E172E6AB2BB92860CB6DEA1AEC6E1B2B498
                5DC191C4D1E4E828B235F94AA869EBE9691255BD4CC0EABAB6923DFBAF74BDF7
                EEBDD7BDFBAF75EF7EEBDD7BDFBAF7412F727726D2E94DABFDE3DCB24D595F5F
                52B8ADA9B5B1BA25CFEF0DC33A934985C2D2B105E46FD73CCD6869600D2C842A
                F3EEBDD043D37B6FB377DE42A37CEFDCB52D46E9C8D5D2E6A0DBC1637DB1D518
                BA749A2C7C7B7AAE6A7967872D04352CB552952D956674912DA3C5EEBDD1BE94
                51A2C30D0D2A52C30C455B4055351532CD35555D5C8A81511EA2A6A1C855002A
                D87E3DFBAF7587DFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7
                BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EE
                BDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD39D07FC05C
                D7FDAB22FF00DDCE27DFBAF75FFFD6DB9FE2F7FD93CF4F7FE18983FF00DC7F7E
                EBDD2FFB1B33D7B80DAB5B95ECFF00EEE3ED4A49A9659E9F736368F3343595F1
                CCB2E3292930B594B5DFC63313D5C6A292961826A99A7D2B1233D87BF75EE8BF
                61B1DB6F6D5475A643B536675E6CB8BB177076CEFDC96DCDCBB6B68E271FB2F0
                51ECBA7A3EBDDB39A82AA922C351E7E930D434D555B15ACB92AA997965BFBF75
                EE9419FDD1D61BBBAA3BCE0EBADBDB3ABB6FEC8DAD9AAC3B836DEDFD972EC7CA
                6E8AED8D97AF85B0B5B8112D26572D84A38512ADDA356A669510312481EEBDD3
                26E6C0E4B700D9DD8736D0D918FDB925474E6DDDBB9BDCFBCBB1719B9EB699B7
                B6070F4D2E3B6361B0D2ECDA1C56773B9268E92AE6A9158F4B32D4F8C3A4517B
                F75EE94BD9F82A7DBDD6790C7EE19FA3B62B54EFCC7BE0B2397C9EEADE18BA59
                323574D0E46B68FF00BEFB657209BFAB30BF7D4F8C8B1F14ED4F2BF9633C329F
                75EE83FDCF97DAF90CAE7B73EE84A259325B83E2A61F6862AA8EF8EBDC63E168
                FB5772E2F2993DBFB7B704FB732B99A5DB5B64C754B5B3D2CB0D2F85AA213100
                241EEBDD3AEEBA3D9996E90DEB9BC4ED4DAF9DA4DAFDA3BB2AB69D6D4D0AEF81
                4F6DD985A2C86E1C3E5336D9CC87DED4D0C9387AA8272FE3B80FA45BDFBAF753
                37355B34FDA9BAB0794EC3EBADAD49574BBB33869B21B6B1F4CBBDF73EE0C0EC
                BA0A1963AFC4E6571D29D85B4E3CAD652BCBE5A45AEA6132C126B847BAF74EF5
                F26D0ABDB9B56B368C589DC5B0FA23B4B79516732DDA1B93074DB7372C953D65
                BEA9F279B5DD55B8FACC16428B1FB97B7294C93494F1C22A29278D46A8949F75
                EE9B3674B96A5C4506FB8B7FED8E9FDA5B6F6B6F5C14BBDB1745899B63C95FD9
                FDDB5FBC303B636764B36BB4F0992C66D8C49A0A29B234E91D1555654C70D386
                62CABEEBDD095B0B178EDEBB336DD7E53766E2DDEB80ED5DE5B91370D1E5AA36
                E2EEAC9EDEDFDB922435C9B76BCD36436AD654162687CB2D24F12A06D400F7EE
                BDD2F5769E25721BAF2AD519F92B777D062F195E1B736796871D458BA5C852C6
                36F6362AF8E8B6FD6550C8B3CF534891544922236BD4A0FBF75EEA1AEC3DBEB8
                ED8387136E55C6F5DD6E1321898A3DDBB852AF2B3E070D5986A48B74E4857FDF
                EE4C7CE95A66A8A6AB79219E748D9D4945B7BAF7599B6661DE4DEF3BD4EE3351
                BFA9E8A8F2D20DD39F48B194943869F091C7B52923AF4A6DA93CD0D434D2CF40
                B04F2D485959CBAA91EEBDD26BB0F7FEC3F8FF00D555FBCF75D65663363F5EED
                FC3514F5134F5F9ECBCF0D2AE3B6FE32133D54B5394CDE6F2D5B243182EF24F5
                35337D4B37BF75EEAB5FAEF6176DF7BF7DD7EF5DED90C5EE3CBCF4A723B3B70E
                21AAAA3AAF62752D6D539C4E476954CEA9F71264D22B54B3AA64AA7228F0CC91
                B45A22F75EEADBB118AC5ED9C3536DCC0ACC31F4DA64A9ACA9B1C866AB82E993
                259275E35B9BF8E21FB70A5957F24FBAF752BDFBAF75EF7EEBDD7BDFBAF75EF7
                EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF7
                5EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDF
                BAF75EF7EEBDD7BDFBAF74E741FF0001735FF6AC8BFF0077389F7EEBDD7FFFD7
                DBB3E33432D27427565054A343598CDA58EC657D3480ACB495F42AD4D59493A1
                B3473D35446C8EA402AC083EFDD7BA1C5A289E4A69A4861965A2A98AB68DE686
                298D2D6539260ABA7F2ABF8AA60249475B329FA11EFDD7BACACECF2899CF9250
                ED289250257F23ABA3C979037AD964604FD6C4FBF75EEBD52E6B299A8AA82D45
                1BACCAF492A2352BAD4208E757A72BE27134634B020EA5E0F1EFDD7BAC752915
                6F83EF20A7AB5A59F1B534D15553C1510415187A8A6ABC4CD141346F0A3E36AE
                8E1960217F6A489596C5411EEBDD678E69A2944F14B24532B165963768E45637
                BB2BA10CA4DFF07DFBAF75E13CBE579CB969E408B24D20124AE10B140D248198
                852E48E78B9F7EEBDD7296A6A26F109257610022117B2C419CC8DE351654D523
                126DF53CFBF75EEA3B056A6146523FB412D44FF6C228C40D3D5CCD51553C9105
                0924F533B9791D81676E493EFDD7BAE5507EEE05A6A9549E993568A69238DA99
                75B895ED015F17AE41A8F1C9E4FBF75EEBD5E7F8A2BA64C2E46391551E2AE55A
                B89E342192368A71246D1A902CA4585BE9EFDD7BAF02162829E38E2869E9A331
                535353C31535353C664795921A78123862569646621545D893EFDD7BAEBDFBAF
                75EF7EEBDD7BDFBAF740EF757466C6F901B7703B3BB1A5DC92ED2C3EF1C2EF3A
                FC1EDECCC7848B7454EDF872071784DC555F615B572EDF8F27570D73C54AF4B5
                0D554501132AAB2BFBAF7422ED6DABB5B62E069B6B6C8DBD8DDABB769199E2C5
                6296658A49A46D72D5564F5134F555F593484BBCB33BBB33124F3EFDD7BA7DF7
                EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF7
                5EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDF
                BAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF75EF7EEBDD7BDFBAF74E741FF00
                01735FF6AC8BFF0077389F7EEBDD7FFFD0DC9BAAFED3C79BFB9FE037FE3159A7
                C3FC73ECADACFF00C0CFE13E8FE357FF00811AF9D56F7EEBDD0C1FEE2BFECD9F
                FD7CBDFBAF75EFF715FF0066CFFEBE5EFDD7BAF7FB8AFF00B367FF005F2F7EEB
                DD7BFDC57FD9B3FF00AF97BF75EEBDFEE2BFECD9FF00D7CBDFBAF75EFF00715F
                F66CFF00EBE5EFDD7BAF7FB8AFFB367FF5F2F7EEBDD7BFDC57FD9B3FFAF97BF7
                5EEBDFEE2BFECD9FFD7CBDFBAF75EFF715FF0066CFFEBE5EFDD7BAF7FB8AFF00
                B367FF005F2F7EEBDD7BFDC57FD9B3FF00AF97BF75EEBDFEE2BFECD9FF00D7CB
                DFBAF75EFF00715FF66CFF00EBE5EFDD7BAF7FB8AFFB367FF5F2F7EEBDD7BFDC
                57FD9B3FFAF97BF75EEBDFEE2BFECD9FFD7CBDFBAF75EFF715FF0066CFFEBE5E
                FDD7BAF7FB8AFF00B367FF005F2F7EEBDD7BFDC57FD9B3FF00AF97BF75EEBDFE
                E2BFECD9FF00D7CBDFBAF75EFF00715FF66CFF00EBE5EFDD7BAF7FB8AFFB367F
                F5F2F7EEBDD7BFDC57FD9B3FFAF97BF75EEBDFEE2BFECD9FFD7CBDFBAF75EFF7
                15FF0066CFFEBE5EFDD7BAF7FB8AFF00B367FF005F2F7EEBDD7BFDC57FD9B3FF
                00AF97BF75EEBDFEE2BFECD9FF00D7CBDFBAF75EFF00715FF66CFF00EBE5EFDD
                7BAF7FB8AFFB367FF5F2F7EEBDD7BFDC57FD9B3FFAF97BF75EEBDFEE2BFECD9F
                FD7CBDFBAF75EFF715FF0066CFFEBE5EFDD7BAF7FB8AFF00B367FF005F2F7EEB
                DD7BFDC57FD9B3FF00AF97BF75EEBDFEE2BFECD9FF00D7CBDFBAF75EFF00715F
                F66CFF00EBE5EFDD7BA9D49FC37EDF29A7FBBD6FB18FC9E3FEF5E8D1FC4F1D6F
                3F97D7E2D7A6DE3F5EBD37F46AF7EEBDD7FFD9}
            end
            object edtREMARK: TcxTextEdit
              Left = 18
              Top = 64
              Width = 316
              Height = 23
              TabOrder = 0
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object edtBK_GUIDE_USER: TRzPanel
              Left = 106
              Top = 18
              Width = 229
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              DesignSize = (
                229
                31)
              object RzPanel4: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel3: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #23548#36141#21592
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
              object edtGUIDE_USER: TzrComboBoxList
                Left = 105
                Top = 4
                Width = 123
                Height = 23
                Anchors = [akTop, akRight]
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = True
                Style.ButtonTransparency = ebtInactive
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
                ShowButton = False
                LocateStyle = lsDark
                Buttons = [zbNew]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object edtBK_ACCT_MNY: TRzPanel
              Left = 293
              Top = 18
              Width = 318
              Height = 31
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 2
              object RzLabel6: TRzLabel
                Left = 307
                Top = 2
                Width = 9
                Height = 27
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
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel4: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 27
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
                Left = 105
                Top = 4
                Width = 112
                Height = 23
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtACCT_MNYKeyPress
              end
              object edtAGIO_RATE: TcxTextEdit
                Left = 254
                Top = 4
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
                Left = 217
                Top = 2
                Width = 37
                Height = 27
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdRight]
                TabOrder = 3
                object RzLabel5: TRzLabel
                  Left = 2
                  Top = 0
                  Width = 33
                  Height = 27
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
            object edtBK_PAY_TOTAL: TRzPanel
              Left = 293
              Top = 57
              Width = 318
              Height = 36
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 3
              DesignSize = (
                318
                36)
              object RzPanel10: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 32
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight]
                FlatColor = clGray
                TabOrder = 0
                object payment: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 32
                  Cursor = crHandPoint
                  Align = alClient
                  Alignment = taCenter
                  Caption = #26412#27425#25910#27454
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3418913
                  Font.Height = -15
                  Font.Name = #23435#20307
                  Font.Style = [fsUnderline]
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  OnClick = paymentClick
                  ShadowColor = 13750737
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object edtPAY_TOTAL: TcxTextEdit
                Left = 105
                Top = 6
                Width = 211
                Height = 23
                Anchors = [akTop, akRight]
                ParentFont = False
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clMaroon
                Style.Font.Height = -15
                Style.Font.Name = #23435#20307
                Style.Font.Style = [fsBold]
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                OnKeyPress = edtPAY_TOTALKeyPress
              end
            end
            object btnSave: TRzBmpButton
              Left = 617
              Top = 25
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
              Caption = #20445#23384#32467#36134'(+)'
              TabOrder = 4
              OnClick = btnSaveClick
            end
            object btnNew: TRzBmpButton
              Left = 737
              Top = 24
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
              Caption = #28165#31354
              TabOrder = 5
              OnClick = btnNewClick
            end
            object btnImport: TRzBmpButton
              Left = 737
              Top = 54
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
              Caption = #23548#20837
              TabOrder = 6
              OnClick = btnImportClick
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
            Width = 839
            Height = 57
            Align = alTop
            BorderOuter = fsNone
            BorderColor = 15461355
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object RzPanel3: TRzPanel
              Left = 10
              Top = 10
              Width = 819
              Height = 37
              Align = alClient
              BorderOuter = fsNone
              BorderColor = 15461355
              BorderShadow = 15461355
              Color = 15461355
              FlatColor = clGray
              GridColor = clBackground
              TabOrder = 0
              DesignSize = (
                819
                37)
              object RzPanel6: TRzPanel
                Left = 340
                Top = 7
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
              object btnFind: TRzBmpButton
                Left = 747
                Top = 7
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
                TabOrder = 1
                OnClick = btnFindClick
              end
              object RzPanel5: TRzPanel
                Left = 1
                Top = 8
                Width = 321
                Height = 29
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                TabOrder = 2
                DesignSize = (
                  321
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
                object Image6: TImage
                  Left = 316
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
                object Image7: TImage
                  Left = 6
                  Top = 0
                  Width = 310
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
                  Width = 310
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
            end
          end
          object RzPanel14: TRzPanel
            Left = 0
            Top = 57
            Width = 839
            Height = 395
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
              Width = 817
              Height = 373
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
                  Width = 107
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'SALES_DATE'
                  Footers = <>
                  Title.Caption = #38144#21806#26085#26399
                  Title.Color = 15787416
                  Width = 75
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
                  FieldName = 'SALE_MNY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #38144#21806#37329#39069
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
                  Title.Caption = #24212#25910#37329#39069
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
                  Title.Caption = #25910#27454#37329#39069
                  Title.Color = 15787416
                  Width = 65
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23548#36141#21592
                  Title.Color = 15787416
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #35828#26126
                  Title.Color = 15787416
                  Width = 84
                end
                item
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Caption = #25805#20316
                  Title.Color = 15787416
                  Width = 145
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
    Width = 1039
    inherited lblCaption: TRzLabel
      Width = 743
      Caption = #38144' '#21806' '#21333
    end
    inherited RzPanel12: TRzPanel
      Left = 743
      Width = 288
      inherited btnPrint: TRzBmpButton
        Left = 5
        OnClick = btnPrintClick
      end
      inherited btnNav: TRzBmpButton
        Left = 156
        OnClick = btnNavClick
      end
      inherited btnPreview: TRzBmpButton
        Left = 80
        OnClick = btnPreviewClick
      end
    end
    inherited RzPanel18: TRzPanel
      Left = 1031
      Width = 8
    end
  end
  inherited photoPanel: TRzPanel
    Left = 839
    Height = 452
    inherited adv_photo_left_line: TImage
      Height = 432
    end
    inherited adv_photo_right_line: TImage
      Height = 432
    end
    inherited adv_bottom: TRzPanel
      Top = 442
    end
    inherited RzPanel1: TRzPanel
      Height = 432
      inherited adv02: TImage
        Height = 176
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
      end
      item
        Name = 'TAX_RATE'
        DataType = ftFloat
      end>
    AfterPost = edtTableAfterPost
    Left = 832
    Top = 168
  end
  inherited dsTable: TDataSource
    Left = 832
    Top = 200
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
    Left = 832
    Top = 232
  end
  inherited PopupMenu1: TPopupMenu
    Left = 865
    Top = 263
  end
  object cdsHeader: TZQuery [7]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 832
    Top = 264
  end
  object cdsDetail: TZQuery [8]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 864
    Top = 96
  end
  object cdsICGlide: TZQuery [9]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 864
    Top = 128
  end
  object dsList: TDataSource [10]
    DataSet = cdsList
    Left = 864
    Top = 200
  end
  object cdsList: TZQuery [11]
    FieldDefs = <>
    BeforeOpen = cdsListBeforeOpen
    CachedUpdates = True
    Params = <>
    Left = 864
    Top = 168
  end
  inherited Timer1: TTimer
    Left = 32
    Top = 128
  end
  object PrintDBGridEh1: TPrintDBGridEh [13]
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
    Left = 832
    Top = 96
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
  inherited Images: TImageList
    Left = 864
    Top = 229
  end
  object frfSalesOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalesOrderGetValue
    OnUserFunction = frfSalesOrderUserFunction
    Left = 832
    Top = 129
    ReportForm = {
      18000000C4200000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      520100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001500494E5428285B5345
      514E4F5D2D3129202F2031352900000000000000FFFF00000000000200000001
      0000000000000001000000C80000001400000001000000000000020039020000
      0700B7D6D7E9BDC5310002010000000012010000F60200004A00000030001100
      01000000000000000000FFFFFF1F000000000000000000000700050062656769
      6E0D1E0020696620436F756E74284D61737465724461746131293C3134207468
      656E0D060020626567696E0D260020202020666F7220693A3D436F756E74284D
      617374657244617461312920746F20313320646F0D15002020202053686F7742
      616E64284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      0002009F02000006006368696C643100020100000000E8000000F60200001300
      00003000150001000000000000000000FFFFFF1F000000000000000000000000
      00FFFF000000000002000000010000000000000001000000C800000014000000
      0100000000000000002303000006004D656D6F33320002001F02000032000000
      2E000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000600B5A5BAC5A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000C103000006004D656D6F31340002002E020000
      BE0000003E0000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010020005B466F726D6174466C6F6174282723302E303023272C5B
      4150524943455D295D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      00020000000000000000006204000006004D656D6F31380002006C020000BE00
      00004F0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000010023005B666F726D6174466C6F6174282723302E3030272C5B43414C
      435F4D4F4E45595D295D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000002205000006004D656D6F3230000200EE000000BE
      000000F90000001300000001000F0001000000000000000000FFFFFF1F2E0200
      00000000010042005B474F44535F4E414D455D205B50524F50455254595F3031
      5F544558545D5B50524F50455254595F30325F544558545D205B49535F505245
      53454E545F544558545D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000080000008600020000000000FFFFFF0000
      000002000000000000000000AC05000005004D656D6F390002007B0000003200
      000000010000120000000100020001000000000000000000FFFFFF1F2E020000
      00000001000D005B434C49454E545F4E414D455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000003606000006004D656D6F
      3430000200A80100003200000076000000120000000100020001000000000000
      000000FFFFFF1F2E02000000000001000C005B53414C45535F444154455D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000080000008600020000000000FFFFFF0000000002000000000000000000
      BF06000006004D656D6F3233000200E7010000BE000000200000001300000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000B005B554E49
      545F4E414D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000000000000000A0000008600020000000000FFFFFF0000000002
      0000000000000000004707000006004D656D6F35380002004E02000032000000
      6C000000120000000100020001000000000000000000FFFFFF1F2E0200000000
      0001000A005B474C4944455F4E4F5D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000000000008600020000000000
      FFFFFF0000000002000000000000000000E307000005004D656D6F3300020007
      020000BE000000270000001300000001000F0001000000000000000000FFFFFF
      1F2E02000000000001001F005B666F726D6174666C6F6174282723302E232327
      2C5B414D4F554E545D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      000000020000000000000000007408000005004D656D6F320002003500000019
      00000085020000180000000100000001000000000000000500FFFFFF1F2E0200
      00000000010014005BC6F3D2B5C3FBB3C65DCFFACADBB3F6BBF5B5A500000000
      FFFF00000000000200000001000000000400CBCECCE500100000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000FB08
      000006004D656D6F313200020035000000320000004600000012000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000900BFCDBBA7C3FB
      B3C63A00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      00000000007F09000006004D656D6F31330002007D010000320000002B000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010006
      00C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      000000000000000000010A000006004D656D6F33340002002E02000070000000
      3E0000001600000001000F0001000000000000000000FFFFFF1F2E0200000000
      0001000400B5A5BCDB00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000870A000006004D656D6F3336000200EE0000007000
      0000F90000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000800C9CCC6B7C3FBB3C600000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF0000000002000000000000000000090B000006004D656D6F3337000200
      0702000070000000270000001600000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000400CAFDC1BF00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF00000000020000000000000000008B0B000006004D656D6F333800
      0200E701000070000000200000001600000001000F0001000000000000000000
      FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF0000000002000000000000000000600C000006004D656D6F32
      350002003500000012010000B20100001300000001000E000100000000000000
      0000FFFFFF1F2E02000000000001005700BACFBCC6BDF0B6EEA3BA5B536D616C
      6C546F426967285B53414C455F4D4E595D295D2020A3A43A5B666F726D617446
      6C6F6174282723302E3030272C5B53414C455F4D4E595D295D20202020202020
      202020202020202000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000EE0C000006004D656D6F3432000200C20100004A0100
      006E0000000F0000000100000001000000000000000000FFFFFF1F2E02000000
      000001001000BFCDBBA7C7A9C3FB28B8C7D5C229A3BA00000000010000000000
      000200000001000000000400CBCECCE5000A0000000200000000000800000086
      00020000000000FFFFFF0000000002000000000000000000740D000006004D65
      6D6F3434000200590100002A0100003700000014000000010000000100000000
      0000000000FFFFFF1F2E02000000000001000800B2D6B9DCD4B1A3BA00000000
      010000000000000200000001000000000400CBCECCE5000A0000000200000000
      00080000008600020000000000FFFFFF0000000002000000000000000000FA0D
      000006004D656D6F3431000200FC0100002A0100003500000014000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000800CBCDBBF5D4B1
      A3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00020000000000080000008600020000000000FFFFFF00000000020000000000
      000000007C0E000006004D656D6F34350002006C020000700000004F00000016
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001000400
      BDF0B6EE00000000FFFF00000000000200000001000000000400CBCECCE5000A
      0000000200000000000A0000008600020000000000FFFFFF0000000002000000
      000000000000010F000006004D656D6F353400020035000000BE0000001B0000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      07005B5345514E4F5D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000000000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000810F000006004D656D6F3535000200350000007000
      00001B0000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000200D0F200000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      00020000000000000000000210000005004D656D6F3700020050000000700000
      003E0000001600000001000F0001000000000000000000FFFFFF1F2E02000000
      000001000400BBF5BAC500000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000008A10000005004D656D6F3800020050000000BE00
      00003E0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000B005B474F44535F434F44455D00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000000000000000080000000100020000
      000000FFFFFF00000000020000000000000000002011000006004D656D6F3234
      0002007A02000019000000560000001200000001000000010000000000000000
      00FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B544F54414C
      50414745535DD2B300000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000090000008600020000000000FFFFFF00000000
      02000000000000000000A911000006004D656D6F32360002007B000000460000
      00E5000000120000000100020001000000000000000000FFFFFF1F2E02000000
      000001000B005B53454E445F414444525D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF00000000020000000000000000003012000006004D656D6F323700
      0200350000004600000046000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000900CBCDBBF5B5D8D6B73A00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000020000000000080000
      008600020000000000FFFFFF0000000002000000000000000000B91200000600
      4D656D6F3238000200A801000046000000760000001200000001000200010000
      00000000000000FFFFFF1F2E02000000000001000B005B54454C4550484F4E45
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000080000008600020000000000FFFFFF0000000002000000000000
      0000004013000006004D656D6F32390002006201000046000000460000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001000900C1
      AACFB5B5E7BBB03A00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000020000000000080000008600020000000000FFFFFF00000000
      02000000000000000000D513000005004D656D6F31000200370000002A010000
      7C000000140000000100000001000000000000000000FFFFFF1F2E0200000000
      0001001800D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D000000
      00010000000000000200000001000000000400CBCECCE5000A00000002000000
      0000080000008600020000000000FFFFFF000000000200000000000000000057
      14000006004D656D6F35360002008E0000007000000060000000160000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000400CCF5C2EB00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000000100020000000000FFFFFF00000000020000000000000000
      00DE14000006004D656D6F35370002008E000000BE0000006000000013000000
      01000F0001000000000000000000FFFFFF1F2E020000000000010009005B4241
      52434F44455D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000000100020000000000FFFFFF000000000200
      0000000000000000C115000006004D656D6F3539000200C00200005C00000018
      0000002A0100000300000001000000000000000000FFFFFF1F2E020000000000
      07000B00B0D7C1AAA3BAB4E6B8F9200D00000D1E002020202020202020202020
      202020202020202020202020202020202020200D0C00BAECC1AAA3BABFCDBBA7
      20200D00000D140020202020202020202020202020202020202020200D0A00BB
      C6C1AAA3BABDE1CBE300000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000000000000100020000000000FFFFFF000000
      00020000000000000000003D16000006004D656D6F36300002002E020000E800
      00003E0000001300000001000F0001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000000000000000090000008600020000000000FFFFFF00000000020000
      00000000000000B916000006004D656D6F36310002006C020000E80000004F00
      00001300000001000F0001000000000000000000FFFFFF1F2E02000000000000
      0000000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      0000003517000006004D656D6F3632000200EE000000E8000000F90000001300
      000001000F0001000000000000000000FFFFFF1F2E0200000000000000000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000B1
      17000006004D656D6F3633000200E7010000E800000020000000130000000100
      0F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF00000000020000000000000000002D18000006
      004D656D6F363400020007020000E8000000270000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000000000000000FFFF0000000000
      0200000001000000000400CBCECCE5000A000000000000000000090000008600
      020000000000FFFFFF0000000002000000000000000000A918000006004D656D
      6F363500020035000000E80000001B0000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000000000000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000000000000000A000000860002000000
      0000FFFFFF00000000020000000000000000002519000006004D656D6F363600
      020050000000E80000003E0000001300000001000F0001000000000000000000
      FFFFFF1F2E020000000000000000000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000000100020000000000FFFF
      FF0000000002000000000000000000A319000006004D656D6F36370002008E00
      0000E8000000600000001300000001000F0001000000000000000000FFFFFF1F
      2E0200000000000100000000000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000080000000100020000000000FFFFFF00
      00000002000000000000000000811A000005004D656D6F35000200E701000012
      010000D40000001300000003000B0001000000000000000000FFFFFF1F2E0200
      0000000001006100D7DCCAFDC1BFA3BA5B666F726D6174666C6F617428272330
      2E2323272C5B53414C455F414D545D295D20B1BED2B3D0A1BCC6A3BAA3A43A5B
      666F726D6174466C6F6174282723302E3030272C5B73756D285B43414C435F4D
      4F4E45595D295D295D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000000100020000000000FFFFFF000000
      0002000000000000000000FD1A000006004D656D6F3130000200320200002F01
      0000610000000C0000000100020001000000000000000000FFFFFF1F2E020000
      000000000000000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000080000008600020000000000FFFFFF00000000020000
      00000000000000791B000006004D656D6F3131000200920100002C0100006100
      0000100000000100020001000000000000000000FFFFFF1F2E02000000000000
      0000000000010000000000000200000001000000000400CBCECCE5000A000000
      0200FFFFFF1F080000008600020000000000FFFFFF0000000002000000000000
      000000091C000006004D656D6F31350002004E020000460000006C0000001200
      00000100020001000000000000000000FFFFFF1F2E020000000000010012005B
      534554544C455F434F44455F544558545D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000860002000000
      0000FFFFFF00000000020000000000000000008C1C000006004D656D6F313600
      02001F020000460000002E000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000500BDE1CBE33A00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000002000000000008000000860002
      0000000000FFFFFF00000000020000000000000000001F1D000005004D656D6F
      34000200370000004B0100001401000012000000030000000100000000000000
      0000FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D
      205B54494D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000000000000100020000000000FFFFFF0000000002
      000000000000000000A71D000005004D656D6F360002007D0000005B00000097
      000000120000000100020001000000000000000000FFFFFF1F2E020000000000
      01000B005B53484F505F4E414D455D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000080000008600020000000000
      FFFFFF00000000020000000000000000002E1E000006004D656D6F3137000200
      350000005B00000046000000120000000100000001000000000000000000FFFF
      FF1F2E02000000000001000900B7A2BBF5C3C5B5EA3A00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000200000000000800000086
      00020000000000FFFFFF0000000002000000000000000000C51E000006004D65
      6D6F3139000200B50000002A0100007C00000014000000010000000100000000
      0000000000FFFFFF1F2E02000000000001001900D2B5CEF1D4B1A3BA5B475549
      44455F555345525F544558545D00000000010000000000000200000001000000
      000400CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FFFF
      FF0000000002000000000000000000481F000006004D656D6F32310002001A01
      00005B00000027000000120000000100000001000000000000000000FFFFFF1F
      2E02000000000001000500B1B8D7A23A00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000800000086000200000000
      00FFFFFF0000000002000000000000000000CE1F000006004D656D6F33350002
      00410100005B0000007A010000120000000100020001000000000000000000FF
      FFFF1F2E020000000000010008005B52454D41524B5D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000004A20000006004D65
      6D6F3339000200320200004E010000610000000C000000010002000100000000
      0000000000FFFFFF1F2E020000000000000000000000FFFF0000000000020000
      0001000000000400CBCECCE5000A000000020000000000080000008600020000
      000000FFFFFF000000000200000000000000FEFEFF060000000A002056617269
      61626C6573000000000200736C0014006364735F436867426F64792E22534C30
      303030220002006A650014006364735F436867426F64792E224A453030303022
      0004006B68796800000000040079687A68000000000200647A00000000000000
      0000000000FDFF0100000000}
  end
end
