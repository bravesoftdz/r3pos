inherited frmBomOrderList: TfrmBomOrderList
  Left = 367
  Top = 292
  Width = 738
  Height = 465
  Caption = #31036#30418#21253#35013
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 722
    Height = 390
    inherited RzPanel2: TRzPanel
      Width = 712
      Height = 380
      inherited RzPage: TRzPageControl
        Width = 706
        Height = 374
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #31036#30418#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 704
            Height = 347
            inherited RzPanel1: TRzPanel
              Width = 694
              Height = 92
              object RzLabel2: TRzLabel
                Left = 33
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #31036#30418#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 4
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel5: TRzLabel
                Left = 329
                Top = 24
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #32463' '#21150' '#20154
              end
              object Label1: TLabel
                Left = 329
                Top = 73
                Width = 144
                Height = 12
                Caption = #25903#25345#21517#31216#12289#26465#30721#12289#21333#21495#27169#31946
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label40: TLabel
                Left = 33
                Top = 24
                Width = 48
                Height = 12
                Caption = #25152#23646#38376#24215
              end
              object RzLabel4: TRzLabel
                Left = 329
                Top = 4
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #31036#30418#31867#22411
              end
              object Label2: TLabel
                Left = 33
                Top = 48
                Width = 48
                Height = 12
                Caption = #25152#23646#37096#38376
              end
              object Label3: TLabel
                Left = 33
                Top = 72
                Width = 48
                Height = 12
                Caption = #20851' '#38190' '#23383
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 0
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 664
                Top = 40
                Width = 67
                Height = 26
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
                TabOrder = 8
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSTATUS: TcxRadioGroup
                Left = 536
                Top = -6
                Width = 105
                Height = 84
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
                TabOrder = 7
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 20
                Width = 236
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
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
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
              object fndBom_Type: TcxComboBox
                Left = 385
                Top = 0
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DropDownListStyle = lsFixedList
                Properties.Items.Strings = (
                  #25955#35013#31036#30418
                  #25972#35013#31036#30418)
                TabOrder = 5
              end
              object fndDEPT_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 44
                Width = 236
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
                FilterFields = 'DEPT_NAME;DEPT_SPELL'
                KeyField = 'DEPT_ID'
                ListField = 'DEPT_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'DEPT_NAME'
                    Footers = <>
                    Title.Caption = #21517#31216
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
              object fndGIFT_NAME: TcxTextEdit
                Left = 89
                Top = 68
                Width = 236
                Height = 20
                TabOrder = 4
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndBOM_USER: TzrComboBoxList
                Left = 385
                Top = 20
                Width = 104
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
                FilterFields = 'ACCOUNT;USER_NAME;USER_SPELL'
                KeyField = 'USER_ID'
                ListField = 'USER_NAME'
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'ACCOUNT'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'USER_NAME'
                    Footers = <>
                  end>
                DropWidth = 290
                DropHeight = 228
                ShowTitle = True
                AutoFitColWidth = True
                ShowButton = True
                LocateStyle = lsDark
                Buttons = []
                DropListStyle = lsFixed
                MultiSelect = False
              end
            end
            inherited DBGridEh1: TDBGridEh
              Top = 97
              Width = 694
              Height = 245
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              PopupMenu = PopupMenu1
              OnCellClick = DBGridEh1CellClick
              OnDblClick = DBGridEh1DblClick
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'SEQNO'
                  Footers = <>
                  Title.Caption = #24207#21495
                  Width = 30
                end
                item
                  EditButtons = <>
                  FieldName = 'GLIDE_NO'
                  Footers = <>
                  Title.Caption = #27969#27700#21495
                  Width = 90
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'BOM_DATE'
                  Footers = <>
                  Title.Caption = #21253#35013#26085#26399
                  Width = 62
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #32463#21150#20154
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'GIFT_NAME'
                  Footers = <>
                  Title.Caption = #31036#30418#21517#31216
                  Width = 186
                end
                item
                  EditButtons = <>
                  FieldName = 'BOM_AMOUNT'
                  Footers = <>
                  Title.Caption = #31036#30418#25968#37327
                  Width = 52
                end
                item
                  EditButtons = <>
                  FieldName = 'RCK_AMOUNT'
                  Footers = <>
                  Title.Caption = #32467#20313#25968#37327
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'RTL_PRICE'
                  Footers = <>
                  Title.Caption = #20215#26684
                  Width = 49
                end
                item
                  EditButtons = <>
                  FieldName = 'BOM_TYPE'
                  Footers = <>
                  Title.Caption = #31867#22411
                  Width = 58
                end
                item
                  EditButtons = <>
                  FieldName = 'BOM_STATUS'
                  Footers = <>
                  Title.Caption = #29366#24577
                  Width = 36
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 143
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                  Width = 57
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 122
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #23457#26680#20154#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CHK_DATE'
                  Footers = <>
                  Title.Caption = #23457#26680#26085#26399
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 722
    inherited Image3: TImage
      Left = 636
      Width = 43
    end
    inherited Image14: TImage
      Left = 702
    end
    inherited Image1: TImage
      Left = 506
      Width = 196
    end
    inherited rzPanel5: TPanel
      Left = 636
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#36827#36135#35746#21333
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 616
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 616
          Width = 36
        end>
      inherited ToolBar1: TToolBar
        Width = 616
        object ToolButton16: TToolButton
          Left = 522
          Top = 0
          Caption = #20184#27454
          ImageIndex = 28
          Visible = False
        end
        object ToolButton17: TToolButton
          Left = 565
          Top = 0
          Width = 8
          Caption = 'ToolButton17'
          ImageIndex = 14
          Style = tbsDivider
        end
        object ToolButton11: TToolButton
          Left = 573
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 240
    Top = 232
  end
  inherited actList: TActionList
    Left = 256
    Top = 176
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
  end
  inherited ppmReport: TPopupMenu
    Left = 878
    Top = 63
  end
  inherited cdsList: TZQuery
    AfterScroll = cdsListAfterScroll
  end
  object frfBomOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfBomOrderGetValue
    OnUserFunction = frfBomOrderUserFunction
    Left = 416
    Top = 193
    ReportForm = {
      18000000381F0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000001200000000FFFF00000000FFFF0000000000
      00000000000000030400466F726D000F000080DC000000780000007C0100002C
      010000040000000200D60000000B004D61737465724461746131000201000000
      00A4000000F6020000130000003000050001000000000000000000FFFFFF1F00
      0000000C0066724442446174615365743100000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      4F0100000700B7D6D7E9CDB7310002010000000019000000F60200006D000000
      3200100001000000000000000000FFFFFF1F000000001200696E7428285B5345
      514E4F5D2D292F31362900000000000000FFFF00000000000200000001000000
      0000000001000000C800000014000000010000000000000200360200000700B7
      D6D7E9BDC5310002010000000012010000F60200004500000030001100010000
      00000000000000FFFFFF1F0000000000000000000007000500626567696E0D1E
      0020696620436F756E74284D61737465724461746131293C3135207468656E0D
      060020626567696E0D260020202020666F7220693A3D436F756E74284D617374
      657244617461312920746F20313420646F0D15002020202053686F7742616E64
      284368696C6431293B0D050020656E643B0D0300656E6400FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000200
      9C02000006006368696C643100020100000000CC000000F60200001300000030
      00150001000000000000000000FFFFFF1F00000000000000000000000000FFFF
      000000000002000000010000000000000001000000C800000014000000010000
      0000000000003A03000006004D656D6F313400020019020000A40000003C0000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      20005B466F726D6174466C6F6174282723302E303023272C5B4150524943455D
      295D00000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000090000008600020000000000FFFFFF00000000020000000000
      00000000DB03000006004D656D6F313800020055020000A40000006000000013
      00000001000F0001000000000000000000FFFFFF1F2E02000000000001002300
      5B666F726D6174466C6F6174282723302E3030272C5B43414C435F4D4F4E4559
      5D295D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000090000008600020000000000FFFFFF000000000200000000
      00000000009B04000006004D656D6F3230000200F0000000A4000000D1000000
      1300000001000F0001000000000000000000FFFFFF1F2E020000000000010042
      005B474F44535F4E414D455D205B50524F50455254595F30315F544558545D5B
      50524F50455254595F30325F544558545D205B49535F50524553454E545F5445
      58545D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      00000000002505000005004D656D6F390002007400000033000000EF00000012
      0000000100020001000000000000000000FFFFFF1F2E02000000000001000D00
      5B434C49454E545F4E414D455D00000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000080000008600020000000000FFFF
      FF0000000002000000000000000000AE05000006004D656D6F34300002009101
      00003300000093000000120000000100020001000000000000000000FFFFFF1F
      2E02000000000001000B005B494E44455F444154455D00000000FFFF00000000
      000200000001000000000400CBCECCE5000A0000000000000000000800000086
      00020000000000FFFFFF00000000020000000000000000003706000006004D65
      6D6F3233000200C1010000A4000000240000001300000001000F000100000000
      0000000000FFFFFF1F2E02000000000001000B005B554E49545F4E414D455D00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000000
      000000000A0000008600020000000000FFFFFF00000000020000000000000000
      00D306000005004D656D6F33000200E5010000A4000000340000001300000001
      000F0001000000000000000000FFFFFF1F2E02000000000001001F005B666F72
      6D6174466C6F6174282723302E2323272C5B414D4F554E545D295D00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      090000008600020000000000FFFFFF00000000020000000000000000005B0700
      0006004D656D6F31320002002E00000033000000460000001200000001000000
      01000000000000000000FFFFFF1F2E02000000000001000A00B9A920D3A620C9
      CCA3BA00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000020000000000080000008600020000000000FFFFFF000000000200000000
      0000000000DF07000006004D656D6F313300020064010000330000002B000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010006
      00C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      0000000000000000006108000006004D656D6F33340002001902000070000000
      3C0000001600000001000F0001000000000000000000FFFFFF1F2E0200000000
      0001000400B5A5BCDB00000000FFFF00000000000200000001000000000400CB
      CECCE5000A0000000200000000000A0000008600020000000000FFFFFF000000
      0002000000000000000000E708000006004D656D6F3336000200F00000007000
      0000D10000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000800C9CCC6B7C3FBB3C600000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF00000000020000000000000000006909000006004D656D6F3337000200
      E501000070000000340000001600000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000400CAFDC1BF00000000FFFF000000000002000000
      01000000000400CBCECCE5000A0000000200000000000A000000860002000000
      0000FFFFFF0000000002000000000000000000EB09000006004D656D6F333800
      0200C101000070000000240000001600000001000F0001000000000000000000
      FFFFFF1F2E02000000000001000400B5A5CEBB00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000200000000000A00000086000200
      00000000FFFFFF0000000002000000000000000000810A000006004D656D6F34
      3100020030000000290100008100000012000000010000000100000000000000
      0000FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA5B435245415F55
      5345525F544558545D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000080000008600020000000000FFFFFF000000
      0002000000000000000000030B000006004D656D6F3435000200550200007000
      0000600000001600000001000F0001000000000000000000FFFFFF1F2E020000
      00000001000400BDF0B6EE00000000FFFF000000000002000000010000000004
      00CBCECCE5000A0000000200000000000A0000008600020000000000FFFFFF00
      00000002000000000000000000880B000006004D656D6F35340002002F000000
      A40000001B0000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010007005B5345514E4F5D00000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000070C000006004D656D6F35350002
      002F000000700000001B0000001600000001000F0001000000000000000000FF
      FFFF1F2E020000000000010001004100000000FFFF0000000000020000000100
      0000000400CBCECCE5000A0000000200000000000A0000008600020000000000
      FFFFFF0000000002000000000000000000880C000005004D656D6F370002004A
      00000070000000420000001600000001000F0001000000000000000000FFFFFF
      1F2E02000000000001000400BBF5BAC500000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000200000000000A00000001000200000000
      00FFFFFF0000000002000000000000000000100D000005004D656D6F38000200
      4A000000A4000000420000001300000001000F0001000000000000000000FFFF
      FF1F2E02000000000001000B005B474F44535F434F44455D00000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000080000
      000100020000000000FFFFFF0000000002000000000000000000EC0D00000600
      4D656D6F3131000200E501000012010000D00000001300000001000B00010000
      00000000000000FFFFFF1F2E02000000000001005E00D7DCCAFDC1BFA3BA5B66
      6F726D6174466C6F6174282723302E2323272C5B494E44455F414D545D295D20
      B1BED2B3D0A1BCC6A3BAA3A45B666F726D6174466C6F6174282723302E303027
      2C73756D285B43414C435F4D4F4E45595D29295D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000009000000860002
      0000000000FFFFFF0000000002000000000000000000740E000006004D656D6F
      31360002002F000000120100004A0000001300000001000E0001000000000000
      000000FFFFFF1F2E02000000000001000A00BACFBCC6BDF0B6EEA3BA00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000200000000
      000A0000008600020000000000FFFFFF0000000002000000000000000000F80E
      000006004D656D6F333200020024020000330000002D00000012000000010000
      0001000000000000000000FFFFFF1F2E02000000000001000600B5A5BAC5A3BA
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      0000000000080000008600020000000000FFFFFF000000000200000000000000
      0000800F000006004D656D6F3538000200510200003300000064000000120000
      000100020001000000000000000000FFFFFF1F2E02000000000001000A005B47
      4C4944455F4E4F5D00000000FFFF00000000000200000001000000000400CBCE
      CCE5000A000000000000000000000000008600020000000000FFFFFF00000000
      020000000000000000000F10000005004D656D6F320002002F00000019000000
      86020000180000000100000001000000000000000500FFFFFF1F2E0200000000
      00010012005BC6F3D2B5C3FBB3C65DBDF8BBF5B6A9B5A500000000FFFF000000
      00000200000001000000000400CBCECCE500100000000200000000000A000000
      8600020000000000FFFFFF0000000002000000000000000000A510000006004D
      656D6F32340002005B0200001B0000007A0000000F0000000100000001000000
      000000000000FFFFFF1F2E02000000000001001800B5DA5B50414745235D2F5B
      544F54414C50414745535DD2B300000000FFFF00000000000200000001000000
      000400CBCECCE5000A000000000000000000090000008600020000000000FFFF
      FF00000000020000000000000000003B11000005004D656D6F31000200C80000
      002801000080000000140000000100000001000000000000000000FFFFFF1F2E
      02000000000001001900D1E9BBF5D4B1A3BA5B47554944455F555345525F5445
      58545D00000000010000000000000200000001000000000400CBCECCE5000A00
      00000200FFFFFF1F080000008600020000000000FFFFFF000000000200000000
      00000000001012000006004D656D6F343300020079000000120100006D010000
      1300000001000A0001000000000000000000FFFFFF1F2E020000000000010057
      005B536D616C6C546F426967285B666F726D6174466C6F6174282723302E3030
      272C5B494E44455F4D4E595D295D295D20A3A4A3BA5B666F726D6174466C6F61
      74282723302E303023272C5B494E44455F4D4E595D295D2000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000080000
      008600020000000000FFFFFF0000000002000000000000000000971200000600
      4D656D6F33310002002D00000047000000480000001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001000900B5D820202020D6B73A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      00000000080000000100020000000000FFFFFF00000000020000000000000000
      001E13000006004D656D6F35300002007300000047000000F100000012000000
      0300020001000000000000000000FFFFFF1F2E020000000000010009005B4144
      44524553535D00000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000000100020000000000FFFFFF000000000200
      0000000000000000A213000006004D656D6F353600020064010000470000002C
      000000120000000300000001000000000000000000FFFFFF1F2E020000000000
      01000600B5E7BBB0A3BA00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000000100020000000000FFFFFF0000
      0000020000000000000000002B14000006004D656D6F35370002009101000047
      00000092000000120000000300020001000000000000000000FFFFFF1F2E0200
      0000000001000B005B4D4F56455F54454C455D00000000FFFF00000000000200
      000001000000000400CBCECCE5000A0000000000000000000800000001000200
      00000000FFFFFF0000000002000000000000000000AD14000006004D656D6F34
      320002008C00000070000000640000001600000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000400CCF5C2EB00000000FFFF0000000000
      0200000001000000000400CBCECCE5000A0000000200000000000A0000000100
      020000000000FFFFFF00000000020000000000000000003415000006004D656D
      6F35390002008C000000A4000000640000001300000001000F00010000000000
      00000000FFFFFF1F2E020000000000010009005B424152434F44455D00000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00080000000100020000000000FFFFFF0000000002000000000000000000B015
      000006004D656D6F363000020019020000CC0000003C0000001300000001000F
      0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF00000000020000000000000000002C1600000600
      4D656D6F363100020055020000CC000000600000001300000001000F00010000
      00000000000000FFFFFF1F2E020000000000000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000009000000860002
      0000000000FFFFFF0000000002000000000000000000A816000006004D656D6F
      3632000200F0000000CC000000D10000001300000001000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000800000086000200000000
      00FFFFFF00000000020000000000000000002617000006004D656D6F36330002
      00C1010000CC000000240000001300000001000F0001000000000000000000FF
      FFFF1F2E0200000000000100000000000000FFFF000000000002000000010000
      00000400CBCECCE5000A0000000000000000000A0000008600020000000000FF
      FFFF0000000002000000000000000000A217000006004D656D6F3634000200E5
      010000CC000000340000001300000001000F0001000000000000000000FFFFFF
      1F2E020000000000000000000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000090000008600020000000000FFFFFF0000
      0000020000000000000000002018000006004D656D6F36350002002F000000CC
      0000001B0000001300000001000F0001000000000000000000FFFFFF1F2E0200
      000000000100000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      020000000000000000009E18000006004D656D6F36360002004A000000CC0000
      00420000001300000001000F0001000000000000000000FFFFFF1F2E02000000
      00000100000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000000000000000080000000100020000000000FFFFFF000000000200
      00000000000000001A19000006004D656D6F36370002008C000000CC00000064
      0000001300000001000F0001000000000000000000FFFFFF1F2E020000000000
      000000000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      00000000FD19000006004D656D6F3638000200C002000061000000140000002E
      0100000300000001000000000000000000FFFFFF1F2E02000000000007000E00
      B0D7C1AAA3BAB4E6B8F9202020200D00000D1500202020202020202020202020
      2020202020202020200D0E00BAECC1AAA3BAB9A9D3A6C9CC20200D00000D1800
      2020202020202020202020202020202020202020202020200D0A00BBC6C1AAA3
      BABDE1CBE300000000FFFF00000000000200000001000000000400CBCECCE500
      0A000000020000000000000000000100020000000000FFFFFF00000000020000
      00000000000000811A000006004D656D6F313000020024020000470000002C00
      0000120000000300000001000000000000000000FFFFFF1F2E02000000000001
      000600BDE1CBE3A3BA00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000080000000100020000000000FFFFFF000000
      0002000000000000000000111B000006004D656D6F3135000200510200004700
      000064000000120000000300020001000000000000000000FFFFFF1F2E020000
      000000010012005B534554544C455F434F44455F544558545D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00000100020000000000FFFFFF0000000002000000000000000000971B000005
      004D656D6F34000200310000005B000000440000001200000003000000010000
      00000000000000FFFFFF1F2E02000000000001000900CAD5BBF5C3C5B5EA3A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      00000000080000000100020000000000FFFFFF00000000020000000000000000
      001F1C000005004D656D6F36000200720000005B000000F30000001200000003
      00020001000000000000000000FFFFFF1F2E02000000000001000B005B53484F
      505F4E414D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000000100020000000000FFFFFF0000000002
      000000000000000000A31C000006004D656D6F3137000200640100005B000000
      2C000000120000000300000001000000000000000000FFFFFF1F2E0200000000
      0001000600B1B8D7A2A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000000100020000000000FFFFFF00
      00000002000000000000000000291D000006004D656D6F313900020091010000
      5B00000024010000120000000300020001000000000000000000FFFFFF1F2E02
      0000000000010008005B52454D41524B5D00000000FFFF000000000002000000
      01000000000400CBCECCE5000A00000000000000000008000000010002000000
      0000FFFFFF0000000002000000000000000000AD1D000006004D656D6F323100
      02001E020000390100002C000000120000000100000001000000000000000000
      FFFFFF1F2E02000000000001000600B2C6CEF1A3BA0000000001000000000000
      0200000001000000000400CBCECCE5000A0000000200FFFFFF1F080000008600
      020000000000FFFFFF0000000002000000000000000000291E000006004D656D
      6F323200020053020000390100005C0000001200000001000200010000000000
      00000000FFFFFF1F2E0200000000000000000000000100000000000002000000
      01000000000400CBCECCE5000A0000000200FFFFFF1F08000000860002000000
      0000FFFFFF0000000002000000000000000000BE1E000006004D656D6F323500
      0200300000004101000088010000120000000300000001000000000000000000
      FFFFFF1F2E02000000000001001600B4F2D3A1CAB1BCE43A5B444154455D205B
      54494D455D00000000FFFF00000000000200000001000000000500417269616C
      000A000000000000000000000000000100020000000000FFFFFF000000000200
      000000000000FEFEFF060000000A00205661726961626C657300000000020073
      6C0014006364735F436867426F64792E22534C30303030220002006A65001400
      6364735F436867426F64792E224A4530303030220004006B6879680000000004
      0079687A68000000000200647A000000000000000000000000FDFF0100000000}
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 321
    Top = 262
    object N1: TMenuItem
      Caption = #21551#29992
      OnClick = N1Click
    end
  end
end
