inherited frmTransOrderList: TfrmTransOrderList
  Left = 337
  Top = 140
  Width = 906
  Height = 587
  Caption = #23384#21462#27454#21333
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 898
    Height = 530
    inherited RzPanel2: TRzPanel
      Width = 888
      Height = 520
      inherited RzPage: TRzPageControl
        Width = 882
        Height = 514
        OnChange = RzPageChange
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #23384#21462#27454#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 880
            Height = 487
            object RzPanel1: TRzPanel
              Left = 5
              Top = 5
              Width = 870
              Height = 117
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object LabTRANS_DATE: TLabel
                Left = 27
                Top = 11
                Width = 48
                Height = 12
                Caption = #23384#21462#26085#26399
              end
              object Label1: TLabel
                Left = 182
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object LabIN_ACCOUNT_ID: TLabel
                Left = 27
                Top = 53
                Width = 48
                Height = 12
                Caption = #23384#27454#36134#21495
              end
              object LabOUT_ACCOUNT_ID: TLabel
                Left = 27
                Top = 74
                Width = 48
                Height = 12
                Caption = #21462#27454#36134#21495
              end
              object LabTRANS_USER: TLabel
                Left = 38
                Top = 95
                Width = 36
                Height = 12
                Caption = #32463#25163#20154
              end
              object Label40: TLabel
                Left = 26
                Top = 31
                Width = 48
                Height = 12
                Caption = #23384#21462#38376#24215
              end
              object TRANS_DATE1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object TRANS_DATE2: TcxDateEdit
                Left = 200
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object fndIN_ACCOUNT_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 49
                Width = 217
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 2
                InGrid = False
                KeyValue = Null
                FilterFields = 'ACCOUNT_ID;ACCT_NAME;ACCT_SPELL'
                KeyField = 'ACCOUNT_ID'
                ListField = 'ACCT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_NAME'
                    Footers = <>
                    Title.Caption = #36134#25143#21517#31216
                    Width = 212
                  end>
                DropWidth = 218
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndOUT_ACCOUNT_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 70
                Width = 217
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 3
                InGrid = False
                KeyValue = Null
                FilterFields = 'ACCT_ID;ACCT_NAME;ACCOUNT_SPELL'
                KeyField = 'ACCOUNT_ID'
                ListField = 'ACCT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCT_NAME'
                    Footers = <>
                    Title.Caption = #36134#25143#21517#31216
                    Width = 212
                  end>
                DropWidth = 218
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndTRANS_USER: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 91
                Width = 89
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 4
                InGrid = False
                KeyValue = Null
                FilterFields = 'USER_ID;USER_NAME;USER_SPELL'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                    Title.Caption = #36134#21495
                    Width = 20
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                    Title.Caption = #21517'  '#31216
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
              end
              object fndQuery: TRzBitBtn
                Left = 437
                Top = 79
                Width = 67
                Height = 28
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
                TabOrder = 5
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndOrderStatus: TcxRadioGroup
                Left = 321
                Top = 22
                Width = 105
                Height = 88
                ItemIndex = 0
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end>
                TabOrder = 6
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 28
                Width = 217
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 7
                InGrid = False
                KeyValue = Null
                FilterFields = 'SHOP_ID;SHOP_NAME;SHOP_SPELL'
                KeyField = 'SHOP_ID'
                ListField = 'SHOP_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'SHOP_NAME'
                    Footers = <>
                    Title.Caption = #38376#24215#21517#31216
                    Width = 212
                  end>
                DropWidth = 218
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object RzPanel6: TRzPanel
              Left = 5
              Top = 122
              Width = 870
              Height = 360
              Align = alClient
              BorderOuter = fsNone
              Color = clWhite
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 0
                Top = 0
                Width = 870
                Height = 360
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = Dsc_1
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FrozenCols = 1
                Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
                RowHeight = 20
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 20
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDblClick = actInfoExecute
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    ReadOnly = True
                    Title.Alignment = taCenter
                    Title.Caption = #24207#21495
                    Width = 32
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #27969#27700#21495
                    Width = 100
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'TRANS_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #36716#36134#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'IN_ACCOUNT_ID_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23384#27454#36134#21495
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'OUT_ACCOUNT_ID_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21462#27454#36134#21495
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TRANS_MNY'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23384#21462#37329#39069
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TRANS_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #32463#25163#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #35828'    '#26126
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23457#26680#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #23457#26680#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21046#21333#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #21046#21333#26102#38388
                    Width = 120
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 898
    inherited Image1: TImage
      Left = 530
      Width = 359
    end
    inherited Image14: TImage
      Left = 889
    end
    inherited Image3: TImage
      Left = 530
      Width = 359
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#23384#21462#27454#21333
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 354
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 354
          Width = 30
        end>
      inherited ToolBar1: TToolBar
        Width = 354
        ButtonHeight = 30
        ButtonWidth = 43
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object ToolButton2: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object ToolButton3: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#24773
          ImageIndex = 0
        end
        object ToolButton4: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton5: TToolButton
          Left = 172
          Top = 0
          Width = 10
          ImageIndex = 36
          Style = tbsDivider
        end
        object ToolButton6: TToolButton
          Left = 182
          Top = 0
          Action = actAudit
        end
        object ToolButton7: TToolButton
          Left = 225
          Top = 0
          Action = actPrint
        end
        object ToolButton8: TToolButton
          Left = 268
          Top = 0
          Action = actPreview
        end
        object ToolButton9: TToolButton
          Left = 311
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 464
    Top = 48
  end
  inherited actList: TActionList
    Left = 656
    Top = 64
    inherited actNew: TAction
      OnExecute = actNewExecute
    end
    inherited actDelete: TAction
      OnExecute = actDeleteExecute
    end
    inherited actEdit: TAction
      OnExecute = actEditExecute
    end
    inherited actPrint: TAction
      OnExecute = actPrintExecute
    end
    inherited actFind: TAction
      OnExecute = actFindExecute
    end
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    inherited actAudit: TAction
      OnExecute = actAuditExecute
    end
  end
  object cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    AfterScroll = cdsListAfterScroll
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 470
    Top = 84
  end
  object Dsc_1: TDataSource
    DataSet = cdsList
    Left = 502
    Top = 85
  end
  object frfTransOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 550
    Top = 88
    ReportForm = {
      180000006A190000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      0016000000F6020000B40100003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000000
      5E01000006004D656D6F353800020051020000380000006E0000001200000003
      00020001000000000000000000FFFFFF1F2E02000000000001000A005B474C49
      44455F4E4F5D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000000000008600020000000000FFFFFF000000000200
      0000000000000000ED01000005004D656D6F320002003A0000001D0000008102
      0000180000000300000001000000000000000500FFFFFF1F2E02000000000001
      0012005BC6F3D2B5C3FBB3C65DB4E6C8A1BFEEB5A500000000FFFF0000000000
      0200000001000000000400CBCECCE500100000000200000000000A0000008600
      020000000000FFFFFF00000000020000000000000000007502000006004D656D
      6F33320002000A02000038000000440000001200000003000000010000000000
      00000000FFFFFF1F2E02000000000001000A00B4E6C8A1B5A5BAC5A3BA000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000002000000
      0000080000008600020000000000FFFFFF0000000002000000000000000000FF
      02000006004D656D6F33360002005F01000067000000EB0000001B0000000300
      0F0001000000000000000000FFFFFF1F2E02000000000001000C00C8A1B3F6D5
      CBBBA7C3FBB3C600000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000200000000000A0000008600020000000000FFFFFF0000000002
      0000000000000000008103000006004D656D6F33370002004A02000067000000
      750000001B00000003000F0001000000000000000000FFFFFF1F2E0200000000
      0001000400BDF0B6EE00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      00020000000000000000000304000006004D656D6F3235000200390000002401
      0000500000002600000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000400BACFBCC600000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      000000020000000000000000008D04000006004D656D6F3432000200BD010000
      6801000072000000140000000300000001000000000000000000FFFFFF1F2E02
      000000000001000C00B2C6CEF128B8C7D5C229A3BA0000000001000000000000
      0200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000008600
      020000000000FFFFFF00000000020000000000000000002205000006004D656D
      6F3434000200EA00000051010000940000001400000001000000010000000000
      00000000FFFFFF1F2E02000000000001001700C9F3BACBC8CBA3BA5B43484B5F
      555345525F544558545D00000000010000000000000200000001000000000400
      CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF0000
      000002000000000000000000B805000006004D656D6F34310002003900000051
      010000A5000000140000000100000001000000000000000000FFFFFF1F2E0200
      0000000001001800D6C6B5A5C8CBA3BA5B435245415F555345525F544558545D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      00007B06000006004D656D6F3433000200890000002401000036020000260000
      0003000F0001000000000000000000FFFFFF1F2E020000000000010045005B53
      6D616C6C546F426967285B5452414E535F4D4E595D295D2020A3A43A5B666F72
      6D6174466C6F6174282723302E3030272C5B5452414E535F4D4E595D295D2020
      20202000000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      0000000000FA06000006004D656D6F353500020039000000670000001B000000
      1B00000003000F0001000000000000000000FFFFFF1F2E020000000000010001
      004100000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000008600020000000000FFFFFF00000000020000000000
      000000008307000005004D656D6F3700020054000000670000000B0100001B00
      000003000F0001000000000000000000FFFFFF1F2E02000000000001000C00B4
      E6C8EBD5CBBBA7C3FBB3C600000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000000100020000000000FFFFFF00
      000000020000000000000000001908000006004D656D6F323400020040020000
      1B0000007E000000130000000300000001000000000000000000FFFFFF1F2E02
      000000000001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2
      B300000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      000000A208000006004D656D6F32360002007B00000038000000E00000001200
      00000300020001000000000000000000FFFFFF1F2E02000000000001000B005B
      53484F505F4E414D455D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000080000008600020000000000FFFFFF0000
      0000020000000000000000002909000006004D656D6F32370002003900000038
      00000044000000120000000300000001000000000000000000FFFFFF1F2E0200
      0000000001000900B4E6C8A1C3C5B5EA3A00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000BB09000005004D656D6F330002
      005F01000082000000EB0000001B00000001000F0001000000000000000000FF
      FFFF1F2E020000000000010015005B4F55545F4143434F554E545F49445F5445
      58545D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      0000000000590A000005004D656D6F340002004A02000082000000750000001B
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001002100
      5B666F726D6174466C6F6174282723302E3030272C5B494F524F5F4D4E595D29
      5D00000000FFFF00000000000200000001000000000400CBCECCE5000A000000
      000000000000090000008600020000000000FFFFFF0000000002000000000000
      000000D70A000005004D656D6F3600020039000000820000001B0000001B0000
      0001000F0001000000000000000000FFFFFF1F2E020000000000010001003100
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00680B000005004D656D6F3800020054000000820000000B0100001B00000001
      000F0001000000000000000000FFFFFF1F2E020000000000010014005B494E5F
      4143434F554E545F49445F544558545D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000001000200000000
      00FFFFFF0000000002000000000000000000F10B000006004D656D6F31300002
      00AB010000380000005C000000120000000300020001000000000000000000FF
      FFFF1F2E02000000000001000B005B494F524F5F444154455D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000780C000006
      004D656D6F31310002005F010000380000004C00000012000000030000000100
      0000000000000000FFFFFF1F2E02000000000001000900B4E6C8A1C8D5C6DA3A
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      0000FE0C000006004D656D6F31340002007F0000004F00000040020000120000
      000300020001000000000000000000FFFFFF1F2E020000000000010008005B52
      454D41524B5D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000008600020000000000FFFFFF000000000200
      0000000000000000860D000006004D656D6F3135000200390000004F00000048
      000000120000000300000001000000000000000000FFFFFF1F2E020000000000
      01000A00B1B820202020D7A2A3BA00000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000200000000000A0000008600020000000000FF
      FFFF00000000020000000000000000001A0E000006004D656D6F31370002003A
      0000006B01000014010000120000000300000001000000000000000000FFFFFF
      1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D205B54494D
      455D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000000000000100020000000000FFFFFF00000000020000000000
      00000000980E000006004D656D6F3138000200300200006A0100008C00000012
      0000000300020001000000000000000000FFFFFF1F2E02000000000001000000
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000000000000100020000000000FFFFFF000000000200000000000000
      00002E0F000005004D656D6F3100020084010000520100009400000014000000
      0100000001000000000000000000FFFFFF1F2E02000000000001001900BEADCA
      D6C8CBA3BA5B5452414E535F555345525F544558545D00000000010000000000
      000200000001000000000400CBCECCE5000A0000000200FFFFFF1F0800000086
      00020000000000FFFFFF0000000002000000000000000000AB0F000005004D65
      6D6F350002005F0100009D000000EB0000001B00000001000F00010000000000
      00000000FFFFFF1F2E0200000000000100000000000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000086000200
      00000000FFFFFF00000000020000000000000000002610000005004D656D6F39
      0002004A0200009D000000750000001B00000001000F00010000000000000000
      00FFFFFF1F2E020000000000000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000090000008600020000000000FF
      FFFF0000000002000000000000000000A210000006004D656D6F313200020039
      0000009D0000001B0000001B00000001000F0001000000000000000000FFFFFF
      1F2E020000000000000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A0000000000000000000A0000008600020000000000FFFFFF0000
      0000020000000000000000002011000006004D656D6F3133000200540000009D
      0000000B0100001B00000001000F0001000000000000000000FFFFFF1F2E0200
      000000000100000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000000100020000000000FFFFFF00000000
      020000000000000000009E11000006004D656D6F31390002005F010000B80000
      00EB0000001B00000001000F0001000000000000000000FFFFFF1F2E02000000
      00000100000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000008600020000000000FFFFFF000000000200
      00000000000000001A12000006004D656D6F32300002004A020000B800000075
      0000001B00000001000F0001000000000000000000FFFFFF1F2E020000000000
      000000000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000090000008600020000000000FFFFFF00000000020000000000
      000000009612000006004D656D6F323100020039000000B80000001B0000001B
      00000001000F0001000000000000000000FFFFFF1F2E02000000000000000000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      1413000006004D656D6F323200020054000000B80000000B0100001B00000001
      000F0001000000000000000000FFFFFF1F2E0200000000000100000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      000A0000000100020000000000FFFFFF00000000020000000000000000009213
      000006004D656D6F32330002005F010000D3000000EB0000001B00000001000F
      0001000000000000000000FFFFFF1F2E0200000000000100000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A00000000000000000008
      0000008600020000000000FFFFFF00000000020000000000000000000E140000
      06004D656D6F32380002004A020000D3000000750000001B00000001000F0001
      000000000000000000FFFFFF1F2E020000000000000000000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000900000086
      00020000000000FFFFFF00000000020000000000000000008A14000006004D65
      6D6F323900020039000000D30000001B0000001B00000001000F000100000000
      0000000000FFFFFF1F2E020000000000000000000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000000000000000A0000008600020000
      000000FFFFFF00000000020000000000000000000815000006004D656D6F3330
      00020054000000D30000000B0100001B00000001000F00010000000000000000
      00FFFFFF1F2E0200000000000100000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000001000200000000
      00FFFFFF00000000020000000000000000008615000006004D656D6F31360002
      005F010000EE000000EB0000001B00000001000F0001000000000000000000FF
      FFFF1F2E0200000000000100000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A000000000000000000080000008600020000000000FF
      FFFF00000000020000000000000000000216000006004D656D6F33310002004A
      020000EE000000750000001B00000001000F0001000000000000000000FFFFFF
      1F2E020000000000000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000007E16000006004D656D6F333300020039000000EE
      0000001B0000001B00000001000F0001000000000000000000FFFFFF1F2E0200
      00000000000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000000000000000A0000008600020000000000FFFFFF000000000200
      0000000000000000FC16000006004D656D6F333400020054000000EE0000000B
      0100001B00000001000F0001000000000000000000FFFFFF1F2E020000000000
      0100000000000000FFFF00000000000200000001000000000400CBCECCE5000A
      0000000000000000000A0000000100020000000000FFFFFF0000000002000000
      0000000000007A17000006004D656D6F33350002005F01000009010000EB0000
      001B00000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      000000000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000008600020000000000FFFFFF00000000020000000000
      00000000F617000006004D656D6F33380002004A02000009010000750000001B
      00000001000F0001000000000000000000FFFFFF1F2E02000000000000000000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000090000008600020000000000FFFFFF0000000002000000000000000000
      7218000006004D656D6F333900020039000000090100001B0000001B00000001
      000F0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF
      00000000000200000001000000000400CBCECCE5000A0000000000000000000A
      0000008600020000000000FFFFFF0000000002000000000000000000F0180000
      06004D656D6F343000020054000000090100000B0100001B00000001000F0001
      000000000000000000FFFFFF1F2E0200000000000100000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A0000000000000000000A0000
      000100020000000000FFFFFF000000000200000000000000FEFEFF060000000A
      00205661726961626C6573000000000200736C0014006364735F436867426F64
      792E22534C30303030220002006A650014006364735F436867426F64792E224A
      4530303030220004006B68796800000000040079687A68000000000200647A00
      0000000000000000000000FDFF0100000000}
  end
end
