inherited frmStockOrder: TfrmStockOrder
  Left = 118
  Top = 115
  Caption = #36827#36135#21333
  ClientWidth = 1065
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited ScrollBox: TScrollBox
    Width = 865
    inherited webForm: TRzPanel
      Width = 865
      inherited PageControl: TRzPageControl
        Width = 865
        ActivePage = TabSheet2
        FixedDimension = 0
        inherited TabSheet1: TRzTabSheet
          Caption = #19994#21153#24405#20837
          inherited order_input: TRzPanel
            Width = 865
            Height = 149
            inherited RzPanel2: TRzPanel
              Width = 845
              Height = 129
              DesignSize = (
                845
                129)
              inherited RzBorder1: TRzBorder
                Width = 807
              end
              inherited barcode_panel_left_line: TImage
                Height = 113
              end
              inherited barcode_panel_right_line: TImage
                Left = 843
                Height = 113
              end
              inherited lblHint: TRzLabel
                Anchors = [akLeft, akTop, akRight]
              end
              object RzLabel1: TRzLabel [8]
                Left = 151
                Top = 54
                Width = 88
                Height = 20
                Caption = #25913#20026#36192#21697'  [F5] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel2: TRzLabel [9]
                Left = 151
                Top = 76
                Width = 83
                Height = 20
                Caption = #20379' '#24212' '#21830'  [F6] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel3: TRzLabel [10]
                Left = 151
                Top = 98
                Width = 83
                Height = 20
                Caption = #25910' '#36135' '#21592'  [F7] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel4: TRzLabel [11]
                Left = 275
                Top = 54
                Width = 62
                Height = 20
                Caption = #28165#23631'  [F8] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel5: TRzLabel [12]
                Left = 275
                Top = 76
                Width = 62
                Height = 20
                Caption = #25346#21333'  [F9] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel12: TRzLabel [13]
                Left = 275
                Top = 98
                Width = 70
                Height = 20
                Caption = #21462#21333'  [F10] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel15: TRzLabel [14]
                Left = 386
                Top = 98
                Width = 95
                Height = 20
                Caption = #20445#23384#21333#25454'  [ +  ] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 6572100
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel14: TRzLabel [15]
                Left = 386
                Top = 76
                Width = 95
                Height = 20
                Caption = #25910#27454#26041#24335'  [ *   ] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 6570814
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              object RzLabel13: TRzLabel [16]
                Left = 386
                Top = 54
                Width = 96
                Height = 20
                Caption = #25972#21333#35843#20215'  [F11] '
                Font.Charset = GB2312_CHARSET
                Font.Color = 3092271
                Font.Height = -13
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                ShadowDepth = 1
                TextStyle = tsShadow
              end
              inherited help: TRzBmpButton
                Left = 813
              end
              inherited barcode_top: TRzPanel
                Width = 845
                inherited barcode_panel_top_right: TImage
                  Left = 835
                end
                inherited barcode_panel_top_line: TImage
                  Width = 816
                end
              end
              inherited barcode_botton: TRzPanel
                Top = 121
                Width = 845
                inherited barcode_panel_bottom_line: TImage
                  Width = 841
                end
                inherited barcodeb_panel_right_line: TImage
                  Left = 843
                end
              end
              inherited barcode: TRzPanel
                inherited edtInput: TcxTextEdit
                  Tag = -1
                  Hint = #25195#30721#25353' pause '#20581
                end
              end
            end
          end
          inherited order_header: TRzPanel
            Top = 149
            Width = 865
            Height = 31
            object customerInfo: TLabel
              Left = 324
              Top = 10
              Width = 302
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
              Width = 318
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground1: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object RzLabel6: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbNew, zbFind]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object edtBK_SALES_DATE: TRzPanel
              Left = 607
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground2: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object RzLabel7: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
              object edtSTOCK_DATE: TcxDateEdit
                Left = 104
                Top = 4
                Width = 142
                Height = 23
                Anchors = [akTop, akRight]
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                TabOrder = 1
              end
            end
          end
          inherited order_grid: TRzPanel
            Top = 180
            Width = 865
            Height = 186
            inherited DBGridEh1: TDBGridEh
              Width = 843
              Height = 164
              FixedColor = 16448239
              FooterColor = 8643839
              FrozenCols = 1
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
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
                  Title.Caption = #36135#21495
                  Title.Color = 15787416
                end
                item
                  EditButtons = <>
                  FieldName = 'BARCODE'
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
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
                  Title.Caption = #21333#20301
                  Title.Color = 15787416
                  Width = 35
                  Control = fndUNIT_ID
                  OnBeforeShowControl = DBGridEh1Columns4BeforeShowControl
                end
                item
                  DisplayFormat = '#0.###'
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.###'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  Title.Caption = #25968#37327
                  Title.Color = 15787416
                  Width = 49
                  OnUpdateData = DBGridEh1Columns5UpdateData
                end
                item
                  DisplayFormat = '#0.00#'
                  EditButtons = <>
                  FieldName = 'APRICE'
                  Footers = <>
                  Title.Caption = #21333#20215
                  Title.Color = 15787416
                  Width = 60
                  OnUpdateData = DBGridEh1Columns6UpdateData
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #37329#39069
                  Title.Color = 15787416
                  Width = 68
                end
                item
                  DisplayFormat = '#00.0%'
                  EditButtons = <>
                  FieldName = 'AGIO_RATE'
                  Footers = <>
                  Title.Caption = #25240#25187
                  Title.Color = 15787416
                  Width = 46
                  OnUpdateData = DBGridEh1Columns8UpdateData
                end
                item
                  DisplayFormat = '#0.00'
                  EditButtons = <>
                  FieldName = 'AGIO_MONEY'
                  Footer.Alignment = taRightJustify
                  Footer.DisplayFormat = '#0.00'
                  Footer.ValueType = fvtSum
                  Footers = <>
                  ReadOnly = True
                  Tag = 1
                  Title.Caption = #35753#21033
                  Title.Color = 15787416
                  Width = 69
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Title.Color = 15787416
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
            Top = 366
            Width = 865
            Height = 109
            inherited footerb_panel_left_line: TImage
              Height = 73
            end
            inherited footerb_panel_right_line: TImage
              Left = 853
              Height = 73
            end
            object Image2: TImage [2]
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
            inherited footer_bottom: TRzPanel
              Top = 91
              Width = 845
              inherited footer_panel_bottom_right: TImage
                Left = 838
              end
              inherited footer_panel_bottom_line: TImage
                Width = 825
              end
            end
            inherited footer_top: TRzPanel
              Width = 845
              inherited footer_panel_top_line: TImage
                Width = 841
              end
              inherited footer_panel_right_line: TImage
                Left = 843
              end
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
              TabOrder = 2
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground3: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object RzLabel8: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Align = alClient
                  Alignment = taCenter
                  Caption = #25910#36135#21592
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
            end
            object edtREMARK: TcxTextEdit
              Left = 18
              Top = 63
              Width = 316
              Height = 23
              TabOrder = 3
              ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
            end
            object edtBK_ACCT_MNY: TRzPanel
              Left = 317
              Top = 18
              Width = 318
              Height = 31
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 4
              object RzLabel9: TRzLabel
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
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground4: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object RzLabel10: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 26
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
                Properties.OnChange = edtACCT_MNYPropertiesChange
                TabOrder = 1
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object edtAGIO_RATE: TcxTextEdit
                Left = 254
                Top = 4
                Width = 47
                Height = 23
                Properties.Alignment.Horz = taRightJustify
                Properties.OnChange = edtAGIO_RATEPropertiesChange
                TabOrder = 2
                Text = '100.0'
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object RzPanel8: TRzPanel
                Left = 217
                Top = 2
                Width = 37
                Height = 27
                BorderOuter = fsGroove
                BorderSides = [sdLeft, sdRight]
                TabOrder = 3
                object RzBackground5: TRzBackground
                  Left = 2
                  Top = 0
                  Width = 33
                  Height = 27
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object RzLabel11: TRzLabel
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
              Left = 317
              Top = 58
              Width = 318
              Height = 35
              Anchors = [akTop, akRight]
              BorderOuter = fsStatus
              BorderWidth = 1
              Color = clWhite
              FlatColor = 9145227
              TabOrder = 5
              DesignSize = (
                318
                35)
              object RzPanel10: TRzPanel
                Left = 2
                Top = 2
                Width = 103
                Height = 31
                Align = alLeft
                BorderOuter = fsFlat
                BorderSides = [sdRight, sdBottom]
                FlatColor = clGray
                TabOrder = 0
                object RzBackground6: TRzBackground
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 30
                  Active = True
                  Align = alClient
                  FrameColor = 9145227
                  GradientColorStart = clWhite
                  GradientColorStop = 14277081
                  ImageStyle = isStretch
                  ShowGradient = True
                  ShowImage = False
                  ShowTexture = False
                end
                object payment: TRzLabel
                  Left = 0
                  Top = 0
                  Width = 102
                  Height = 30
                  Align = alClient
                  Alignment = taCenter
                  Caption = #29616#37329#20184#27454
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
              object edtPAY_TOTAL: TcxTextEdit
                Left = 105
                Top = 6
                Width = 211
                Height = 23
                Anchors = [akTop, akRight]
                ParentFont = False
                Properties.OnChange = edtPAY_TOTALPropertiesChange
                Style.Font.Charset = GB2312_CHARSET
                Style.Font.Color = clMaroon
                Style.Font.Height = -15
                Style.Font.Name = #23435#20307
                Style.Font.Style = [fsBold]
                TabOrder = 1
                Text = '34866.55'
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
            end
            object btnSave: TRzBmpButton
              Left = 642
              Top = 18
              Width = 208
              Height = 81
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                A6C50000424DA6C50000000000003600000028000000D0000000510000000100
                18000000000070C5000000000000000000000000000000000000DEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDBDBDBD5D5D5CFCFCFC7C7C7C6C6C6C8C8C8
                CDCDCDCECECECBCBCBC6C6C6C2C2C2C5C5C5CACACACDCDCDCDCDCDC8C8C8C3C3
                C3C3C3C3C7C7C7CDCDCDCDCDCDCBCBCBC5C5C5C2C2C2C4C4C4C9C9C9CDCDCDCC
                CCCCC7C7C7C3C3C3C3C3C3C8C8C8CDCDCDCDCDCDC8C8C8C4C4C4C3C3C3C6C6C6
                CCCCCCCECECECCCCCCC6C6C6C3C3C3C4C4C4C9C9C9CDCDCDCDCDCDC9C9C9C4C4
                C4C3C3C3C6C6C6CCCCCCCDCDCDCBCBCBC6C6C6C2C2C2C4C4C4C8C8C8CDCDCDCC
                CCCCC7C7C7C3C3C3C3C3C3C8C8C8CDCDCDCDCDCDC9C9C9C4C4C4C2C2C2C6C6C6
                CBCBCBCDCDCDCCCCCCC6C6C6C3C3C3C3C3C3C9C9C9CDCDCDCECECECDCDCDC9C9
                C9CFCFCFD8D8D8E8E8E8DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDADA
                DACFCFCFC2C2C2D1D1D2D5D5D6B7B7B8B8B8B8BABABAB7B7B7C0C0C0D5D5D6C4
                C4C4B6B6B6BABABAB9B9B9BBBBBBCECECFCECECFBCBCBCB9B9B9BABABAB7B7B7
                C4C4C4D3D3D4C8C8C8B8B8B9B9B9B9B7B7B7BDBDBED1D1D2CECECFBBBBBBB9B9
                B9B9B9B9B8B8B8C9C9CAD0D0D1BEBEBEB7B7B7BBBBBBB6B6B6BEBEBFD1D1D2C8
                C8C9B7B7B7B9B9B9B9B9B9B9B9B9CACACBCFCFD0BCBCBDB7B7B7BABABAB8B8B8
                C1C1C2D2D2D3C9C9CAB8B8B8B9B9B9B8B8B8BEBEBECFCFD0CDCDCEBBBBBCB9B9
                B9B9B9B9B9B9B9C8C8C8D2D2D3C2C2C2B6B6B6BABABAB8B8B8BCBCBCD0D0D1CC
                CCCDB5B5B5B9B9B9BBBBBBBABABAC6C6C6DEDEE0C4C4C4CFCFCFDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDED7D7D7C8C8C8B5B5B5F0F0F1F4F4F5C5C5C5
                A1A1A19E9E9EA2A2A2D6D6D7F6F6F7DFDFE0AFAFAF9F9F9F9E9E9EBDBDBEF0F0
                F1F3F3F4C4C4C4A1A1A19E9E9EAAAAABDADADBF6F6F7DDDDDEADADAD9E9E9EA1
                A1A1C7C7C7F3F3F4EBEBECB8B8B89D9D9D9D9D9DB7B7B7E8E8E8F5F5F6C9C9CA
                A3A3A39E9E9EA3A3A3CCCCCDF6F6F7E5E5E6B3B3B49E9E9E9E9E9EB5B5B5E8E8
                E8F6F6F7CECECEA5A5A59E9E9EA5A5A5CECECFF6F6F7E5E5E6B3B3B39C9C9CA0
                A0A0C0C0C1F2F2F3F0F0F1BFBFBF9E9E9E9F9F9FB0B0B0E0E0E0F6F6F7D6D6D6
                A5A5A59E9E9EA1A1A1C6C6C6F4F4F5EBEBECB6B6B79E9E9E9E9E9EB0B0B0E6E6
                E7F4F4F5B7B7B7C8C8C8DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED5D5
                D5C3C3C3ABABABEDEEEDEFF0EFEBECEBA5A5A58A8A8AC1C2C1EAEBEAEFF0EFEE
                EFEEC3C3C38D8D8D9A9A9AD4D5D4EDEEEDEFF0EFDADADA9F9F9F8A8A8AB6B6B6
                E6E7E6EFF0EFECEDECBCBDBC8D8D8D9A9A9AD4D5D4EFF0EFEFF0EFCDCECD9696
                96919191CACACAEFF0EFEFF0EFE3E4E3AEAEAE8A8B8AB2B2B2E7E8E7EFF0EFEF
                F0EFCCCDCC939393979797D0D1D0EFF0EFEFF0EFE1E2E1ACADAC898989ADADAD
                E2E3E2EFF0EFEAEBEAC0C1C08E8E8E9A9A9AD3D4D3EFF0EFEEEFEED3D4D39A9A
                9A8D8D8DC0C1C0EDEEEDEFF0EFE8E9E8B8B9B88A8A8AA5A5A5E8E9E8EFF0EFEE
                EFEEDADBDA9D9D9D8E8F8ED4D5D4EFF0EFEEEFEEACACACC3C3C3DEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDED4D4D4C0C0C0A4A4A4E3E3E2E5E5E4E5E5E4
                D9D9D8CCCCCCDCDCDBE4E4E3E5E5E4E5E5E4DFDFDECFCFCED3D3D2E1E1E0E5E5
                E4E5E5E4E1E1E0D4D4D3CFCFCEDADAD9E4E4E3E5E5E4E5E5E4DADAD9CECECDD2
                D2D1DFDFDFE5E5E4E5E5E4DEDEDED2D2D1D0D0CFDDDDDCE5E5E4E5E5E4E3E3E2
                D7D7D6CFCFCED8D8D7E4E4E3E5E5E4E5E5E4DFDFDED1D1D0D1D1D0DFDFDEE5E5
                E4E5E5E4E1E1E0D4D4D3CECECDD9D9D8E4E4E3E5E5E4E4E4E3DADAD9CFCFCED3
                D3D2E0E0DFE5E5E4E4E4E3DEDEDDD0D0CFCFCFCEDDDDDCE5E5E4E5E5E4E4E4E3
                D9D9D8CECECDD4D4D4E3E3E2E5E5E4E5E5E4E3E3E2D7D7D6CBCBCAE3E3E2E5E5
                E4E3E3E2A5A5A5C0C0C0DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED4D4
                D4C0C0C0A1A1A1D2D2D0D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4
                D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2
                D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4
                D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4
                D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2
                D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4
                D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4
                D4D2D4D4D2D4D4D2D4D4D2D4D4D2D4D4D2D2D2D0A1A1A1C0C0C0DEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDED4D4D4C0C0C0A1A1A1BABAB9BBBBBABBBBBA
                BBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBB
                BABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABB
                BBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBA
                BBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBB
                BABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABB
                BBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBA
                BBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBBBABBBB
                BABABAB9A1A1A1C0C0C0DCDCDCDADADAD4D4D4D2D2D2D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D2D2D2D4D4D4DADADADCDCDCDEDEDED4D4
                D4C0C0C0A1A1A19999989A9A999A9A999A9A999A9A999A9A999A9A999A9A999A
                9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A99
                9A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A
                999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A
                9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A99
                9A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A
                999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A9A999A
                9A999A9A999A9A999A9A999A9A999A9A99999998A1A1A1C0C0C0DADADAD0D0D0
                C2C2C2B9B9B9B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B9
                B9B9C2C2C2D0D0D0DADADADEDEDED4D4D4C0C0C0A1A1A1787877787877787877
                7878777878777878777878777878777878777878777878777878777878777878
                7778787778787778787778787778787778787778787778787778787778787778
                7877787877787877787877787877787877787877787877787877787877787877
                7878777878777878777878777878777878777878777878777878777878777878
                7778787778787778787778787778787778787778787778787778787778787778
                7877787877787877787877787877787877787877787877787877787877787877
                7878777878777878777878777878777878777878777878777878777878777878
                77787877A1A1A1C0C0C0D4D4D4D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D8D8D8A6A6A6C2C2C2D4D4D4DEDEDED5D5
                D5C2C2C2A5A5A55F5F5E5C5C5B5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B
                5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A
                5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B
                5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B
                5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A
                5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B
                5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B5B5A5B
                5B5A5B5B5A5B5B5A5B5B5A5B5B5A5C5C5B5F5F5EA5A5A5C2C2C2D2D2D2D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D8
                D8D8949494B9B9B9D2D2D2DEDEDED6D6D6C6C6C6ADADAD444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                4444444444444444444444444444444444444444444444444444444444444444
                44444444ADADADC6C6C6D0D0D0DADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADAD8D8D88A8A8AB4B4B4D0D0D0DEDEDED8D8
                D8CBCBCBB9B9B91A1A1A02020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202060606111111B9B9B9CBCBCBD0D0D0DBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBD9
                D9D98A8A8AB4B4B4D0D0D0DEDEDEDBDBDBD3D3D38B8B8B353535323232404040
                3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F
                3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F
                3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F
                3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F
                3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F
                3F3F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F
                3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F3F3F3F3F3F3F4040403737
                37141414C7C7C7D3D3D3D0D0D0DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBD9D9D98A8A8AB4B4B4D0D0D0DEDEDEDCDC
                DCD8D8D89494943B3B3B5353533E3E3E5252525252525252525252525252523D
                3D3D5252523D3D3D5252525252525252525252525252523D3D3D5252523D3D3D
                5252525252525252525252525252523D3D3D5252523D3D3D5252525252525252
                525252525252523D3D3D5252523D3D3D5252525252525252525252525252523D
                3D3D5252523D3D3D5252525252525252525252525252523D3D3D5252523D3D3D
                5252525252525252525252525252523D3D3D5252523D3D3D5252525252525252
                525252525252523D3D3D5252523D3D3D5252525252525252525252525252523D
                3D3D5252523D3D3D5252525252525151510B0B0BD3D3D3D8D8D8D0D0D0DCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDA
                DADA8A8A8AB4B4B4D0D0D0DEDEDEDDDDDDDCDCDC9C9C9C424242646464646464
                6464636464636464636464636464636464636464636464636464636464636464
                6364646364646364646364646364646364646364646364646364646364646364
                6463646463646463646463646463646463646463646463646463646463646463
                6464636464636464636464636464636464636464636464636464636464636464
                6364646364646364646364646364646364646364646364646364646364646364
                6463646463646463646463646463646463646463646463646463646463646463
                6464636464636464636464636464636464636464636464636464636464646464
                630E0E0EDBDBDBDCDCDCD0D0D0DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDBDBDB8A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEA0A0A048484871717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171717171717171717171717171717171717171
                7171717171717171717171717171707070151515DEDEDEDEDEDED0D0D0DEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEE0E0E0E4E4E4DEDEDEDEDEDEDEDEDEF5F5F5E0E0E0DEDEDEDEDEDEDEDE
                DEDEDEDEE6E6E6E6E6E6E4E4E4DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEE2E2E2EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE2E2E2DEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDC
                DCDC8A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEA3A3A34C4C4C787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787878
                7878787878787878787878787878787878787878787878787878787878787777
                771B1B1BDEDEDEDEDEDED0D0D0DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD1D1D1C0C0C0FFFFFFE3E3E3DFDFDF46
                4646EFEFEFE7E7E7DFDFDFDFDFDFDFDFDFB0B0B0BFBFBFCFCFCFFFFFFFEDEDED
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFC3C3C377777780
                8080808080808080808080808080808080808080808080808080808080808080
                808080DFDFDFF1F1F1DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDDDDDD8A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEA5A5A55151517D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
                7D7D7D7D7D7D7D7D7D7D7D7D7D7D7C7C7C232323DEDEDEDEDEDED0D0D0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                7E7E7E000000DCDCDCF3F3F3E0E0E0000000BFBFBFE8E8E8E0E0E0E0E0E08C8C
                8C0000000000000000008B8B8BEFEFEFE0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E07E7E7E0000000000000000000000000000000000000000
                00000000000000000000000000000000000000626262E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0DE
                DEDE8A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEA8A8A8565656818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818080
                802B2B2BDEDEDEDEDEDED0D0D0E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1D3D3D31C1C1C595959FFFFFFE5E5E500
                0000BFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080F0F0F0
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1A9A9A9000000FFFFFFE1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DFDFDF8A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEABABAB5B5B5B85858563636385858585858585858585858585858563
                6363858585636363858585858585858585858585858585636363858585636363
                8585858585858585858585858585856363638585856363638585858585858585
                8585858585858563636385858563636385858585858585858585858585858563
                6363858585636363858585858585858585858585858585636363858585636363
                8585858585858585858585858585856363638585856363638585858585858585
                8585858585858563636385858563636385858585858585858585858585858563
                6363858585636363858585858585848484343434DEDEDEDEDEDED0D0D0E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E38E8E8E000000DDDDDDEFEFEF0000000000000000000000000000000000
                000000000000000000007C7C7CF1F1F1E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3AAAAAA0000
                00FFFFFFE3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E1
                E1E18A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEADADAD616161676767898989
                8989898989898989898989898989898989896767678989898989898989898989
                8989898989898989898967676789898989898989898989898989898989898989
                8989676767898989898989898989898989898989898989898989676767898989
                8989898989898989898989898989898989896767678989898989898989898989
                8989898989898989898967676789898989898989898989898989898989898989
                8989676767898989898989898989898989898989898989898989676767898989
                8989898989898989898989898989898989896767678989898989898989898888
                883E3E3EDEDEDEDEDEDED0D0D0E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E40E0E0E898989F8F8F800
                0000BFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040808080F1F1F1
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4ABABAB000000FFFFFFE4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E3E3E38A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEB1B1B16767678C8C8C6969698C8C8C8C8C8C8C8C8C8C8C8C8C8C8C69
                69698C8C8C6969698C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6969698C8C8C696969
                8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6969698C8C8C6969698C8C8C8C8C8C8C8C
                8C8C8C8C8C8C8C6969698C8C8C6969698C8C8C8C8C8C8C8C8C8C8C8C8C8C8C69
                69698C8C8C6969698C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6969698C8C8C696969
                8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C6969698C8C8C6969698C8C8C8C8C8C8C8C
                8C8C8C8C8C8C8C6969698C8C8C6969698C8C8C8C8C8C8C8C8C8C8C8C8C8C8C69
                69698C8C8C6969698C8C8C8C8C8C8B8B8B4A4A4ADEDEDEDEDEDED0D0D0E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E55656563B3B3BFDFDFD0000000000000000000000000000000000
                000000000000000000007D7D7DF2F2F2E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5EDEDEDE8E8E8FDFDFDFFFFFFFFFFFFBFBFBF0000
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8EAEAEAEFEFEFE5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E58A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEB3B3B36C6C6C8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8D
                8D545454DEDEDEDEDEDED0D0D0E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E69E9E9E0E0E0EE6E6E600
                00009E9E9EBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF303030808080EEEEEE
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E69E9E9EDDDDDD10
                10100000000000000000000000000000000000000000000000000000003B3B3B
                C1C1C19E9E9EF9F9F9E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E68A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEB7B7B77272728E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8D8D606060DEDEDEDEDEDED0D0D0E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E9E9E9F9F9F9ECECEC0F0F0F0000000000000000000000000000
                00000000000000000000A3A3A3ECECECE7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E70E0E0E0F0F0F5B5B5BBFBFBFB9B9B9AFAFAFADADADADAD
                ADADADADADADADADADADADADADA3A3A31010103F3F3FE9E9E9E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E5
                E5E58A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEBABABA7777778E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E
                8E6B6B6BDEDEDEDEDEDED0D0D0E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9DBDBDB3F3F3FCDCDCDC0C0C0BE
                BEBEBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCFCFCFFFFFFF
                EDEDEDE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9DADADA7A7A7A00
                00004A4A4AEEEEEEFBFBFBEAEAEAE9E9E9E9E9E9E9E9E9E9E9E9B6B6B6101010
                2F2F2FE2E2E2EAEAEAE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E7E7E78A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEBDBDBD7E7E7E90909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090777777DEDEDEDEDEDED0D0D0EAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                DBDBDB2D2D2D1F1F1FCECECE0F0F0F0000000000000000000000000000000000
                00000000000000000000000000BFBFBFEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEA8383839C9C9CC6C6C60F0F0F2D2D2DEEEEEEF7F7F7EAEA
                EAEAEAEAEDEDED8C8C8C0000004D4D4D929292EEEEEEF6F6F6EAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE8
                E8E88A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEC0C0C0858585909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                90818181DEDEDEDEDEDED0D0D0EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBB0B0B04A4A4ADCDCDCEBEBEBEFEFEFBF
                BFBFBBBBBBBBBBBBBBBBBB0000008F8F8FBCBCBCBBBBBBBBBBBBEAEAEAF1F1F1
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB3B3B3B7D7D7DF5
                F5F5BFBFBF0F0F0F5B5B5BFAFAFAEBEBEBCECECE3D3D3D000000787878EBEBEB
                0F0F0F6C6C6CFEFEFEEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBE9E9E98A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEC3C3C38C8C8C9090906C6C6C9090909090909090909090909090906C
                6C6C9090906C6C6C9090909090909090909090909090906C6C6C9090906C6C6C
                9090909090909090909090909090906C6C6C9090906C6C6C9090909090909090
                909090909090906C6C6C9090906C6C6C9090909090909090909090909090906C
                6C6C9090906C6C6C9090909090909090909090909090906C6C6C9090906C6C6C
                9090909090909090909090909090906C6C6C9090906C6C6C9090909090909090
                909090909090906C6C6C9090906C6C6C9090909090909090909090909090906C
                6C6C9090906C6C6C9090909090909090908B8B8BDEDEDEDEDEDED0D0D0ECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECC9C9C9FEFEFE3C3C3C3C3C3C3C3C3C3C3C3C0000003030
                303D3D3D3C3C3C3C3C3CA5A5A5F0F0F0ECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECEC3B3B3B7C7C7CFEFEFEFAFAFA9C9C9C3F3F3FFAFAFAFAFA
                FA8C8C8C2F2F2FBBBBBBFAFAFAFAFAFA7D7D7D101010FFFFFFECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEA
                EAEA8A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDEC6C6C69393936D6D6D929292
                9292929292929292929292929292929292926D6D6D9292929292929292929292
                929292929292929292926D6D6D92929292929292929292929292929292929292
                92926D6D6D9292929292929292929292929292929292929292926D6D6D929292
                9292929292929292929292929292929292926D6D6D9292929292929292929292
                929292929292929292926D6D6D92929292929292929292929292929292929292
                92926D6D6D9292929292929292929292929292929292929292926D6D6D929292
                9292929292929292929292929292929292926D6D6D9292929292929292929292
                92959595DEDEDEDEDEDED0D0D0EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED5E5E5E101010D2D2D2B7
                B7B7BBBBBBBBBBBBBBBBBB0000008F8F8FBDBDBDBBBBBBBBBBBBCBCBCBF9F9F9
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED6868680F0F0F3E
                3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E4040403E3E3E3E3E3E3E3E3E3E3E3E
                1F1F1F000000F3F3F3EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEBEBEB8A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDECACACA9B9B9B9393936E6E6E9393939393939393939393939393936E
                6E6E9393936E6E6E9393939393939393939393939393936E6E6E9393936E6E6E
                9393939393939393939393939393936E6E6E9393936E6E6E9393939393939393
                939393939393936E6E6E9393936E6E6E9393939393939393939393939393936E
                6E6E9393936E6E6E9393939393939393939393939393936E6E6E9393936E6E6E
                9393939393939393939393939393936E6E6E9393936E6E6E9393939393939393
                939393939393936E6E6E9393936E6E6E9393939393939393939393939393936E
                6E6E9393936E6E6E9393939393939393939F9F9FDEDEDEDEDEDED0D0D0EFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEF4B4B4B0F0F0FC4C4C49595953C3C3C3C3C3C3C3C3C3C3C3C0000003030
                303D3D3D3C3C3C3C3C3C4B4B4BEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFE0E0E07878787878787878787878787878784B4B4B0000
                006F6F6F787878787878787878787878787878A4A4A4EFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFED
                EDED8A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDECDCDCDA2A2A2969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                9696969696969696969696969696969696969696969696969696969696969696
                96A9A9A9DEDEDEDEDEDED0D0D0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0A5A5A5D2D2D2F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F01E1E1EC3C3C3F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F06969692E2E2EF3F3F3F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EEEEEE8A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDED0D0D0AAAAAA98989898989898989898989898989898989898989898
                9898989898989898989898989898989898989898989898989898989898989898
                9898989898989898989898989898989898989898989898989898989898989898
                9898989898989898989898989898989898989898989898989898989898989896
                9696989898989898989898989898989898989898989898989898989898969696
                8F8F8F9696969898989898989898989898989898989898989898989898989898
                9898989898989898989898989898989898989898989898989898989898989898
                9898989898989898989898989898989898B3B3B3DEDEDEDEDEDED0D0D0F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1C4C4C4C4C4
                C4F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1EF
                EFEF8A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDED3D3D3B1B1B19B9B9B9B9B9B
                9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
                9B9B9B9B8F8F8F8888888F8F8F9B9B9B9B9B9B9B9B9B9898988B8B8B8383837C
                7C7C7E7E7E8585859292929B9B9B9B9B9B9090908383837C7C7C808080878787
                9393939B9B9B9B9B9B9494948181817C7C7C8181819393939B9B9B9B9B9B9B9B
                9B9B9B9B9393938F8F8F8C8C8C7C7C7C7C7C7C7C7C7C8C8C8C9B9B9B9B9B9B9B
                9B9B9393938C8C8C9393939B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
                9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B
                9BBBBBBBDEDEDEDEDEDED0D0D0F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F0F0F08A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDED6D6D6B8B8B89F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
                9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F8585857E7E7E7E7E7E7E7E7E858585
                9F9F9F9C9C9C8181817E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E8F8F8F8989
                897E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E8989899F9F9F8484847E7E7E7E
                7E7E7E7E7E7E7E7E8989899A9A9A9191917E7E7E7E7E7E7E7E7E7E7E7E7E7E7E
                7E7E7E7E7E7E7E7E7E9393939797978484847E7E7E7E7E7E7E7E7E8989899F9F
                9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F
                9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9FC4C4C4DEDEDEDEDEDED0D0D0F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F1
                F1F18A8A8AB4B4B4D0D0D0DEDEDEDEDEDEDEDEDED8D8D8BFBFBFA2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A29292
                9281818181818181818181818181818187878791919181818181818181818181
                8181818181818181818181818181818181818181818181818181818181818181
                81818181818197979781818181818179797D8181818181818181818282828181
                8181818181818181818181818181818159597081818181818181818187878781
                8181818181818181818181818181909090A1A1A1A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2CCCCCCDEDEDEDEDEDED0D0D0F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F2F2F28A8A8AB4B4B4D0D0D0DEDEDEDEDE
                DEDEDEDEDBDBDBC5C5C5A6A6A67C7C7CA6A6A6A6A6A6A6A6A6A6A6A6A6A6A67C
                7C7CA6A6A67C7C7CA6A6A6A3A3A3848484848484848484323262848484848484
                84848484848484848484848422215A0100510908585B5B758484848484848484
                8484848443426901005111115B43426D8484848484849393938484848484843B
                3A63434268848484848484848484848484848484636376535271848484636377
                0100526B6B7B8484848484848484848484847C7C8043426A8484848484848484
                848686869A9A9A7C7C7CA6A6A67C7C7CA6A6A6A6A6A6A6A6A6A6A6A6A6A6A67C
                7C7CA6A6A67C7C7CA6A6A6A6A6A6A7A7A7D4D4D4DEDEDEDEDEDED0D0D0F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F3
                F3F38B8B8BB5B5B5D1D1D1DEDEDEDEDEDEDEDEDEDDDDDDCBCBCB7F7F7FAAAAAA
                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7F7F7FAAAAAAAAAAAA9B9B9B8888
                888888885E5D76030053464470807F8588888888888888888888888824225D03
                005403005824226446446E46446C46446B46446B24225D030053030058242264
                88888888888891919188888888888888888824225B1C1A5B807F858888888888
                88807F840B095503005746447035336903005603005846447188888888888888
                88883D3C6A0300565655768888888888888888888A8A8AAAAAAA7F7F7FAAAAAA
                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7F7F7FAAAAAAAAAAAAAAAAAAABAB
                ABDBDBDBDEDEDEDEDEDED0D0D0F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5EFEFEF909090B8B8B8D2D2D2DEDEDEDEDE
                DEDEDEDEDFDFDFD1D1D2AEAEAF828283AEAEAFAEAEAFAEAEAFAEAEAFAEAEAF82
                8283AEAEAF828283AEAEAF9191918B8B8B8B8B8B2E2C6405005705005A0D095E
                504E768B8B8B8B8B8B8B8B8B27236205005805005C4846738B8B8B8B8B8B8B8B
                8B8B8B8B48466E05005605005B2723688B8B8B8B8B8B9494949494958B8B8B8B
                8B8B7A7A840C09551E1A608382888B8B8B59577705005805005A16115F050056
                05005805005C05005D27236783828869687E05005905005C05005D2F2C6B7271
                828B8B8B8B8B8B858586AEAEAF828283AEAEAFAEAEAFAEAEAFAEAEAFAEAEAF82
                8283AEAEAF828283AEAEAFAEAEAFAFAFB0E2E2E2DEDEDEDEDEDED0D0D0F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6DF
                DFDF989898BEBEBED4D4D4DEDEDEDEDEDEDEDEDEE1E1E1D8D8D8B2B2B3B2B2B3
                B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B0B0B18F8F8F8F8F
                8F86868B06005406005706005907005A07005B211B657574858F8F8F28246707
                005D0700604B48778F8F8F8F8F8F8F8F8F8F8F8F4B487206005A07005F29246C
                8F8F8F8F8F8F9898989393938F8F8F8F8F8F8F8F8F4B487307005A322D6D8686
                8C18126207005C10095F6D6B8153507606005907005E10096307005D0F095C21
                1B6407005F07006107006007005D423F708F8F8F8F8F8F9E9E9FB2B2B3B2B2B3
                B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B2B2B3B3B3
                B4E9E9E9DEDEDEDEDEDED0D0D0F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7AFAFAFAAAAAAC7C7C7D8D8D8DEDEDEDEDE
                DEDEDEDEE3E3E3DDDDDDB7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
                B7B7B7B7B7B7B7B7B7B7B799999993939393939382818B706E845F5C7E4E4A78
                2B256911095E08005A56527A2B256A0900610900644E4A7B9393939393939393
                939393934E4A7608005D0900632C25709393939393939C9C9C93939393939382
                818C82818C82818D090061090062342E721A126645417582818C939393706E85
                08005C0900622C2570939393706E8508005C090063090064120963706E859393
                93939393939393ABABABB7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7
                B7B7B7B7B7B7B7B7B7B7B7B7B7B7B8B8B8EEEEEEDEDEDEDEDEDED2D2D2F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7C9C9C9A5
                A5A5BDBDBDD2D2D2DBDBDBDEDEDEDEDEDEDEDEDEE5E5E5E1E1E1BBBBBBBBBBBB
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBAFAFAF9898
                98989898989898514C7B5A5581989898989898989898868591635F811C13650A
                00650B0069524C80989898989898989898989898514C7B0A00630B00682E2675
                989898989898A1A1A1989898989898514C7A0A00621D136E261D710B0067524C
                807D7B8E373074524C7F8F8E9574728A0A00610B00672E26759898986B68860A
                00620B0067261D6F8F8E94989898989898989898A1A1A1BBBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBCBC
                BCF3F3F3DEDEDEDEDEDED4D4D4F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F7F7F7F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F8F8F8F8F8F8F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F0F0F0DFDFDFBABABAADADADBDBDBDCECECED9D9D9DDDDDDDEDEDEDEDE
                DEDEDEDEE6E6E6E5E6E6BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BF
                C0C0BFC0C0BFC0C0BFC0C0BCBDBD9C9C9C9C9C9C9C9C9C1F146B0D006B433B7F
                817F939C9C9C9C9C9C9C9C9C3127730D00690E006C554E849C9C9C9C9C9C9C9C
                9C9C9C9C554E810D00690E006E32277A9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C54
                4E7F0D00670E006D4C45810D006A3227787875900D00680E006C78759078758E
                0D00660E006C32277A9C9C9C554E800D0068160A6D8A88959C9C9C9C9C9C9C9C
                9CB0B1B1BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BFC0C0BF
                C0C0BFC0C0BFC0C0BFC0C0BFC0C0C0C1C1F7F7F7DEDEDEDEDEDEDADADAD0D0D0
                C2C2C2B9B9B9B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B5B5B5B9B9B9BFBFBFC7C7C7D2
                D2D2D9D9D9DDDDDDDEDEDEDEDEDEDEDEDEDEDEDEE9E9E9E6E6E6C4C4C5C4C4C5
                C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5B9B9B9A0A0
                A0A0A0A0726E8D0E00670F006C10007110007233287B7C7893A0A0A03328780F
                006B0F006C3328785750845750835750835750833328750F006D1000710F0070
                585087A0A0A0A0A0A0A0A0A0A0A0A05750830F006B100072615A8B0F006E2214
                777C78940F006D1000717C78947C78920F006A10007134287EA0A0A03C327A0F
                006C7C7893A0A0A0A0A0A0A1A1A1BABABAC4C4C5C4C4C5C4C4C5C4C4C5C4C4C5
                C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C4C4C5C5C5
                C6FBFBFBDEDEDEDEDEDEDCDCDCDADADAD4D4D4D2D2D2D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D1D1D1D2D2D2D5D5D5D9D9D9DBDBDBDDDDDDDEDEDEDEDEDEDEDEDEDEDE
                DEE0E0E0FAFAFAD8D8D8C8C8C9969697C8C8C9C8C8C9C8C8C9C8C8C9C8C8C996
                9697C8C8C9969697C8C8C9BFBFC0A5A5A5A5A5A5807C95483E7F11006B1B0A74
                37298137297F11006D3F347D3F347D493E816D678F92909EA5A5A5A5A5A5A5A5
                A5A5A5A536297811006E1200702D1F79777193A5A5A5A5A5A5A5A5A5A5A5A55B
                5387120070130077807C99120072120076807C99120072120076807C99807C98
                120070120076382983A5A5A536297D403481A5A5A5A5A5A5A5A5A5A5A5A5A5A5
                A5A9A9A9BEBEBE969697C8C8C9969697C8C8C9C8C8C9C8C8C9C8C8C9C8C8C996
                9697C8C8C9969697C8C8C9C8C8C9C9C9CAFDFDFDDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEE3E3E3EEEEEEE7E7E8CCCCCD99999ACCCCCD
                CCCCCDCCCCCDCCCCCDCCCCCDCCCCCDCCCCCD99999ACCCCCDCCCCCDCBCBCCA9A9
                A9A9A9A9A9A9A9A9A9A9554A88140072716997A9A9A9A9A9A9A9A9A9A9A9A9A9
                A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9847F9B4C40878D899FA9A9A9
                A9A9A9A9A9A9A9A9A9A9A9A9A9A9A95E558C14007516007C847F9D1500771500
                7B847F9D15007715007B847F9D847F9C15007615007B3B2A88A9A9A927157B96
                94A2A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9ADADADCCCCCD99999ACCCCCD
                CCCCCDCCCCCDCCCCCDCCCCCDCCCCCDCCCCCD99999ACCCCCDCCCCCDCCCCCDCDCD
                CEFEFEFEDEDEDEDEDEDEDEDEDEE4E4E4F1F1F1F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F4F4F4F7F8
                F8E7E8E8D4D5D5D0D1D1D0D1D19C9D9DD0D1D1D0D1D1D0D1D1D0D1D1D0D1D19C
                9D9DD0D1D19C9D9DD0D1D1C3C3C3AEAEAEAEAEAE9B98A7A5A3ABA5A3AB200B7D
                210B80928DA6AEAEAEAEAEAE918DA388829F88829F88829F8882A08882A18882
                A28882A28882A18882A18882A28882A2928DA4AEAEAEAEAEAEAEAEAEAEAEAE62
                579117007A1900818882A218007D1800808882A218007D1800806C629A6C6298
                17007B18008135218B8882A22A167F8882A08882A08882A18882A28882A29B98
                A7AEAEAEAEAEAE9E9F9FD0D1D19C9D9DD0D1D1D0D1D1D0D1D1D0D1D1D0D1D19C
                9D9DD0D1D19C9D9DD0D1D1D0D1D1D1D2D2FFFFFFDEDEDEDEDEDEDEDEDEEEEEEE
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E2E2E3DDDDDDD4D4D5D4D4D5D4D4D5D4D4D5D4D4D5
                D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5BEBEBEB4B4
                B4B4B4B453448F4A3892AAA9B1675A9C1A00842E178DAAA9B1B4B4B49792A98D
                87A48D87A48D87A43522841A00821B008855449870659D18007C19007F230B83
                79709FB4B4B4B4B4B4B4B4B4B4B4B4665A9619007F1A00868D87A81A00811A00
                858D87A81A00811A008570659F70659C19007E1A00853822908D87A88D87A68D
                87A53F2D8618007B190080362289A09DADB4B4B4B4B4B4D0D0D1D4D4D5D4D4D5
                D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4D5D4D4
                D5FEFEFEDEDEDEDEDEDEDEDEDEEAEAEAD8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8BBBBBBBABABABABABA250C821C00871E008C442F96
                1D00871D008A6352A0BABABABABABABABABABABABABABABA422F8C1C00861E00
                8D6C5DA3BABABA4C3A90382388A6A3B2BABABABABABABABABABABABABABABA6A
                5D9B1C00831D008B938BAE1C00861D008A938BAE1C00861D008A938BAE928BAC
                1C00821D008A321793A6A3B4BABABABABABAB0AEB6240C80605298BABABABABA
                BABABABABDBDBDD8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8
                D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8D8FDFDFDDEDEDEDEDEDEDEDEDEE7E7E7
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDB
                DCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDB
                DBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDC
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDB
                DCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDB
                DBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDC
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDB
                DCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDB
                DBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDC
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDB
                DCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDB
                DBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDC
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCD6D6D7C1C1C1C1C1
                C1A29DB41C007F1D00873D249747309932188D1E00891F00909891B5C1C1C1C1
                C1C1C1C1C1C1C1C14530921E008C2000927061A9C1C1C1B7B5BDC1C1C1C1C1C1
                C1C1C1C1C1C1C4C4C4C1C1C1C1C1C16F61A11E00881F00909891B41E008B1F00
                8F9891B51E008C1F00909891B49891B21D00871F008F341898290C917061A7C1
                C1C1C1C1C1B7B5BDC1C1C1C1C1C1C1C1C1C1C1C1D3D3D4DBDBDCDBDBDCDBDBDC
                DBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDBDCDBDB
                DCFBFBFBDEDEDEDEDEDEDEDEDEE3E3E3DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDF
                DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDE
                DFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDF
                DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDE
                DFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDF
                DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDE
                DFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDF
                DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDE
                DFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFC8C8C8C7C7C7C7C7C79D95B61F00866A57A8C7C7C7
                887CB020008A21008E3619977464AAC7C7C7C7C7C7C7C7C74A32992100912300
                977564AFC7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C773
                64A620008D2200959E95BA21008E2100919E95BA2100912200959E95BA9D95B8
                20008B2200944C32A37464AC20008B40259AA8A2BEC7C7C7C7C7C7C7C7C7CACA
                CAD7D7D8DEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFDE
                DEDFDEDEDFDEDEDFDEDEDFDEDEDFDEDEDFF7F7F7DEDEDEDEDEDEDEDEDEDFDFDF
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DADADACECE
                CECECECECECECE4C349922008F998DBDC3C1CA22008D57419F6D5AA8988DB9A3
                9ABDA39ABDA39ABD42279923009525009B644EAEA39ABFA39ABEA39ABEA39AC0
                A39AC0B8B4C6CECECECECECECECECE7767AB220090240099A39AC022008F2200
                8E634EA7230092240099A39AC0A39ABE22008F2400984F34A8CECECE371A9322
                008F2F0D9B998DBECECECECECECECECECED0D0D0E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1F3F3F3DEDEDEDEDEDEDEDEDEDBDBDBE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAAB
                E3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3
                E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAAB
                E3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3
                E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAAB
                E3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3
                E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAAB
                E3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3
                E4E3E3E4E3E3E4AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4DBDBDCD4D4D4D4D4D49184B823008F310D9E
                C9C7D1C9C7D0D4D4D4B2ACC6A79FC1A79FC1A79FC1A79FC144289B2500982700
                9F6850B2A89FC44F359F230090250096300D9AA89FC3D4D4D4D4D4D4D4D4D47B
                6AB024009426009DBEB9CD7C6AB39184B98677B624009526009CA89FC6A89FC4
                24009426009C5235ACD4D4D49184B923008E25009826009D725DB5BEB9CCD4D4
                D4D4D4D4E1E1E2AAAAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4E3E3E4E3E3E4AA
                AAABE3E3E4AAAAABE3E3E4E3E3E4E3E3E4EEEEEEDEDEDEDEDEDEDEDEDED7D7D7
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4
                E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4
                E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4
                E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4
                E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4
                E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4
                E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4
                E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4
                E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E3E3
                E4DBDBDBDBDBDBCFCDD624009127009C6145B4DBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDB5237A327009B2900A3826EBFDBDBDBD0CDD62F0E935237A4
                C4C0D2DBDBDBDBDBDBDBDBDBDBDBDB806EB525009527009BDBDBDBDBDBDBDBDB
                DBADA4C926009828009F8C7BC1AEA4CA26009828009F5637B1DBDBDBDBDBDB3B
                1B992500952600993D1B9FADA4C8DBDBDBDBDBDBE2E2E2E4E4E5ABABACE4E4E5
                E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5E4E4E5ABABACE4E4E5E4E4E5E4E4E5E4E4
                E5E9E9E9DEDEDEDEDEDEDEDEDED2D2D2E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACAD
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACAD
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACAD
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACAD
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E2E2E2E1E1E1E1E1E1492AA128009B
                2900A08571C1D5D3DDE1E1E1E1E1E1E1E1E1E1E1E1E1E1E15538A628009B2900
                A17A63BDE1E1E1E1E1E1C9C5D7E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E183
                71B82600925538A78471BA8371B98371B95538A627009628009B3E1CA2B2A9CE
                27009729009E4C2AAEE1E1E1E1E1E18E7EBE3D1C9B9B8CC3E1E1E1E1E1E1E1E1
                E1E1E1E1E6E6E7ACACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E6E6E7E6E6E7AC
                ACADE6E6E7ACACADE6E6E7E6E6E7E6E6E7E2E2E2DEDEDEDEDEDEDEDEDECECECE
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E6E6E6E6E6E6E6E6E66E57B2270096280098573AAAB6ACD1E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6563AA72700962800982800989281C3E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E7E7E7E6E6E6E6E6E6CEC9DBDAD8E1E6E6E6E6E6E6E6E6E6E6E6
                E6DAD8E14A2BA19E8FC7E6E6E6B6ACD12600932800982800996448B0E6E6E6DA
                D8E1E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7DBDBDBDEDEDEDEDEDEDEDEDEC9C9C9E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E9E9E9EBEBEBEBEBEBBAB0D4BAB0D4
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBE9E9E9EBEBEBEBEBEBC6BFDABAB0D4BAB0
                D4EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBE9E9E9E7E7E7E7E7E7EBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBDFDCE5
                BAB0D4BAB0D4C6BFDAEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAE8E8
                E8E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7D4D4D4DEDEDEDEDEDEDEDEDEC5C5C5
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6
                E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6
                E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6
                E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6
                E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7E6E6E7F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EAEAEBE7
                E7E8F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0ECECEDE6E6E7
                E6E6E7E6E6E7E6E6E7E9E9EAEFEFEFF0F0F0F0F0F0EEEEEEEBEBECEBEBEBF0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0EFEFEFECECEDE8E8E9E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7
                E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6E7E6E6
                E7CCCCCCDEDEDEDEDEDEDEDEDEC0C0C0E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6
                E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6EBEBECF3F3F3F3F3F3F3F3F3
                F3F3F3F0F0F0ECECEDE6E6E7E5E5E6E5E5E6EAEAEBF2F2F2F3F3F3F3F3F3F3F3
                F3F3F3F3F0F0F0EAEAEBE5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E7
                E7E8E6E6E7E5E5E6E5E5E6E5E5E6E7E7E8EDEDEDF0F0F1EDEDEDF1F1F1F3F3F3
                F3F3F3F3F3F3F3F3F3F2F2F2EBEBECE6E6E7E5E5E6E5E5E6E5E5E6E5E5E6E5E5
                E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5
                E5E6E5E5E6E5E5E6E5E5E6E5E5E6E5E5E6C4C4C4DEDEDEDEDEDEDEDEDEBBBBBB
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E8E8E8E8E8E8E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E7E7E7E8E8E8E8E8E8E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E5E5E5E8E8E8E8E8E8E7E7E7E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4BBBBBBDEDEDEDEDEDEDEDEDEB6B6B6E0E1E1E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9
                E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2
                E2E1E2E2E1E2E2A9A9A9E1E2E2A9A9A9E1E2E2E1E2E2E1E2E2E1E2E2E1E2E2A9
                A9A9E1E2E2A9A9A9E1E2E2E1E2E2E0E1E1B3B3B3DEDEDEDEDEDEDEDEDEB1B1B1
                DEDEDFDFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDF
                E0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DF
                DFE0A7A7A8DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0
                DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0DFDFE0A7A7A8DFDFE0DFDFE0DFDFE0DEDE
                DFA9A9A9DEDEDEDEDEDEDEDEDEACACACDBDBDCDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6
                DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDC
                DDDCDCDDDCDCDDA5A5A6DCDCDDA5A5A6DCDCDDDCDCDDDCDCDDDCDCDDDCDCDDA5
                A5A6DCDCDDA5A5A6DCDCDDDCDCDDDBDBDC9F9F9FDEDEDEDEDEDEDEDEDEA7A7A7
                D8D8D9D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9
                DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9
                D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DA
                D9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD9D9DAD8D8
                D9959595DEDEDEDEDEDEDEDEDEA2A2A2D4D4D5D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6
                D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5
                D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5D5D6D5
                D5D6D5D5D6D5D5D6D5D5D6D5D5D6D4D4D58B8B8BDEDEDEDEDEDEDEDEDE9C9C9C
                D0D1D1D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2
                D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1
                D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2
                D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D1D2D2D0D1
                D1818181DEDEDEDEDEDEDEDEDE979797CDCDCDCECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
                CECECECECECECECECECECECECECECDCDCD777777DEDEDEDEDEDEDEDEDE929292
                C8C8C9C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9
                CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9
                C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CA
                C9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC9C9CAC8C8
                C96D6D6DDEDEDEDEDEDEDEDEDE8C8C8CC4C4C4C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494
                C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5
                C5C5C5C5C5C5C5949494C5C5C5949494C5C5C5C5C5C5C5C5C5C5C5C5C5C5C594
                9494C5C5C5949494C5C5C5C5C5C5C4C4C4636363DEDEDEDEDEDEDEDEDE878787
                BFBFC0C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0
                C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0
                C0C1909091C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1
                C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1C0C0C1909091C0C0C1C0C0C1C0C0C1BFBF
                C05A5A5ADEDEDEDEDEDEDEDEDE818181BABABABBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8C
                BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBB
                BBBBBBBBBBBBBB8C8C8CBBBBBB8C8C8CBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8C
                8C8CBBBBBB8C8C8CBBBBBBBBBBBBBABABA515151DEDEDEDEDEDEDEDEDE7A7A7A
                B5B5B5B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6
                B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B5B5
                B5474747DEDEDEDEDEDEDEDEDE727272AFAFB0B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1
                B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0
                B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0B0B1B0
                B0B1B0B0B1B0B0B1B0B0B1B0B0B1AFAFB03E3E3EDEDEDEDEDEDEDEDEDE6A6A6A
                AAAAABABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABAB
                ACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAB
                ABACABABACABABACABABACABABACABABACABABACABABACABABACABABACABABAC
                ABABACABABACABABACABABACABABACABABACABABACABABACABABACABABACAAAA
                AB353535DEDEDEDEDEDEDEDEDE626262A5A5A5A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
                A6A6A6A6A6A6A6A6A6A6A6A6A6A6A5A5A52D2D2DDEDEDEDEDEDEDEDEDE5A5A5A
                A1A1A1A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
                A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A1A1
                A1252525DEDEDEDEDEDEDEDEDE5252529B9B9B9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D767676
                9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D
                9D9D9D9D9D9D9D7676769D9D9D7676769D9D9D9D9D9D9D9D9D9D9D9D9D9D9D76
                76769D9D9D7676769D9D9D9D9D9D9B9B9B1E1E1EDEDEDEDEDEDEDEDEDE4B4B4B
                9797979999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999999
                9999999999999999999973737399999999999999999999999999999999999999
                9999737373999999999999999999999999999999999999999999737373999999
                9999999999999999999999999999999999997373739999999999999999999797
                97171717DEDEDEDEDEDEDEDEDE43434394949496969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696969696969696969696707070969696707070
                9696969696969696969696969696967070709696967070709696969696969696
                9696969696969670707096969670707096969696969696969696969696969670
                7070969696707070969696969696949494101010DEDEDEDEDEDEDEDEDE3C3C3C
                9191919393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939393
                9393939393939393939393939393939393939393939393939393939393939191
                910C0C0CDEDEDEDEDEDEDEDEDE3535358E8E8E90909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                9090909090909090909090909090909090909090909090909090909090909090
                90909090909090909090909090908E8E8E080808DEDEDEDEDEDEDEDEDE2E2E2E
                0404040202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020202
                0202020202020202020202020202020202020202020202020202020202020404
                04606060DEDEDEDEDEDE}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              TabOrder = 6
              OnClick = btnSaveClick
            end
            object btnNew: TRzBmpButton
              Left = 642
              Top = 54
              Width = 123
              Height = 45
              Bitmaps.TransparentColor = clFuchsia
              Bitmaps.Up.Data = {
                9A410000424D9A4100000000000036000000280000007B0000002D0000000100
                1800000000006441000000000000000000000000000000000000DEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDE000000DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE00
                0000DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE000000DEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDE000000DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE000000DEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDE000000DEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDE000000DCDCDCDADADAD4D4D4D2D2D2D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D2D2D2D4D4D4DADADADCDCDC000000DADADAD0D0D0
                C2C2C2B9B9B9B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B9
                B9B9C2C2C2D0D0D0DADADA000000D4D4D4D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D8D8D8A6A6A6C2C2C2D4D4D400
                0000D2D2D2D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D8D8D8949494B9B9B9D2D2D2000000D0D0D0DADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADAD9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
                D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9DADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADAD8D8D88A8A
                8AB4B4B4D0D0D0000000D0D0D0DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA
                DADADADADADADADADADADADADBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBD9D9D98A8A8AB4B4B4D0D0D0000000D0D0
                D0DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBD9D9D98A8A8AB4B4B4D0D0D0000000D0D0D0DCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDADADA8A8A8AB4B4B4
                D0D0D0000000D0D0D0DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC
                DCDCDCDCDCDCDCDCDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDBDBDB8A8A8AB4B4B4D0D0D0000000D0D0D0DEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
                DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDC
                DCDC8A8A8AB4B4B4D0D0D0000000D0D0D0DFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDDDDDD8A8A8AB4B4B4D0D0D000
                0000D0D0D0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
                DFDFDFDFE0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0DEDEDE8A8A8AB4B4B4D0D0D0000000D0D0D0E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
                E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DFDFDF8A8A
                8AB4B4B4D0D0D0000000D0D0D0E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
                E1E1E1E1E1E1E1E1E1E1E1E1E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E1E1E18A8A8AB4B4B4D0D0D0000000D0D0
                D0E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E3E3E38A8A8AB4B4B4D0D0D0000000D0D0D0E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
                E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E58A8A8AB4B4B4
                D0D0D0000000D0D0D0E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
                E5E5E5E5E5E5E5E5E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E68A8A8AB4B4B4D0D0D0000000D0D0D0E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
                E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E5
                E5E58A8A8AB4B4B4D0D0D0000000D0D0D0E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
                E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E7E7E78A8A8AB4B4B4D0D0D000
                0000D0D0D0EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
                E9E9E9E9EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAE8E8E88A8A8AB4B4B4D0D0D0000000D0D0D0EBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEA
                EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBE9E9E98A8A
                8AB4B4B4D0D0D0000000D0D0D0ECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB
                EBEBEBEBEBEBEBEBEBEBEBEBECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECEAEAEA8A8A8AB4B4B4D0D0D0000000D0D0
                D0EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                ECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECECEC
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEBEBEB8A8A8AB4B4B4D0D0D0000000D0D0D0EFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
                EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDEDED8A8A8AB4B4B4
                D0D0D0000000D0D0D0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
                EFEFEFEFEFEFEFEFF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0EEEEEE8A8A8AB4B4B4D0D0D0000000D0D0D0F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1EF
                EFEF8A8A8AB4B4B4D0D0D0000000D0D0D0F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
                F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F0F0F08A8A8AB4B4B4D0D0D000
                0000D0D0D0F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2
                F2F2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F1F1F18A8A8AB4B4B4D0D0D0000000D0D0D0F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
                F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F2F2F28A8A
                8AB4B4B4D0D0D0000000D0D0D0F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4
                F4F4F4F4F4F4F4F4F4F4F4F4F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F3F3F38B8B8BB5B5B5D1D1D1000000D0D0
                D0F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5EFEFEF909090B8B8B8D2D2D2000000D0D0D0F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5
                F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6DFDFDF989898BEBEBE
                D4D4D4000000D0D0D0F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7AFAFAFAAAAAAC7C7C7D8D8D8000000D2D2D2F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7C9C9C9A5
                A5A5BDBDBDD2D2D2DBDBDB000000D4D4D4F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
                F7F7F7F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7
                F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
                F6F6F6F6F6F6F6F0F0F0DFDFDFBABABAADADADBDBDBDCECECED9D9D9DDDDDD00
                0000DADADAD0D0D0C2C2C2B9B9B9B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4
                B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B4B5B5B5B9B9
                B9BFBFBFC7C7C7D2D2D2D9D9D9DDDDDDDEDEDE000000DCDCDCDADADAD4D4D4D2
                D2D2D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
                D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D1D1D1D2D2D2D5D5D5D9D9D9DBDBDBDDDD
                DDDEDEDEDEDEDE000000DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE000000}
              Color = clBtnFace
              Anchors = [akTop, akRight]
              Caption = #28165#31354
              TabOrder = 7
              OnClick = btnNewClick
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
            Width = 865
            Height = 60
            Align = alTop
            BorderOuter = fsNone
            BorderColor = 15461355
            Color = clWhite
            TabOrder = 0
            object RzPanel3: TRzPanel
              Left = 0
              Top = 0
              Width = 865
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
                865
                60)
              object RzPanel6: TRzPanel
                Left = 376
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
                  BorderSides = [sdRight, sdBottom]
                  FlatColor = clGray
                  TabOrder = 0
                  object RzBackground7: TRzBackground
                    Left = 0
                    Top = 0
                    Width = 62
                    Height = 26
                    Active = True
                    Align = alClient
                    FrameColor = 9145227
                    GradientColorStart = clWhite
                    GradientColorStop = 14277081
                    ImageStyle = isStretch
                    ShowGradient = True
                    ShowImage = False
                    ShowTexture = False
                  end
                  object RzLabel17: TRzLabel
                    Left = 0
                    Top = 0
                    Width = 62
                    Height = 26
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
                  object RzBackground8: TRzBackground
                    Left = 2
                    Top = 0
                    Width = 22
                    Height = 27
                    Active = True
                    Align = alClient
                    FrameColor = 9145227
                    GradientColorStart = clWhite
                    GradientColorStop = 14277081
                    ImageStyle = isStretch
                    ShowGradient = True
                    ShowImage = False
                    ShowTexture = False
                  end
                  object RzLabel16: TRzLabel
                    Left = 2
                    Top = 0
                    Width = 22
                    Height = 27
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
                Width = 346
                Height = 29
                Anchors = [akLeft, akTop, akRight]
                BorderOuter = fsNone
                TabOrder = 1
                DesignSize = (
                  346
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
                    0000FF00FFFF00FFFF00FFE6E6E6F5F5F5FCFCFC0000FF00FFFF00FFE1E1E1E9
                    E9E9F4F4F4FBFBFB0000FF00FFCBCBCBE0E0E0FAFAFAFFFFFFFFFFFF0000CBCB
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
                    FAFAFFFFFFFFFFFF0000FF00FF929292B9B9B9DFDFDFF3F3F3FBFBFB0000FF00
                    FFFF00FF919191ACACACC6C6C6D6D6D60000FF00FFFF00FFFF00FFA2A2A29999
                    999999990000}
                  Transparent = True
                end
                object Image3: TImage
                  Left = 341
                  Top = 0
                  Width = 5
                  Height = 29
                  Align = alRight
                  AutoSize = True
                  Picture.Data = {
                    07544269746D617006020000424D060200000000000036000000280000000500
                    00001D0000000100180000000000D00100000000000000000000000000000000
                    0000FCFCFCF5F5F5FF00FFFF00FFFF00FF00FCFCFCFCFCFCFFFFFFFF00FFFF00
                    FF00FFFFFFFFFFFFFDFDFDFFFFFFFF00FF00FFFFFFFFFFFFFFFFFFFCFCFCF7F7
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
                    E600FBFBFBF3F3F3DFDFDFE2E2E2FF00FF00D6D6D6C6C6C6CBCBCBFF00FFFF00
                    FF00AEAEAECBCBCBFF00FFFF00FFFF00FF00}
                  Transparent = True
                end
                object Image4: TImage
                  Left = 6
                  Top = 0
                  Width = 335
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
                  Width = 335
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
                end
              end
              object btnFind: TRzBmpButton
                Left = 783
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
            Width = 865
            Height = 415
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
              Width = 843
              Height = 393
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
                  Width = 146
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
                RzToolButton1)
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
            end
          end
        end
      end
    end
  end
  inherited toolNav: TRzPanel
    Width = 1065
    inherited lblCaption: TRzLabel
      Width = 753
      Caption = #36827' '#36135' '#21333
    end
    inherited RzPanel12: TRzPanel
      Left = 753
      Width = 278
      inherited btnPrint: TRzBmpButton
        Left = 11
      end
      inherited btnNav: TRzBmpButton
        Left = 165
        OnClick = btnNavClick
      end
      inherited btnPreview: TRzBmpButton
        Left = 88
      end
    end
    inherited RzPanel18: TRzPanel
      Left = 1031
    end
  end
  inherited photoPanel: TRzPanel
    Left = 865
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
      end>
    AfterPost = edtTableAfterPost
    AfterDelete = edtTableAfterDelete
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
  object dsList: TDataSource [8]
    DataSet = cdsList
    Left = 104
    Top = 392
  end
  object cdsList: TZQuery [9]
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    Left = 144
    Top = 392
  end
  inherited Timer1: TTimer
    Left = 440
  end
end
