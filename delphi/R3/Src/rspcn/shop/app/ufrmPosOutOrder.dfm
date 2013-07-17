inherited frmPosOutOrder: TfrmPosOutOrder
  Left = 141
  Top = 95
  Caption = #21830#21697#38144#21806
  ClientHeight = 558
  ClientWidth = 997
  Color = 15461355
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 797
    Height = 511
    inherited webForm: TRzPanel
      Width = 797
      Height = 511
      inherited PageControl: TRzPageControl
        Width = 797
        Height = 511
        FixedDimension = 0
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#24405#20837
          inherited order_input: TRzPanel
            Width = 797
            Height = 147
            inherited RzPanel2: TRzPanel
              Width = 775
              Height = 125
              DesignSize = (
                775
                125)
              inherited RzBorder1: TRzBorder
                Left = 16
                Top = 48
                Width = 743
              end
              inherited lblInput: TRzLabel
                Left = 17
                Top = 11
                Width = 77
                Height = 26
                Font.Height = -19
                LightTextStyle = True
                HighlightColor = clWhite
                ShadowColor = 16250871
              end
              inherited lblHint: TRzLabel
                Left = 325
                Top = 14
                ShadowColor = 16119285
              end
              inherited help: TRzBmpButton
                Left = 743
                Down = True
              end
              inherited barcode: TRzPanel
                Left = 108
                Top = 9
                inherited barcode_input_line: TImage
                  Hint = #25195#30721#25353' pause '#20581
                end
                inherited edtInput: TcxTextEdit
                  Tag = -1
                end
              end
              inherited helpPanel: TRzPanel
                Left = 359
                Top = 54
                Width = 400
                inherited lblModifyUnit: TRzLabel
                  Left = 13
                  Top = 2
                  ShadowColor = 15658734
                end
                inherited lblModifyAmt: TRzLabel
                  Left = 217
                  Top = 55
                  Visible = False
                  ShadowColor = 15658734
                end
                inherited lblModifyPrice: TRzLabel
                  Left = 13
                  Top = 22
                  ShadowColor = 15658734
                end
                object RzLabel7: TRzLabel
                  Tag = 5
                  Left = 148
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel8: TRzLabel
                  Tag = 6
                  Left = 12
                  Top = 43
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel9: TRzLabel
                  Left = 239
                  Top = 44
                  Width = 83
                  Height = 20
                  Caption = #23548' '#36141' '#21592'  [F7] '
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 3092271
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  Visible = False
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel12: TRzLabel
                  Tag = 10
                  Left = 147
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel11: TRzLabel
                  Tag = 9
                  Left = 147
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel10: TRzLabel
                  Left = 187
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel13: TRzLabel
                  Tag = 11
                  Left = 285
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel14: TRzLabel
                  Tag = 12
                  Left = 285
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object RzLabel15: TRzLabel
                  Tag = 13
                  Left = 285
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
                  ShadowColor = 15658734
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
              end
              object RzPanel19: TRzPanel
                Left = 17
                Top = 60
                Width = 323
                Height = 54
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
                  323
                  54)
                object Image5: TImage
                  Left = 5
                  Top = 0
                  Width = 313
                  Height = 54
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
                  Left = 37
                  Top = 18
                  Width = 315
                  Height = 30
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
                  ScrollType = stNone
                end
                object Image3: TImage
                  Left = 0
                  Top = 0
                  Width = 5
                  Height = 54
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
                  Left = 318
                  Top = 0
                  Width = 5
                  Height = 54
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
            Top = 147
            Width = 797
            object edtVBK_SALES_DATE: TRzPanel
              Left = 539
              Top = 1
              Width = 248
              Height = 31
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              FlatColor = 9145227
              TabOrder = 0
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
                Tag = 1
                Left = 105
                Top = 4
                Width = 142
                Height = 23
                Anchors = [akTop, akRight]
                Enabled = False
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Style.Color = clBtnFace
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.ButtonTransparency = ebtHideInactive
                TabOrder = 1
              end
            end
            object edtBK_CLIENT_ID: TRzPanel
              Left = 10
              Top = 1
              Width = 431
              Height = 31
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 1
              object edtBK_CARD_NO: TRzPanel
                Left = 2
                Top = 2
                Width = 185
                Height = 27
                Align = alLeft
                BorderOuter = fsNone
                TabOrder = 3
                object edtCARD_NO: TcxTextEdit
                  Left = 0
                  Top = 2
                  Width = 184
                  Height = 23
                  TabOrder = 0
                  Text = #35831#36755#20837#20250#21592#21345#21495#25110#25163#26426#21495
                  ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                  OnEnter = edtCARD_NOEnter
                  OnKeyPress = edtCARD_NOKeyPress
                end
              end
              object RzPanel21: TRzPanel
                Left = 187
                Top = 2
                Width = 103
                Height = 27
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdLeft, sdRight]
                FlatColor = clGray
                TabOrder = 0
                object RzLabel1: TRzLabel
                  Left = 1
                  Top = 0
                  Width = 101
                  Height = 27
                  Align = alClient
                  Alignment = taCenter
                  Caption = #20250#21592#21517#31216
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
                Left = 291
                Top = 4
                Width = 137
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
                Text = 'sdafadsfads'
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
              object RzPanel10: TRzPanel
                Left = 0
                Top = 2
                Width = 430
                Height = 27
                BorderOuter = fsFlat
                BorderSides = [sdLeft]
                FlatColor = clGray
                TabOrder = 2
                DesignSize = (
                  430
                  27)
                object RzLabel3: TRzLabel
                  Left = 118
                  Top = 3
                  Width = 236
                  Height = 20
                  Caption = '< '#28857#20987#12304#20250#21592#28040#36153#12305#36827#20837#20250#21592#21345#36755#20837#27169#24335
                  Font.Charset = GB2312_CHARSET
                  Font.Color = 8158332
                  Font.Height = -13
                  Font.Name = #24494#36719#38597#40657
                  Font.Style = []
                  ParentFont = False
                  ShadowColor = 16119285
                  ShadowDepth = 1
                  TextStyle = tsShadow
                end
                object intoCustomer: TRzBmpButton
                  Left = 5
                  Top = -1
                  Width = 106
                  Height = 29
                  Bitmaps.TransparentColor = clFuchsia
                  Bitmaps.Up.Data = {
                    76240000424D762400000000000036000000280000006A0000001D0000000100
                    1800000000004024000000000000000000000000000000000000EBEBEBEAEAEA
                    E5E5E5D9D9D9D0D0D0CECECECDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD
                    CDCDCDCDCDCDCECECED0D0D0D9D9D9E5E5E5EAEAEAEBEBEB0000E9E9E9E0E0E0
                    C7C7C7AAAAAA9999999393939292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    9292929292929292929292929292929292929292929292929292929292929292
                    929292929292939393999999AAAAAAC7C7C7E0E0E0E9E9E90000E4E4E4C7C7C7
                    C6C6C6D2D2D2DADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADAD0D0D0B9B9B98A8A8A9C9C9CC5C5C5E4E4E40000DADADAD8D8D8
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADAD3D3D38E8E8EA9A9A9D9D9D90000E1E1E1DFDFDF
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADABBBBBB979797D0D0D00000EAEAEADBDBDB
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADAD5D5D5929292CECECE0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CDCDCD0000EEEEEEDADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA929292CECECE0000EEEEEEDBDBDB
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADA979797D0D0D00000EFEFEFDFDFDF
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADAD6D6D6A9A9A9D9D9D90000EDEDEDE9E9E9
                    DBDBDBDADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADAC6C6C6C5C5C5E4E4E40000EBEBEBEFEFEF
                    E8E8E8E0E0E0DCDCDCDADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                    DADADADADADADADADADADADAD7D7D7CACACAE0E0E0E9E9E90000EBEBEBEBEBEB
                    EAEAEAE6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                    E6E6E6E5E5E5E1E1E1DADADAD9D9D9E5E5E5EAEAEAEBEBEB0000}
                  Color = clBtnFace
                  Anchors = [akTop, akRight]
                  Caption = #20250#21592#28040#36153
                  TabOrder = 0
                  OnClick = intoCustomerClick
                end
              end
            end
          end
          inherited order_grid: TRzPanel
            Top = 179
            Width = 416
            Height = 265
            inherited DBGridEh1: TDBGridEh
              Width = 394
              Height = 243
              FixedColor = 16448239
              FooterColor = 15787416
              FrozenCols = 1
              OnCellClick = DBGridEh1CellClick
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
                  Width = 25
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
                  Width = 191
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
                  Visible = False
                end
                item
                  Alignment = taCenter
                  Color = clWhite
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Alignment = taCenter
                  Title.Caption = #26465#30721
                  Title.Color = 15787416
                  Width = 123
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
                  Width = 23
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
                  Width = 41
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
                  Width = 55
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
                  EditButtons = <>
                  FieldName = 'TOOL_NAV'
                  Footers = <>
                  Title.Alignment = taCenter
                  Title.Caption = #25805#20316
                  Width = 55
                end>
            end
            inherited fndGODS_ID: TzrComboBoxList
              Left = 232
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
            inherited row_order_nav: TToolBar
              Width = 539
              inherited toolDelete: TToolButton
                Caption = #21024
              end
              inherited toolReturn: TToolButton
                Caption = #36864
              end
            end
          end
          inherited order_footer: TRzPanel
            Top = 444
            Width = 797
            Height = 67
            object RzBmpButton1: TRzBmpButton
              Left = 358
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
              Caption = #25346#21333'(F9)'
              TabOrder = 0
              OnClick = RzBmpButton1Click
            end
            object RzBmpButton2: TRzBmpButton
              Left = 438
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
              Caption = #21462#21333'(F10)'
              TabOrder = 1
              OnClick = RzBmpButton2Click
            end
            object edtBK_ACCT_MNY: TRzPanel
              Left = 16
              Top = 18
              Width = 318
              Height = 31
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
                  Caption = #32467#31639#37329#39069
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
            object btnSave: TRzBmpButton
              Left = 428
              Top = 19
              Width = 119
              Height = 29
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                FE280000424DFE280000000000003600000028000000770000001D0000000100
                180000000000C828000000000000000000000000000000000000DEDEDEDEDEDE
                DADADACECECEBEBEBEB0B0B0AAAAAAA8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8
                A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8B6B6B600
                0000DEDEDED8D8D8BEBEBE9797977575755E5E5E565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                5656565656565656565656565656565656565656565656565656565656565656
                56565656717171000000DADADABDBDBD879BA174ACBC72C4DC72CCE672CCE672
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
                72CCE672CCE672CCE672CCE6565656000000CECECE91BBC774C6DE72CCE674CD
                E673CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000BDCDD297D4E5
                7BCFE873CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
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
                0000BFD9E19BD7E978CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
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
                E672CCE6565656000000C3DDE49AD7E978CEE772CCE672CCE672CCE672CCE672
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
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6565656000000C6DFE69CD9EA
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
                0000CEE3E9ABDEED7ACFE772CCE672CCE672CCE672CCE672CCE672CCE672CCE6
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
                E672CCE6565656000000D8E2E5C4E7F193D8EC76CEE772CCE672CCE672CCE672
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
                72CCE672CCE672CCE672CCE6565656000000DEDEDED4E6EBBCE5F1A3DEEF89D4
                EA78CEE772CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE6
                72CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CC
                E672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672CCE672
                CCE672CCE672CCE672CCE672CCE672CCE672CCE6717171000000DEDEDEDEDEDE
                D6E0E3C3E1E9AEDFEDA2DDEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9F
                DCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE
                9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDC
                EE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE9FDCEE72CCE6B6B6B600
                0000}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #25910#38134#32467#36134'(+)'
              TabOrder = 3
              OnClick = btnSaveClick
            end
            object btnNew: TRzBmpButton
              Left = 547
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
              Caption = #28165#31354
              TabOrder = 4
              OnClick = btnNewClick
            end
            object RzBmpButton3: TRzBmpButton
              Left = 645
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
              Caption = #23548#20837
              TabOrder = 5
              OnClick = RzBmpButton3Click
            end
          end
          object RzPanel4: TRzPanel
            Left = 416
            Top = 179
            Width = 381
            Height = 265
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
              Height = 243
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
                Height = 212
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
            Width = 797
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
              Width = 777
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
                777
                37)
              object RzPanel6: TRzPanel
                Left = 298
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
                Left = 705
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
                Width = 279
                Height = 29
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                TabOrder = 2
                DesignSize = (
                  279
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
                  Left = 274
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
                  Width = 268
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
                  Width = 268
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
            Width = 797
            Height = 454
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
              Width = 775
              Height = 432
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
                  Title.Caption = #32467#31639#37329#39069
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
                  Width = 137
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
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsUnderline]
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
                OnClick = RzToolButton4Click
              end
            end
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 997
    inherited lblCaption: TRzLabel
      Width = 701
      Caption = #21830#21697#38144#21806
    end
    inherited RzPanel12: TRzPanel
      Left = 701
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
      Left = 989
      Width = 8
    end
  end
  inherited photoPanel: TRzPanel
    Left = 797
    Height = 511
    inherited adv_photo_left_line: TImage
      Height = 491
    end
    inherited adv_photo_right_line: TImage
      Height = 491
    end
    inherited adv_bottom: TRzPanel
      Top = 501
    end
    inherited RzPanel1: TRzPanel
      Height = 491
      inherited adv02: TImage
        Height = 235
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
    Left = 824
    Top = 192
  end
  inherited dsTable: TDataSource
    Left = 824
    Top = 128
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
    Left = 824
    Top = 224
  end
  inherited PopupMenu1: TPopupMenu
    Left = 856
    Top = 160
  end
  object cdsHeader: TZQuery [7]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 824
    Top = 160
  end
  object cdsDetail: TZQuery [8]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 824
    Top = 256
  end
  object cdsICGlide: TZQuery [9]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 856
    Top = 224
  end
  object dsList: TDataSource [10]
    DataSet = cdsList
    Left = 856
    Top = 96
  end
  object cdsList: TZQuery [11]
    FieldDefs = <>
    BeforeOpen = cdsListBeforeOpen
    CachedUpdates = True
    Params = <>
    Left = 856
    Top = 192
  end
  inherited Timer1: TTimer
    Left = 856
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
    Left = 824
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
    Left = 856
    Top = 259
  end
  object frfSalesOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalesOrderGetValue
    OnUserFunction = frfSalesOrderUserFunction
    Left = 888
    Top = 97
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
  object DelGodsShortCust: TPopupMenu
    Left = 657
    Top = 359
    object DeleteShortCut: TMenuItem
      Caption = #21024#38500
      OnClick = DeleteShortCutClick
    end
  end
end
