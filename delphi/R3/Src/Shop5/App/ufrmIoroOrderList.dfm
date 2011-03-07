inherited frmIoroOrderList: TfrmIoroOrderList
  Left = 177
  Top = 114
  Width = 818
  Height = 569
  Caption = #20854#20182#36153#29992
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 802
    Height = 501
    inherited RzPanel2: TRzPanel
      Width = 792
      Height = 491
      inherited RzPage: TRzPageControl
        Width = 786
        Height = 485
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #25910#20837#20973#35777#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 784
            Height = 458
            BorderInner = fsStatus
            object RzPanel1: TRzPanel
              Left = 6
              Top = 6
              Width = 772
              Height = 97
              Align = alTop
              BorderOuter = fsNone
              BorderColor = clWhite
              BorderWidth = 5
              Color = clWhite
              TabOrder = 0
              object RzLabel2: TRzLabel
                Left = 48
                Top = 11
                Width = 24
                Height = 12
                Alignment = taRightJustify
                Caption = #26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 186
                Top = 11
                Width = 12
                Height = 12
                Caption = #33267
              end
              object Label4: TLabel
                Left = 38
                Top = 74
                Width = 36
                Height = 12
                Alignment = taRightJustify
                Caption = #36127#36131#20154
              end
              object Label17: TLabel
                Left = 24
                Top = 53
                Width = 48
                Height = 12
                Caption = #23458#25143#21517#31216
              end
              object Label40: TLabel
                Left = 24
                Top = 32
                Width = 48
                Height = 12
                Caption = #25152#23646#38376#24215
              end
              object P1_D1: TcxDateEdit
                Left = 80
                Top = 7
                Width = 97
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object P1_D2: TcxDateEdit
                Left = 205
                Top = 7
                Width = 98
                Height = 20
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 443
                Top = 57
                Width = 67
                Height = 32
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
                TabOrder = 2
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 316
                Top = 2
                Width = 105
                Height = 87
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
                TabOrder = 3
                Caption = ''
              end
              object fndIORO_USER: TzrComboBoxList
                Left = 80
                Top = 70
                Width = 114
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
                FilterFields = 'ACCOUNT;USER_NAME'
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
              object fndCLIENT_ID: TzrComboBoxList
                Left = 80
                Top = 49
                Width = 223
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 5
                InGrid = False
                KeyValue = Null
                FilterFields = 'CLIENT_CODE;CLIENT_NAME;CLIENT_SPELL'
                KeyField = 'CLIENT_ID'
                ListField = 'CLIENT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_CODE'
                    Footers = <>
                    Title.Caption = #20195#30721
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
                DropWidth = 296
                DropHeight = 220
                ShowTitle = True
                AutoFitColWidth = False
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 80
                Top = 28
                Width = 223
                Height = 20
                Properties.AutoSelect = False
                Properties.Buttons = <
                  item
                    Default = True
                  end>
                Properties.ReadOnly = False
                TabOrder = 6
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
                    Title.Caption = #21517#31216
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SEQ_NO'
                    Footers = <>
                    Title.Caption = #24207#21495
                    Width = 20
                  end>
                DropWidth = 185
                DropHeight = 180
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = False
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            object Panel1: TPanel
              Left = 6
              Top = 103
              Width = 772
              Height = 349
              Align = alClient
              Caption = 'Panel1'
              TabOrder = 1
              object DBGridEh1: TDBGridEh
                Left = 1
                Top = 1
                Width = 770
                Height = 347
                Align = alClient
                AllowedOperations = [alopUpdateEh]
                DataSource = DataSource1
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
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                TitleHeight = 20
                UseMultiTitle = True
                IsDrawNullRow = False
                CurrencySymbol = #65509
                DecimalNumber = 2
                DigitalNumber = 12
                OnDblClick = DBGridEh1DblClick
                OnDrawColumnCell = DBGridEh1DrawColumnCell
                OnGetCellParams = DBGridEh1GetCellParams
                Columns = <
                  item
                    Color = clBtnFace
                    EditButtons = <>
                    FieldName = 'SEQNO'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #24207#21495
                    Width = 31
                  end
                  item
                    DisplayFormat = '0000-00-00'
                    EditButtons = <>
                    FieldName = 'IORO_DATE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #26085#26399
                    Width = 75
                  end
                  item
                    EditButtons = <>
                    FieldName = 'GLIDE_NO'
                    Footer.Value = #21512'   '#35745#65306
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #21333#21495
                    Width = 95
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CLIENT_ID_TEXT'
                    Footers = <>
                    Title.Caption = #24448#26469#21333#20301
                    Width = 145
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ITEM_ID_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #31185#30446#21517#31216
                    Width = 79
                  end
                  item
                    EditButtons = <>
                    FieldName = 'IORO_USER_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #36127#36131#20154
                    Width = 69
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARK'
                    Footers = <>
                    Title.Caption = #35828#26126
                    Width = 161
                  end
                  item
                    Alignment = taRightJustify
                    EditButtons = <>
                    FieldName = 'CHK_USER_TEXT'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23457#26680#20154
                    Width = 75
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CHK_DATE'
                    Footers = <>
                    ReadOnly = True
                    Title.Caption = #23457#26680#26085#26399
                    Width = 72
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_USER_TEXT'
                    Footers = <>
                    Title.Caption = #21046#21333#20154
                    Width = 56
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREA_DATE'
                    Footers = <>
                    Title.Caption = #21046#21333#26085#26399
                    Width = 118
                  end>
              end
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 802
    inherited Image1: TImage
      Left = 530
      Width = 263
    end
    inherited Image14: TImage
      Left = 793
    end
    inherited Image3: TImage
      Left = 530
      Width = 263
    end
    inherited rzPanel5: TPanel
      inherited lblToolCaption: TRzLabel
        Width = 48
        Caption = #20854#20182#36153#29992
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
        object ToolButton2: TToolButton
          Left = 0
          Top = 0
          Action = actNew
        end
        object ToolButton4: TToolButton
          Left = 43
          Top = 0
          Action = actEdit
          Caption = #20462#25913
        end
        object ToolButton1: TToolButton
          Left = 86
          Top = 0
          Action = actInfo
          Caption = #35814#32454
        end
        object ToolButton5: TToolButton
          Left = 129
          Top = 0
          Action = actDelete
        end
        object ToolButton7: TToolButton
          Left = 172
          Top = 0
          Width = 10
          Caption = 'ToolButton7'
          ImageIndex = 3
          Style = tbsDivider
        end
        object ToolButton8: TToolButton
          Left = 182
          Top = 0
          Action = actAudit
        end
        object ToolButton3: TToolButton
          Left = 225
          Top = 0
          Action = actPrint
        end
        object ToolButton6: TToolButton
          Left = 268
          Top = 0
          Action = actPreview
        end
        object ToolButton10: TToolButton
          Left = 311
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 112
    Top = 232
  end
  inherited actList: TActionList
    Left = 160
    Top = 232
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
    inherited actPreview: TAction
      OnExecute = actPreviewExecute
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
  object DataSource1: TDataSource
    DataSet = cdsBrowser
    Left = 113
    Top = 266
  end
  object frfIoroOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnUserFunction = frfIoroOrderUserFunction
    Left = 176
    Top = 193
    ReportForm = {
      18000000E8120000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00000000000000000000000000000000000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00BE000000F6020000140000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      3B0100000500D2B3CDB7310002010000000024000000F6020000680000003000
      020001000000000000000000FFFFFF1F00000000000000000000000000FFFF00
      0000000002000000010000000000000001000000C80000001400000001000000
      0000000200A20100000700D6F7CFEEBDC531000201000000004C010000F60200
      004D0000003000060001000000000000000000FFFFFF1F000000000000000000
      00000000FFFF000000000002000000010000000000000001000000C800000014
      000000010000000000000200070200000500D2B3BDC53100020100000000F600
      0000F6020000150000003000030001000000000000000000FFFFFF1F00000000
      000000000000000000FFFF000000000002000000010000000000000001000000
      C8000000140000000100000000000000008E02000005004D656D6F390002007B
      00000052000000640000001200000003000F0001000000000000000000FFFFFF
      1F2E02000000000001000A005BD5CABBA7C3FBB3C65D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000001A03000006004D65
      6D6F353800020045020000410000007A0000000F000000030000000100000000
      0000000000FFFFFF1F2E02000000000001000E005BCAD5D6A7C6BED6A4B5A5BA
      C55D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000000000008600020000000000FFFFFF00000000020000000000
      00000000A203000005004D656D6F320002000A01000025000000A50000001800
      00000300020001000000000000000500FFFFFF1F2E02000000000001000B00CA
      D520D6A720C6BE20D6A400000000FFFF00000000000200000001000000000400
      CBCECCE500100000000200000000000A0000008600020000000000FFFFFF0000
      0000020000000000000000002904000005004D656D6F35000200390000004100
      0000440000000F0000000300000001000000000000000000FFFFFF1F2E020000
      00000001000A00C3C5B5EAC3FBB3C6A3BA00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000002000000000008000000860002000000
      0000FFFFFF0000000002000000000000000000AF04000006004D656D6F313200
      02003900000052000000420000001200000003000F0001000000000000000000
      FFFFFF1F2E02000000000001000800D5CABBA7C3FBB3C600000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000200000000000A000000
      8600020000000000FFFFFF00000000020000000000000000003705000006004D
      656D6F333100020080000000410000000B0100000F0000000300000001000000
      000000000000FFFFFF1F2E02000000000001000A005BC3C5B5EAC3FBB3C65D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      00C305000006004D656D6F3332000200E201000041000000600000000F000000
      0300000001000000000000000000FFFFFF1F2E02000000000001000E00CAD5D6
      A7C6BED6A4B5A5BAC5A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      000000020000000000000000004506000006004D656D6F333400020063020000
      760000005C0000001600000003000F0001000000000000000000FFFFFF1F2E02
      000000000001000400D6A7B3F600000000FFFF00000000000200000001000000
      000400CBCECCE5000A0000000200000000000A0000008600020000000000FFFF
      FF0000000002000000000000000000C706000006004D656D6F3336000200DE00
      000076000000310100001600000003000F0001000000000000000000FFFFFF1F
      2E02000000000001000400D5AAD2AA00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF00000000020000000000000000004907000006004D656D6F3337000200
      0F02000076000000540000001600000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000400CAD5C8EB00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000CF07000006004D656D6F323500
      0200390000004C010000500000001300000003000F0001000000000000000000
      FFFFFF1F2E02000000000001000800BACFBCC6CAD5C8EB00000000FFFF000000
      00000200000001000000000400CBCECCE5000A0000000200000000000A000000
      8600020000000000FFFFFF00000000020000000000000000005D08000006004D
      656D6F3434000200BA010000840100007C000000140000000300000001000000
      000000000000FFFFFF1F2E02000000000001001000C9F3BACBC8CBA3BA5BC9F3
      BACBC8CB5D00000000010000000000000200000001000000000400CBCECCE500
      0A0000000200FFFFFF1F080000008600020000000000FFFFFF00000000020000
      00000000000000EB08000006004D656D6F34310002003D020000840100008100
      0000140000000300000001000000000000000000FFFFFF1F2E02000000000001
      001000BFAAB5A5D4B1A3BA5BBFAAB5A5D4B15D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF00000000020000000000000000009809000006004D656D6F34
      33000200890000004C010000360200001300000003000F000100000000000000
      0000FFFFFF1F2E02000000000001002F005B73756D285BD7DCCAD5C8EB5D295D
      20285B536D616C6C546F426967285B73756D285BD7DCCAD5C8EB5D295D295D29
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      00001A0A000006004D656D6F353500020039000000760000001B000000160000
      0003000F0001000000000000000000FFFFFF1F2E02000000000001000400D0F2
      BAC500000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      000200000000000A0000008600020000000000FFFFFF00000000020000000000
      000000009F0A000005004D656D6F3700020054000000760000008A0000001600
      000003000F0001000000000000000000FFFFFF1F2E02000000000001000800CF
      EEC4BFC3FBB3C600000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000200000000000A0000000100020000000000FFFFFF0000000002
      000000000000000000580B000006004D656D6F32340002003C000000F7000000
      86020000130000000300000001000000000000000000FFFFFF1F2E0200000000
      0001003B00B5DA5B50414745235D2F5B544F54414C50414745535DD2B320D0A1
      BCC63A5B73756D285BCAD5C8EB5D295D202F205B73756D285BD6A7B3F65D295D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      0000DC0B000006004D656D6F32360002007B0000006400000044020000120000
      0003000F0001000000000000000000FFFFFF1F2E020000000000010006005BCB
      B5C3F75D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000008600020000000000FFFFFF0000000002000000
      0000000000005E0C000006004D656D6F32370002003900000064000000420000
      001200000003000F0001000000000000000000FFFFFF1F2E0200000000000100
      0400CBB5C3F700000000FFFF00000000000200000001000000000400CBCECCE5
      000A0000000200000000000A0000008600020000000000FFFFFF000000000200
      0000000000000000F80C000005004D656D6F3100020063020000BE0000005C00
      00001400000003000F0001000000000000000000FFFFFF1F2E02000000000001
      001D005B666F726D6174466C6F6174282723302E3030272C5BD6A7B3F65D295D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      0000000000090000008600020000000000FFFFFF000000000200000000000000
      00007B0D000005004D656D6F33000200DE000000BE0000003101000014000000
      03000F0001000000000000000000FFFFFF1F2E020000000000010006005BD5AA
      D2AA5D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      0000000000150E000005004D656D6F340002000F020000BE0000005400000014
      00000003000F0001000000000000000000FFFFFF1F2E02000000000001001D00
      5B666F726D6174466C6F6174282723302E3030272C5BCAD5C8EB5D295D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF000000000200000000000000000098
      0E000005004D656D6F3600020039000000BE0000001B0000001400000003000F
      0001000000000000000000FFFFFF1F2E020000000000010006005BD0F2BAC55D
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000000
      00000000000A0000008600020000000000FFFFFF000000000200000000000000
      00001F0F000005004D656D6F3800020054000000BE0000008A00000014000000
      03000F0001000000000000000000FFFFFF1F2E02000000000001000A005BCFEE
      C4BFC3FBB3C65D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000000000000000A0000000100020000000000FFFFFF0000000002
      000000000000000000A70F000006004D656D6F31300002006302000052000000
      5C0000001200000003000F0001000000000000000000FFFFFF1F2E0200000000
      0001000A005BD5CBBFEEC8D5C6DA5D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000000000000000A0000008600020000000000
      FFFFFF00000000020000000000000000002D10000006004D656D6F3131000200
      17020000520000004C0000001200000003000F0001000000000000000000FFFF
      FF1F2E02000000000001000800D5CBBFEEC8D5C6DA00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000200000000000A0000008600
      020000000000FFFFFF0000000002000000000000000000B510000006004D656D
      6F31330002003701000052000000E00000001200000003000F00010000000000
      00000000FFFFFF1F2E02000000000001000A005BCDF9C0B4B5A5CEBB5D000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      00000A0000008600020000000000FFFFFF00000000020000000000000000003B
      11000006004D656D6F3134000200DF0000005200000058000000120000000300
      0F0001000000000000000000FFFFFF1F2E02000000000001000800CDF9C0B4B5
      A5CEBB00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      00000200000000000A0000008600020000000000FFFFFF000000000200000000
      0000000000C111000006004D656D6F3135000200390000005F01000050000000
      1300000003000F0001000000000000000000FFFFFF1F2E020000000000010008
      00BACFBCC6D6A7B3F600000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      00020000000000000000006E12000006004D656D6F3136000200890000005F01
      0000360200001300000003000F0001000000000000000000FFFFFF1F2E020000
      00000001002F005B73756D285BD7DCD6A7B3F65D295D20285B536D616C6C546F
      426967285B73756D285BD7DCD6A7B3F65D295D295D2900000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF000000000200000000000000FEFEFF060000000A0020
      5661726961626C6573000000000200736C0014006364735F436867426F64792E
      22534C30303030220002006A650014006364735F436867426F64792E224A4530
      303030220004006B68796800000000040079687A68000000000200647A000000
      000000000000000000FDFF0100000000}
  end
  object PrintDBGridEh1: TPrintDBGridEh
    DBGridEh = DBGridEh1
    Options = [pghFitGridToPageWidth]
    Page.BottomMargin = 2.000000000000000000
    Page.LeftMargin = 2.000000000000000000
    Page.RightMargin = 2.000000000000000000
    Page.TopMargin = 2.000000000000000000
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    Units = MM
    Left = 144
    Top = 184
  end
  object cdsBrowser: TZQuery
    SortedFields = 'GLIDE_NO'
    FieldDefs = <>
    CachedUpdates = True
    Params = <>
    IndexFieldNames = 'GLIDE_NO Asc'
    Left = 159
    Top = 265
  end
end
