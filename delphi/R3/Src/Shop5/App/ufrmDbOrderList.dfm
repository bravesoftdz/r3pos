inherited frmDbOrderList: TfrmDbOrderList
  Left = 253
  Top = 179
  Width = 845
  Height = 536
  Caption = #35843#25320#21333
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  inherited bgPanel: TRzPanel
    Width = 829
    Height = 462
    inherited RzPanel2: TRzPanel
      Width = 819
      Height = 452
      inherited RzPage: TRzPageControl
        Width = 813
        Height = 446
        FixedDimension = 25
        inherited TabSheet1: TRzTabSheet
          Caption = #35843#25320#21333#26597#35810
          inherited RzPanel3: TRzPanel
            Width = 811
            Height = 419
            inherited RzPanel1: TRzPanel
              Width = 801
              Height = 102
              Caption = '.'
              object RzLabel2: TRzLabel
                Left = 33
                Top = 5
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#26085#26399
              end
              object RzLabel3: TRzLabel
                Left = 200
                Top = 5
                Width = 12
                Height = 12
                Caption = #33267
              end
              object RzLabel4: TRzLabel
                Left = 33
                Top = 47
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#20837#38376#24215
              end
              object RzLabel5: TRzLabel
                Left = 33
                Top = 68
                Width = 48
                Height = 12
                Alignment = taRightJustify
                Caption = #35843#25320#21333#21495
              end
              object Label40: TLabel
                Left = 33
                Top = 26
                Width = 48
                Height = 12
                Caption = #35843#20986#38376#24215
              end
              object Label1: TLabel
                Left = 201
                Top = 69
                Width = 120
                Height = 12
                Caption = #25903#25345#27169#22359','#36755#21518'4'#20301#26597#35810
                Font.Charset = GB2312_CHARSET
                Font.Color = clNavy
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object D1: TcxDateEdit
                Left = 89
                Top = 1
                Width = 104
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 0
              end
              object D2: TcxDateEdit
                Left = 216
                Top = 1
                Width = 109
                Height = 20
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
                Properties.DateButtons = [btnToday]
                TabOrder = 1
              end
              object btnOk: TRzBitBtn
                Left = 508
                Top = 60
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
                TabOrder = 4
                TextStyle = tsRaised
                ThemeAware = False
                ImageIndex = 12
                NumGlyphs = 2
                Spacing = 5
              end
              object fndSALES_ID: TcxTextEdit
                Left = 89
                Top = 65
                Width = 104
                Height = 20
                TabOrder = 2
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
              end
              object fndSTATUS: TcxRadioGroup
                Left = 344
                Top = -4
                Width = 145
                Height = 90
                ItemIndex = 0
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = #20840#37096
                  end
                  item
                    Caption = #24453#23457#26680
                  end
                  item
                    Caption = #24050#23457#26680
                  end
                  item
                    Caption = #26410#21040#36135
                  end
                  item
                    Caption = #24050#21040#36135
                  end>
                TabOrder = 3
                Caption = ''
              end
              object fndSHOP_ID: TzrComboBoxList
                Tag = -1
                Left = 89
                Top = 22
                Width = 236
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
                ShowButton = True
                LocateStyle = lsDark
                Buttons = [zbClear]
                DropListStyle = lsFixed
                MultiSelect = False
              end
              object fndCLIENT_ID: TzrComboBoxList
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
                    FieldName = 'SHOP_ID'
                    Footers = <>
                    Title.Caption = #20195#30721
                    Width = 20
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
            end
            inherited DBGridEh1: TDBGridEh
              Top = 107
              Width = 801
              Height = 307
              FrozenCols = 1
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghFrozen3D, dghHighlightFocus, dghClearSelection]
              OnDblClick = DBGridEh1DblClick
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
                  Footers = <>
                  Title.Caption = #21333#21495
                  Width = 78
                end
                item
                  DisplayFormat = '0000-00-00'
                  EditButtons = <>
                  FieldName = 'SALES_DATE'
                  Footers = <>
                  Title.Caption = #35843#25320#26085#26399
                  Width = 67
                end
                item
                  EditButtons = <>
                  FieldName = 'SHOP_NAME'
                  Footers = <>
                  Title.Caption = #35843#20986#38376#24215
                  Width = 148
                end
                item
                  EditButtons = <>
                  FieldName = 'CLIENT_NAME'
                  Footers = <>
                  Title.Caption = #35843#20837#38376#24215
                  Width = 150
                end
                item
                  EditButtons = <>
                  FieldName = 'PLAN_DATE'
                  Footers = <>
                  Title.Caption = #21040#36135#26085#26399
                  Width = 63
                end
                item
                  EditButtons = <>
                  FieldName = 'GUIDE_USER_TEXT'
                  Footers = <>
                  Title.Caption = #36865#36135#21592
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'STOCK_USER_TEXT'
                  Footers = <>
                  Title.Caption = #39564#36135#21592
                  Width = 49
                end
                item
                  EditButtons = <>
                  FieldName = 'AMOUNT'
                  Footers = <>
                  Title.Caption = #25968#37327
                  Width = 54
                end
                item
                  EditButtons = <>
                  FieldName = 'AMONEY'
                  Footers = <>
                  Title.Caption = #38144#21806#39069
                  Width = 61
                end
                item
                  EditButtons = <>
                  FieldName = 'REMARK'
                  Footers = <>
                  Title.Caption = #22791#27880
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_USER_TEXT'
                  Footers = <>
                  Title.Caption = #21046#21333#21592
                end
                item
                  EditButtons = <>
                  FieldName = 'CREA_DATE'
                  Footers = <>
                  Title.Caption = #24405#20837#26102#38388
                  Width = 119
                end>
            end
          end
        end
      end
    end
  end
  inherited RzPanel4: TRzPanel
    Width = 829
    inherited Image1: TImage
      Left = 585
      Width = 224
    end
    inherited Image3: TImage
      Left = 585
      Width = 224
    end
    inherited Image14: TImage
      Left = 809
    end
    inherited rzPanel5: TPanel
      Left = 585
      inherited lblToolCaption: TRzLabel
        Caption = #24403#21069#20301#32622'->'#35843#25320#20986#36135
      end
    end
    inherited CoolBar1: TCoolBar
      Width = 565
      Bands = <
        item
          Break = False
          Control = ToolBar1
          FixedSize = True
          ImageIndex = -1
          MinHeight = 565
          Width = 48
        end>
      inherited ToolBar1: TToolBar
        Width = 565
        object ToolButton17: TToolButton
          Left = 522
          Top = 0
          Action = actExit
        end
      end
    end
  end
  inherited mmMenu: TMainMenu
    Left = 200
    Top = 232
  end
  inherited actList: TActionList
    Left = 256
    Top = 216
    inherited actInfo: TAction
      OnExecute = actInfoExecute
    end
    object actReport: TAction
      Caption = #25253#34920
    end
  end
  inherited ppmReport: TPopupMenu
    AutoHotkeys = maManual
    inherited mnmFormer0: TMenuItem
      Caption = #40664#35748#34920#26679
    end
    inherited mnmFormer1: TMenuItem
      Caption = #33258#23450#20041#19968
    end
    inherited mnmFormer2: TMenuItem
      Caption = #33258#23450#20041#20108
    end
    inherited mnmFormer3: TMenuItem
      Caption = #33258#23450#20041#19977
    end
    inherited mnmFormer4: TMenuItem
      Caption = #33258#23450#20041#22235
    end
    inherited mnmFormer5: TMenuItem
      Caption = #33258#23450#20041#20116
    end
  end
  inherited cdsList: TZQuery
    SortedFields = 'GLIDE_NO'
    AfterScroll = cdsListAfterScroll
    IndexFieldNames = 'GLIDE_NO Asc'
  end
  object frfSalesOrder: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = frfSalesOrderGetValue
    OnUserFunction = frfSalesOrderUserFunction
    Left = 488
    Top = 201
    ReportForm = {
      18000000B81E0000180000FFFF01000100FFFFFFFFFF00010000340800007805
      00002400000012000000240000002400000000FFFF00000000FFFF0000000000
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
      0100000000000000002303000006004D656D6F33320002002502000032000000
      2E000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001000600B5A5BAC5A3BA00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      00000002000000000000000000C103000006004D656D6F31340002002E020000
      BE000000440000001300000001000F0001000000000000000000FFFFFF1F2E02
      0000000000010020005B466F726D6174466C6F6174282723302E303023272C5B
      4150524943455D295D00000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000000000000000090000008600020000000000FFFFFF000000
      00020000000000000000006204000006004D656D6F313800020072020000BE00
      0000490000001300000001000F0001000000000000000000FFFFFF1F2E020000
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
      0000E5000000120000000100020001000000000000000000FFFFFF1F2E020000
      00000001000D005B434C49454E545F4E414D455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000003606000006004D656D6F
      3430000200A90100003200000079000000120000000100020001000000000000
      000000FFFFFF1F2E02000000000001000C005B53414C45535F444154455D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      000000080000008600020000000000FFFFFF0000000002000000000000000000
      BF06000006004D656D6F3233000200E7010000BE000000200000001300000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000B005B554E49
      545F4E414D455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A0000000000000000000A0000008600020000000000FFFFFF0000000002
      0000000000000000004707000006004D656D6F35380002005402000032000000
      67000000120000000100020001000000000000000000FFFFFF1F2E0200000000
      0001000A005B474C4944455F4E4F5D00000000FFFF0000000000020000000100
      0000000400CBCECCE5000A000000000000000000000000008600020000000000
      FFFFFF0000000002000000000000000000E307000005004D656D6F3300020007
      020000BE000000270000001300000001000F0001000000000000000000FFFFFF
      1F2E02000000000001001F005B666F726D6174666C6F6174282723302E232327
      2C5B414D4F554E545D295D00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000000000000000090000008600020000000000FFFFFF00
      000000020000000000000000007008000005004D656D6F320002003500000019
      00000085020000180000000100000001000000000000000500FFFFFF1F2E0200
      00000000010010005BC6F3D2B5C3FBB3C65DB5F7B2A6B5A500000000FFFF0000
      0000000200000001000000000400CBCECCE500100000000200000000000A0000
      008600020000000000FFFFFF0000000002000000000000000000F70800000600
      4D656D6F31320002003500000032000000460000001200000001000000010000
      00000000000000FFFFFF1F2E02000000000001000900B5F7C8EBC3C5B5EA3A00
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      00000000080000008600020000000000FFFFFF00000000020000000000000000
      007F09000006004D656D6F313300020061010000320000004500000012000000
      0100000001000000000000000000FFFFFF1F2E02000000000001000A00B5F7B2
      A6C8D5C6DAA3BA00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000020000000000080000008600020000000000FFFFFF0000000002
      000000000000000000010A000006004D656D6F33340002002E02000070000000
      440000001600000001000F0001000000000000000000FFFFFF1F2E0200000000
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
      00000000FFFFFF0000000002000000000000000000610C000006004D656D6F32
      350002003500000012010000B10100001300000001000E000100000000000000
      0000FFFFFF1F2E02000000000001005800BACFBCC6BDF0B6EEA3BA205B536D61
      6C6C546F426967285B53414C455F4D4E595D295D2020A3A43A5B666F726D6174
      466C6F6174282723302E3030272C5B53414C455F4D4E595D295D202020202020
      20202020202020202000000000FFFF00000000000200000001000000000400CB
      CECCE5000A000000020000000000080000008600020000000000FFFFFF000000
      0002000000000000000000E50C000006004D656D6F3432000200020200004901
      00002A0000000F0000000100000001000000000000000000FFFFFF1F2E020000
      00000001000600B2C6CEF1A3BA00000000010000000000000200000001000000
      000400CBCECCE5000A0000000200FFFFFF1F080000008600020000000000FFFF
      FF00000000020000000000000000006B0D000006004D656D6F34340002005901
      00002A01000037000000140000000100000001000000000000000000FFFFFF1F
      2E02000000000001000800D1E9BBF5D4B1A3BA00000000010000000000000200
      000001000000000400CBCECCE5000A0000000200FFFFFF1F0800000086000200
      00000000FFFFFF0000000002000000000000000000F10D000006004D656D6F34
      350002007202000070000000490000001600000001000F000100000000000000
      0000FFFFFF1F2E02000000000001000800CFFACADBBDF0B6EE00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000200000000000A00
      00008600020000000000FFFFFF0000000002000000000000000000760E000006
      004D656D6F353400020035000000BE0000001B0000001300000001000F000100
      0000000000000000FFFFFF1F2E020000000000010007005B5345514E4F5D0000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000000000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      F60E000006004D656D6F353500020035000000700000001B0000001600000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000200D0F20000
      0000FFFF00000000000200000001000000000400CBCECCE5000A000000020000
      0000000A0000008600020000000000FFFFFF0000000002000000000000000000
      770F000005004D656D6F3700020050000000700000003E000000160000000100
      0F0001000000000000000000FFFFFF1F2E02000000000001000400BBF5BAC500
      000000FFFF00000000000200000001000000000400CBCECCE5000A0000000200
      000000000A0000000100020000000000FFFFFF00000000020000000000000000
      00FF0F000005004D656D6F3800020050000000BE0000003E0000001300000001
      000F0001000000000000000000FFFFFF1F2E02000000000001000B005B474F44
      535F434F44455D00000000FFFF00000000000200000001000000000400CBCECC
      E5000A000000000000000000080000000100020000000000FFFFFF0000000002
      0000000000000000009510000006004D656D6F32340002007A02000019000000
      56000000120000000100000001000000000000000000FFFFFF1F2E0200000000
      0001001800B5DA5B50414745235D2F5B544F54414C50414745535DD2B3000000
      00FFFF00000000000200000001000000000400CBCECCE5000A00000000000000
      0000090000008600020000000000FFFFFF00000000020000000000000000001C
      11000006004D656D6F3236000200A80100004600000013010000120000000100
      020001000000000000000000FFFFFF1F2E020000000000010009005B41444452
      4553535D00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000008600020000000000FFFFFF0000000002000000
      000000000000A311000006004D656D6F32370002006201000046000000460000
      00120000000100000001000000000000000000FFFFFF1F2E0200000000000100
      0900CBCDBBF5B5D8D6B73A00000000FFFF000000000002000000010000000004
      00CBCECCE5000A000000020000000000080000008600020000000000FFFFFF00
      000000020000000000000000002C12000006004D656D6F32380002007B000000
      5B0000009C000000120000000100020001000000000000000000FFFFFF1F2E02
      000000000001000B005B4D4F56455F54454C455D00000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF0000000002000000000000000000B312000006004D656D6F
      3239000200350000005B00000046000000120000000100000001000000000000
      000000FFFFFF1F2E02000000000001000900C1AACFB5B5E7BBB03A00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000020000000000
      080000008600020000000000FFFFFF0000000002000000000000000000481300
      0005004D656D6F31000200370000002A0100007C000000140000000100000001
      000000000000000000FFFFFF1F2E02000000000001001800D6C6B5A5C8CBA3BA
      5B435245415F555345525F544558545D00000000010000000000000200000001
      000000000400CBCECCE5000A0000000200FFFFFF1F0800000086000200000000
      00FFFFFF0000000002000000000000000000CA13000006004D656D6F35360002
      008E00000070000000600000001600000001000F0001000000000000000000FF
      FFFF1F2E02000000000001000400CCF5C2EB00000000FFFF0000000000020000
      0001000000000400CBCECCE5000A0000000200000000000A0000000100020000
      000000FFFFFF00000000020000000000000000005114000006004D656D6F3537
      0002008E000000BE000000600000001300000001000F00010000000000000000
      00FFFFFF1F2E020000000000010009005B424152434F44455D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000800
      00000100020000000000FFFFFF00000000020000000000000000003815000006
      004D656D6F3539000200C00200005C000000180000004E010000030000000100
      0000000000000000FFFFFF1F2E02000000000007000D00B0D7C1AAA3BAB5F7B3
      F6B7BD200D00000D1E0020202020202020202020202020202020202020202020
      20202020202020200D0E00BAECC1AAA3BAB5F7C8EBB7BD20200D00000D140020
      202020202020202020202020202020202020200D0A00BBC6C1AAA3BABDE1CBE3
      00000000FFFF00000000000200000001000000000400CBCECCE5000A00000002
      0000000000000000000100020000000000FFFFFF000000000200000000000000
      0000B415000006004D656D6F36300002002E020000E800000044000000130000
      0001000F0001000000000000000000FFFFFF1F2E020000000000000000000000
      FFFF00000000000200000001000000000400CBCECCE5000A0000000000000000
      00090000008600020000000000FFFFFF00000000020000000000000000003016
      000006004D656D6F363100020072020000E8000000490000001300000001000F
      0001000000000000000000FFFFFF1F2E020000000000000000000000FFFF0000
      0000000200000001000000000400CBCECCE5000A000000000000000000090000
      008600020000000000FFFFFF0000000002000000000000000000AC1600000600
      4D656D6F3632000200EE000000E8000000F90000001300000001000F00010000
      00000000000000FFFFFF1F2E020000000000000000000000FFFF000000000002
      00000001000000000400CBCECCE5000A00000000000000000008000000860002
      0000000000FFFFFF00000000020000000000000000002817000006004D656D6F
      3633000200E7010000E8000000200000001300000001000F0001000000000000
      000000FFFFFF1F2E020000000000000000000000FFFF00000000000200000001
      000000000400CBCECCE5000A0000000000000000000A00000086000200000000
      00FFFFFF0000000002000000000000000000A417000006004D656D6F36340002
      0007020000E8000000270000001300000001000F0001000000000000000000FF
      FFFF1F2E020000000000000000000000FFFF0000000000020000000100000000
      0400CBCECCE5000A000000000000000000090000008600020000000000FFFFFF
      00000000020000000000000000002018000006004D656D6F3635000200350000
      00E80000001B0000001300000001000F0001000000000000000000FFFFFF1F2E
      020000000000000000000000FFFF00000000000200000001000000000400CBCE
      CCE5000A0000000000000000000A0000008600020000000000FFFFFF00000000
      020000000000000000009C18000006004D656D6F363600020050000000E80000
      003E0000001300000001000F0001000000000000000000FFFFFF1F2E02000000
      0000000000000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000000000000000080000000100020000000000FFFFFF0000000002000000
      0000000000001A19000006004D656D6F36370002008E000000E8000000600000
      001300000001000F0001000000000000000000FFFFFF1F2E0200000000000100
      000000000000FFFF00000000000200000001000000000400CBCECCE5000A0000
      00000000000000080000000100020000000000FFFFFF00000000020000000000
      00000000F119000005004D656D6F35000200E701000012010000D40000001300
      000003000B0001000000000000000000FFFFFF1F2E02000000000001005A00D7
      DCCAFDC1BFA3BA5B666F726D6174666C6F6174282723302E2323272C5B53414C
      455F414D545D295D20B1BED2B3D0A1BCC6A3BA5B666F726D6174466C6F617428
      2723302E3023272C5B73756D285B414D4F554E545D295D295D00000000FFFF00
      000000000200000001000000000400CBCECCE5000A0000000000000000000900
      00000100020000000000FFFFFF0000000002000000000000000000801A000006
      004D656D6F3131000200920100002A0100006100000014000000010000000100
      0000000000000000FFFFFF1F2E020000000000010011005B53544F434B5F5553
      45525F544558545D00000000010000000000000200000001000000000400CBCE
      CCE5000A0000000200FFFFFF1F080000008600020000000000FFFFFF00000000
      02000000000000000000131B000005004D656D6F340002003700000046010000
      14010000120000000300000001000000000000000000FFFFFF1F2E0200000000
      0001001600B4F2D3A1CAB1BCE43A5B444154455D205B54494D455D00000000FF
      FF00000000000200000001000000000400CBCECCE5000A000000000000000000
      000000000100020000000000FFFFFF00000000020000000000000000009B1B00
      0005004D656D6F360002007D00000047000000E3000000120000000100020001
      000000000000000000FFFFFF1F2E02000000000001000B005B53484F505F4E41
      4D455D00000000FFFF00000000000200000001000000000400CBCECCE5000A00
      0000000000000000080000008600020000000000FFFFFF000000000200000000
      0000000000221C000006004D656D6F3137000200350000004700000046000000
      120000000100000001000000000000000000FFFFFF1F2E020000000000010009
      00B7A2BBF5C3C5B5EA3A00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000020000000000080000008600020000000000FFFFFF0000
      000002000000000000000000B91C000006004D656D6F3139000200C50000002A
      01000080000000140000000100000001000000000000000000FFFFFF1F2E0200
      0000000001001900CBCDBBF5D4B1A3BA5B47554944455F555345525F54455854
      5D00000000010000000000000200000001000000000400CBCECCE5000A000000
      0200FFFFFF1F080000008600020000000000FFFFFF0000000002000000000000
      0000003C1D000006004D656D6F32310002001A0100005B000000270000001200
      00000100000001000000000000000000FFFFFF1F2E02000000000001000500B1
      B8D7A23A00000000FFFF00000000000200000001000000000400CBCECCE5000A
      000000020000000000080000008600020000000000FFFFFF0000000002000000
      000000000000C21D000006004D656D6F3335000200410100005B0000007A0100
      00120000000100020001000000000000000000FFFFFF1F2E0200000000000100
      08005B52454D41524B5D00000000FFFF00000000000200000001000000000400
      CBCECCE5000A000000000000000000080000008600020000000000FFFFFF0000
      0000020000000000000000003E1E000006004D656D6F3339000200320200004A
      010000610000000C0000000100020001000000000000000000FFFFFF1F2E0200
      00000000000000000000FFFF00000000000200000001000000000400CBCECCE5
      000A000000020000000000080000008600020000000000FFFFFF000000000200
      000000000000FEFEFF060000000A00205661726961626C657300000000020073
      6C0014006364735F436867426F64792E22534C30303030220002006A65001400
      6364735F436867426F64792E224A4530303030220004006B6879680000000004
      0079687A68000000000200647A000000000000000000000000FDFF0100000000}
  end
end
